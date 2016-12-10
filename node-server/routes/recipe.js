var express = require('express');
var router = express.Router();


/* GET home page. */
router.get('/', function (req, res, next) {
    if (req.query["id"]) {
        postgreaccess.doQuery(queries.recipes.query_id, [req.query["id"]], function (recipe_values) {
            console.log(recipe_values);
            postgreaccess.doQuery(queries.recipes.query_id_ingredients, [req.query["id"]], function (ingredients_values) {
                console.log(ingredients_values);
                postgreaccess.doQuery(queries.recipes.query_id_description, [req.query["id"]], function (description) {
                    console.log(description);
                    postgreaccess.doQuery(queries.recipes.query_id_comments, [req.query["id"]], function (comments) {
                        console.log(comments);
                        postgreaccess.doQuery(queries.recipes.query_id_notes, [req.query["id"]], function (notes){
                            var new_notes = convert_notes(notes);
                            var average = compute_average(notes);
                            console.log(new_notes);
                            res.render('recipe', {
                                rows: recipe_values,
                                ingredients_rows: ingredients_values,
                                description_rows: description,
                                comments_rows: comments,
                                notes_rows: new_notes,
                                average_note: average,
                                recipes: true,
                                session: req.session
                            });
                        });
                    });
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

function convert_notes(notes){
    var new_notes = {};

    for(var i=0;i<notes.length;i++){
        new_notes[notes[i]["pseudo"]] = notes[i]["note"];
    }

    return new_notes;
}

function compute_average(notes){
    if(notes.length != 0) {
        var average = 0;

        for (var i = 0; i < notes.length; i++)
            average += notes[i]["note"];

        return average / notes.length;
    }else{
        return -1;
    }
}


module.exports = router;
