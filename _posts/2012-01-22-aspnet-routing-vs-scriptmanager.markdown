---
layout: post
title:  "ASP.Net Routing Vs ScriptManager"
date:   2012-01-22 15:57:00
categories: blog
tags:
- web development
- asp.net
---
Recently I had a problem with ScriptManager on a WebForms site where I was also using the ScriptManager.

Suddenly my ASP.net validators stopped working client-side and on Firebug I could read this error:
{% highlight text %}
ASP.NET Ajax Client-Side Framework Failed To Load
{% endhighlight %}
Crap... what am I doing wrong here!?

It seems that Rounting messes with the .axd files script manager generates so we only need to tell the routing to ignore those:
{% highlight csharp %}
routes.Ignore("{resource}.axd/{*pathInfo}");
{% endhighlight %}

Done!!