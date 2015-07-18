---
layout: post
title:  "Ajax Requests Cache Problems"
date:   2011-07-11 04:04:00
categories: blog
tags:
- web development
- ajax
- jquery
---

If you're doing GET HTTP requests, chances are that your browser will cache them.  
This means that if the request is exactly the same, it will only reach the server the first time. All subsequent requests, if exactly the same, will be given by the browser's cache.

This is actually good if the result of the request is supposed to be the same, but at that point we shouldn't be doing it in the first place right? :)

To overcome this "problem" we have to tell in some way that we don't want the result to be cached.

### Using jQuery Ajax
If you're using jQuery to perform your AJAX requests you can do:
{% highlight javascript %}
$.ajax(
  cache: false,
  url: 'http://myurl',
  data: {}
);
{% endhighlight %}

This will work for this particular request.  
If you want to expand the scope of this setting to all ajax request you can set it on the global ajax configuration:
{% highlight javascript %}
$.ajaxSetup({ cache: false });
{% endhighlight %}

Be aware that this only happens on GET requests, all the others are never cached.

### Be aware of the insights
The theory behind this is that browsers use cache for requests with the exact same signature. So if you change something on the request the cache won't be used.

In web there's no magic, and this thing here is no exception. When a $.ajax have the cache set to false what it does is append a dummy parameter to the query string.
The name of the parameter is a single _ (underscore) and the value is a timestamp.
This way they are quite sure there's no parameter name collision and that the querystring is always unique.

This usually isn't a problem unless you actually already use a parameter _ on your application querystring or if you perform some kind of URL parameters validation uppon request and find an unexpected parameter sitting at the end
