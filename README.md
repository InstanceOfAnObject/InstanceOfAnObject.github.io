# InstanceOfAnObject.github.io
Some time back, I decided to take my blog out of Blogger.  
I'm not happy with it (I never was actually), so my first idea was to build my own blogging engine as a process for learning a new language.  
And so I did... Too many times :)  
I built it with NodeJS, AngularJS, React... played with several NoSql DB's, whatever...  
The outcome was always a workable playground but I never had the time to make them good enough for production.

Meanwhile I also tried existing blogging platforms and now I finally decided to use Jekyll and host it on GitHub.  
I'll be using this page to document my experience and maybe help someone else.

## Why Jekyll?


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