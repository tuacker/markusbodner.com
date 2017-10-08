+++
title = "Fix large navigation bar title not hiding on scroll in iOS 11"
date = 2017-10-08T09:53:44+02:00
tags = ["Swift", "iOS"]
+++

iOS 11 introduced large navigation bar titles. They look great and you should use them on main views. When you use large titles on a ```UITableViewController``` everything works as expected. On scroll the large title hides with a nice animation and returns to a normal smaller one.

Problems arise if you need to customize your view around your table. Usually you create a ```UIViewController``` for this and then add the views and tableView as required.
If the ```tableView``` is not the first view in your storyboard, the large title fails to hide automatically.

To fix this issue drag and drop the ```tableView``` on top of every other view inside that controller.

{{< figure src="/media/images/storyboard.png" >}}


I've filed a bug with Apple and hope this gets fixed in the future.
