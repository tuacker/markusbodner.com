+++
date = "2017-05-16T20:53:04+02:00"
draft = false
tags = ["iOS", "Swift", "XCode", "Realm"]
title = "Choosing how to persist data in iOS (and beyond)"

+++

In one of my iOS projects I had to figure out how I store data. There are several ways, all with their pros and cons. Let's look at a few of them and what I ended up with. Here is what I reviewed:

  * NSUserDefaults / NSUbiquitousKeyValueStore
  * SQLite
  * CoreData
  * Realm.io

<!--more-->

### NSUserDefaults / NSUbiquitousKeyValueStore
NSUserDefaults is a simple and easy way to store small amounts of data relevant to your app. For small amounts of data, like TV shows the user cares about, NSUserDefaults is a good candidate. If you need the data to sync across (iOS) devices the users controls, use NSUbiquitousKeyValueStore. Usage is similar to NSUserDefaults with the capabilities to sync across devices, but know it is currently limited to 1MB of data.

### SQLite
Not only has SQLite been around for a while, it also very, very good at its job. On top of that iOS ships with SQLite built in. If you need to store complex data, with relations to each other this is what you should use. The only downside here is that SQLite doesn't sync across devices. You could store the SQLite-DB in iCloud but this opens up all kinds of issues, like merging data.


### CoreData
While built on top of SQLite, CoreData is not SQLite and handles quite different. This is the Apple approved and provided way to store data on iOS devices. If all you ever care for is iOS, use this. CoreData even allows you to sync your data over iCloud with all user-owned devices, for free. Remember, you are locked into the Apple ecosystem. If you ever plan to release an Android version of your app, data will not be able to flow easily between these two ecosystems.

### Realm.io
Depending on your needs, Realm is a free, open source database built with a mobile-first mindset. It comes in two components: *Realm Mobile Database* and *Realm Mobile Platform*.

Realm Mobile Database is a quick and clean library around your objects to persist data in your app. You are using normal objects and all saving is done for you after minimal set-up.

Realm Mobile Platform is a database you have to host yourself on your own servers. Together with the mobile database it is easy to build an offline-first app with syncing capabilities. Because Realm is available in Swift, Objective-C, Java, React Native and Xamarin it is possible to share data between Android and iOS with ease.

### What Is Needed?
Before deciding on what to use you have to take a step back and and look at your needs. If you only care about a few bits of data go with NSUserDefaults, its easy, quick and works.

For my project I know I'll have to work with an ever growing set of data. My users will enter data every day, sometimes several times a day. While my initial version won't have any sort of sync capabilities, it is something I have planned down the line. Finally, I am starting out with iOS but I do have plans for Android later on.

### Conclusion
Because I do not want to be locked into any ecosystem and have plans to sync data I ended up choosing Realm. Giving the docs a quick look-over the implementation seems easy enough. I've also heard good things about Realm the past year, so to me this seems a solid choice.

The only thing I am currently unsure about is how easy or hard it'll be to move from a on-device only setup to one with data synchronization. But I will cross that bridge once it is time. I'm also aware of having to self-host the DB on my own server but I've already got experience in that and this won't be an issue for me.
