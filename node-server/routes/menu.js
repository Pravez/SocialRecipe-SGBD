var express = require('express');
var router = express.Router();

/* GET menus page. */
router.get('/', function (req, res) {
    if (req.query["id"]) {
        postgreaccess.doQuery(queries.menus.query_id_user, [req.query["id"]], function (menu_user) {
            console.log(menu_user);
            postgreaccess.doQuery(queries.menus.query_id_recipes, [req.query["id"]], function(recipes){
                res.render('menu', {rows: menu_user, recipes_rows: recipes, session: req.session, menus:true});
            });
        });
    } else {
        postgreaccess.doQuery(queries.menus.all, [], function (results) {
            console.log(results);
            res.render('menus', {rows: results, menus: true, session: req.session});
        });
    }
});

router.post('/', function (req, res) {
    if (req.body["date"]) {
        var date = req.body["date"];
        if (date === "") date = "01/01/1970";
        date = date.split("/");
        var final_date = date[2] + "-" + date[0] + "-" + date[1];

        postgreaccess.doQuery(queries.menus.query_date, [final_date], function (results) {
            res.render('menus', {rows: results, date: req.body["date"], name: req.body["name"], session: req.session, menus:true});
        });
    } else {
        postgreaccess.doQuery(queries.menus.all, [], function (results) {
            res.render('menus', {rows: results, date: req.body["date"], name: req.body["name"], session: req.session, menus:true});
        });
    }
});


module.exports = router;
