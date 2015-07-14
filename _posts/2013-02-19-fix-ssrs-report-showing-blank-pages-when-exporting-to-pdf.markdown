---
layout: post
title:  "Fix SSRS PDF Blank Pages"
date:   2013-02-19 17:29:00
categories: blog
tags:
- ssrs
- reporting
---
## The problem
You're designing a report on SSRS. Everything looks good until you export it to PDF and you realize that every other page appears blank.

If this is your problem, read on!

## The solution
The solution is plain simple and rational but if you're already dealing with a complex report maybe you already switched off your rational part of the brain.

The idea basically is:

{% highlight text %}
[Body width] <= [Report Width]-[Report Left Margin]-[Report Right Margin]
{% endhighlight %}

So do the following:

1. Go to Report properties
2. Take note of the Width and the left and right margin values
3. Go to the design view and select Body
4. Take note of the Body width
5. Do your math with the above formula, adjust as needed and it should be fine!

Cheers!