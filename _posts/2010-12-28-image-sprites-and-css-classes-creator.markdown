---
layout: post
title:  "Image Sprites and CSS Classes creator"
date:   2010-12-28 02:24:00
categories: blog
tags:
- c#
- css
- web development
---

<p>
<a href="http://www.codeproject.com/KB/HTML/SpritesAndCSSCreator/SpriteCreator.zip">Download Code Here</a><br />
</p>
<p>
Example:<br />
<a href="http://www.codeproject.com/KB/HTML/SpritesAndCSSCreator/SpriteCreatorSourceFiles.jpg">Source Images</a><br />
<a href="http://www.codeproject.com/KB/HTML/SpritesAndCSSCreator/sample.png">Generated Sprite</a><br />
<a href="http://www.codeproject.com/KB/HTML/SpritesAndCSSCreator/samplecss..txt">Generated CSS Classes</a>
</p>
<p>
Image Sprites are a very good way to feed your application some images.<br />
Basically it consists of combining a set of images in a larger one and then just cache it.<br />
When you need one of the small images all you have to know are the coodenates of it on the large one.<br />
With this technique, you just need to load one image for the entire application and reuse it, instead loading each image at a time.
</p>
<p>
Here I'll be covering the implementation with CSS used on WebSites but you can use this technique wherever you want.
</p>
<h2>Why this?</h2>Sure you can Google it and find a lot of matches telling you how to use sprites and CSS but where's the "no pain" way of building them and their CSS?<br />
All of them will tell you to use Photoshop of any other photo editing tool but this will always take a lot of time.<br />
That's when this cute little application comes in.<br />
It will generate the sprite image and its css in no time, and you can add images later and regenerate it without having to worry about breaking your code!<br />
<br />
<h2>Using the code</h2>On the package you'll find a compiled version and its source code.<br />
<br />
Just drop the SpriteCreator.exe file on the folder that have the images to be inclided on the sprite and run it. DONE!<br />
<br />
<br />
<h2>Assumptions and Limitations</h2><ol><li>All images on the folder have the same size, ex: 16x16, 32x32, ...</li>
<li>The size of the images will be the size of the first image loaded into the sprite.</li>
<li>The big srite image will be always square, having the minimum size needed to fit all images inside.</li>
<li>All the images on the folder will be included on the sprite.</li>
<li>Only jpg, jpeg, png &amp; bmp extensions are supported.</li>
<li>The name of the images is used on the CSS class name.</li>
<li>The spaces on images file name will be replaced with -</li>
<li>The result 2 files, one *.png and *.css where * is a generated GUID</li>
</ol><h2>Options</h2>This is a console application so you can pass some customization arguments.<br />
<ol><li><b>/h</b><span class="Apple-tab-span" style="white-space: pre;">    </span>:: Help.<span class="Apple-style-span" style="white-space: pre;"> </span></li>
<li><b>/source</b><span class="Apple-tab-span" style="white-space: pre;">   </span>:: Specify the images source directory path.</li>
<li><b>/destination</b><span class="Apple-tab-span" style="white-space: pre;">  </span>:: Destination dir path.</li>
<li><b>/classprefix</b><span class="Apple-tab-span" style="white-space: pre;">  </span>:: CSS class name prefix.</li>
</ol><b>Ex: </b>SpriteCreator.exe /source shadow /classprefix app-ui-<br />
<span class="Apple-style-span" style="font-size: large;"><b><br />
</b></span>