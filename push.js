#!/usr/bin/env node

const child = require('child_process');
const path = require('path');
const readlineSync = require('readline-sync');

const needPush = readlineSync.question('Are You Sure to Push? [Y/n] ');

if (['Y', 'y'].includes(needPush)) {
    const cmtMsg = readlineSync.question('Please input commit message: ');

    if (cmtMsg !== '') {
        /**
         * exec方法相比spawn方法，多提供了一个回调函数，可以更便捷得获取子进程输出。这与为返回的ChildProcess对象的stdout或stderr监听data事件来获得输出的区别在于：
         * data事件的方式，会在子进程一有数据时就触发，并把数据返回给Node。
         * 而回调函数，则会先将数据缓存在内存中（数据量小于maxBuffer参数），等待子进程运行完毕后，再调用回调函数，并把最终数据交给回调函数。
         */
        //callback里的stout会先加入缓存，在命令执行完之后才输出，会有延迟，且返回内容有大小限制，并且不能保证执行顺序和输出顺序一致。
        // child.execFile('sh-push', ['-m', cmtMsg, '-n', needPush], function (error, stdout, stderr) {
        //     if (error) {
        //         console.error(error.message);
        //     }
        //     if (stderr) {
        //         console.error(stderr);
        //     }
        //     if (stdout) {
        //         console.info(stdout);
        //     }
        // });

        const ls = child.spawn('bash', [path.join(process.env['NODE_PATH'], 'git-auto-push', 'push2.sh'), '-m', cmtMsg, '-n', needPush]);
        //有返回就会输出，比较实时，且没有大小限制，适合大文件
        ls.stdout.on('data', function (data) {
            console.log('' + data);
        });
        ls.stderr.on('data', function (data) {
            console.error('' + data);
        });
        ls.on('exit', function (code) {
            //console.log('exit:' + code);
        });
    } else {
        console.log('Commit message can not be empty!!!');
    }
}
