---
title: "Week 12 - Blip - Welcome"
description: "A welcome screen for blip and a new OS"
date: 2021-04-30T12:22:01+02:00
tags: ["Blip", "Devlog"]
images: ["/images/blip/2021-04-21-welcome-window.png"]
draft: false
---

Bit laaaaate on that one. Forgot to write up the weekly review but here it is. Better late than never!<!--more-->

*Side note before we begin: I do dread writing these posts a little but they'll serve as a nice reminder in the future when I look back at how all of this started!*

Managed to do most of what I set out [the previous week]({{< relref "week-11-blip-preferences.md" >}}), pretty good. Started out with the welcome screen on Monday. As expected, with everything I learned from implementing Preferences this was rather quick to set up and get going.

After that I finally upgraded from macOS Catalina to Big Sur and spent the next two days or so to adjust small things here and there to get the app look good on Big Sur as well. I also set up a VM to keep testing Blip under Catalina.

Another improvement was using a splitView for editing entries. Up until now it was just a view I'd show above the list of entries. This implementation now is more robust and as a bonus I also figured out how to stop the text input from polluting my undo history.

Previously I had to clear the undo history after showing the editing view because it'd lead to a crash otherwise. Now I preserve the full history for as long as it makes sense.

Here's how the welcome screen looks. I'll be adding the icon on the left side once I have it done:

![welcome window reading Blip - A simple box two write along with an input for the license key and global hotkey to show blip and the option to launch blip at login](/images/blip/2021-04-21-welcome-window.png)
