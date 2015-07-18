---
layout: post
title:  "ASP.net ResolveUrl without Page"
date:   2011-06-01 20:27:00
categories: blog
tags:
- web development
- asp.net
---

### The quick answer
{% highlight csharp %}System.Web.VirtualPathUtility.ToAbsolute("~/default.aspx");{% endhighlight %}

Don't forget the ~/ (tilde) before the page name.

### The lengthy explanation
Assume that we want to redirect to the default.aspx that's on the site root:
{% highlight csharp %}Response.Redirect("default.aspx");{% endhighlight %}

If we're on a page that's also on the root, it will map to: http://www.mysite.com/default.aspx and work correctly.

### The problem
The problem comes when we're not on the site root but insite a child folder.  
Lets say we're on a page that's insite the /Administration  folder, the same line will map to http://www.mysite.com/Administration/default.aspx that ofcourse won't resolve and return a glorious 404: Page Not Found.

### The solution
Solving this is easy using the ResolveUrl method:
{% highlight csharp %}Response.Redirect(ResolveUrl("~/default.aspx"));{% endhighlight %}

### Where this won't work
ResolveUrl is only available withing the context of a Page or a UserControl, if you're, for instance, inside an ASHX this method isn't available.  
In these cases you have to use the followinf line to do the job:
{% highlight csharp %}System.Web.VirtualPathUtility.ToAbsolute("~/default.aspx");{% endhighlight %}

We must include the tilde before the page name to make it a relative path, otherwise this method will throw an exception.