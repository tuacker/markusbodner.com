+++
date = "2017-05-18T14:23:03+02:00"
draft = false
tags = ["Realm", "Budget With Claire", "Devlog"]
title = "Automatic recreation of Realm DB during development"

+++

In a [previous devlog]({{< relref "choosing-how-to-persist-data-in-ios-and-beyond.md" >}}) I mentioned choosing [Realm](https://realm.io) as backend for [Budget With Claire](https://budgetwithclaire.com). I like it so far, but there has been a minor nuisance. During early development the layout of the DB changes all the time.

If you want to change the existing schema Realm requires a migration from old to new. This is important for production code. Writing a migration during early development for every minor change is tedious and overkill.

Time to automate! Realm exposes a `deleteRealmIfMigrationNeeded` configuration. You can set this config to `true` for debug builds and Realm will re-create the DB for you. Here is how I do it:

```swift
// AppDelegate.swift

// at the top add:
#if DEBUG
  // required to automatically recreate the DB during development
  // see func application() for more info
  import RealmSwift
#endif

// in func application(didFinishLaunchingWithOptions), add:
#if DEBUG
  // In debug builds, delete the realm if a migration is needed
  // Reasoning: The DB changes all the time during development,
  //            this way we don't have to manually delete the realm
  //            database all the time.
  Realm.Configuration.defaultConfiguration.deleteRealmIfMigrationNeeded = true
#endif
```

Here we use a simple `DEBUG` compiler flag. Debug-builds will have the code above added in the `AppDelegate.swift` file. Once our app starts and Realm notices a migration is needed it recreates the database for us.

Of course this removes all existing data and hides the need for migrations. I only recommend using this crutch for early stage development. After your schema is somewhat defined, or you released a version to the public, this will do more harm than good as you might miss required migration steps.
