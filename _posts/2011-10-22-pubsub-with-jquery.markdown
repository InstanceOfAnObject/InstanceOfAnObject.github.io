---
layout: post
title:  "PubSub with jQuery"
date:   2011-10-22 01:58:00
categories: blog
tags:
- javascript
- jquery
- patterns
---


## What is PubSub?
PubSub stands short for Publish/Subscriber and is a technique based on events that lets you decouple the logic of an application.  

## When to use this?
The short answer is: Whenever you want to decouple components.  
For instance, at the web UI level, sometimes sections of a webpage must communicate with each other, react on each other activities. To do this we usually have to make the sections aware of each other, making it much harder to maintain.  
Using Pub/Subs we just publish the events and forget about it, "someone" else on the page may make some use out of it.

### How does it work?
The concept is pretty easy to understand and the implementation follows the simplicity.

The basic concept is to have something that triggers an event (the publisher) and have one or more listeners (the subscribers) that are waiting for that event to be fired to act appon, breaking strict dependencies between components.

### The Publisher
This guy here (the publisher) usually reacts upon a user action and screams out loud:  
**"I got something here, it's called [myevent] and comes along with this extra information.  
Anyone interested?"**  
{% highlight javascript %}
$(document).trigger('myevent', [age]);
{% endhighlight %}

### The Subscriber
This guy (the subscriber) meaning in life is to wait for someone to say he got a [myevent].  
There can be as many guys as you want waiting for the same event, and each can react differently.
{% highlight javascript %}
 $(document).bind('myevent', function(e, age){ });
{% endhighlight %}

### Sample Code
Bellow you find a piece of code that shows the functionality in action on a very simple scenario.  
Basically you have a textbox where you can enter numbers, meaning ages for the case.  
Every time you click on the publish button, an event is triggered, publishing a message that contains the typed age.  
Listening are two subscribers that want to be notified whenever that event is triggered.  
One of the subscribers only cares about ages bellow 18, the other one cares about everything else.

Create a new html file and paste this code there and show it on a browser. You'll need internet connection as I'm using Google's CDN to get JQuery.
{% highlight html %}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
 <title>JQuery PubSub Demo</title>
 <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
 
 <style type="text/css">
  .Subscriber{ display:block; list-style-type: none; float: left; width: 200px; border: solid 1px #dcdcdc; margin: 5px; padding: 5px; }
 </style>
</head>
<body>
<h2>Publisher</h2>
<p>
 Publish: 
 <input id="txtPublisherAge" type="text" />
 <input type="button" value="publish" onclick='Publish($("#txtPublisherAge").val())' />
</p>

<h2>Subscriber</h2>
<ul id="ulLessThan18" class="Subscriber"></ul>
<ul id="ul18Plus" class="Subscriber"></ul>

<script type="text/javascript">

 $(document).ready(function(){
  
  // handle ages < 18
  $(document).bind('myevent', 
   function(e, age){
    if(age < 18) {
     $('#ulLessThan18').append('<li>Handled age: ' + age + '</li>'); 
    }
   });
   
  // handle ages >= 18
  $(document).bind('myevent', 
   function(e, age){
    if(age >= 18) {
     $('#ul18Plus').append('<li>Handled age: ' + age + '</li>'); 
    }
   });
   
 });

 // Everytime this method is called, the 'myevent' event is published with the passed age value
 function Publish(age){
  $(document).trigger('myevent', [age]);
 }

</script>

</body>
</html>
{% endhighlight %}