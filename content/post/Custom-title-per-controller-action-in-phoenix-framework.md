+++
date = "2016-03-27T12:46:38+02:00"
draft = true
tags = ["Elixir", "Phoenix Framework"]
title = "Custom title per view or controller action in Phoenix Framework"

+++

The simplest option would be to pass the page title along with the render call in your controller action. For example you could do <code>render(conn, "new.html", page_title: "New Resource")</code>. Then, in your app layout template <code>app.html.eex</code> access it with <code>\<title\><%= @page_title %>\</title></code>.  


The problem with this approach is that you have to provide the page_title for every controller action. In addition setting the page title should probably be done by the view and not the controller. Here is how you'd do that.

Start out by adding phoenix controller's <code>action_name/1</code> to the imported helpers for our view in web.ex. action_name/1 returns the action as atom that is being performed for the current conn (:new, :create, :update, ...).

    # web/web.ex

    ...
    def view do
      ...
      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1, action_name: 1]
    ...

Next up create a <code>title/2</code> function in our <code>LayoutView</code> module. This function will try and ask the view module that is being rendered for its title or return a default title instead.

    # web/views/layout_view.ex


    @doc """
    Calls the `title` fun of the current `view_module` with the performed `:action` as arg.
    If no fun exists/matches the `default` title is returned instead.
    """
    def title(conn, default) do
      try do
        apply(view_module(conn), :title, [action_name(conn)])
      rescue
        _ -> default
      end
    end

Using <code>view_module(conn)</code> we can fetch the module of the view which is being rendered, for example the UserView. <code>apply/3</code> will try to call the function title inside that module with the action name as argument.  

If that view does not implement <code>title/1</code> a <code>UndefinedFunctionError</code> error is thrown. We don't really care about which error so in our rescure block we just return the default title instead.


Now it is time to implement the title/1 functions in all views we want to specify a custom title for. In this example I assume you have a user model with matching user controller and a user view.

    # web/views/user_view.ex

    def title(:index), do: "List all users"
  	def title(:new),   do: "Create a new user"
  	def title(:show),  do: "Show a single user"
  	def title(_),      do: "Users"

 As you can see we can use elixir's pattern matching to specify a custom title for every controller action. If you only need one title for all actions replace simply <code> def title(_) do..</code>, which will always match.

 That is it. Open the layout template at <code>web/templates/layout/app.html.eex</code> and add the call to <code>title/2</code>.

     # web/templates/layout/app.html.eex

    <head>
      ...
      <title><%= title @conn, "My Default Title" %></title>
      ...
    </head>

The <code>title @conn, "My Default Title"</code> will call <code>title/2</code> defined in our <code>web/views/layout.view.ex</code>, which in turn calls the <code>title/1</code> function of the current view module that is being rendered. If no functions matches or none is found "My Default Title" is returned instead.
