
# Overcome github pages plugin limitations
# This script assumes that:
#   1. the development branch is 'dev'
#   2. the website branch used by github pages is 'master'
#   3. workspace and workspace-master folders exist under ~
#   4. workspace holds the dev branch and workspace-master holds the master branch

#   The procedure
#   The idea is to copy the contents of the _site folder in the dev branch 
#       into the root of the master branch in order to by-pass the google pages 
#       Jekyll plugins security limitations


# make sure we're on the right place
cd ~/workspace
git checkout dev

# rebuild website
jekyll build

# delete all files in master branch
cd ~/workspace-master
git checkout master
rm -rf *

# copy the contents of the dev branch _site dir
cd ~/workspace
cp -avr _site/* ../workspace-master/

# commit and push master
cd ~/workspace-master/
git add --all
git commit -m "update site"
git push
