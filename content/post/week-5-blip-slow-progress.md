---
title: "Week 5 - Blip - Slow Progress"
description: "Progress has been a bit slow for the past two weeks, but I have a feeling it'll pick up again next one"
date: 2021-03-06T09:23:12+01:00
tags: ["Blip", "Devlog"]
images: ["/images/blip/2021-03-06-summary-view.png"]
draft: false
---

These past two weeks progress has been a bit slow. Main reason was all the issues, and to be honest, annoyance I felt around [using SwiftUI]({{< relref "week-4-blip-bye-swiftui.md" >}}). That said, I think next week will be better again.<!--more-->

When I started work on Blip I planned on getting the initial version done and available by the end of February. This didn't quite happen. I've spent the past two weeks fighting with SwiftUI — and then until around Wednesday this week replacing everything in Cocoa. That took away a good chunk of time.

Besides that, I've also been a bit tired this week. A mixture of bad sleep and bad food hygiene (which causes more bad sleep in my case). I am quite happy with the progress I've made though.

Thinking back on other projects, every time I'd run into an issue like I did here, I'd soon be giving up. Getting so annoyed, and thinking myself incapable that I'd drop them entirely. Not this time around though. I've learned from my mistakes. I know that just because I feel stuck for the moment that doesn't mean I have to give up.

This week was also about learning. Getting to know AppKit again and reading further into GRDB, the framework I use to access SQLite. As a result I think I'll get a lot done next week.

Another thing that is bothering me at the moment is how Blip looks. For the "entry panel" I've been looking at it for so long it feels old. And for the summary view, which I've started working on this week, well. I don't like it at all. But I made myself the promise that I'd finish functionality first. I have a feeling that by the end of that it will look more put-together on its own.

I've also spent a day or so trying to make the entry panel grow as more lines are written. Couldn't get it to work quite right though. There is always a weird jump animation here or there, or it interferes too much with manually resizing the window. Dropped that idea for now, but I may revisit it another time.

Plan for the next week:

  - Use actual data to show in the summary view
  - Group data shown between daily/weekly/monthly (and maybe yearly?)
  - Allow selection of the date for above
  - Bonus: Full-text Search?

And finally as has been usual in most of these posts so far, here is how the "summary view" looks at the moment. This is where you'll see all the entries you've made.

![a list of entries made using the Blip app with the first entry selected. The mouse is hovering over the second entry which reveals the entry date](/images/blip/2021-03-06-summary-view.png)




