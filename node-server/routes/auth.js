var express = require('express');
var router = express.Router();


/* GET home page. */
var session;

router.get('/', function(req, res){
    session = req.session;
    if(req.query["so"] && session.username != undefined){
        delete session.username;
        session.destroy();
    }
    res.redirect(req.header('Referer') || '/');
});

router.post('/', function(req, res){
   session = req.session;
   if(req.body["name"] && session.username == undefined) {
       postgreaccess.doQuery(queries.users.auth, [req.body["name"]], function (results) {
           if (results.length > 0)
               session.username = results[0]["pseudo"];
           res.redirect(req.header('Referer') || '/');
       });
   }
});


module.exports = router;
