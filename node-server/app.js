const express = require('express');
const path = require('path');
const favicon = require('serve-favicon');
const logger = require('morgan');
const cookieParser = require('cookie-parser');
const bodyParser = require('body-parser');
const app = express();
const postgres = require('./lib/postgres');
const ssh = require('./lib/sshConnection');

const index = require('./routes/index');
const menu = require('./routes/menu');
const recipe = require('./routes/recipe');


const pgconfig = {
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
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(require('less-middleware')(path.join(__dirname, 'public')));
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', index);
app.use('/menu', menu);
app.use('/recipe', recipe);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  const err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
