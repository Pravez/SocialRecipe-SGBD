var express = require('express');
var router = express.Router();


/* GET home page. */
router.get('/', function(req, res, next) {
    res.render("add/add_ingredient", {session: req.session});
});

router.post('/', function(req, res){
    if(req.body["ingredient_name"]){
        var name = req.body["ingredient_name"];
        var calories = parseInt(req.body["calories"]);
        var lipids = parseInt(req.body["lipids"]);
        var carbohydrates = parseInt(req.body["carbohydrates"]);
        var proteins = parseInt(req.body["proteins"]);

        postgreaccess.doQuery(queries.add.ingredients.query_ingredient, [name], function (results) {
            var id = results[0].id_ingredient;
            postgreaccess.doQuery(queries.add.ingredients.query_ing_charac, [queries.add.ingredients.calory, id, calories], function (ca) {
                console.log(ca);
                postgreaccess.doQuery(queries.add.ingredients.query_ing_charac, [queries.add.ingredients.protein, id, proteins], function (pr) {
                    console.log(pr);
                    postgreaccess.doQuery(queries.add.ingredients.query_ing_charac, [queries.add.ingredients.carbohydrate, id, carbohydrates], function (car) {
                        console.log(car);
                        postgreaccess.doQuery(queries.add.ingredients.query_ing_charac, [queries.add.ingredients.lipid, id, lipids], function (li) {
                            console.log(li);
                            res.render("add/add_ingredient", {added: true, session: req.session});
                        });
                    });
                });
            });
        });
    }else{

    }
});


module.exports = router;

