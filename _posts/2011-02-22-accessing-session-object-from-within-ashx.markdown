---
layout: post
title:  "Accessing The Session Object From Within An HttpHandler (ASHX)"
date:   2011-02-22 21:49:00
categories: blog
tags:
- asp.net
---

By default if you try to use the line above you'll get an impressive null

{% highlight csharp %}
var mySession = System.Web.HttpContext.Current.Session;
{% endhighlight %}

To make this work, the only thing you have to do is implement the <br />
`System.Web.SessionState.IReadOnlySessionState` on your handler.

{% highlight csharp %}
using System.Web.SessionState;

public abstract class BaseHandler : IHttpHandler, IReadOnlySessionState {
   public void ProcessRequest(HttpContext context)
   {
       var mySession = System.Web.HttpContext.Current.Session;
       // your code here //
   }
}
{% endhighlight %}

And that's it!