'use strict';

var tunnel = require('tunnel-ssh');


var config = {
    username: 'enseirb',
    password: '', // ME DEMANDER LE PASS
    host: 'pravez.ddns.net',
    port: 22,
    dstHost: 'localhost',
    dstPort: 5432,
    localHost: 'localhost',
    localPort: 30003,
    keepAlive: true
};

var ssh = tunnel(config, function(error, tnl){
    if(error){
        console.log(error);
        process.exit();
    }

    console.log("connected");
});

module.exports = ssh;
