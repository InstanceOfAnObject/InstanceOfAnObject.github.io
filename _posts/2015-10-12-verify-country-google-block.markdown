---
layout: post
title: "Verify country Google block"
date:   2015-10-12 00:00:00
categories: blog
tags:
- security
- web development
- google
---

## The problem
Countries like [China block web traffic from certain domains](https://en.wikipedia.org/wiki/Websites_blocked_in_mainland_China).

## So what?
So what if our website depends on some Google API and we don't want it to break if it's not available?

There are two main approaches to try to by-pass this:
  
  * Resolving the Country by the request IP
  * Same as above but directly querying an IP database

These are valid options as long as the IP gets well resolved, but nothing actually keeps you from:

  * blocking users that might not be affected by the content blockage
  * taking a bad decision if the IP country is unknown
 
Also these API's have some usage thresholds and PRO subscriptions can become expensive.  
  
## Test the functionality instead of the country!

Don't bother trying to identify the country your using is accessing from, try to verify 
if Google is available instead by grabbing a resource that is hosted under a Google domain or sub-domain!

For instance, [Google Drive](https://www.google.com/drive/) lets us store images and make them publically available.  
If we try to access this image from our website and the load fails, then we are sure that the content is blocked!

## Configuring Google Drive
You can point to an image shared in Google Drive, but there's a small "trick" that you need to be aware of.

By default, a shared image URL looks like the following (fake link):  
```
https://drive.google.com/file/d/xxxxxxxxxxxxxxxxxxxxxxxxxxxx/view?pli=1
```

The problem is that this kind of link will open your file in Google Drive viewer which is useless for us.  
To get a pointer to the image directly we need to use a slightly different URL structure:
```
https://drive.google.com/uc?id=xxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

The id argument must be exactly the same as the represented by xxxxxxxxxxxxxxxxxxxxxxxxxxxx in the previous link

## Javascript
Bellow is the code you must use in your pages:
{% highlight javascript %}
(function(){

    var body = document.getElementsByTagName('body')[0],
       	img = document.createElement('img'),
       	timestamp = new Date()*1;
    
    // a timestamp is added to avoid browser cache
    img.src = 
        'https://drive.google.com/uc?id=xxxxxxxxxxxxxxxxxxxxxxxxxxxx&_=' 
        + timestamp;
    
    img.onload = function(){
        // put your success code here
        alert('all good!'); 
    };
    
    img.onerror = function(){ 
        // put your error code here
        alert('something went wrong!'); 
    };
    
    body.appendChild(img);
    
})();
{% endhighlight %}

## Additional resources
**Resolve IP to Country APIs and DBs**
  
  * [freegeoip](https://freegeoip.net)  
  * [MaxMind](https://www.maxmind.com)  
  * [Telize](http://www.telize.com)  

**Verify China domain blockage**  
  
  * [ViewDNS](http://viewdns.info/chinesefirewall)