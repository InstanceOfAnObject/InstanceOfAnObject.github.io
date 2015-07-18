---
layout: post
title:  "How to put an ASP.net site offline"
date:   2011-07-05 01:13:00
categories: blog
tags:
- web development
- asp.net
---

This is the fastest, cleanest and stand-alone solution I know to put an ASP.net website offline.

On a perfect world we would never ever need to put our site offline... never!... but we're all grown up now and there's no such thing as a perfect world and we need to put our sites into a comma stage so we can begin surgery without thinking about outside factors.

### The trick: *app_offline.htm*
There are many ways of putting your ASP.net website offline but the fastest way is to just drop a file named *app_offline.htm* on the site's root. BAM! That's it folks, good night!

Ok, not so fast, I have one more trick on the sleave.

As you can imagine, this *app_offline.htm* file can contain HTML markup which will be returned to the user. So you can build you Offline page all in there in plain HTML for your users to see.  
As long as you have this file on the website root, all requests to anything on that website will be redirected to this offline page... an this leads us to a problem...

### Showing images on app_offline.htm
This is nice 'till the point you try to show an image on that page.  
Like I said above, all requests to anything on this website will be redirected to the app_offline.htm file, and that includes any image file you mas want to show on you cute offline page.

To overcome this you have two options:

1. reference an external image file with an URL that point to another site
2. Embed the image file right on the markup

### Embedding images inside the app_offline.htm
&lt;img&gt; tags have the ability to consume more than direct pointers to image files, they can read Base64.  
So the idea is to convert our images into Base64 and inject that code on our page:
{% highlight html %}
<img class="undermaintenanceimage" src="data:image/png;base64,[BASE64 DATA]" />
{% endhighlight %}
Just replace [BASE64 DATA] with your image in Base64 format.<br />

If you don't know how to convert an image into its Base64 representation you may use one of the services online that do that for you, [try this one for example](http://www.motobit.com/util/base64-decoder-encoder.asp").

### Conclusion
This way you can create a simple and stand-alone offline file without having to worry about external references or much harder to maintain techniques.