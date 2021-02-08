+++
date = "2021-02-08T13:10:50+02:00"
draft = false
tags = ["Swift", "macOS", "XCode", "Programming"]
title = "Use global keyboard hotkey to show/hide a window using Swift"
images = ["/images/global-keyboard-shortcut.png"]
+++

Here I'll show you how to show/hide a window using a global keyboard hotkey/shortcut, similar to how Spotlight or Alfred work, on macOS using Swift.<!--more--> I needed this for myself with the following requirements:

- works on macOS 10.15+ (Catalina)
- uses Swift

As a result of the OS version requirement we're using the old AppDelegate for life cycle of the app instead of going full SwiftUI.

Begin by creating a new mac project in XCode and select `SwiftUI` for "Interface" and `AppKit App Delegate` for the "Life Cycle".

Next up lets add the [KeyboardShortcuts](https://github.com/sindresorhus/KeyboardShortcuts) package using the Swift Package Manager to make working working with keyboard shortcuts easier.

To do so in pick `File > Swift Packages > Add Package Dependency` in the XCode menu and then point it to `https://github.com/sindresorhus/KeyboardShortcuts`.

Now open `AppDelegate.swift` and set up your shortcut.

```swift
import KeyboardShortcuts

extension KeyboardShortcuts.Name {
  // **NOTE**: It is not recommended to set a default keyboard shortcut. Instead opt to show a setup on first app-launch to let the user define a shortcut
  static let showFloatingPanel = Self("showFloatingPanel", default: .init(.return, modifiers: [.command, .shift]))
}
```

Here we define a shortcut of the name `showFloatingPanel` and define a default hotkey combination of <kbd>⌘ Cmd</kbd>+<kbd>Shift</kbd>+<kbd>Enter</kbd>.

It is not recommended to set default global hotkeys like this. The user might already have a shortcut on this combination. Instead show them a screen when they launch your app for the first time and let them set one up. See the [KeyboardShortcuts documentation](https://github.com/sindresorhus/KeyboardShortcuts) on how to do this. The library provides helpful utilities to get this done.

Now with a shortcut defined, we need to listen to it. Further in your `AppDelegate.swift` inside the `applicationDidFinishLaunching` callback register the shortcuts.

```swift
func applicationDidFinishLaunching(_ aNotification: Notification) {
  // ... other launch setup things

  KeyboardShortcuts.onKeyUp(for: .showFloatingPanel, action: {
    print("Keyboard shortcut was pressed!")
  })
}
```

Your `action` can be anything you want. For example you could use it to show or hide a [floating window]({{< relref "create-a-spotlight-alfred-like-window-with-swiftui.md" >}}) similar to Spotlight and Alfred.
