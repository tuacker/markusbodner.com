+++
url = "/archive/"
tpye = "archive"
title = "Archive"
date = "2015-01-01"
+++

This is just a dummy-file to force hugo to render the /archive/ site.

The way it works:

Hugo sees the archive/archive.md file and then checks if /layouts/single.html exits.
Abusing this fact I simply render out all content of the type "post" in this layouts/single.html template


It's important that the FrontMatter on top of this file rewrites the url to /archive/