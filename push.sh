#!/bin/bash

#获取远程分支名
function obtain_git_branch {
  branch=`git branch -vv`
  result=`echo ${branch##*"*"}`
  result1=`echo ${result#*"/"}`
  currbranch=`echo ${result1%%":"*}`

  echo ${currbranch}
}

#确认是否提交
read -r -p "Are You Sure to Push? [Y/n] " input

case ${input} in
    [yY][eE][sS]|[yY])
		;;

    [nN][oO]|[nN])
		echo "exit"
		exit 1
       		;;
    *)
	echo "Invalid input"
	exit 1
	;;
esac

#关联远程分支
#git init && git checkout -b master && git remote add origin xxx && git branch -u origin/master

#提交到当前远程分支
#输入commit message
read -p "Please input commit message:" msg
git add .&& git commit -m "${msg}"

#获取当前分支所在的远程分支
currbh=`obtain_git_branch`

#尝试两种方式提交
git push origin HEAD:${currbh}

git push origin HEAD:refs/for/${currbh}
