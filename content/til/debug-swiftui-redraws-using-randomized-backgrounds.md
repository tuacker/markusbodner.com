---
date: "2021-02-18T12:37:12+02:00"
draft: false
tags: ["SwiftUI", "Programming"]
title: "Debug SwiftUI redraws using randomized backgrounds"
images: ["/images/steve-johnson-wpw8sHoBtSY-unsplash.jpg"]
---

SwiftUI redraws every view affected by a state change. If you are not careful this might cause your entire UI to redraw on every interaction. For me this happened at every keystroke in an text-field. Using random background colors you can find such issues.<!--more-->

Let's look at an example. Here is the entry panel for Blip. I attached a background with a randomized color on every UI element. As I type there is an explosion of colors!

![on every keystroke every label, input and button gets a new background color, the whole UI is flashing](/videos/swiftui-redraw-before.mp4)

What is going on there? Well, in my case: rookie mistakes. I was keeping my entire state in a single struct like this.

```swift
struct EntryView: View {
  @State var entry: BlipEntry
  ...
}
```

So whenever `entry.text` changes on an input SwiftUI then detects the struct has changed. In my case the struct changing affects every view in my UI. The fix (and better approach in general) is to create separate properties for every input (example: `@State text: String`) and create `BlipEntry` only when saving.

I've discovered this colorized debugging approach [via a tweet](https://twitter.com/r_alikhamov/status/1362065679193628672). It's so useful I turned it into a small View extension.

```swift
// make a file, for example: View+Extensions.swift

import SwiftUI

#if DEBUG
private let rainbowDebugColors = [Color.purple, Color.blue, Color.green, Color.yellow, Color.orange, Color.red]

extension View {
    func rainbowDebug() -> some View {
        self.background(rainbowDebugColors.randomElement()!)
    }
}
#endif
```

Now, whenever I need to check if the UI is updating as expected all I have to do is append `.rainbowDebug()` to the individual views. Here is an example:

```swift
struct YourView: View {
  var body: some View {
    Text("hello world").rainbowDebug()
  }
}
```

You can use this on everything that accepts a background, which is pretty much all SwiftUI views to my knowledge. Happy debugging!

And finally, here's how the UI behaves after implementing my fixes:

![unlike before, the colors are no longer flashing because the UI isn't redrawing on every keystroke](/videos/swiftui-redraw-after.mp4)

Much better.
