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

router.post('/', function (req, res, next) {
    if (req.body["recipe_name"]) {
        var recipe_name = req.body["recipe_name"];
        var servings = req.body["servings"];
        var description = req.body["description_text"];
        var categories = req.body["categories"];

        var cooking = pg_parse(req.body["cooking_time"] || "00:00:00");
        var preparation = pg_parse(req.body["preparation_time"] || "00:00:00");
        var waiting = pg_parse(req.body["waiting_time"] || "00:00:00");

        var now = new Date();
        var now_date = now.getDate() + "/" + (now.getMonth()+1) + "/" + now.getFullYear();

        var ingredients = parse_ingredients(req.body);
        var max = Object.keys(ingredients.id).length;

        postgreaccess.doQuery(queries.add.recipes.recipe, [recipe_name, now_date, preparation, cooking, waiting, servings], function(result){
            var id = result[0]["id_recipe"];

            categories.forEach(function(e){
                postgreaccess.doQuery(queries.add.recipes.link_category, [e, id], function(res){
                    console.log("category");
                });
            });

            for(var i = 0;i<max;i++){
                var n_insert = {id: ingredients.id[i], quantity: ingredients.quantity[i], unit: ingredients.unit[i]};
                if(n_insert.id != "" && n_insert.quantity != "" && n_insert.unit != "")
                    postgreaccess.doQuery(queries.add.recipes.link_ingredient, [n_insert.id, id, n_insert.unit, n_insert.quantity], function(res){
                        console.log("link_ingredient")
                    });
            }

            postgreaccess.doQuery(queries.add.recipes.link_description, [description, now_date, id, 0], function(res){
                console.log("description");
            });

            res.redirect('/recipe');
        });
    }
});

function pg_parse(time) {
    var array = time.split(":");

    return array.length == 2 ? array[1] + " minutes " + array[0] + " hours " : array[2] + " seconds " + array[1] + " minutes " + array[0] + " hours ";
}

function parse_ingredients(body){
    var results = [];
    var regexs = [new RegExp("ingredient_unit"), new RegExp("ingredient_quantity"), new RegExp("ingredient_id")];
    for(var key in body){
        if(body.hasOwnProperty(key)){
            if(key.match(regexs[0]) || key.match(regexs[1]) || key.match(regexs[2])){
                if(body[key] != "")
                    results.push({key: key, value:body[key]});
            }
        }
    }

    var final = {quantity:{}, unit:{}, id:{}};

    results.forEach(function(e){
        var splitted = e.key.split("_");
        switch(splitted[1]){
            case "unit":
                final.unit[splitted[2]] = e.value;
                break;
            case "quantity":
                final.quantity[splitted[2]] = e.value;
                break;
            case "id":
                final.id[splitted[2]] = e.value;
                break;
        }
    });

    return final;
}

module.exports = router;
