---
layout: post
title:  "Advanced ASP.net Generic Handler"
date:   2012-03-24 12:24:00
categories: projects
tags:
- web development
- asp.net
---

[<img src="/assets/images/autreplanete_icons/social_icons/png/color/github-color.png" />Github Repository](https://github.com/InstanceOfAnObject/ASPnetAdvancedHandler)  

## Disclaimer
This is a project I did some years back but never took much care maintaining or writing proper automated tests.  
Although this has been used in multiple production applications, I suggest to take your time to understand it properly.

On [CodeProject](http://www.codeproject.com/Articles/353260/ASP-NET-Advanced-Generic-Handler-ASHX) there's also a nice discusison about this approach over WebAPI.

## Description
In ASP.NET, we have something that is usually overlooked that is called [Generic Handlers](https://msdn.microsoft.com/en-us/library/system.web.ihttphandler(v=vs.100).aspx).

This is an completely worked out Generic Handler that truly knows how to handle your http (AJAX and not) requests. 

For now, for a detailed explanation, please look at the original <a href="http://www.codeproject.com/Articles/353260/ASP-NET-Advanced-Generic-Handler-ASHX">CodeProject article</a>

## Why not WebAPI or MVC?
When I wrote this, WebAPI was not available yet.

Although Generic Handlers still have their meaning, probably you'll find WebAPI a good match for most of your needs.

ASP.net MVC Controllers can also be used, specially if you're already using it in your application.