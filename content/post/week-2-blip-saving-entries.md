---
title: "Week 2 - Blip - Saving entries"
description: "This week I've improved the up/down vote buttons and implemented data persistence"
date: 2021-02-12T13:16:42+01:00
tags: ["Blip", "Devlog"]
images: ["/images/blip-week-2-screenshot.png"]
draft: false
---
The second week working on Blip didn't quite start off as I wanted but I managed to turn it all around by the end of the week. Sweet!<!--more-->

[Last week]({{< relref "week-1-blip-getting-started.md" >}}) I said my plan was to implement data persistence using SQLite. It didn't look good for half of the week. Monday until sometimes Wednesday I got distracted with making the up/down vote buttons prettier. As well as improve how they work. There is something about finding the correct icon and playing around with the look of something. I can get lost in this process for hours on end.

On Thursday I've managed to refocus my efforts on what I had actually planned this week. To my surprise adding SQLite was easier than I had expected. Thanks go to [GRDB](https://github.com/groue/GRDB.swift.git) a Swift toolkit around SQLite that made it easy.

I did get lost in trying to make publishers/combine work, until I realized that for the new-entry panel I don't need that at all. I can just query the entries-count when the window is about to show and thats that!

I'm very happy that two weeks in a row now I've somehow managed to get exactly what I had planned done. Usually I'm off by 3 weeks. I think having a clear focus on what I want and saying no to everything else is important. My mental health has been great these last 3 weeks as well. And getting what I want done is further boon to that!

Next week I'll introduce keyboard shortcuts to toggle up/down votes and saving. I also need to figure out how to do singular/pluralizations of strings in Swift/SwiftUI. (See the video below "1 entries" is not correct!). If there is any time left after that I'll begin work on the Daily/Weekly/Monthly(/Yearly?) summary view.

Biggest road-block this week was (Swift) Combine and how to combine that with SwiftUI. Even though I didn't end up needing it, it'll probably become relevant again with the summary view. Still don't entirely understand the process. Well I get what and how Combine works, but getting it to play nice with SwiftUI is what is throwing me up.

Here is a video of saving an entry and how the app looks this week:

![video showing an entry being saved in the Blip app and then the saved record being selected in SQLite](/videos/2021-02-12-blip-persistence.mp4)
