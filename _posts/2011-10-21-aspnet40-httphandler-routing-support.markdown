---
layout: post
title:  "ASP.net 4.0 HttpHandler Routing Support"
date:   2011-10-21 01:53:00
categories: blog
tags:
- asp.net
- routing
---

I'm a big fan of ASP.net Routing and I use it a lot on my ASP.net Webforms applications.

If you're just getting started with Routing on ASP.net Webforms I recommend reading [this post](http://weblogs.asp.net/scottgu/archive/2009/10/13/url-routing-with-asp-net-4-web-forms-vs-2010-and-net-4-0-series.aspx) from Scott Guthrie.

Ok now, back to the subject, one thing about Routing is that it doesn't support routes that point to HttpHandlers (common .ASHX files).  
The code bellow comes just to overcome this limitation by adding a new method (and one overload) to the RoutesCollection object that will let you map a route to an *.ashx url or directly to the handler object.

## The Code
{% highlight csharp %}
namespace System.Web.Routing
{
 public class HttpHandlerRoute<T> : IRouteHandler where T: IHttpHandler
 {
  private String _virtualPath = null;

  public HttpHandlerRoute(String virtualPath)
  {
   _virtualPath = virtualPath;
  }

  public HttpHandlerRoute() { }

  public IHttpHandler GetHttpHandler(RequestContext requestContext)
  {
   return Activator.CreateInstance<T>();
  }
 }

 public class HttpHandlerRoute : IRouteHandler
 {
  private String _virtualPath = null;

  public HttpHandlerRoute(String virtualPath)
  {
   _virtualPath = virtualPath;
  }

  public IHttpHandler GetHttpHandler(RequestContext requestContext)
  {
   if (!string.IsNullOrEmpty(_virtualPath))
   {
    return (IHttpHandler)System.Web.Compilation.BuildManager.CreateInstanceFromVirtualPath(_virtualPath, typeof(IHttpHandler));
   }
   else
   {
    throw new InvalidOperationException("HttpHandlerRoute threw an error because the virtual path to the HttpHandler is null or empty.");
   }
  }
 }

 public static class RoutingExtension
 {
  public static void MapHttpHandlerRoute(this RouteCollection routes, string routeName, string routeUrl, string physicalFile, RouteValueDictionary defaults = null, RouteValueDictionary constraints = null)
  {
   var route = new Route(routeUrl, defaults, constraints, new HttpHandlerRoute(physicalFile));
   routes.Add(routeName, route);
  }

  public static void MapHttpHandlerRoute<T>(this RouteCollection routes, string routeName, string routeUrl, RouteValueDictionary defaults = null, RouteValueDictionary constraints = null) where T : IHttpHandler
  {
   var route = new Route(routeUrl, defaults, constraints, new HttpHandlerRoute<T>());
   routes.Add(routeName, route);
  }
 }
}
{% endhighlight %}

## How to use it
{% highlight csharp %}
// using the handler url
routes.MapHttpHandlerRoute("DoSomething", "Handlers/DoSomething", "~/DoSomething.ashx");

// using the type of the handler
routes.MapHttpHandlerRoute<MyHttpHanler>("DoSomething", "Handlers/DoSomething");
{% endhighlight %}

And that's it! :)
