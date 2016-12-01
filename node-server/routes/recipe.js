const express = require('express');
const router = express.Router();


/* GET home page. */
router.get('/', function(req, res, next) {
    postgreaccess.doQuery("SELECT * FROM recipe", [], function(results){
        console.log(results);
        res.render('recipes', { rows: results, recipes: true });
    });
});


module.exports = router;
