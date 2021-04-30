---
title: "Prevent NSTextView from polluting undo history"
description: "Learn how to give NSTextView a separate undo stack to prevent it from interfering with your app"
date: "2021-04-30T13:09:45+02:00"
draft: false
tags: ["AppKit", "Cocoa", "Xcode", "Programming"]
images: ["/images/thomas-kelley-hHL08lF7Ikc-unsplash.jpg"]
---

A thing that cost me some nerves while making Blip was getting undo/redo functionality right. Especially when NSTextView was part of the mix.<!--more-->

First off, AppKit makes it very easy to get undo working using the [UndoManager](https://developer.apple.com/documentation/foundation/undomanager). A problem I ran into though was with NSTextViews. To be more precise, in Blip it is possible to edit an entry. Doing so temporarily shows a text view which disappears again on save.

The problem was that the NSTextView would insert its undo commands into the main history. Now if the user were to undo it would lead to a crash because the UndoManager was trying to undo/redo something on a text view that no longer exists!

The solution is rather simple: Give the NSTextView a separate UndoManager!

In my case I started out with adding a property to my view controller the NSTextView would be part of:

```swift
class MyViewController: NSViewController {
  @IBOutlet private var myTextView: NSTextView!

  // A separate UndoManager just for the `myTextView`.
  private var textViewUndoManager: UndoManager = UndoManager()
}
```

Next up the view controller needs to define itself as delegate for the textview:

```swift
extension MyViewController: NSTextViewDelegate {
  // Give the textView a separate UndoManger so it doesn't affect the overall undo-stack.
  func undoManager(for view: NSTextView) -> UndoManager? {
      guard view == myTextView else { return self.undoManager }

      return textViewUndoManager
  }
}
```

It is important to always return the same `UndoManager` instance in this delegate call. That means you can't just do `return UndoManager()` in `undoManager(for view:)`. Doing so would result in a creation of a new undo manager with every change to the text view!

Finally to tie these two things together assign the delegate. You can do so either in Interface Builder or in your code.

```swift
override func viewDidLoad() {
  super.viewDidLoad()

  // Register as delegate so we can set a custom undoManager
  myTextView.delegate = self
}
```

Now the `myTextView` has its own private UndoManager and can do with that what it wants. While you are free to add your own undo/redo actions to the overall UndoManager.

**Important:** Remember to call `textViewUndoManager.removeAllActions()` at appropriate times. For me this is when my edit view closes:

```swift
private func closeView() {
  textViewUndoManager.removeAllActions()
  //...
}
```

Otherwise the undoManager will remember its undo history between invocations and lead to a crash as well!
