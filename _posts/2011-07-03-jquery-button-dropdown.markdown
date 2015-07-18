---
layout: post
title:  "jQuery button dropdown"
date:   2011-07-03 01:44:00
categories: blog
tags:
- web development
- jquery
- jquery-ui
---

### Introduction
<img align="left" border="0" style="margin: 0 15px 0 0;" src="/assets/blog/2011-07-03-jquery-button-dropdown/DropdownJqueryButton.png" />
On the jQueryUI documentation for the .button() widget we have an example illustrates the split button functionality [See here](http://jqueryui.com/demos/button/#splitbutton).

The problem is that, at the time of this writing, the example isn't finished and clicking on the small button will only fire an alert.<br />

### My requirements
I had few requirements but they were very important to me:

* Dropdown shold perfectly integrate with the selected theme
* Only the small '+' button should interact with the dropdown
* Consider both buttons as a single block so that the dropdown would show beneath that block and not only bellow the '+' button
* All the buttons should be able to be hidden and shown on demand to reflect different form display modes

### Limitations and work to be done

#### Code reuse
Right now I don't have the time to make this a JQueryUI widget but sure it would be nicer to handle. Anyway, what I did was writing all this inside a user control (ASP.ne ASCX) and reuse it on every Item Edit page. To do this just create a new ASCX and drop all the code I have on the bottom of this post (CSS, HTML and Javascript) and you're done.

#### Multiple instances on the page
A true limitation it that **there can only be one of these per page**.
So if you need this behavior more than once on the page you need to abstract it inside a JQuery UI widget.

### Getting it done
The code I'm posting here will render like the picture above and behaves like this:

* **Click '+'**: Toggles open/close the dropdown menu
* <b>Click dropdown item</b>: Closes dropdown and performs action
* <b>Mouse leave dropdown</b>: Closes dropdown

Here's a live sample:
<iframe width="100%" height="300" src="https://jsfiddle.net/AlexCode/mm1hwnms/embedded/result,html%2Cjs%2Ccss/" allowfullscreen="allowfullscreen" frameborder="0"></iframe>

### The code
Dropping all the code bellow into a page will do the trick.  
After that, all you have to do is override the click events callbacks:
{% highlight javascript %}
ItemActionButtons.onSaveClick = function(){ alert('Save button have been clicked'); };
{% endhighlight %}

We can also hide/show a button this way:
{% highlight javascript %}
ItemActionButtons.AllowCancel(false);
{% endhighlight %}

See the ItemActionButtons object for more.  
Feel free to add your own actions and events to customise it as you need.

#### HTML
{% highlight html %}
<div class="ItemActionButtons">
<div class="buttonset" style="float: right;">
<input class="button" id="btnDelete" onclick="ItemActionButtons.onDeleteClick.apply(this)" type="button" value="Delete" />
  <input class="button" id="btnCancel" onclick="ItemActionButtons.onCancelClick.apply(this)" type="button" value="Cancel" />
 </div>
<div class="buttonset" id="divSaveButton" style="float: right;">
<input class="button" id="btnSave" onclick="ItemActionButtons.onSaveClick.apply(this)" type="button" value="Save" />
  <input class="button" id="btnSaveExtra" onclick="ItemActionButtons.onSaveExtraClick.apply(this)" type="button" value="+" />

  <br />
<ul class="SaveExtraOptions ui-corner-bottom" id="btnSaveExtraOptions">
<li onclick="$('#btnSaveExtraOptions').toggle(); ItemActionButtons.SaveAndNewClick.apply(this)">Save and New</li>
<li onclick="$('#btnSaveExtraOptions').toggle(); ItemActionButtons.SaveAndCopyClick.apply(this)">Save and Copy</li>
</ul>
</div>
</div>
{% endhighlight %}

#### CSS
{% highlight css %}
<style type="text/css">
 .ItemActionButtons{}
 .ItemActionButtons .SaveExtraOptions
 {
  display: none; 
  list-style-type: none; 
  padding: 5px; 
  margin: 0; 
  border: 1px solid #DCDCDC; 
  background-color: #fff; 
  z-index: 999; 
  position: absolute;
 }
 .ItemActionButtons .SaveExtraOptions li
 {
  padding: 5px 3px 5px 3px; 
  margin: 0; 
  width: 150px; 
  border: 1px solid #fff;
 }
 .ItemActionButtons .SaveExtraOptions li:hover
 {
  cursor: pointer;
  background-color: #DCDCDC;
 }
 .ItemActionButtons .SaveExtraOptions li a
 {
  text-transform: none;
 }
</style>
{% endhighlight %}

#### Javascript
{% highlight javascript %}
<script type="text/javascript">

 $(document).delegate(
     '#btnSaveExtra', 
     'mouseleave', 
     function () { 
         setTimeout(
             function(){ 
                 if (!ItemActionButtons.isHoverMenu) { 
                     $('#btnSaveExtraOptions').hide(); 
                 }
             }, 100, 1) 
     });
 $(document).delegate(
     '#btnSaveExtraOptions', 
     'mouseenter', 
     function () { 
         ItemActionButtons.isHoverMenu = true; 
     });
 $(document).delegate(
     '#btnSaveExtraOptions', 
     'mouseleave', 
     function () { 
         $('#btnSaveExtraOptions').hide(); 
         ItemActionButtons.isHoverMenu = false; 
     });

 var $IsHoverExtraOptionsFlag = 0;
 $(document).ready(function () {
  $(".button").button();
  $(".buttonset").buttonset();

  $('#btnSaveExtra').button({ icons: { primary: "ui-icon-plusthick" } });
  $('#btnSaveExtraOptions li').addClass('ui-corner-all ui-widget');
  $('#btnSaveExtraOptions li').hover(
   function () { $(this).addClass('ui-state-default'); },
   function () { $(this).removeClass('ui-state-default'); }
  );
  $('#btnSaveExtraOptions li').mousedown(
      function () { 
          $(this).addClass('ui-state-active'); 
      });
  $('#btnSaveExtraOptions li').mouseup(
      function () { 
          $(this).removeClass('ui-state-active'); 
      });
 });

 var ItemActionButtons = {
  isHoverMenu: false,

  AllowDelete: function (value) { value ? $("#btnDelete").show() : $("#btnDelete").hide() },
  AllowCancel: function (value) { value ? $("#btnCancel").show() : $("#btnCancel").hide() },
  AllowSave: function (value) { value ? $("#btnSave").show() : $("#btnSave").hide() },
  AllowSaveExtra: function (value) { value ? $("#btnSaveExtra").show() : $("#btnSaveExtra").hide() },

  onDeleteClick: function () { },
  onCancelClick: function () { },
  onSaveClick: function () { },
  onSaveExtraClick: function () {
   $('#btnSaveExtraOptions').toggle();

   var btnLeft = $('#divSaveButton').offset().left;
   var btnTop = $('#divSaveButton').offset().top + $('#divSaveButton').outerHeight();
   var btnWidth = $('#divSaveButton').outerWidth();
   $('#btnSaveExtraOptions').css('left', btnLeft).css('top', btnTop);
  },
  SaveAndNewClick: function () { },
  SaveAndCopyClick: function () { }
 }

</script>
{% endhighlight %}