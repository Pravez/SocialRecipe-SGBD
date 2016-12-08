var express = require('express');
var router = express.Router();


/* GET home page. */
var session;
router.get('/', function(req, res, next) {
    session = req.session;
    res.render('index', { home: true, session: session});
});


module.exports = router;
