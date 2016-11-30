const express = require('express');
const router = express.Router();


/* GET home page. */
router.get('/', function(req, res, next) {
    postgreaccess.doQuery("SELECT * FROM menu", [], function(results){
        console.log(results);
        res.render('index', { rows: results });
    });
});


module.exports = router;
