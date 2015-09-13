---
layout: post
title:  "JQuery UI Autocomplete With ID"
date:   2011-01-27 20:26:00
categories: blog
tags:
- jquery
- jquery-ui
---

<div class="separator" style="clear: both; text-align: center; background-color: #FAA523;">
    <a href="http://jqueryui.com/" imageanchor="1" style="clear: left; float: left; margin-bottom: 1em; margin-right: 1em;">
        <img border="0" height="47" src="http://jqueryui.com/jquery-wp-content/themes/jquery/images/logo-jquery-ui@2x.png" width="200" />
    </a>
</div>
JQuery UI 
<a href="http://jqueryui.com/demos/autocomplete/">auto-complete widget</a> is great.
<br />
Basically it just works and is very easy to customize.

<h2>The Problem</h2>
By default this control supports the retrieval of Text and Value for the selected item but still needs one tweek or two.<br />
<br />
What I'm about to show here is how to:<br />
<ul><li>Use the basics of the control</li>
<li>Use and store the item ID</li>
<li>Don't show the ID on the textbox while selecting an item</li>
</ul><br />
<h2>The Basics</h2>The basic idea is to pass a json array of strings and it will do the rest.<br />

{% highlight javascript %}
var req = ["item 1", "item 2", "item 3"];
$('#txtRequestor').autocomplete({ source: req });
{% endhighlight %}

<h2>Storing the selected item ID</h2>
In real world nothing is this simple and we usually have an ID for each item on the list. We may use this ID in several ways but the more obvious is to store the selected ID on the database.<br />
This is still very simple, just feed the control some json objects instead of simple strings. <br />
<br />
Note that each item must, <u>at least</u> have the following structure:
<br />
<ul><li><b>label</b> - Represents the display text</li>
<li><b>value</b> - Represents the item value (the ID in our case)</li>
</ul>

{% highlight javascript %}var req = [
  {"label":"item 1", "value":1}, 
  {"label":"item 2", "value":2}, 
  {"label":"item 3", "value":3}];

$('#txtRequestor').autocomplete({ 
     source: req,
     change: function (event, ui) { alert(ui.item.value); } });
{% endhighlight %}

Using the <i>change</i> event we can handle the ID selected item ID and store it on a variable for later use.<br />
<br />
<h2>Not showing the value (ID) on the textbox</h2>If you tried the code above you got anoyed with the fact that the our ID is being shown on the rextbox while we select an item from the list. Didn't you?! :)<br />
<br />
To avoid this is very simple, we must only change our json object a little as follows.<br />

{% highlight javascript %}
var req = [
  {"label":"item 1", "value":"item 1", "id": 1}, 
  {"label":"item 2", "value":"item 2", "id": 2}, 
  {"label":"item 3", "value":"item 1", "id": 3}];

$('#txtRequestor').autocomplete({ 
     source: req,
     change: function (event, ui) { alert(ui.item.id); } });
{% endhighlight %}

As you can see I just added a new property to each item for our id value. This will foul the control passing the same value as both display and value and have a "backup" property that holds the actual id value.