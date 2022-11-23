---
title: "Week 6 - Blip - Date and Time"
description: "This week revolved around showing entries at the correct date and time"
date: 2021-03-12T17:39:00+01:00
tags: ["Blip", "Devlog"]
images: ["/images/blip/2021-03-12-select-date.png"]
draft: true
---

This weeks focus was on creating a summary view to show all entries. Took me a while to get going and it doesn't look like much at the moment, but there is progress!<!--more-->

First thing this week was figuring out how to observe changes made to the DB and refresh the summary view. Thanks to GRDB and a bit of elbow-grease that turned out quite easy. Once over that small hurdle I got sidetracked a bit and implemented some more keyboard shortcuts.

As part of implementing the "delete entries" shortcut I realized that I need undo functionality. I actually prepared myself to be stuck on that for the rest of the week. Turns out Foundation has the [Undo Manager](https://developer.apple.com/documentation/foundation/undomanager) that makes the whole thing a breeze. Took me all of a day to get undo/redo working. Nice! That said I don't have everything undo-able yet.

I'm unsure if inserting a new entry should create an undo action if the summary window isn't currently visible. I'm also thinking that the undo-actions should be cleared out once the user closes the summary window. That fells to me to be the expected behavior. Need to play with it a bit more.

I've also added my first context-menu for the summary view and made sure every user-facing string I'm using so far is localizeable to maybe save me future sorrow.

Finally today on Friday I've started working on what I set out to do [last week]({{< relref "week-5-blip-slow-progress.md" >}}). Hah! The list of entries can now be filtered by day/week/month/year; though you can't select the specific date for these yet. So it is all centered around "today". To round off today I made the entry date on the new entry panel clickable so you can select a different date for the entry.

In addition to all of the above I've also kept up with writing both unit and UI tests for all these things. Knowing I can run a suite of tests that'll point out issues is amazing.

Given the progress the things I have planned for next week are:

- Allow selection of the date for the day/week/month/year filter
- Add full text search? Gonna be a tough one I think
- Improve how the summary view looks. Don't like the current look at all

And to round off this weekly report, here is a video of the filtering and one for how the date selection works:

{{< video src="/videos/blip/2021-03-12-summary-view-nice.mp4" alt="First one entry for today is shown. The user then selects weekly and another entry appears, the same thing repeats for monthly and then yearly which reveals all entries made in the current year" >}}

{{< video src="/videos/blip/2021-03-12-select-date.mp4" alt="The user is making a new blip entry and then clicks on the current date below the input. This reveals a popover that allows the user to select a different date and time, which they do" >}}

