'use strict';

const tunnel = require('tunnel-ssh');


const config = {
    username: 'enseirb',
    password: 'vatefairefoutre42sgbd',
    host: 'pravez.ddns.net',
    port: 22,
    dstHost: 'localhost',
    dstPort: 5432,
    localHost: 'localhost',
    localPort: 30003,
    keepAlive: true
};

const ssh = tunnel(config, function(error, tnl){
    if(error){
        console.log(error);
        process.exit();
    }

    console.log("connected");
});

module.exports = ssh;