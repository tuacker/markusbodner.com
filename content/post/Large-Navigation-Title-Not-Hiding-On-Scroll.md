+++
title = "Fix large navigation bar title not hiding on scroll in iOS 11"
date = 2017-10-08T09:53:44+02:00
tags = ["Swift", "iOS"]
+++

iOS 11 introduced large navigation bar titles. They look great and you should use them on main views. When you use large titles on a ```UITableViewController``` everything works as expected. On scroll the large title hides with a nice animation and returns to a normal smaller one.<!--more-->

There exist two bugs which can prevent the title from showing up. If you set ```prefers large title``` on the navigation bar in the storyboard the setting does not get picked up. I recommend you add the following to the controller you want the large navigation title.

In ```viewDidLoad```:
```swift
override func viewDidLoad() {
  ...
  // Drop the if-#available should you only target iOS 11 and newer.
  if #available(iOS 11.0, *) {
    navigationController?.navigationBar.prefersLargeTitles = true
  }
}
```

Apple recommends to only show large titles in main views. If your viewcontroller has sub-sections make sure to set ```navigationItem.largeTitleDisplayMode = .never``` either in code or in your storyboard.


In addition problems arise if you need to customize your view around your table. Usually you create a ```UIViewController``` for this and then add the views and tableView as required.
If the ```tableView``` is not the first view in your storyboard, the large title fails to hide automatically.

To fix this issue drag and drop the ```tableView``` on top of every other view.

{{< figure src="/media/images/storyboard.png" alt="" >}}

If you are creating the layout via code you most likely need to make sure your ```tableView``` is the first element in the main view's ```subviews``` array.
