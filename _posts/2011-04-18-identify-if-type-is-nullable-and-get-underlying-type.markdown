---
layout: post
title:  "Identify If Type Is Nullable And Get Its Undelying Type"
date:   2011-04-18 12:40:00
categories: blog
tags:
- c#
---

Identifying if a type is nullable and getting its underlying (not nullable) type is something no one needs constantly but when we do it's not trivial to get just from intellisense.<br />
<br />
There is no IsNullable property in System.Type so we need to understand a bit how thing work.<br />
{% highlight csharp %}
Type myType = (Guid?).GetType(); // dummy type for this example
{% endhighlight %}
<h2>For short:</h2>
{% highlight csharp %}
Type myBaseType = Nullable.GetUnderlyingType(myType) ?? myType;
{% endhighlight %}
<h2>If you need a bit more information:</h2>
{% highlight csharp %}
myType.IsGenericType();
myType.GetGenericTypeDefinition() == typeof(Nullable<>)  
myType.GetGenericArguments()[0]
{% endhighlight %}
<h2>The Long story:</h2>The basic idea of a nullable type is that it is a type wrapped in the generic type NULLABLE<>.<br />
So to know if a type is nullable we need to:<br />
<ul><li>Evaluate if the type is generic</li>
<li>Being generic, lets check if it's Nullable&lt;&gt;</li>
<li>If so, get its first generic argument that holds the base type.<br />
<ul><li>If you run a QuickWatch on a nullable Guid? type you'll get something like: </br><br />
System.Nullable`1[System.Guid] </br><br />
System.Nullable`1[] is the way .net serializes NULLABLE&lt;&gt; </br><br />
The value within [] is its undelying type we're looking for.</li>
</ul></li>
</ul>