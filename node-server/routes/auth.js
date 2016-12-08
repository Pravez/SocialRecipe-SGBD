var express = require('express');
var router = express.Router();


/* GET home page. */
var session;

router.get('/', function(req, res){
    session = req.session;
    if(req.query["so"] && session.username != undefined){
        delete session.username;
        delete session.user_id;
        session.destroy();
        res.redirect(req.header('Referer') || '/');
    }else if(req.query["del"] && session.username != undefined){
        postgreaccess.doQuery(queries.users.remove, [session.user_id], function(results){
            delete session.username;
            delete session.user_id;
            session.destroy();
            res.redirect(req.header('Referer') || '/');
        });
    }else{
        res.redirect(req.header('Referer') || '/');
    }
});

router.post('/', function(req, res){
   session = req.session;
   if(req.body["name"] && session.username == undefined) {
       postgreaccess.doQuery(queries.users.auth, [req.body["name"]], function (results) {
           if (results.length > 0) {
               session.username = results[0]["pseudo"];
               session.user_id = results[0]["id_user"];
           }
           res.redirect(req.header('Referer') || '/');
       });
   }else if(req.body["new_user"] && session.username == undefined){
       postgreaccess.doQuery(queries.users.add, [req.body["new_user"]], function(results){
           postgreaccess.doQuery(queries.users.auth_id, [results[0]["id_user"]], function (newuser) {
               if (newuser.length > 0) {
                   session.username = newuser[0]["pseudo"];
                   session.user_id = newuser[0]["id_user"];
               }
               res.redirect(req.header('Referer') || '/');
           });
       });
   }
});


module.exports = router;
