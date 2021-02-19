---
title: "Week 3 - Blip - What the fuck"
description: "Not the best of weeks — ended it with being stuck on something that should be super easy."
date: 2021-02-19T18:40:12+01:00
tags: ["Blip", "Devlog"]
images: ["/images/blip-week-3-screenshot.png"]
draft: false
---

This week ended with a big annoyance — and I still have no idea how to fix it. What I want to do seems so easy, but it isn't working.<!--more--> At this point I'm not sure if it is worth sticking with SwiftUI. Or if I should require Big Sur (and thus SwiftUI2 as a minimum) ... or switch to AppKit/Cocoa entirely.

All I wanted to accomplish was to list out every entry in a list so you can view it and copy the text. Sounds easy right? Not so fast. Somehow, for an unexplainable reason I can't get long text to wrap around properly. Either the text gets truncated or the lines get cut off.

![as the window is resized, longer text in the view is either truncated or cut off, depending on different code strategies (which are not shown in the video)](/videos/blip-resizing-bug.mp4)

I've tried every StackOverflow and search query I could think of. No dice. Either I am misunderstanding how SwiftUI works in this regard or the version I am using is bugged. May have to download Big Sur and install it on a separate partition just to check.

Either way, I'm this close to kick SwiftUI in the bin and redo everything in good old Cocoa.

Oh and by the way: SwiftUI doesn't seem to have a way to make selectable Text?! *Sigh.*

Not all is lost though. I've managed to get what I planned [last week]({{< relref "week-2-blip-saving-entries.md" >}}) done. I actually though I had the summary view I worked on today planned as well, but that was a bonus objective! So feeling a bit better. Only a bit though.

I've also discovered a bit of a fail in [how I've handled SwiftUI state]({{< relref "debug-swiftui-redraws-using-randomized-backgrounds.md" >}}) which gave me something to write about.

For next week: Figure out how to wrap text?! I am at a loss at this point and it is really grinding my gears.

The entry panel changed again a bit. I am quite happy with this layout now and don't think it'll change anymore.

![the blip entry window, reorganized from previous iterations. The text input field is now the first element, followed by the date & number of entries bottom left and the up/down vote and save buttons on the bottom right of the input field](/images/blip-week-3-screenshot.png)
