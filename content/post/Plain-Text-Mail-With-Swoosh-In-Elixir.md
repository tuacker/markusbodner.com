+++
title = "Sending plain text and HTML emails using EEx and Swoosh in Phoenix & Elixir"
draft = false
tags = ["Elixir"]
date = "2017-03-22T12:25:17+01:00"

+++

While working on a SaaS built with the Phoenix Framework I needed to be able to send emails.

For the actual processing I'm using [Mailgun](https://www.mailgun.com/) and to get them there the awesome [swoosh](https://github.com/swoosh/swoosh) Elixir library (as well as the [phoenix_swoosh](https://github.com/swoosh/phoenix_swoosh) extension).<!--more-->

As with all Elixir libraries swoosh comes with a [great documentation](https://hexdocs.pm/swoosh/Swoosh.html). I'm not going to repeat it here, check out the git repos linked above for basic setup.

Once you've gone through the swoosh and phoenix_swoosh setups you already know how to send HTML emails. But what about plain text? It is important to send emails containing both in order to support most clients.

So how to leverage EEx to generate plain text emails just like HTML? Easy, you should already have a `web/views/email_view.ex` (from the phoenix_swoosh setup) which is just a simple phoenix view and a `mailer`.

```elixir
# web/views/email_view.ex
defmodule MyApp.EmailView do
  use MyApp.Web, :view
end

# lib/my_app/mailer.ex
defmodule MyApp.Mailer do
  use Swoosh.Mailer, otp_app: :my_app
end
```

As well as an email html layout in `web/templates/email.html.eex` and maybe even an actual email in `web/templates/email/welcome_email.html.eex`. This is exactly how rendering any view in the Phoenix Framework works.

In order to get text emails all you have to do is add a text layout `web/templates/email.text.eex` (notice the _.**text**.eex_ instead of _.**html**.eex_) and `web/templates/email/welcome_email.text.eex` (again _.text.eex_).

For example, here are mine:

```elixir
# web/templates/email.text.eex
<%= render @view_module, @view_template, assigns %>

---------
Markus Bodner
<rest of signature>


# web/templates/email/welcome_email.text.eex
Welcome to My App, @user.name!

We have put together some information about
your <rest of welcome mail>
```

Once you have the basic text-template and a text-email you are done! Ready to send HTML+plain text emails using our Mailer:

```elixir
# lib/my_app/user_email.ex
defmodule MyApp.UserEmail do
  # specify the Layout and View we want to use
  # (the ones defined above)
  use Phoenix.Swoosh, view: MyApp.EmailView,
                      layout: {MyApp.LayoutView, :email}

  def send_welcome_mail(user) do
    new()
    |> to({user.name, user.email})
    |> from({"Swoosh is great", "email@myemail.com"})
    |> subject("This mail has both a HTML and plain text body!")
    |> render_body("welcome_email.html")  # html body
    |> render_body("welcome_email.text")  # text body
    |> MyApp.Mailer.deliver()
  end
end
```

We're calling `render_body/2` twice, Swoosh looks at the template extension (html, text) and correctly puts them either in the HTML part or plain-text part of your email.

Have fun sending emails!
