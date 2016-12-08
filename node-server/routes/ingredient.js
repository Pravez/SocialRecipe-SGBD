var express = require('express');
var router = express.Router();

/* GET ingredients page. */
router.get('/', function (req, res) {
    if (req.query["id"]) {
        postgreaccess.doQuery(queries.ingredients.query_id, [req.query["id"]], function (results) {
            console.log(results);
            res.render('ingredient', {rows: results, session: req.session});
        });
    } else {
        postgreaccess.doQuery(queries.ingredients.all, [], function (results) {
            console.log(results);
            res.render('ingredients', {rows: results, ingredients: true, session: req.session});
        });
    }
});

module.exports = router;