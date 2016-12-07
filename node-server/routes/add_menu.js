var express = require('express');
var router = express.Router();


/* GET home page. */
router.get('/', function(req, res, next) {
    postgreaccess.doQuery(queries.recipes.all, [], function(results){
        res.render("add/add_menu", { rows: results });
    });
});

router.post('/', function(req, res){
    if(req.body["menu_name"]){
        var name = req.body["menu_name"];
    }else{

    }
});


module.exports = router;
