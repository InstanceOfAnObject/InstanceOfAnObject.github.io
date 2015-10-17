---
layout: post
title:  "IFrame Orchestrator"
date:   2015-05-24 00:00:00
categories: projects
tags:
- web development
---

[<img src="/assets/images/autreplanete_icons/social_icons/png/color/github-color.png" />Github Repository](https://github.com/InstanceOfAnObject/IFrameOrchestrator)  
[![Build Status](https://travis-ci.org/InstanceOfAnObject/IFrameOrchestrator.svg?branch=master)](https://travis-ci.org/InstanceOfAnObject/IFrameOrchestrator)

## Description
Orchestrates messages between an IFrame and its parent page, as well as between IFrames on the same page. The Iframes can even reside on different domains!

[Hop on to the Github page](https://github.com/InstanceOfAnObject/IFrameOrchestrator) to get everything you need to get started.

## Why?
I realize this looks a bit outdated functionally; after all, who uses IFrames anyway right!?

Well if you're asking yourself that question, clearly you're not a SharePoint developer (neither am I). In SharePoint 2013, Provider Hosted Apps are rendered inside of IFrames that are rendered inside your site.

If you're planning to do, lets say, a single-page-app (SPA) to be delivered in this model, you'll need to interact with the "world" outside your IFrame.

## What does this do?
This tool will allow you to establish a communication pipeline between each IFrame and its parent, easing a lot of pain.

To take this a bit further, you'll also be able to pass messages and trigger events between IFrames.

## Where can this be used?
The motivation behind this tool was for complex SharePoint Provider Hosted App, but there's no dependency whatsoever with SharePoint.