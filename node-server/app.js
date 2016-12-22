var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var app = express();
var postgres = require('./lib/postgres');
var session = require('express-session');

var index = require('./routes/index');
var menu = require('./routes/menu');
var recipe = require('./routes/recipe');
var ingredient = require('./routes/ingredient');

var add_ingredient = require('./routes/add_ingredient');
var add_menu = require('./routes/add_menu');
var add_recipe = require('./routes/add_recipe');

var statistics = require('./routes/stats');

var authentification = require('./routes/auth');

app.use(session({secret:"canard rhododendron"}));



/********************PARTIE CONFIGURATION************************************/
/***************************************************************************/
//A commenter si vous ne souhaitez pas utiliser de tunnel ssh
//vers la raspberry contenant la base de donnees
var ssh = require('./lib/sshConnection');

var pgconfig = {
    user: 'enseirb', //precisez ici l'utilisateur utilisant la base de donnees
    database: 'enseirb', //ici le nom de la base de donnees
    password: '', //ici le mot de passe de l'utilisateur pour se connecter (ME DEMANDER LE PASS)
                                 //Nous excuserons ici la nature du contenu du mot de passe, et le laisserons passer
                                 //comme mot de passe lambda, simple enchaînement de lettres sans réelle significations
                                 //n'ayant pour but que de rendre compliqué l'accès à des données protégées ...
    host: 'localhost', // ici le host de la base de donnees
    port: 30003 //et enfin ici le port sur lequel se connecter
};
/******************************************************************************/



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
app.use('/add_recipe', add_recipe);

app.use('/auth', authentification);
app.use('/stats', statistics);


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
