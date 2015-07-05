---
layout: post
title:  "Include Javascript And CSS On Your MasterPage"
date:   2012-06-14 23:24:00
categories: blog
tags:
- web development
- asp.net
- javascript
- css
---
This is a quick one.

On the web I see a lot of tricks on how to do this but in fact it's quite easy.

## The Problem

When you reference a script or a css file on your masterpage it takes the relative path of that file according to the MasterPage location. The problem is that the MasterPage isn't the one that it's going to be shown, it will be the actual ASPX page the inherits from it.  
This said, if your ASPX files are in other location than the MasterPage then the references script files path won't be resolved.

There's also the problem when your site can either run on a virtual folder or as a site on IIS.

## The Solution

There are a lot of ways to handle this, but most rely on specific ASPX locations.  
I like to have my ASPXs well organized on a convenient way, sometimes in the same folder but most of the times on separated folders.  
I don't want to be forced to put all pages on the same folder just because of this.  

So the idea is to put all the script and CSS references on the MasterPage *<head>*, make use of the server-side tilde (~) and write the correct paths on Page_Init.

If you need to reference jquery and jqueryUI your MasterPage *<head>* should look similar as the following:
{% highlight html %}
<head runat="server">
    <title></title>

 <link href="<%# ResolveUrl("~/") %>css/custom-theme/jquery-ui-1.8.21.custom.css" rel="stylesheet" type="text/css" />

 <script src="<%# ResolveUrl("~/") %>Scripts/jquery-1.7.2.min.js" type="text/javascript"></script>
 <script src="<%# ResolveUrl("~/") %>Scripts/jquery-ui-1.8.20.min.js" type="text/javascript"></script>

    <asp:ContentPlaceHolder ID="head" runat="server">
    </asp:ContentPlaceHolder>
</head>
{% endhighlight %}
Now, on the MasterPage CodeBehind you should include the following code:
{% highlight csharp %}
protected override void OnLoad(EventArgs e)
{
 base.OnLoad(e);
 Page.Header.DataBind();
}
{% endhighlight %}
DONE!  

**Keep in mind that the script and css references paths must be relative to he root of your site.**

This way, everywhere the MasterPage is used the paths to the resources will always be correct.

Cheers!