---
layout: post
title:  "DateTime, .Net JavaScriptSerializer, JSON And Javascript"
date:   2011-02-28 17:01:00
categories: blog
tags:
- javascript
- c#
- jquery
- jquery-ui
- json
---

If you're using .Net JavaScriptSerializer and are having trouble handling the way it serialized DateTime types to JSON then read on, this might help.<br />
<br />
<h2>Scenario</h2>On a page I have:<br />
<ul><li>an html textbox element set as a JQuery datepicker</li>
<li>a button that makes an AJAX call and returns a date and populates the above control</li>
<li>The method I call on that ajax request is using the .net JavaScriptSerializer that serializes dates the following way:
{% highlight javascript %}
/Date(628318530718)/
{% endhighlight %}</li>
<li>Im using the following to populate the textbox:
{% highlight javascript %}
$('#txtDate').datepicker('setDate', item.Date);
{% endhighlight %}</li>
</ul><br />
<h2>Problem</h2>On IE the textbox displays the the following: NaN/NaN/NaN<br />
Somehow FF is able to unwrap this and show the correct value on the textbox.<br />
Nice! :(<br />
<br />
<h2>Solution</h2>We must unwrap that value our-selfs like shown bellow:
{% highlight javascript %}
myDate =  new Date(parseFloat(item.Date.slice(6, 19)));
$('#txtDate').datepicker('setDate', myDate);
{% endhighlight %}