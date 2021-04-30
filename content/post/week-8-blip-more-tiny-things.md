---
title: "Week 8 - Blip - Beginnings of a configuration"
description: "Working on saving user configuration and more little things making a good app"
date: 2021-03-26T15:03:01+02:00
tags: ["Blip", "Devlog"]
images: ["/images/blip/oudom-pravat-yQi4mAFmRew-unsplash.jpg"]
draft: false
---

More little things to set up and working on the app configuration this week.<!--more-->

As with the [previous week]({{< relref "week-7-blip-this-and-that.md" >}}) this one was again spent doing the little things. A small touch here, a new keyboard shortcut there and some more tests written. I'm a bit dismayed about the past few weeks. Progress seems really slow. I am getting stuff done day-to-day and week-to-week, but I wish it was faster.

A big hold-up this week was configuration and data separation. For macOS applications data is usually kept under a unique bundle-identifier. The problem: Development and Release use the same identifiers. That means, data will mix. And if I try to clean out everything to have a "fresh" environment to test and develop the app? Also means all my real data is gone.

I've scoured the web for a good day on best practices and found nothing. Not a single post. There were some StackOverflow questions with no or lacking answers. For a moment I thought I am being super dumb and missing something obvious. Not at all. The general approach appears to be "yeah it is what it is".

Well. I wasn't content with that. The result, two days of mucking about and finally a working approach which I [wrote about here]({{< relref "how-to-keep-debug-and-release-data-separate-for-macos-app-development.md" >}}).

The other big thing this week was saving preferences. Or the beginnings thereof. The app now remembers which filter interval you selected between launches and everything is set up for me to put more preferences in.

The last visible thing that happened this week was going to a specific date in the summary view. Overall the date and filter navigation is heavily adapted from the Calendar.app and should feel familiar.

![](/images/blip/2021-03-26-goto-date.png)

For the next week I have the following planned:

- Show the positive/negative rating in the summary view of each entry
- Implement editing entries
- Implement a welcome/first time - window
- Implement the preferences pane

Lots of things planned. Looking at the date though that means I will not be able to release the MVP this month. I thought I'd be done by end of February, now March is almost over. I was hopeful that this time my estimation wasn't far off. And I made good progress at first. The last few weeks have been a bit rough though. I am getting there though! Soon™.
