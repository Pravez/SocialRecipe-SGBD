var express = require('express');
var router = express.Router();


/* GET home page. */
router.get('/', function(req, res, next) {
    postgreaccess.doQuery("SELECT * FROM menu", [], function(results){
        console.log(results);
        res.render('index', { rows: results , home: true});
    });
});


module.exports = router;
