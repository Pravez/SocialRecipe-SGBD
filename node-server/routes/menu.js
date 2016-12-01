const express = require('express');
const router = express.Router();

/* GET menus page. */
router.get('/', function(req, res, next) {
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


module.exports = router;
