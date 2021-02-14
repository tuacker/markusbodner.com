---
title: "Change which struct-key the Phoenix path-helpers use"
description: ""
date: 2019-01-02T10:55:29+01:00
tags: ["Phoenix Framework", "Elixir", "TIL"]
images: ["/images/tamara-menzi-275952-unsplash.jpg"]
draft: false
---

By default the Elixir Phoenix path helpers use the `:id` key. For example: `property_path(conn, :show, property)` would turn into `/properties/1`. If you want to use a different key inside the property use the `Phoenix.Param` protocol in the `schema` definition.<!--more-->

```elixir
defmodule Property do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Phoenix.Param, key: :identifier}   # <--- THIS!
  @type t :: %__MODULE__{}

  schema "properties" do
    field :identifier, :string
    field ...
  end
end
```

The `@derive {Phoenix.Param, key: :identifier}` instructs the path helpers to use the `:identifier` key. Now the path above would turn into `/properties/that_identifier` instead.

![areal photograph of a mountain road splitting into two separate roads leading up and down hill](/images/tamara-menzi-275952-unsplash.jpg)
