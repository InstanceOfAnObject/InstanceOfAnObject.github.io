---
layout: post
title:  "Making a JQuery UI Datepicker Read Only"
date:   2011-05-25 03:16:00
categories: blog
tags:
- javascript
- jquery
- jquery-ui
---

To make this post clear, by ReadOnly I mean really READ ONLY, no input allowed whatsoever.

### Datepicker default behavior
This one seemed easy at first but it isn't just because by design, setting the input textbox to readonly the widget will understand it as if we just wanted to limit the user to choose a date from the popup, disallowing any input text.

What I want here is to block any way of the user to change the textbox value, either from the calendar popup or by direct input on the textbox.<br />

### Option 1: Disable Textbox
<table style="text-align: center; width: 100%px;"><tbody>
<tr><td style="background-color: gainsboro;" width="50%"><b>The good</b></td><td style="background-color: gainsboro;" width="50%"><b>The bad</b></td></tr>
<tr><td>Works!</td><td>Grays out the control to make it look disabled</td></tr>
</tbody></table>
  
  
This would be a quick solution by just disable the textbox but it kind of shades the control and I want it to display its value with the same appearance as the other textboxes. Not aproved!

### Option 2: Bend the control
This datepicker widget has a lot of options, we just have to find a way to use them in our favor to achieve this "unsupported" behavior.

{% highlight html %}
<input id="txtDate" readonly="readonly" type="text" />

<script type="text/javascript">

$(document).ready(function () {
   $('#txtDate').datepicker(
     {
        beforeShow: function (input, inst) 
        { inst.dpDiv = $('<div style="display: none;"></div>'); }
     });
});

</script>
{% endhighlight %}

What did I do?  
On the Textbox you can see that I made it ReadOnly, but as I said, this alone still lets the user change the date from the calendar popup.  
To block the calendar popup I'm replacing it it an empty DIV element and to avoid unhandled complications I'm styling it as display: none.  

With this workaround the datepicker still thinks is showing the popup but infact nothing happens.

This is kind of tricky but is pretty easy to do and works very well on all browsers.

### My recomendation to JQuery UI Team
This would be so much easier if we could only pass something like:  
*showOn: "never"*