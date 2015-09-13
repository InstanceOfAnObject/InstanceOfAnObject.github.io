---
layout: post
title:  "jqGrid Quick Tips"
date:   2011-05-19 01:39:00
categories: blog
tags:
- jqgrid
- javascript
- jquery
- jquery-ui
---

<table cellpadding="0" cellspacing="0"><tbody>
<tr><td colspan="2&quot;">I'll use this post as a repository of quick tips so I'll be updating it on a regular basis... keep posted!</td></tr>
<tr> <td colspan="2"><h2>
Get it!</h2>
</td> </tr>
<tr> <td style="vertical-align: top;"><br />
<a href="http://www.trirand.com/blog/">The blog</a><br />
<a href="http://www.trirand.com/jqgridwiki/doku.php?id=wiki:features">Features</a><br />
<a href="http://www.trirand.com/blog/?page_id=6">Download</a><br />
<a href="http://www.trirand.com/jqgridwiki/doku.php?id=wiki:jqgriddocs">Documentation</a><br />
<a href="http://stackoverflow.com/questions/tagged/jqgrid">On StackOverflow</a></td> <td><a href="http://www.trirand.com/jqgridwiki/lib/exe/fetch.php?cache=&amp;media=wiki:celledit.png" imageanchor="1" style="clear: right; float: right; margin-bottom: 1em; margin-left: 1em;"><img border="0" src="http://www.trirand.com/jqgridwiki/lib/exe/fetch.php?cache=&amp;media=wiki:celledit.png" height="147" width="400" /></a></td> </tr>
</tbody></table>
<h2>
Licensing and Flavours</h2>
jqGrid is an open-source control registed under the GPL and MIT lincenses.<br />
Basically this means that it's FREE! and you can do quite anything with it.<br />
Read more about this <a href="http://www.trirand.com/blog/?page_id=154">here</a>.<br />
<br />
If you want to use the "side" versions of this control, specially wrapped and packaged for PHP, ASP.net Webforms and ASP.net MVC then you have to pay for them... but rust me when I say that all you need is on the Free package!!<br />
See the price list <a href="http://www.trirand.net/licensing.aspx">here</a><br />
You can also access the payed versions website <a href="http://www.trirand.net/">here</a>.<br />
<br />
The feature set is a huge list and has a <a href="http://stackoverflow.com/questions/tagged/jqgrid">awsome comunity on Stackoverflow</a> that reply to your questions in no time.<br />
<br />
<h2 style="background-color: darkgrey; border-bottom: 1px dashed #000; margin-bottom: 15px; width: 100%;">
Columns</h2>
<h3>
1. Hide a column</h3>
<div style="border: dashed 1px #000; padding: 5px;">
I'm putting this on here just because it's not the instinctive visible, it's called hidden!<br />
<pre class="brush:js">colModel: [{ name: 'colName', hidden: true }]
</pre>
</div>
<br />
<h2 style="background-color: darkgrey; border-bottom: 1px dashed #000; margin-bottom: 15px; width: 100%;">
Data</h2>
<h3>
1. Refresh grid</h3>
<div style="border: dashed 1px #000; padding: 5px;">
If you need to refresh the grid from code just call:<br />
<pre class="brush:js">$("#grid1").trigger("reloadGrid");
</pre>
<br />
The tricky, and not to well documented part is if you want to refresh and select the disired page:<br />
<pre class="brush:js">$("#grid1").trigger("reloadGrid", [{page:3}]);</pre>
This will refresh the frid and show it on page 3.<br />
<br />
With this you can refresh the current page:<br />
<pre class="brush:js">var currentPage = $('#grid1').getGridParam('page');
$("#grid1").trigger("reloadGrid", [{page: currentPage }]);
</pre>
<br />
You can also keep the current selection:<br />
<pre class="brush:js">$("#grid1").trigger("reloadGrid", [{current:true}]);</pre>
<br />
Note that both page and selection settings can be used together.</div>
<br />
<h2 style="background-color: darkgrey; border-bottom: 1px dashed #000; margin-bottom: 15px; width: 100%;">
NavBar</h2>
<h3>
1. Add custom buttons to the NavBar</h3>
<div style="border: dashed 1px #000; padding: 5px;">
<pre class="brush:js">/* Add this line to allow advanced search using the toolbar button */
$('#grid1').navGrid('#grid1pager', { search: true, edit: true, add: true, del: true }, {}, {}, {}, { closeOnEscape: true, multipleSearch: true, closeAfterSearch: true });

/* Add this line to include a separator between buttons */
$('#grid1').navSeparatorAdd("#grid1pager", { sepclass: 'ui-separator', sepcontent: '' });

/* Add this line to include custom buttons on the toolbar */
$('#grid1').jqGrid('navButtonAdd', "#grid1pager", { caption: "", buttonicon: "ui-icon-plusthick", onClickButton: function () { alert('Exporting!!!!!'); }, position: "last", title: "Export to Excel", cursor: "pointer" })
</pre>
</div>
<br />
<h2 style="background-color: darkgrey; border-bottom: 1px dashed #000; margin-bottom: 15px; width: 100%;">
Search</h2>
<h3>
1. Show the Advanced Search dialog from an external button</h3>
<div style="border: dashed 1px #000; padding: 5px;">
<pre class="brush:js">function OpenSearchDialog() {
     $("#grid1").jqGrid(
          'searchGrid', { multipleSearch: true, overlay: false });
}
</pre>
</div>
<br />
<h3>
2. Show the filter toolbar</h3>
<div style="border: dashed 1px #000; padding: 5px;">
The filter toolbar is a bar that appears right bellow the column captions that allow filtering by each column. To make this toolbar visible use the following:<br />
<pre class="brush:js">$('#grid1').jqGrid('filterToolbar', 
            { stringResult: true, searchOnEnter: false });
</pre>
</div>
<br />
<h2 style="background-color: darkgrey; border-bottom: 1px dashed #000; margin-bottom: 15px; width: 100%;">
Selection</h2>
<h3>
1. Get the ID of the selected row</h3>
<div style="border: dashed 1px #000; padding: 5px;">
<pre class="brush:js">$('#grid1').jqGrid('getGridParam', 'selrow')
</pre>
</div>
<br />
<h3>
2. Get the row data</h3>
<div style="border: dashed 1px #000; padding: 5px;">
<pre class="brush:js">var rowData = $("#grid1").jqGrid('getRowData', rowid);
</pre>
<b>rowid</b>: is the id value set on the data source, <b>NOT</b> the index of the row.<br />
<br />
This returns an object with the column names and value like:<br />
<pre class="brush:js">{name="alex", address="here and there", age=34}
</pre>
<br />
so its easy then the get a value using:<br />
<pre class="brush:js">var myName = rowData.name;
</pre>
<br />
<b>Be aware that</b> the object will only have the columns configured on the colModel.Everything that may come on the datasource won't appear here.<br />
If you want to have values here that you don't want to show on the grid you must add the column to the colModel collection and set it to hidden: true</div>
