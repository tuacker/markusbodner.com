+++
date = "2015-01-01T11:18:49+02:00"
title = "Archive"
+++

### Explaination of this file

This is a dummy-file to force hugo to render the /archive/ site. The content, aside from the FRONTMATTER is acutally completely disregarded.

## The way it works

Hugo sees the file in "content/archive/archive.md and then checks /layouts/archive/single.html for the template to render this content TYPE. (If that template doesn't exist it falls back to /layouts/_default/single.html)

Abusing this fact (hugo checking layout/TYPE/single.html first) we simply render out all content of the type "post" in this TYPES ("archive") template at /layouts/archive/single.html

Obviously a "single.html" shouldn't render a LIST of CONTENT but that why this is a hack.

## Required FrontMatter config
The FrontMatter on top of this file has contain at least these things for this to work:

	* Rewrite url: url = "/archive/" (so the template renders to http://baseurl.com/archive/)

	* Set the date to be the oldest content of all with the year set to the same year as the actual first post
		Example: Your first actual post is on "2015-05-21" so the date of this file should be "2015-01-01"
		This way the last post has a .Prev.Permalink to the archive


## But why not use the default /layouts/post/list.html (or layouts/_default/list.html or /layouts/_default/section.html ) ?

We have not found a way to rewrite the url from http://baseurl.com/post/, where the actual LIST of POSTS is usually rendered to http://baseurl.com/archive/.

Rendering the archive @ http://baseurl.com/post/ is still active but the URL is rather unfortunate in my opinion so this hack.
