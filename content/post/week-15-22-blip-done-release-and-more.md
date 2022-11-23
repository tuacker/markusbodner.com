---
title: "Week 15–22 - Blip - Done, Release and More"
description: "Long time no update, I've since then released Blip and pushed an update or two"
date: 2021-07-02T14:01:00+02:00
tags: ["Blip", "Devlog"]
images: ["/images/raimond-klavins-dP5RKDUJqeU-unsplash.jpg"]
draft: true
slug: "week-15-22-blip-done-release-and-more"
---

It's been a while since I've wrote an update for Blip here. There are a couple of reasons for that, one of the biggest being that updating this blog is a bit too cumbersome with the setup (Hugo) I'm using.<!--more-->

There's also the fact that I've come to not enjoy writing these weekly updates. I probably should still do them if only for a nice historic record of how Blip progressed. But I haven't been able to muster up the motivation to do that for several weeks now.

Today, in an attempt to procrastinate though, I'll do a quick update. Since [the last time]({{< relref "week-14-blip-website.md" >}}) a lot has changed. For one: [Blip](https://blipnotes.app) is out and available! I haven't done a proper launch yet though. There is still some functionality I want done before I do that!

Since that last entry I've made quite a few changes:

- Set up the website
- Wrote a script that builds, bundles a DMG, notarizes said DMG and generates delta patches and release notes
- Implemented payment / trial / licensing
- Automated deploying new versions of the website & releases
- Implemented a Sidebar for Day/Week/Month/Year interval navigation
- Implemented cutting on top of copying entries
- Updated UI once more to look even better (not yet released)

The first four points above are a huge boon. Having all that grunt work of how to make releases, accept payments, and deploying releases figured out makes it easy to ship new versions. I am very happy that I've done that. And even though Blip isn't fully launched yet I am also excited that the app is generally available for anyone to try.

The other three points I am less excited about. Don't get me wrong those are all things that I want, but I've been messing about with these for 3 weeks now, whereas I should spend my time on the last few features I want to have and focus on marketing.

To keep up the tradition, here's a quick video showing how Blip looks at the moment (this version isn't yet released):

{{< video src="/videos/blip/2021-06-29-text-selection.mp4" alt="showing three entries where the user is selecting rows at first and then the text of an entry directly showing off that the app supports direct text-selection as well as per row selection" >}}

*PS: To my surprise I kinda did enjoy writing this article. Maybe I can get into the habit of writing updates again. Maybe on a monthly schedule.*
