---
title: "Week 4 - Blip - Bye SwiftUI"
description: "As a result of last week I decided to drop SwiftUI. At least for now"
date: 2021-02-27T09:10:15+01:00
tags: ["Blip", "Devlog"]
images: ["/images/yancy-min-842ofHC6MaI-unsplash.jpg"]
draft: false
---

I ended [last week]({{< relref "week-3-blip-what-the-fuck.md" >}}) with a bit of a downer. After a lot back and forth I have now dropped SwiftUI and gone back to good old AppKit/Cocoa. Which took me a while to get used to again.<!--more-->

It all started with a simple problem: Display entries in a list. Huh, can't be that hard right?

{{< video src="/videos/lists-old-SwiftUI-no-resize.mp4" alt="showing a list of text in a window with a scrollbar, as the window resizes text gets truncated" >}}

Here I'm using an old version of SwiftUI because I want macOS Catalina to be supported by the app. Maybe I am doing something wrong? I spent a good day looking for solutions, yet the end results with every attempt end up like the next video. With one exception, where I drop down to AppKit entirely.

{{< video src="/videos/lists-old-SwiftUI-broken-resize.mp4" alt="same list as in the above video, but as the window resizes text re-flows but lines get cut off and become unreadable" >}}

Then it hit me: maybe this is a bug with SwiftUI. Give it a try with a new version. I download and install  Big Sur on a separate volume — and yes, it is a bug! So there I am thinking about making macOS Big Sur the minimum. I play around with the list a bit more. Turns out with bigger lists the performance gets really bad. This here is just 100 entries. Look at the scroll-bar as I navigate using the keyboard in the second part of the video.

{{< video src="/videos/lists-new-SwiftUI-broken-scroll.mp4" alt="same list again, resizing works as expected, but as I scroll through the list the animation gets choppy and the scroll-bar indicator jumps around like crazy" >}}

The performance of the list gets so much worse with a few more items. And it's not like there is a lot I could be doing wrong here. All examples are like 10 lines of code!

```swift
struct SummaryView: View {
  private let entries = makeEntries()
  @State private var selection: UUID?

  var body: some View {
    List(entries, selection: $selection) { entry in
      Text(entry.text)
    }
  }
}
```

Looking around a bit more I discovered ScrollView+LazyVStack (Big Sur+ only). And the performance of that is a dream. Even with thousands of entries everything remained smooth as butter.

{{< video src="/videos/lists-lazyVStack.mp4" alt="same list once more, this time using a lazy-v-stack in SwiftUI and performance is great" >}}

But. BUT! There is no selection and no keyboard navigation (so many "but"'s this past week).

Sure I could make a right-click/context menu to copy entries. The UI framework has very lacking concepts for keyboard interaction though. Did you know there is no way to make selectable text in SwiftUI unless you drop down to AppKit/UIKit? Turning a LazyVStack into something that behaves like a list, where you can navigate with arrow up/down keys? I wouldn't even know where to start. SwiftUI doesn't expose facilities for that (yet).

Since I already have a few workarounds where I drop down to AppKit to begin with, and with the above performance and interaction problems I decided to redo everything I have so far in AppKit. Didn't work with that for a while so it took some re-learning, but I am up to speed now. Everything is working again. Sure there is a bit more code to set up, but getting the UI to do what you want it to is so much easier it feels. And it is very smooth!

SwiftUI is great, and I'd love to use it. But as far as desktop applications are concerned, where keyboard and shortcuts are a huge thing? I feel like the framework isn't quite there yet.
