---
layout: post
title:  "Getting the file extension on SQL Server"
date:   2009-10-01 16:41:00
categories: blog
tags:
- sql server
---

<p>
Today I had the need to get the extension of a file name I have stored on a table column.
</p>

Googled it a bit and ended wrapping the concepts I've found and making my own solution:

{% highlight sql %}
REVERSE(
    SUBSTRING(
        REVERSE('filename.pdf'), 
        0, 
        CHARINDEX('.',REVERSE('filename.pdf'))
    )
)
{% endhighlight %}