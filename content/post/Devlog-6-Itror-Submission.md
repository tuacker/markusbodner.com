+++
date = "2015-09-28T15:22:33+02:00"
draft = false
tags = ["Devlog","Itro", "Itror"]
title = "Devlog 6 - Itror: Submission"

+++

Almost two months have passed since my last [Devlog](http://www.markusbodner.com/2015/08/01/devlog-5---itror-points-points-points/) on [Itror](http://www.itror.com). Which is far too long.

If this is the first time you hear about Itror here is the pitch: You have to tap icons in the order they originally appeared, with each round adding a new one to remember. At the end you'll have to recall a sequence of 35 objects.

[![Itror text logo](/media/images/devlog-6-intro.png)](/media/images/devlog-6-intro.png)

When I started development on Itror I wanted to write weekly updates on how the games is progressing but somewhere along the line I fell off. This is going be something I'm improving for my next project. Scrolling past the 5 devlogs I made, it is fun to see how the game came along.

That said I did some small updates on Twitter all the time but even those could've been more frequent.

So what has changed since August? First off: **The game is finished!** As I write this I'm doing the final release compilations and uploading to the app store for approval.

#### Advertising & IAP

A large part of the last two months was spent integrating a way for me to earn money. The game will be free, supported by ads. If you chose to you can buy it for $2.99 / 2.99€ to remove all ads. Additionally the full version allows you to activate several modifier at once. In the free version you can only have one active at a time.

I am using the Heyzap SDK to integrate ads with the cocos2d-x engine. Heyzap is Obj-C & Java based, cocos2d-x C++. I had to figure out how to create a bridge between my c++ code and Heyzap's Obj-C & Java code. There weren't any guides but I managed to make it work. Once the game is out I'll write a guide on how to integrate the Heyzap SDK with cocos2d-x for iOS and Android.

#### Highscores & Social

From the Game Over screen you'll be able to share a screenshot of your score on Twitter, Facebook and more. For iOS I've implemented leaderboards via Apple's Game Center. You'll be able to challenge your friends to beat your highscore. 

#### Sounds

Finally I added sound effects to the various actions in Itror. This immediately improved how the game feels and plays. Even though most mobile gamers will turn them off, having sounds is a large part of what makes a game a game.

You'll be able to play your own music while playing Itror!

#### Testing

Test, test, test. Show people your game. This is something you hear over and over again. It is not until you let other people play your game that you realize what all the fuss is about.

Every time I've let someone new play the game I found problems to fix. My first tutorial turned out to be too confusing. For some the game was too easy. Others got confused by how stuff animated. I've made dozens of little changes due to playtesting. It is invaluable.

#### Meta

Both the Appstore and Play Store require quite a few assets. Screenshots, videos, texts. In case of the iPhone I've created a 30s long app-preview video which will be visible in the appstore on your phone. Screenshots have to be in multiple resolutions for multiple devices and tablets.

Creating these assets is, personally, one of the lesser enjoyable aspects of game development. In addition to all the marketing and some business related stuff.

With that said all I have left to do is to create a release announcement trailer and a final gameplay/release trailer. I'll use the [Average App Store Review Times](http://appreviewtimes.com/) period to create them.

-
Sign up for the newsletter on [www.itror.com](http://www.itror.com) to get notified once the game is available!
-


**Thank You** to all the people who have joined me on this journey. As always, if you have any questions feel free to contact me. You can find my email on top & bottom of this page. You can also follow and ask me questions on [Twitter](https://www.twitter.com/tuacker).