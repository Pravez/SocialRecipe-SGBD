const express = require('express');
const router = express.Router();

/* GET menus page. */
router.get('/', function(req, res) {
    if(req.query["id"]) {
        postgreaccess.doQuery(queries.menus.query_id, [req.query["id"]], function (results) {
            console.log(results);
            res.render('menu', {rows: results});
        });
    }else{
        postgreaccess.doQuery(queries.menus.all, [], function (results) {
            console.log(results);
            res.render('menus', {rows: results, menus: true});
        });
    }
});

router.post('/', function(req, res){
    if(req.body["date"]){
         let date = req.body["date"];
         if(date === "") date = "01/01/1970";
         date = date.split("/");
         let final_date = date[2] + "-" + date[0] + "-" + date[1];

        postgreaccess.doQuery(queries.menus.query_date, [final_date], function (results) {
            res.render('menus', {rows: results, date: req.body["date"], name: req.body["name"]});
        });
    }else{
        postgreaccess.doQuery(queries.menus.all, [], function (results) {
            res.render('menus', {rows: results, date: req.body["date"], name: req.body["name"]});
        });
    }
});


module.exports = router;
