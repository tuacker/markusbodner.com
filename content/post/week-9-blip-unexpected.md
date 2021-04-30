---
title: "Week 9 - Blip - Unexpected"
description: "This week a family member fell sick and I had to take care of them which meant little time left for Blip."
date: 2021-04-03T09:45:01+02:00
tags: ["Blip", "Devlog"]
images: ["/images/blip/2021-04-03-ratings-in-summary-view.png"]
draft: false
---

A family member unexpectedly fell sick this week and I had to take care of them. As a result there was little time for Blip.<!--more-->

The [last time around]({{< relref "week-8-blip-more-tiny-things.md" >}}) I set out with quite some plans for this week. They all fell through. I got little done and as such this post will be a short one as well since I am still a bit low on time.

What I did do this week was improve how the "feeling hearts" are being drawn so I can also show it in the summary view. Once I had them visible in the list I thought: It'd be great if I could toggle them on/off right then and there. This led me to uncovering an issue with my table-reloading code which consumed the rest of the week. I tried out some caching to speed up the table, but that came with its own problems. In the end I went back to loading the whole result set at once.

This works great for day/week/month ranges, but is rather slow for a year-long list of entries. I am sticking with it for now though. I need more time to think through a way to make this super snappy in all cases. And I will definitely not do that before releasing an MVP. It is getting high time I release one.

With this week being the way it was it will take at least one week more now than I wanted to. I am very happy though, that despite everything, I still achieved some progress. It was a rough week and previously such events would stop me in my tracks. But no more!


So for next week I have the same planned as last week!

And as is usual here is a screenshot of how the summary view looks now:


![a couple of entries are shown, some of them have a heart-shaped icon and some a broken-heart shaped icon next to them to indicate the feeling associated with the entry](/images/blip/2021-04-03-ratings-in-summary-view.png)
