var express = require('express');
var router = express.Router();

/* GET ingredients page. */
router.get('/', function (req, res) {
    if (req.query["rankings"] !== undefined) {
        postgreaccess.doQuery(queries.stats.ranking, [], function (results) {
            res.render('rankings', {rows: results, session:req.session});
        })
    }
});

module.exports = router;