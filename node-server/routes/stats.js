var express = require('express');
var router = express.Router();

/* GET ingredients page. */
router.get('/', function (req, res) {
    if (req.query["rankings"] !== undefined) {
        postgreaccess.doQuery(queries.stats.ranking, [], function (results) {
            res.render('rankings/notes', {rows: results, session:req.session});
        })
    } else if(req.query["categories"] !== undefined) {
        var date = req.query["date"] || new Date().getFullYear();
        postgreaccess.doQuery(queries.stats.cat_ranking, ["01/01/"+date], function(results){
            res.render('rankings/categories', {rows: results, session:req.session, date:date});
        });
    }
});

module.exports = router;