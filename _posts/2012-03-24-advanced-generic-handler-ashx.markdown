---
layout: post
title:  "Advanced Generic Handler ASHX"
date:   2012-03-24 01:09:00
categories: blog
tags:
- web development
- asp.net
---
## Introduction

In ASP.net we have something that is usually overlloked that is called Generic Handlers.  
I see a lot o f people using pages to process AJAX requests when we can use this much less expensive endpont.  
This is an completelly worked out Generic Handler that trully knows how to handle your http (AJAX and not) requests.

Sample code

## Background

For a long time I used plain Generic Handlers (ASHX files) to handle my AJAX requests but it felt stupid and painful.  
I mean, the functionality was there but the whole process of handling the requests wasn't straight forward.  
So I made a list of the things I would like to have on and handler:

* Standard way to parse the query string
* Transparently handle multiple methods within the same handler
* Support methods with multiple typed arguments, not just strings
* Support Methods that receive lists as an argument
* Support passing less arguments than the method is expecting (like optional parameters)
* Transparently reply eather POSTs or GETs
* Support default object serialization to JSON but still let me override it on each method
* Return application/json by default but still let me override it on each method
* Support JQuery $.ajax request
* Support request by query string (url right on the browser)
* A way to visualize the methods the hadler supports (like webservices do)
* Extensible

And that's it...

I can tell you in advance that it already does all this and more.

## Using The Code

### List the Handler methods
I've provided a very basic way of listing the methods the Handler exposes.  
This is specially useful to test if the handler is working correctly (like on webservices)
Do do so just append *?help* at the end of the handler URL:

*http://localhost/mydemohandler.ashx?help*

### Calling the Handler from the browser URL
Using this handler is very simple:

1. Create a new Generic Handler
2. Clear everything inside the handler class
3. Inherit from my Handler class

DONE! Now you only need to add your methods.

Lets create a very simple example that receives a name and returns a string (see on the project).
{% highlight csharp %}
public class MyFirstHandler : BaseHandler
  {
    // I don't bother specifying the return type, it'll be serialized anyway
    public object GreetMe(string name) 
    {
      return string.Format("Hello {0}!", name);
    }
}
{% endhighlight %}

To call this method through a URL use:  
*MyFirstHandler.ashx?method=GreetMe&name=AlexCode*  

### AJAX Request using JQuery
If you want to use JQuery AJAX method you just need to know the object the handler is expecting to get.  
On the data property of the $.ajax request you must pass something like:
{% highlight json %}
{ 
  "method": "mymethod", 
  "args": {
    "name": "Alex",
    "country": "CH"
  } 
}
{% endhighlight %}
Be aware that everything is case sensitive!
{% highlight js %}
$.ajax({
 url: 'MyFirstHandler.ashx',
 type: 'GET',
 data: { method: 'GreetMe', args: { name: 'AlexCode'} },
 success: function (data) {
  alert(data);
 }
});
{% endhighlight %}

### Writing a method that returns HTML
Like I said on my intention points above, I need to have some methods that return whatever I want like HTML, XML, images, files, etc...  
The default behavior of the handler is to return JSON so, by method, we need to explicitly say that we want to handle things our way.  
For that just use these lines anywhere within the method:

{% highlight csharp %}
SkipContentTypeEvaluation = true; 
SkipDefaultSerialization = true;

// you can specify the response content type as follows
context.Response.ContentType = "text/html";
{% endhighlight %}

Lets see an example on how we could write a method on the handler that returns HTML:
{% highlight csharp %}
public object GiveMeSomeHTML(string text)
{
 StringBuilder sb = new StringBuilder();
 sb.Append("<head><title>My Handler!</title></head>");
 sb.Append("<body>");
 sb.Append("This is a HTML page returned from the Handler");
 sb.Append("The text passed was: " + text);
 sb.Append("</body>");

 context.Response.ContentType = "text/html";
 SkipContentTypeEvaluation = true;
 SkipDefaultSerialization = true;

 return sb.ToString();
}
{% endhighlight %}

### Optional Parameters and nullable types
All parameters in the methods are optional. If they're not passed their default value is assigned.  
Also all parameters can be nullable. In this case the default value will be null.  

Please have a look at the attached code sample for more examples.

### Points Of Interest

I can say that this handler already saved me a good amount of development and maintenance hours.
Currently all my AJAX requests point to a method on an handler like this.

### History 

v1.0 - The first wide open version  
This is a work in progress, I keep improving it regularly.  
I have no doubt that you'll try to use this in scenarios I haven't predicted.  
Please send me your requests and desires, I'll do my best to implement them.  