---
layout: post
title:  "Overriding FormsAuthentication For Some URLs"
date:   2011-10-30 20:19:00
categories: blog
tags:
- asp.net
- routing
- forms authentication
---


How many times did you thought that creating virtual directories with specific web.config files was lame?  
If you feel the pain and want it to go away, read on!  
Also note that although I'll refer a lot to HttpHandlers on this post, everything here (except the route registration) is also true for common web pages.  

## Be sure to have a look at this
A few days ago I wrote about [handling HttpHandlers with ASP.net routing](http://www.instanceofanobject.com/2011/10/aspnet-40-httphandler-routing-support.html).  
I'll refer to those extension methods to register my test handler route, so have a look on that post before continuing.

Now what I need is a way to override the default FormsAuthentication configuration for a specific set of HttpHandlers.

## Virtual Folder, web.config and the ASHX files
FormsAuthentication support this out-of-the-box by simply putting the resources with special security concerns on a separated folder with its own web.config file.

So if you want a virtual directory to allow access to anonymous users just add a web.config file with nothing but this in it:
{% highlight xml %}
 <system .web="">
  <authorization>
   <allow users="?">
  </allow></authorization>
 </system>
</configuration>
{% endhighlight %}
This will work for any resource can can be accessed through an URL but this isn't always the case with HttpHandlers.

## FormsAuthentication and HttpHandlers **without** ASHX file
Using the extension methods I wrote on the [said previous post](http://www.instanceofanobject.com/2011/10/aspnet-40-httphandler-routing-support.html) you can create an HttpHandler by simply creating a new class and implementing the IHttpHandler interface and point a route to it, just like this:
{% highlight csharp %}
RouteTable.Routes.MapHttpHandlerRoute(
    "Test", 
    "Unsecured/Controllers/Test", 
    new MyApplication.UnsecuredHandlers.MyUnsecuredHandler()
);
{% endhighlight %}

This means that, whenever you call ht**://mydomain/Unsecured/Controllers/Test the request will be routed to MyUnsecuredHandler instance, not to a physical uri location as usual.  
Now have a look at the route. It begins with *Unsecured* right? Keep reading and you'll understand why.

But we're not there yet, what I really want is to say that some of my handlers allow anonymous requests, and for that I'll edit my website web.config and add the following:

{% highlight xml %}
<configuration>
 <location path="unsecured">
  <system .web="">
   <authorization>
    <allow users="*">
   </allow></authorization>
  </system>
 </location>  
</configuration>
{% endhighlight %}

Now its done!
Notice that on the location path I only have *unsecured*. This will grant request permissions to all routes that begin with *unsecured*!  
This is great because now I don't have to bother about structuring the resources on virtual directories and possibly duplicating the code for different scenarios.  
Whenever I need a Page or and HttpHandler to be available to anonymous users I just need to create a route to it that begins with *unsecured*.

If you don't like this approach (specially for pages where the url is visible for the users) you can always add as much *location* entries on the web.config as you like.

If you're **not using Routing** you can still specify a location to your resources putting the uri of the Page or HttpHandler on the *path* attribute:
{% highlight xml %}
<configuration>
 <location path="MyUnsecuredPage.aspx">
  <system .web="">
   <authorization>
    <allow users="*">
   </allow></authorization>
  </system>
 </location>  
</configuration>
{% endhighlight %}