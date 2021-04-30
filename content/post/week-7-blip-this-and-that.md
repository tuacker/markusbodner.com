---
title: "Week 7 - Blip - This and That"
description: "They say the last 10% are the last 90%. That's where I'm at."
date: 2021-03-22T09:08:01+01:00
tags: ["Blip", "Devlog"]
images: ["/images/blip/2021-03-22-header-view.png"]
draft: false
---

There is a saying that the last 10% are the last 90% and this past week felt like that. Every little thing that I add needs various this and thats to feel like a real app.<!--more-->

I spent the week finally getting navigation to previous/next dates, or rather ranges (day/week/month/year) to work. And I added a header view that always shows you where in the day you are at:

![showing todays entries with the header displaying the date and time at hour-precision for the current entries that are visible](/images/blip/2021-03-22-header-view.png)

The header always shows the current hour of all the entries that are below it, as you scroll it'll update. This way you'll always know where you are at the moment with just a glance.

Interestingly just adding this header made the app look more like an app than it did before. That confirms my suspicion that I shouldn't worry about making it "look good" until I've got all the functionality in.

While visually not a lot changed from [last week]({{< relref "week-6-blip-date-and-time.md" >}}) there was a lot of code. Every little button and option needs a keyboard shortcut. Needs to be tested and so on. Development of Blip feels very slow at the moment. Especially compared to how I started out at the beginning.

Even for just an MVP I am working on right now, it feels slow. But I know that is how projects are at their "end". There is always a million hidden steps that need to be done. I've initially hoped to get the first version of Blip out at the end of February. It is now almost end of March. I am aiming for end of March now. I feel I am getting close, but I also know that I don't have a website yet, no "Preference Pane", no "First launch" experience, no update mechanism and no payment setup.

There's still a lot of work ahead. But as long as I keep showing up every day I know it'll get done. None of those things are impossible to achieve, so they are bound to happen!

For the next week:

- Write final tests for last weeks changes
- Add preferences pane
- Add first launch experience
- Add update mechanism for app

I've cut "search" from the first MVP release. It'll come shortly after, but for now I am trying to lock down everything to bare necessity and ship!
