var express = require('express');
var router = express.Router();


/* GET home page. */
router.get('/', function(req, res, next) {
    if(req.session.username) {
        postgreaccess.doQuery(queries.recipes.all, [], function (results) {
            res.render("add/add_menu", {rows: results, session: req.session});
        });
    }else{
        res.redirect(req.header('Referer') || '/');
    }
});

router.post('/', function(req, res){
    if(req.body["menu_name"]){
        var name = req.body["menu_name"];
        var array_recipes = [];

        for(var key in req.body){
            if(req.body.hasOwnProperty(key)){
                if(key != "menu_name" && req.body[key] != ""){
                    array_recipes.push(req.body[key]);
                }
            }
        }

        postgreaccess.doQuery(queries.add.menus.query_menu, [name, req.session.user_id], function(results){
            console.log(results);
            for(var i = 0;i<array_recipes.length;i++){
                postgreaccess.doQuery(queries.add.menus.query_part_of, [array_recipes[i], results[0]["id_menu"], ], function(res){
                    console.log(res);
                });
            }

            res.render("add/add_menu", {rows: results, session: req.session, added: results});
        });


    }else{
        res.redirect('/add_menu');
    }
});


module.exports = router;
