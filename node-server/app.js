var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var app = express();
var postgres = require('./lib/postgres');
var ssh = require('./lib/sshConnection');
var session = require('express-session');

var index = require('./routes/index');
var menu = require('./routes/menu');
var recipe = require('./routes/recipe');
var ingredient = require('./routes/ingredient');

var add_ingredient = require('./routes/add_ingredient');
var add_menu = require('./routes/add_menu');

var authentification = require('./routes/auth');

app.use(session({secret:"canard rhododendron"}));


var pgconfig = {
    user: 'enseirb', //env var: PGUSER
    database: 'enseirb', //env var: PGDATABASE
    password: 'vatefairefoutre', //env var: PGPASSWORD
    host: 'localhost', // Server hosting the postgres database
    port: 30003 //env var: PGPORT
};

postgreaccess = new postgres(pgconfig);
queries = require('./lib/queries.json');

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));
app.use(cookieParser());
app.use(require('less-middleware')(path.join(__dirname, 'public')));
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', index);
app.use('/menu', menu);
app.use('/recipe', recipe);
app.use('/ingredient', ingredient);
app.use('/add_ingredient', add_ingredient);
app.use('/add_menu', add_menu);

app.use('/auth', authentification);

// catch 404 and forward to error handler
app.use(function (req, res, next) {
    var err = new Error('Not Found');
    err.status = 404;
    next(err);
});

// error handler
app.use(function (err, req, res, next) {
    // set locals, only providing error in development
    res.locals.message = err.message;
    res.locals.error = req.app.get('env') === 'development' ? err : {};

    // render the error page
    res.status(err.status || 500);
    res.render('error');
});

module.exports = app;
