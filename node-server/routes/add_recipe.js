var express = require('express');
var router = express.Router();


/* GET home page. */
router.get('/', function (req, res, next) {
    postgreaccess.doQuery(queries.ingredients.all, [], function (results) {
        postgreaccess.doQuery(queries.categories.all, [], function (cat_results) {
            postgreaccess.doQuery(queries.unit.all, [], function (unit_results) {
                res.render("add/add_recipe", {
                    session: req.session,
                    ingredients_rows: results,
                    categories_rows: cat_results,
                    unit_rows: unit_results
                });
            });
        });
    });
});

module.exports = router;
