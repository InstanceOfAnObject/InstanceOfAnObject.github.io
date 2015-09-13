---
layout: post
title:  "More logging options... NLog"
date:   2009-09-25 13:55:00
categories: blog
tags:
- c#
- logging
- nlog
---

<p>
    I'm still searching for "the right" logging API for me.<br/>
    I need something simple yet configurable and extendable, so I can add complexity to it whenever I need to.
</p>

<p>
    I've aready <a href="http://alexcode.blogspot.com/2009/09/implementing-log-on-your-net.html">posted about Log4Net</a>. Cool thing, very customizable, but too hard to use.
    Like I said, I need something really Plug-N-Play... keep it as simple as possible.
</p>

<p>
    This time I was willing to give <a href="http://www.nlog-project.org/">NLog</a> a chance.
</p>

<p>
    What I can say is that it just works. Two minutes after the creation of my test console application I had it working.
    What did I had to do to test it out:
    
    <ul>
        <li>Add a reference to the NLog dll</li>
        <li>Create a configuration file</li>
        <li>errrrr... hit F5? :)</li>
    </ul>
</p>

<p>
    <b>Configuration file:</b>
    <div>
        <img style="border: none; max-width: 100%;" src="http://1.bp.blogspot.com/_lhIm4rzeEag/SryTheuV-nI/AAAAAAAAADM/BoM1RWc_ee4/s400/NLog+Configuration+File.jpg" />
    </div>
</p>

<p>
    <b>My test code:</b>
    <div>
        <img style="border: none; max-width: 100%;" src="http://4.bp.blogspot.com/_lhIm4rzeEag/SryUPuojQDI/AAAAAAAAADU/I3GcMfYtPwM/s400/NLog+ConsoleApp+Demo.jpg" />
    </div>
</p>

Ok... this is a really dumb and useless implementation but to me proves the simplicity I was looking for.

<p>
What's next?! :: Custom Targets!
<br/>
I'll create a custom target that will do some cool things...
</p>