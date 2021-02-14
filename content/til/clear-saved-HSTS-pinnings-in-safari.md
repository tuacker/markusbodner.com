---
title: "Clear saved HSTS pinnings in Safari and macOS"
description: ""
date: 2019-01-02T10:43:17+01:00
tags: ["web-development", "macos", "TIL"]
images: ["/images/delfi-de-la-rua-152121-unsplash.jpg"]
draft: false
---

So today I was trying to get SSL working on my machine with localhost. In the process I set the HSTS headers, telling the browser to never access the non-secure `http://` version of localhost. Thus going to `http://localhost:4000` would always fail as HSTS tells the browser to only access `https://`.<!--more-->

Here is how you can reset the cache Safari has for HSTS pinnings so you can access your local `http://localhost` again.

Open a terminal and follow those steps:

```bash
sudo killall nsurlstoraged

# or edit file, search for "localhost", remove it and then save
rm -f ~/Library/Cookies/HSTS.plist

launchctl start /System/Library/LaunchAgents/com.apple.nsurlstoraged.plist
```

You may have to restart Safari afterwards.

![selective focus photography of pins](/images/delfi-de-la-rua-152121-unsplash.jpg)
