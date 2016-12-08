var express = require('express');
var router = express.Router();


/* GET home page. */
router.get('/', function(req, res, next) {
    if(req.query["id"]){
        postgreaccess.doQuery(queries.recipes.query_id, [req.query["id"]], function(results){
            console.log(results);
            res.render('recipe', {rows: results, recipes: false, session: req.session});
        });
    }else {
        postgreaccess.doQuery(queries.recipes.everything, [], function(results){
            postgreaccess.doQuery(queries.categories.all, [], function(categories){
                console.log(categories);
                //console.log(results);
                res.render('recipes', {rows: results, categories: categories, recipes: true, session: req.session})
            });
        });
    }
});


module.exports = router;
