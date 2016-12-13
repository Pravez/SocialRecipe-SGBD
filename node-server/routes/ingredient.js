var express = require('express');
var router = express.Router();

/* GET ingredients page. */
router.get('/', function (req, res) {
    if (req.query["id"]) {
        postgreaccess.doQuery(queries.ingredients.query_id_nc, [req.query["id"]], function (results) {
            console.log(results);
            postgreaccess.doQuery(queries.stats.ingredient_ranking_id, [req.query["id"]], function(coef){
                var final = coef[0]["?column?"];
                if(final == null)
                    final = 0;
                final = Number(final).toFixed(3);
                res.render('ingredient', {rows: results, session: req.session, ingredients:true, coef:final});
            });
        });
    } else {
        postgreaccess.doQuery(queries.ingredients.all, [], function (results) {
            console.log(results);
            res.render('ingredients', {rows: results, ingredients: true, session: req.session});
        });
    }
});

module.exports = router;