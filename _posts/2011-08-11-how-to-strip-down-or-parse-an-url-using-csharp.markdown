---
layout: post
title:  "How to strip down or parse an Url using C#"
date:   2011-08-11 18:58:00
categories: blog
tags:
- asp.net
---

Many times I need to get the segments of an Url, and I'm not only talking about the query string.<br />

If we search around the web we can see a lot of ideas for parsing URLs, most using regular expressions.  
The fact is that .net Framework gives us a much better tool: [System.Uri](http://msdn.microsoft.com/en-us/library/system.uri.aspx)

So if we have an Url that we need to strip down we can write:
{% highlight csharp %}
public void MyMethod(string url)
{
	System.Uri path = new Uri(url);
	var protocol = path.Scheme;
	var host = path.Host;
	// See the System.Uri documentation for the available methods
}
{% endhighlight %}

Note that this object is the same that you may be familiar with and is used when we get the current HttpContext url:
{% highlight csharp %}
System.Web.HttpContext.Current.Request.Url
{% endhighlight %}