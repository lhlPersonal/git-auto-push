#Desc

### A tool to auto commit or push git repository.

* autopush eq 'git add . && git commit -m "xxx" && git push origin HEAD : refs/for/${branch} '.
* ${branch} is name of current remote branch which automatic analysed by shell.  

#steps:
1. npm install -g git-auto-push
2. cd directory name
3. autopush
