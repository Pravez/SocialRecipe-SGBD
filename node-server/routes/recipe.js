var express = require('express');
var router = express.Router();


/* GET home page. */
router.get('/', function(req, res, next) {
    if(req.query["id"]){
        postgreaccess.doQuery(queries.recipes.query_id, [req.query["id"]], (results) => {
            console.log(results);
            res.render('recipe', {rows: results, recipes: false});
        });
    }else {
        postgreaccess.doQuery(queries.recipes.everything, [], (results) => {
            postgreaccess.doQuery(queries.categories.all, [], (categories) =>{
                console.log(categories);
                //console.log(results);
                res.render('recipes', {rows: results, categories: categories, recipes: true})
            });
        });
    }
});


module.exports = router;
