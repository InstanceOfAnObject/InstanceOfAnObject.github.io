---
layout: post
title:  "CSS Sprite Generator"
date:   2013-12-18 12:24:00
categories: projects
tags:
- web development
- css
---

[<img src="/assets/images/autreplanete_icons/social_icons/png/color/github-color.png" />Github Repository](https://github.com/InstanceOfAnObject/SpriteCreator)

<h2>New v2.0</h2>

<p>I&nbsp; decided to increment the major version of this tool as it implements new core features and actually brakes background compatibility with the previous command line commands.</p>

<p>So... what&#39;s new?</p>

<ul>
	<li>3 Bin Packing algorithms to choose from that optimize the sprite image size</li>
	<li>New and refactored command line commands to let you automate the generation process</li>
	<li>Support for inner folders</li>
	<li>Allow setting the output file names</li>
</ul>

<h2>Introduction</h2>

<p>Image Sprites are a very good way to feed your application some images. Basically, it consists of combining a set of images in a larger one and then just caching it. When you need one of the small images, all you have to know are the coordinates of it on the large one. With this technique, you just need to load one image for the entire application and reuse it, instead of loading each image at a time.</p>

<p>Here, I&#39;ll be covering the implementation with CSS used on WebSites, but you can use this technique wherever you want.</p>

<h2>Why This?</h2>

<p>Sure you can Google it and find a lot of matches telling you how to use sprites and CSS but where&#39;s the &quot;no pain&quot; way of building them and their CSS? All of them will tell you to use Photoshop of any other photo editing tool but this will always take a lot of time. That&#39;s when this cute little application comes in. It will generate the sprite image and its CSS in no time, and you can add images later and regenerate it without having to worry about breaking your code!</p>

<h2>Using the Code</h2>

<p>On the package, you&#39;ll find a compiled version and its source code.</p>

<p>Just drop the <em>SpriteCreator.exe</em> file on the folder that has the images to be included on the sprite and run it. DONE!</p>

<h3>Assumptions, Limitations and Functionality</h3>

<ul>
	<li>All image files on the folder will be added to the sprite no matter the size.</li>
	<li>All the images on the folder will be included on the sprite. &nbsp;</li>
	<li>Only jpg, jpeg, png &amp; bmp extensions are supported.</li>
	<li>The name of the images is used on the CSS class name.</li>
	<li>The spaces on images file name will be replaced with -</li>
	<li>The result 3 files, one <em>*.png</em> (the sprite), <em>*.css</em> and *.html (the demo usage page) where <em>*</em> is the name you specified or a random GUID.&nbsp;</li>
	<li>CSS file includes a class that applies the background image to the element</li>
	<li>Images are ordered using 3 different algorithms (more about them bellow).</li>
</ul>

<h2>Bin Packing Algorithms</h2>

<p>To optimize the distribution of the images on the sprite I used the code from here:&nbsp; <a href="http://nuclexframework.codeplex.com/wikipage?title=Nuclex.Game" target="_blank" title="Nuclex Game">Nuclex Game</a>&nbsp;</p>

<p>The Bin packing algorithms are very well documented on <a href="http://nuclexframework.codeplex.com/wikipage?title=Rectangle%20Packing&amp;referringTitle=Nuclex.Game" target="_blank" title="Rectangle Packing Documentation">their page</a>.</p>

<p>All Bin Packing Algorithm credits must be given to these guys that saved me a lot of time by perfectly implementing these three good bin packing algorithms in C#. On my side I only removed the XNA dependencies and replaced them with pure System.Drawing objects.</p>

<h2>Options</h2>

<p>This is a console application so you can pass some customization arguments.</p>

<ol>
	<li><strong>/h, /?, /help</strong> :: Help</li>
	<li><strong>/s</strong> :: Specify the images source directory path</li>
	<li><strong>/d</strong> :: Destination dir path</li>
	<li><strong>/D</strong> :: Same as /d but creates the directory if it doesn&#39;t exist</li>
	<li><strong>/f</strong> :: Destination file name</li>
	<li><strong>/F</strong> :: Same as /f but overrides the files if they already exist</li>
	<li><strong>/cp</strong> :: CSS class name prefix</li>
	<li><strong>/pl</strong> :: Specify the Bin Packaging Level (1, 2 (default) or 3)</li>
</ol>

<p><strong>Ex: </strong><em>SpriteCreator.exe</em> /s Images /F SiteImages /cp &quot;app-ui-&quot;</p>

<h2>History</h2>

<ul>
	<li>v1.0 - The very beginning</li>
	<li>v1.1 - Support for images of different sizes and small improvements.</li>
	<li>v2.0 - Arguments refactoring and Bin Packing Algorithm usage.</li>
</ul>