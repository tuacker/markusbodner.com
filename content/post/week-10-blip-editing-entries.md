---
title: "Week 10 - Blip - Editing entries"
description: "Editing of entries now works, but progress remains a bit slower than wanted."
date: 2021-04-09T13:18:11+02:00
tags: ["Blip", "Devlog"]
images: ["/images/2021-04-09-editing-entries.png"]
draft: false
---

It is now possible to edit entries in Blip, the rating is visible in the summary view and other little things that make the app feel like an app.<!--more-->

Progress this week is still slowed by a family member falling ill, and as [last week]({{< relref "week-9-blip-unexpected.md" >}}) I didn't quite advance as fast as I wanted to.

That said, a big "feature" is now working: Editing entries. It's fast and implementing it was somewhat easier than I expected it to.

In making this work I did remove my somewhat shitty "caching" system for larger lists. It was causing too much issues. I now load all entries at once. This remains fast for day/week/month ranges, but a year long query with about 7000 entries now takes ~1s to load. Which is OK. I can optimize that later.

Besides that I hooked up a bunch of knicks-knacks that make the app feel at home. Context menus, menu items, shortcuts, row-actions you can swipe if you have a trackpad, etc. There is a surprising amount of little things that need to be done to achieve something that "feels right"!

Feature wise I am now done for the first release. (YAYYY!) Everything else comes after.

Plans for next week:

- Preferences-pane
- Welcome window
- Updating my OS to BigSur and check how Blip looks & works there
- Bonus, one of: Introduce Sprinkle for updating / work on app icon / work on website

And at last, here is a short video of me editing an entry:

{{< video src="/videos/2021-04-09-editing-entries.mp4" alt="The first entry is right-clicked and a positive rating assigned via the context menu. After that the edit action is chosen and the entry is updated with some more text and a different rating" >}}
