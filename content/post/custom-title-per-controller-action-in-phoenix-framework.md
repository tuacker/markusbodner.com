+++
date = "2016-03-27T12:46:38+02:00"
draft = false
tags = ["phoenix-framework", "Elixir"]
title = "Custom titles per view or controller actions in Phoenix Framework"
images = ["/images/nick-fewings-642060-unsplash.jpg"]
+++
Phoenix offers the `render_existing/3` function, which tries to render the template for the provided module, or returns `nil` if the template doesn't exist. We can use this to create custom titles or even JavaScript includes on a per-view basis.<!--more-->

In your existing phoenix project open up your `MyApp.LayoutView` usually located in `views/layout_view.ex` and add the following.

```elixir
# views/layout_view.ex

@doc """
Returns the string of the title for the provided module and template.
It does so by calling render_existing/3 on the `view_module`. The `view module`
is concatenated with "title." to get the template.

So if the `view_template` is `show.html` then this will call
`title.show.html` on the provided `view_module`.

If `render_existing/3` doesn't produce any results `default` is used instead.
"""
def title(view_module, view_template, assigns, default \\ "Your Default Title") do
  render_existing(view_module, "title." <> view_template, assigns) || default
end
```

Now open the view module of any of your controller actions, for example the `session_view.ex`. Lets say you want the title for your login action to read "Log in to MyApp".

```elixir
# views/session_view.ex
def render("title.new.html", _), do: "Log in to MyApp"
```

Here the `new` maps to the current view template `new`, it could also be `show` or any other value.

Finally, open up your main layout, usually `templates/layout/app.html.eex` and add the following to the `<head>`

```elixir
  # templates/layout/app.html.eex
  <title><%= title @view_module, @view_template, assigns %></title>
```

The above line will call the `title/3` function in your `layout_view.ex` defined at the beginning of this post, which will turn use `render_existing/3` on the current view module (in our example the `session_view.ex`) for the template `title.new.html`.

For any page you don't define a `title.<action>.html` the call will just silently fail and return the default value instead.

You can even use this to include custom JavaScript on select pages. Just create another function in your layout view and repeat the process of adding a `render` function to your view, and update the layout to call the function.

I heavily use this for custom titles, breadcrumbs and meta tags. Here is how my `layout_view.ex` looks.

```elixir
def title(view_module, view_template, assigns, default \\ "Ads From Source") do
  render_existing(view_module, "title." <> view_template, assigns) || default
end

def breadcrumbs(view_module, view_template, assigns) do
  render_existing(view_module, "crumbs." <> view_template, assigns)
end

def meta_descriptors(view_module, view_template, assigns) do
  render_existing(view_module, "meta." <> view_template, assigns)
end
```

*This post was updated on 22. December 2018 to use a better approach using `render_existing/3`.*

![assorted-title book lot placed on white wooden shelf](/images/nick-fewings-642060-unsplash.jpg)
