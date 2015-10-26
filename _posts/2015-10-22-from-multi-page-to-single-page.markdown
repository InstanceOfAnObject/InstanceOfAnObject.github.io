---
layout: post
title: "Go from Multi-Page to a Single-Page Web App"
date:   2015-10-22 00:00:00
categories: blog
tags:
- angularjs
- web development
- jquery
- spa
---

## The problem
You have your nice classic multi-page web application and you want to move to the new [Single-Page (SPA)](https://en.wikipedia.org/wiki/Single-page_application) paradigm.

I'll leave the why so and why not to "SPA" to another post.
I'm assuming you've made up your mind and that you already chose your technology, lets say [AngularJS 1.x](https://angularjs.org/) or [AngularJS 2.x](https://angular.io/), but the you're still asking yourself:

* What skills do I need to have in the team?
* What should I be aware?
* From where should I start?
* What would be the best approach?
* How do I estimate the necessary time?

I've been there several times so I've decided to share my experience and hopefully save someone else's time and patience.

## Train your team
If I would have to choose the most important thing for the success of this migration process I would say: **Train your team!!**.  
Really, I can't stress this enough.

If your team is not completely aligned regarding knowledge and processes, this will fail, badly.  
The core knowledge needed is not only on AngularJS (or any other framework), you need to have a deep and solid understanding of Javascript itself.

Here's my preferred list of resources I usually propose to my teams and trainees:

**Books**

* [Secrets of the Javascript Ninja](https://www.manning.com/books/secrets-of-the-javascript-ninja)  
* [Javascript: The good parts](http://shop.oreilly.com/product/9780596517748.do)  
* [High Performance Javascript](http://shop.oreilly.com/product/9780596802806.do)  

**Video content**  
Search by Angular and Javascript on these sites and you'll find a lot of awesome material.  
I won't point to any specific training because they keep putting more up to date content so it's better if you just search!

* [Pluralsight](https://app.pluralsight.com/library/)  
* [Egghead.io](https://egghead.io/)

## Define a strategy
In everything we do we should define a strategy, even if it's a shallow one, something is always better than nothing.

In this specific case, is very important that you don't start changing code all over the place otherwise you'll end up with an uncontrolled amount of regressions and frustration will kill you.

**Do things incrementally** and you'll even be able to keep adding features to your app along side with this migration process.  
This is a very important selling point when you need to do this migration as part of a technical task and the business sees no real added value upfront.  
It's very important that you don't stall the new features implementation flow and keep giving them the added value the product owner requested plus the performance boost and user-friendly features a SPA allows.

Of course, there's a bit of a compromise here, and you won't be able to fit as many features in your sprint but don't stop it completely.

Here's the approach I like to follow:

### Phase 1: Split the controllers
One good way is to keep the single-page paradigm aside at first and migrate the views, one by one to Angular.  
Doing it like this, the pages will keep being delivered by as usual from server-side but all the dynamic elements will be rendered with Angular. The site will keep on working and some views will be Angular others are legacy code and changing views will still trigger a full page refresh.

#### MVC in the back-end?
During this process, you'll be "forced" to clean-up your server-side controllers and make new ones that return JSON instead of HTML. These will be the AJAX endpoints of you angular service that will handle all the $http requests.
You'll end up with one controller method to deliver the HTML view and a bunch of other methods that implement the necessary CRUD.
I advise to prefix all the CRUD routes with /api/..., this will help you isolate the routes that return JSON from the ones that return HTML.  
No pressure, take your time.
Meanwhile, new screens and improvements that you have in the pipeline should be done directly in Angular.

#### No MVC in the back-end?
If you're not using MVC on the back-end, the process should be more or less the same as described above anyway with the exception that you might want to use another technology to handle your AJAX requests.

Here are some options depending on your server-side technology:

* .Net Framework: [Web API](http://www.asp.net/web-api)
* JAVA: [RESTEasy](http://resteasy.jboss.org/)
* PHP: [Slim](http://www.slimframework.com/)
* ...

The list goes on, and each platform has multiple options; choose your own!

### Phase 2: Start managing state with Angular
This will take you some time to figure out and debug.  
Basically, you'll need to move all the user state to Angular, more specifically into a separate angular service/factory that will be used by all Angular controllers.  
It's this mechanism that will allow you later to hit F5 in the browser and still get the needed logged in user information and permissions.  
You achieve this by adding a controller on the server that you can do an AJAX call and retrieve this information.  

### Phase 3: Add ng-route
Once all the views are converted and are able to manage their state, it's time to add ng-route to the mix.  
It's not mandatory, but this should ideally be a one shot mission for all views. If all the above is completed, it won't take you that long.  
What you need to do here is to drop all the controller methods that render HTML leaving only one that delivers the main page.  
Move all your views routing logic to Angular leaving only the API routes on the back-end (if you prefix them like I said above, they will be easy to identify.

### Phase 4: The login page
In all this, I never mentioned the login page and it was on purpose.  
You can leave this one to the end because doing a full page refresh every time you login/logout will be useful to clean up some nasty global and badly written javascript you might have.  
Moving the login page into the single-page paradigm means that you don't do a form post to login, you do it by ajax request and you need to populate your previously prepared state service (Phase 2).  
You also have to clean this info once you logout or you get a 401 from the server and redirect to the login view.  


## The pitfalls list
During the process described above, you'll face a lot of challenges.  
Each time I had to do this exercise I kept aside a list of the problems I encountered and how I solved them.  
Bellow you'll find this list. I'll try to keep it up-to-date and you are also welcome to message me if you have other experiences you want to share.

### PF1: Converting the page javascript file into a controller
Of course, you're already using javascript in your site, so what should you do with it?

If you already use [RequireJS](http://requirejs.org/) or any other [AMD](http://requirejs.org/docs/whyamd.html) mechanism then it's easy because you already have your dependencies and encapsulation figured out.  
Each [RequireJS](http://requirejs.org/) module represents either a [Controller](https://docs.angularjs.org/guide/controller) or a [Factory or Service](https://docs.angularjs.org/guide/services) in the Angular world so all you need is to slightly change the way you declare it.

On the other hand, if you didn't pay the appropriate attention to the way you handle your Javascript then this will be a harder task.

The time you'll spend migrating each page into an AngularJS view will greatly depend on how well structured your current Javascript is.

### PF2: Splitting code into factories
All reusable code should, or better, must be moved into a Factory or Directive.  
Good examples of this are state or data related methods or code for popups that are used in multiple views.

### PF3: Think when it's a good idea to split functionalities into several modules
Modules in AngularJS are a great way to encapsulate logic or even to abstract enterprise level logic that can later on be reused in other applications.  
This way you can easily decouple dependencies and reuse the code later on.  
Thinking this ahead is a good idea, it won't slow you down and will save you big refactorings later.

### PF4: Be aware of library version conflicts
I recall this problem related to jQueryUI based FileUpload widget. We were using this JQueryUI widget that needed a jQueryUI version higher than the rest of our controls.  
I agree this is a bad thing to have as it is, but this was a legacy site and the client had implemented this upload functionality on a separate page and didn't want to update the other pages.  
All of the sudden, we were overriding one version of JQueryUI with another and breaking the whole site.

Another similar problem I also had with another site was with JQuery itself. Different versions of JQuery were being loaded by different components.

In the Multi-Page world, this is a bad practice but hardly a breaking problem, but as we moved to single-page we had a conflict because the main page itself never changes.

Be aware of this and enforce one single version for your components across the whole application.

### PF5: jQuery events bound to the document
This is a JQuery best-practice that will make you lose some time.  
The problem is that, in a multi-page web application, each time you change page, you start on a clean plate.  
In a single-page scenario, the document is always the same, events bound to it will remain there even when the view changes.

If we come to a view the event binds are set, lets say for a click of a button, moving to another page and coming back will make the events to be bound again resulting in multiple event handlers for the same event.

**Example:**  
{% highlight javascript %}
$(document).on('click', '#btnNext', function(){ ... });
{% endhighlight %}

**Solution:**  
Use ng-click and handle your code in the controller. This is the correct way to do it and should always be the preferred solution.

Now there might be cases where you want to just postpone conversion to ng-click so here are some temporary solutions:

**Temporary Solution 1**  
If the event handler can actually be bound directly to the element... do it.

**Temporary Solution 2**  
If we need to make a delegate event handler, wrap each view with a div.  
Move the event handlers from the document to this wrapper div.

**Temporary Solution 3**  
Some times the same view/controller can be used in more than one parent view.  
A good example of this is popups and the correct solution is to wrap them in Directives but, if for some edge reason at the moment you can't...

In this case we can't use the main view wrapper div because it's not always the same, so for these edge cases we remove the handler before adding it again:

{% highlight javascript %}
var gotoNextPage = function(){ /* do your stuff */ };
$(document).off('click', '#btnNext', gotoNextPage);
$(document).on('click', '#btnNext', gotoNextPage);
{% endhighlight %}

__Avoid this and any of the above temporary solutions if you can.__

### PF6: jQuery based controls/widgets will be a pain in the... neck
Most of them will fail to work properly, especially due to event-related problems. Reserve some substantial amount of time for this if you use a lot of these things.
Honor mentions to DatePicker, Dialog, jqGrid...

A lot of alternatives already exist for most of them and you'll see that wrapping them yourself with a Directive is also usually not a bad alternative.

So before starting the migration process, identify all your controls that might need to be worked out.  
If you work on them before starting a page migration, you'll feel much more confident estimating the effort.
		
### PF7: The Login page is still a separate page?
This will require a lot of refactoring, rewriting and rethinking.

Here's a small list of pain-points:

* Hiding the menus and everything else while you're in the login page
* Correctly redirecting/refreshing the view when you login/logout
* Handling the session information when you login/logout and press F5
  * Rethink everything related to the session data that was being handled server-side like user information, authorization, contextual data, etc...
* Security, Some views will need to be requested from the server without security validation
  * The main change in the paradigm will be that you really need to stop concerning about hiding pages from the user. Your main concern is to secure data, not the HTML and data is still coming and going to the server, secure it there!
* Make sure that all the state is rebuilt client-side if the user presses F5.
  * This often requires a separate AJAX call to get the user extra information based on the cookie that you already have.
* Move code into a security factory
  * Make sure all this code is "grouped" in a single reusable factory that is shared across all views.

### PF8: Slowly start to get rid of all jQuery selectors
This is kind of the end of the line for me. When you have the view fully working but jQuery is still being used inside your Angular Controllers.  
Take the extra time to get rid of them. You should not have any jQuery selector inside a Controller. Either replace them with native Directives and Services or create your own.

Things like ```$.ajax({})``` or ```$('#mybutton').on('click', function(){});``` must be banned from your code and replaced by [$http](https://docs.angularjs.org/api/ng/service/$http) and [ngClick](https://docs.angularjs.org/api/ngTouch/directive/ngClick) respectively.

## Final notes
I'm not addressing any migration considerations here specific to [Angular 2.0](https://angular.io/) but, apart from syntax changes, the overall considerations remain the same.

This article was based on my personal experience and I'm sure many other challenges are missing here. If you happen to have something to add, please drop me a line and I'll be happy to enrich this knowledge base.

I'm a regular contributor on [Experts-Exchange](http://www.experts-exchange.com/members/AlexCode.html) and recently I've also [answered a question regarding this topic](http://www.experts-exchange.com//questions/28712820/Adopting-AngularJS-in-existing-web-app-Struts-Tomcat.html).



