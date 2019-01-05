---
title: "No overlapping dateranges in Postgres"
description: ""
date: 2019-01-02T10:10:07+01:00
tags: ["Postgres", "TIL"]
draft: false
images: ["/images/eric-rothermel-23788-unsplash.jpg"]
---
Lets say we have several rooms, and every room has reservations. We do not want the reservations to overlap, ever. Here's how we add that check to a table in PostgreSQL.<!--more-->

The following will make sure no `start_date` and `end_date` overlaps, but completely ignores the check on the room for now.

```sql
CREATE TABLE room_reservation (
  room text,
  start_date date,
  end_date date,
  EXCLUDE USING GIST (daterange("start_date", "end_date", '[]') WITH &&));
```

To get the room into the mix we need the `btree_gist` extension.

```sql
CREATE EXTENSION btree_gist;
```

Now we can include the room, notice the new `room WITH =` inside the `EXCLUDE`:

```sql
CREATE TABLE room_reservation (
  room text,
  start_date date,
  end_date date,
  EXCLUDE USING GIST (room WITH =, daterange("start_date", "end_date", '[]') WITH &&));
```

If you're wondering what the `[]` is about. It specifies the bounds. `()`, `[]`, `[)`, `(]`. In our case `[]` means we include both the lower and upper bound (start and end date) in the check.

If we would use `[)` instead then the `start_date` of another entry could be equal to the `end_date` of the other one.

This is a simplified take on it, check [https://en.wikipedia.org/wiki/Interval_(mathematics)](https://en.wikipedia.org/wiki/Interval_(mathematics)) for a detailed look.

You could also use a Range-Type to simplify the `EXCLUDE` a bit, see [https://www.postgresql.org/docs/current/static/rangetypes.html](https://www.postgresql.org/docs/current/static/rangetypes.html) for more

## In an Elixir migration do this

```elixir
# Create the extension on up, drop it on down migrations
execute("CREATE EXTENSION IF NOT EXISTS btree_gist", "DROP EXTENSION IF EXISTS btree_gist")

# Create the constraint (with the name :cannot_overlap)
create(constraint(:reservations, :cannot_overlap, exclude: ~s|gist ("room" WITH =, daterange("start_date", "end_date", '[]') WITH &&)|))
```

![planner lying on table showing a calendar](/images/eric-rothermel-23788-unsplash.jpg)
