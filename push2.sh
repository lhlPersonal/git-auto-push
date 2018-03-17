#!/bin/bash

MSG=""
INPUT=""

#获取参数
while getopts m:n: arg
do
    case ${arg} in
        m)MSG=$OPTARG;;
        n)INPUT=$OPTARG;;
        \?)echo "Invalid args";;
    esac
done

#判断本地commitid和远程commitid是否相等
function needpush {
    localid=`git rev-parse HEAD`
    latestlog=`git log -p -1`
    remoteid=`echo ${latestlog:7:40}`

    if [[ "${localid}" == "${remoteid}" ]]
        then echo 'F'
    else echo 'T'
    fi
}

#获取远程分支名
function obtain_git_branch {
    branch=`git branch -vv`
    result=`echo ${branch##*"*"}`
    result1=`echo ${result#*"/"}`
    currbranch=`echo ${result1%%":"*}`

    echo ${currbranch}
}

#提交到当前远程分支
git add . && git commit -m "${MSG}"

#获取当前分支所在的远程分支
currbh=`obtain_git_branch`

#push
git push origin HEAD:refs/for/${currbh}

echo 'exec end'