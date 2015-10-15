# InstanceOfAnObject.github.io
Some time back, I decided to take my blog out of Blogger.  
I'm not happy with it (I never was actually), so my first idea was to build my own blogging engine as a process for learning a new language.  
And so I did... Too many times :)  
I built it with NodeJS, AngularJS, React... played with several NoSql DB's, whatever...  
The outcome was always a workable playground but I never had the time to make them good enough for production.

Meanwhile I also tried existing blogging platforms and now I finally decided to use Jekyll and host it on GitHub.  
I'll be using this page to document my experience and maybe help someone else.

## Why Jekyll?
My first option was [Ghost](https://ghost.org/).  
For whoever doesn't know about it, [Ghost](https://ghost.org/) is a publishing platform based on [node.js](https://nodejs.org/en/) and (Express)[http://expressjs.com/]. 
The community is very active and the product features are pretty impressive.  
The problem is that I don't intend to collaborate or do anything else other than put some words out there. Most of all, I didn't want to have a database to store static content.

I want to write, publish and go on with my life.

That's when I found [Jekyll](http://jekyllrb.com/).  
To put it correctly, I found it through Github when I was reading about what it supports as publising platforms for project and user pages.

Jekyll itself is not a blogging platform, is "simply" an HTML generator.  
What you get as a publisher is a set of static HTML files that you can just deploy wherever you want.  
In my case I'm using Github pages and it works just fine.  
If Github turns out not to be the best hosting option, moving everything somewhere else requires no additional effort.

## Plugins
### Plugins under GitHub Pages
Due to security restrictions, GitHub only supports a (very) limited number of Jekyll plugins.  
Everything else zou might have in zour _plugins folder will be ignored.

This means that everything works fine on your dev machine but once you deploy do GitHub Pages you'll loose functionality.  
To solve this I decided to take advantage of git branches and the .nojekyll file.

What I ended up doing was:

* create a 'dev' branch where I have the full Jekyll project
* empty the 'master' branch and copy the contents of the dev branch _site folder
* add the .nojekyll file in the root of the 'master' branch to tell GitHub that this is not a Jekyll site
and that's it.

To automate things I've created a deploy.sh bash file in the 'dev' branch.

This is a user site. In case you have a repository site, do the same but for the gh-pages branch.

### Taking the most out of Tags
I like to tag my posts 

## Redirecting old Blogger URL's
One thing I absolutely had to support is the redirection from the old Blogger URL structure.  
As Jekyll has a different document structure and I also wanted to do some cleanup my previous articles now live in a different URL to which I need to point if someone still points to the old ones.

To accomplish this I decided to use the 404.html page and add some javascript in there.  
Here's a small code snippet but you can refer to the whole file [here](https://github.com/InstanceOfAnObject/InstanceOfAnObject.github.io/blob/master/404.html#L243-L365).

{% highlight javascript %}
<script>
	(function(){
		var url = window.location,
			path = url.pathname;

		// handle old blogger urls
		switch(path){
			case '/2013/02/fix-ssrs-report-showing-blank-pages.html':
				window.location.href = '/blog/2013/02/19/fix-ssrs-report-showing-blank-pages-when-exporting-to-pdf.html';
				break;
			case '/2012/08/windows-7-2008-r2-as-internet-hot-spot.html':
				window.location.href = '/blog/2012/08/05/windows-as-internet-hotspot.html';
				break;
            
            /* ... and so on ... */
            
		}
	})();
</script>
{% endhighlight %}

## Using Jekyll on Cloud9
C9 is a great way to edit your GitHub pages Jekyll site.  
Basically you just login with your github account, clone to repository and start editing.

Here I'll log the issues and solutions I'll be facing.

### Start serving Jekyll from C9
To start serving Jekyll locally we usually use: *jekyll serve*  
Under C9 we have to be a bit more specific and specify the host and port:
```bash
jekyll serve --host $IP --port $PORT --baseurl ''
```
If it complains that the port 8080 is already in use, chances are that Apache server took it for himself.  
Execute this to make sure:
```bash
lsof -i:8080
```
If it's in fact Apache, execute the following to stop the process:
```bash
sudo /etc/init.d/apache2 stop
```
After this, try starting jekyll again, it will work.