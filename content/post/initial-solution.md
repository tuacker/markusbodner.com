---
title: "Initial Solution"
description: "Sometimes I waste 3 hours to find a solution even though the initial one was correct."
date: 2020-07-13T15:14:54+02:00
tags: ["Programming", "Newsletty"]
images: ["/images/jamie-street-dQLgop4tnsc-unsplash.jpg"]
draft: false
---

I write this post in hope to stop my future self from doing this again. Sometimes I waste a few hours to find an implementation for something because I don't like my first draft, or it should do more. The result is always the same: Whatever that first draft was.
<!--more-->

A few weeks ago I was implementing "slugs" for [Newsletty](https://newsletty.com). Slugs in my case are where individual newsletters will live, for example `https://newsletty.com/lists/thisistheslug`. My first draft was to allow `a-z, A-Z, 0-9, -` and `_`.

Then I thought: This world has more than just the English language. What if I allow more. This led me down a hole of what is a valid URL-part and not. Slugs, in my case, are also used for the from address when users send out their newsletters. So on top of what is allowed in URLs I also had to figure out if that holds true for the local-part of an email address (the part in front of the @).

All in all I think I spent a good 3 hours looking at various StackOverflow answers, RFCs, Wikipedia entries and more. Until I decided, you know what...no. Lets just do `a-z A-Z 0-9 - _`.

This is a mistake I keep making. Lets hope by writing it down my brain learns to flag this behavior and alerts me the next time I am doing this.

*P.S.: In this particular case it is a "not right now", not a "not ever" decision. I think internationalization is important. Just not for an MVP or the first version, or whatever you want to call it.*

![Image of a closed off road with multiple signs reading road closed, wrong way, and detour](/images/jamie-street-dQLgop4tnsc-unsplash.jpg)
