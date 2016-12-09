var express = require('express');
var router = express.Router();


/* GET home page. */
router.get('/', function (req, res, next) {
    if (req.query["id"]) {
        postgreaccess.doQuery(queries.recipes.query_id, [req.query["id"]], function (recipe_values) {
            console.log(recipe_values);
            postgreaccess.doQuery(queries.recipes.query_id_ingredients, [req.query["id"]], function (ingredients_values) {
                console.log(ingredients_values);
                res.render('recipe', {
                    rows: recipe_values,
                    ingredients_rows: ingredients_values,
                    recipes: true,
                    session: req.session
                });
            });
        });
    } else {
        postgreaccess.doQuery(queries.recipes.everything, [], function (results) {
            postgreaccess.doQuery(queries.categories.all, [], function (categories) {
                console.log(categories);
                var computed = compute_categories(results);
                res.render('recipes', {rows: computed, categories: categories, recipes: true, session: req.session})
            });
        });
    }
});

function compute_categories(results) {
    var newResults = {};

    results.forEach(function (e) {
        if (!newResults[e["id_recipe"]]) {
            newResults[e["id_recipe"]] = e;
            var category = e["category_name"];
            newResults[e["id_recipe"]]["category_name"] = [category];
        } else {
            newResults[e["id_recipe"]]["category_name"].push(e["category_name"]);
        }
    });

    var final = [];

    for (var e in newResults) {
        if (newResults.hasOwnProperty(e)) {
            final.push(newResults[e]);
        }
    }

    return final;
}


module.exports = router;
