// This file is required by the index.html file and will
// be executed in the renderer process for that window.
// All of the Node.js APIs are available in this process.
'use strict';

const riot = require('riot');
const remote = require('electron');
const path = require('path');


const tunnel = require('./connection/sshTunnel');

const pg = require('./connection/postgres');

//Get the app
const app = remote.app;
//Register app root as here
global.appRoot = path.resolve(__dirname);



const pgconfig = {
    user: 'enseirb', //env var: PGUSER
    database: 'enseirb', //env var: PGDATABASE
    password: 'vatefairefoutre', //env var: PGPASSWORD
    host: 'localhost', // Server hosting the postgres database
    port: 30003 //env var: PGPORT
};


const c = new pg(pgconfig);

c.doQuery("SELECT * FROM menu",[], console.log);

require('./test.tag');
riot.mount('test');
