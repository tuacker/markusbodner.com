---
title: "Multi-Step Form using Phoenix Live View"
description: "Implementing a multi-step form using Phoenix Live view without having to write any JavaScript"
date: 2019-05-31T08:25:51+02:00
tags: ["phoenix-framework", "live-view", "Elixir", "TIL", "Programming"]
images: ["/images/form_live_view_steps_test_code_length.png"]
draft: false
aliases:
  - "/2019/05/31/multi-step-form-using-phoenix-live-view/"
---

One thing I needed recently is a multi-step form for a specific flow. I thought the upcoming [Live View](https://github.com/phoenixframework/phoenix_live_view/) would be a perfect fit for that. What you see in the following clip I achieved without having to write any JavaScript myself.
<!--more-->

**Note: This post was written for one of the first versions of LiveView. A lot has changed by now and this example won't work as-is. The general concepts should remain the same though.** I hope to update this tutorial at some point.

![Video showing the multi-step flow](/videos/form_live_view_steps_test.mp4)

## Implementation
I will talk about the view template as well as the actual code managing it here. If you want to see a step-by-step from a fresh Phoenix project to the final result you can go through my [commits](https://github.com/tuacker/phoenix_live_view_form_steps/commits/master) from oldest to newest.

First the template. It is a very normal looking form, same as you'd do in Phoenix. The only exception it has a `.leex` extension. And there are some weird `if @current_step....` in there.

```elixir
# lib/live_view_form_web/templates/example/form.html.leex
<%= form_for @changeset, "#", [phx_change: :validate, phx_submit: :save], fn f -> %>
  <%= if @current_step == 1 do %>
    <div>
      <%= label f, :title %>
      <%= text_input f, :title, autofocus: true %>
      <%= error_tag f, :title %>
    </div>

    <div>
      <%= label f, :description %>
      <%= text_input f, :description %>
      <%= error_tag f, :description %>
    </div>

  <% else %>
    <%= hidden_input f, :title %>
    <%= hidden_input f, :description %>
  <% end %>


  <%= if @current_step == 2 do %>
    <div>
      <%= label f, :type %>

      <%= label do %>
        <%= radio_button f, :type, "thing_a" %>
        Thing A
      <% end %>

      <%= label do %>
        <%= radio_button f, :type, "thing_b" %>
        Thing B
      <% end %>

      <%= error_tag f, :type %>
   </div>
  <% else %>
    <%= hidden_input f, :type %>
  <% end %>

  <%= if @current_step == 3 do %>
    <div>
      <%= label f, :something_else %>
      <%= text_input f, :something_else, autofocus: true %>
      <%= error_tag f, :something_else %>
    </div>
  <% end %>


  <%= if @current_step > 1 do %><button phx-click="prev-step">Back</button><% end %>

  <%= if @current_step == 3 do %>
    <%= submit "Submit" %>
  <% else %>
    <button phx-click="next-step">Continue</button>
  <% end %>

<% end %>
```

Take note of the `[phx_change: :validate, phx_submit: :save]` on 2nd line and `phx-click="next-step"` as well as `phx-click="prev-step"` on the Continue & Back buttons.

Now with the Live View code it gets exciting. I'll split it up and go through it function by function.

```elixir
# lib/live_view_form_web/live/example_live.ex
defmodule LiveViewFormWeb.ExampleLive do
  use Phoenix.LiveView
  alias LiveViewFormWeb.Router.Helpers, as: Routes

  def render(assigns) do
    LiveViewFormWeb.ExampleView.render("form.html", assigns)
  end

  def mount(_session, socket) do
    socket =
      socket
      |> assign(:current_step, 1)
      |> assign(:changeset, LiveViewForm.change_example(%{}))

    {:ok, socket}
  end

  # ...
```

Here we define our Live View module. In `render/1`, all we do is pass the current assigns on to the view template we just saw above. When the user first accesses a page with a live view on it `mount/2` is called. In here we set the initial assigns of the process. In our case that is setting `current_step` to 1 and creating an empty `changeset` for our Example.

What's exciting about this is that you are working with a long lived process here. While the user remains on the page the process is alive on your server. And with it all its state like the two assigns above. Live View then uses the assigns to determine if a new render needs to happen. Whenever one of the assigns changes, `render/1` is called again. It then figures out what part of the HTML has to change and sends that down to the client. Not the full HTML. Just what has changed. The client side then uses that patch to update the DOM accordingly.

```elixir
def handle_event("validate", %{"example" => params}, socket) do
  changeset = LiveViewForm.change_example(params) |> Map.put(:action, :insert)

  {:noreply, assign(socket, :changeset, changeset)}
end

def handle_event("save", %{"example" => params}, socket) do
  # Pretending to insert stuff if changeset is valid
  changeset = LiveViewForm.change_example(params)

  case changeset.valid? do
    true ->
      {:stop,
       socket
       |> put_flash(:info, "Example inserted => #{inspect(changeset.changes)}")
       |> redirect(to: Routes.live_path(LiveViewFormWeb.Endpoint, LiveViewFormWeb.ExampleLive))}

    false ->
      {:noreply, assign(socket, :changeset, %{changeset | action: :insert})}
  end
end
```

In the `form_for/4` we set up `[phx_change: :validate, phx_submit: :save]`. The `:validate` and `:save` map to the 2 `handle_event/3` above. In `"validate"` the current form data is passed to the changeset and then assigned to the socket. If the form has validation errors the template is re-rendered and pushed down to the client.

Similar to that in `save` we check if the `changeset` is valid. Normally you'd insert the data to your database here, but I forewent that. Instead I just pretend to by checking if the changeset is valid. If it is not valid the same thing as in `"validate"` happens. When valid put a flash on the connection and then redirect.

```elixir
def handle_event("prev-step", _value, socket) do
  new_step = max(socket.assigns.current_step - 1, 1)
  {:noreply, assign(socket, :current_step, new_step)}
end

def handle_event("next-step", _value, socket) do
  current_step = socket.assigns.current_step
  changeset = socket.assigns.changeset

  step_invalid =
    case current_step do
      1 -> Enum.any?(Keyword.keys(changeset.errors), fn k -> k in [:title, :description] end)
      2 -> Enum.any?(Keyword.keys(changeset.errors), fn k -> k in [:type] end)
      _ -> true
    end

  new_step = if step_invalid, do: current_step, else: current_step + 1

  {:noreply, assign(socket, :current_step, new_step)}
end
```

The `phx-click` on the back/continue buttons map to these `handle_event/3`. In `prev-step` we decrease the current step level. This allows the user to go back. With an updated `current_step` assigned to the socket Live View will re-render and push the changes down to the client. Since the `changeset` is held in memory by the live view process we don't lose any data.

On `next-step` we grab the `changeset` from the assigns and check if the input fields of the current step are valid. I'm not certain this is the best way, but it works well enough for a simple example like that. If the step is valid we increase the `current_step` by one, update the socket and it'll re-render again with the next step.

If you look back at the template at the start you'll see if-s using the `@current_value` to determine which inputs are visible and which are hidden.

That's it! With only 60 lines of live code (+ html template code) I have a multi-step form. Didn't have to write a single line of JavaScript. All the validations are happening server-side! I really like the simplicity of this.

## Caveats
There are some problems though. Some of it because Live View is still new, and some of my own making.

- If you look closely, you'll see on the last step the input validation is already visible before the user made any input. A fix to that could be to reset the changeset `action` to `nil` whenever the current step is increased.
- As I understand it, the validate step is run after every keypress. With high latency this may destroy the UX and thus feel really janky.
- If one of the values has to be unique that can only be determined by attempting to insert. You'd then have to find the correct step to show; with the error present. Or maybe render the whole form at once after an insert was attempted and failed.

The full code for this example can be found on [GitHub](https://github.com/tuacker/phoenix_live_view_form_steps/).
