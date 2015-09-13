---
layout: post
title:  "EF4 DbDataRecord ConvertTo&lt;T&gt;"
date:   2011-01-09 08:07:00
categories: blog
tags:
- c#
- entity framework
---

<div class="separator" style="clear: both; text-align: center;">
<a href="/assets/blog/2011-01-09-ef4-dbdatarecord-convert-to-t/dotnet-framework.jpg" imageanchor="1" style="clear: left; float: left; margin-bottom: 1em; margin-right: 1em;"><img border="0" src="/assets/blog/2011-01-09-ef4-dbdatarecord-convert-to-t/dotnet-framework.jpg" /></a></div>
<h2>
Intro</h2>
If you're using <a href="http://msdn.microsoft.com/en-us/library/bb399572.aspx">Entity Framework 4</a> <b>(EF4)</b> and its ESQL query syntax its more than likely that after <a href="http://msdn.microsoft.com/en-us/library/bb738642.aspx">executing a query</a> you'll end up with a collection of <a href="http://msdn.microsoft.com/en-us/library/system.data.common.dbdatarecord.aspx">DbDataRecord</a> to deal with.<br />
This happens when the query returns an anonymous type.<br />
<br />
DbDataRecord object reminded me the DbDataReader from the plain old ADO.net where the result is an abstract item that can have everything in it. To get it, all we have to do is iterate through the DbDataReader and get the data by column name or index.<br />
Remember? Yeah, it's the same one on EF4!<br />
<br />
<h2>
Environment</h2>
I'll be using: <br />
<ul>
<li><a href="http://msftdbprodsamples.codeplex.com/releases/view/37109">AdventureWorks LT 2008 Demo Database</a></li>
<li>Entity Framework 4</li>
</ul>
<br />
<h2>
Querying with ESQL</h2>
I'm going to show 3 examples from the easier to the more complex one where we need to convert that DbDataRecord into a custom type we made.<br />
<br />
<h3>
Simple query</h3>
Lets just get some typed data, say all the Customers!<br />
Using <b><i>SELECT VALUE item FROM</i></b> is like the <b><i>SELECT * FROM</i></b> in T-SQL but we're also saying that the result is of a specific type, in this case, Customer.

{% highlight csharp %}
using (AdventureWorksLT2008Entities ctx = new AdventureWorksLT2008Entities())
{
 string query = 
    string.Format(
        "SELECT VALUE item FROM {0}.Customers AS item", 
        ctx.DefaultContainerName
    );
 ObjectQuery<customer> customersQuery = 
    new ObjectQuery<customer>(query, ctx);
}
{% endhighlight %}

<h3>
Anonymous Query</h3>
Now we want to get all records but only the FirstName, LastName and CompanyName columns.<br />
<br />
If we try to use the previous code and just change the query EF4 will give you a nice yellow screen of death saying:<br />
<br />
<div style="background-color: #ffffcd; border: 1px dashed black; color: #621616;">
<b><i>The specified cast from a materialized 'System.Data.Objects.MaterializedDataRecord' type to the 'BlogDemos.EF4DbDatarecord.Website.Customer' type is not valid.</i></b></div>
<br />
To make this work we have to use ObjectQuery<DbDataRecord> as follows.

{% highlight csharp %}
using (AdventureWorksLT2008Entities ctx = new AdventureWorksLT2008Entities())
{
 string query = string.Format("SELECT item.FirstName, item.LastName, item.CompanyName FROM {0}.Customers AS item", ctx.DefaultContainerName);
 ObjectQuery<DbDataRecord> customersQuery = new ObjectQuery<DbDataRecord>(query, ctx);
}
{% endhighlight %}

<h3>
Anonymous Query and Type Convertion</h3>
Ok, but now we have all the data as an anonymous type not as a Customer. This is good if you only want to display/use that raw data but:<br />
<ol>
<li>What if we wanted to turn this list of anonymous types into a list of customers?</li>
<li>And if you get a little more ambitious and want to get a list of a custom type of yours that happen to have properties with the same name as the columns you're retrieving on the query?</li>
</ol>
<br />
No problem, just use these extension methods and you're back on track.

{% highlight csharp %}
public static class AnonymousTypeConversion
{

 /// <summary>
 /// Converts a single DbDataRwcord object into something else.
 /// The destination type must have a default constructor.
 /// </summary>
 /// <typeparam name="T"></typeparam>
 /// <param name="record"></param>
 /// <returns></returns>
 public static T ConvertTo<T>(this DbDataRecord record)
 {
  T item = Activator.CreateInstance<T>();
  for (int f = 0; f < record.FieldCount; f++)
  {
   PropertyInfo p = item.GetType().GetProperty(record.GetName(f));
   if (p != null &amp;&amp; p.PropertyType == record.GetFieldType(f))
   {
    p.SetValue(item, record.GetValue(f), null);
   }
  }

  return item;
 }

 /// <summary>
 /// Converts a list of DbDataRecord to a list of something else.
 /// </summary>
 /// <typeparam name="T"></typeparam>
 /// <param name="list"></param>
 /// <returns></returns>
 public static List<T> ConvertTo<T>(this List<DbDataRecord> list)
 {
  List<T> result = (List<T>)Activator.CreateInstance<List<T>>();

  list.ForEach(rec =>
  {
   result.Add(rec.ConvertTo<T>());
  });

  return result;
 }

}
{% endhighlight %}

Now I'm going to create a custom Customer type, with fewer properties and a new dumb one called FullName that just concatenates the FirstName and the LastaName.

{% highlight csharp %}
public class TinyCustomer
 {
  public string FirstName { get; set; }
  public string LastName { get; set; }
  public string CompanyName { get; set; }

  public string FullName
  {
   get
   {
    return (string.IsNullOrEmpty(FirstName) ? 
            string.Empty : FirstName) + " " + 
            (string.IsNullOrEmpty(LastName) ? string.Empty : LastName);
   }
  }
 }
{% endhighlight %}

Now lets get a list of TinyCustomer from that Anonymous query:

{% highlight csharp %}
using (AdventureWorksLT2008Entities ctx = new AdventureWorksLT2008Entities())
{
 string query = 
    string.Format(
        "SELECT item.FirstName, item.LastName, item.CompanyName FROM {0}.Customers AS item", 
        ctx.DefaultContainerName
    );
 ObjectQuery<DbDataRecord> customersQuery = new ObjectQuery<DbDataRecord>(query, ctx);

 lblQueryString.Text = query;

 var tinyCustomers = customersQuery.ToList().ConvertTo<DemoTypes.TinyCustomer>();
}
{% endhighlight %}

<h2>
Conclusion</h2>
I plan to write about dynamic queries with EF4/ESQL soon where I find this particularly useful.<br />
I did a sample project with all the code presented here, just download the demo project, install the AdventureWorks db on your SQL Server instance and configure the connections string on the web.config.<br />

<h2>
Downloads</h2>
<a href="http://files.instanceofanobject.com/downloads/EF4DbDataRecordConvertToType.zip">Demo project</a><br />
<a href="http://msftdbprodsamples.codeplex.com/releases/view/37109">AdventureWorks LT 2008 Demo Database</a><br />
<br />
Have fun!