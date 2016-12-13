var express = require('express');
var router = express.Router();

/* GET ingredients page. */
router.get('/', function (req, res) {
    if (req.query["rankings"] !== undefined) {
        postgreaccess.doQuery(queries.stats.ranking, [], function (results) {
            res.render('rankings/notes', {rows: results, session: req.session});
        })
    } else if (req.query["categories"] !== undefined) {
        var date = req.query["date"] || new Date().getFullYear();
        postgreaccess.doQuery(queries.stats.cat_ranking, ["01/01/" + date], function (results) {
            res.render('rankings/categories', {rows: results, session: req.session, date: date});
        });
    } else if (req.query["average"] !== undefined) {
        postgreaccess.doQuery(queries.stats.user_menu_average, [req.query["id"]], function (results) {
            var menus_ranks = parse_menus(results);
            postgreaccess.doQuery(queries.users.all, [], function (users) {
                postgreaccess.doQuery(queries.stats.user_average, [req.query["id"]], function (total_average) {
                    res.render('rankings/user_avg', {
                        rows: menus_ranks,
                        session: req.session,
                        total_average: total_average,
                        users: users,
                        user_selected: req.query["id"]
                    });
                });
            });
        });
    } else if (req.query["ingredient_ranking"] !== undefined) {
        postgreaccess.doQuery(queries.stats.ingredients_ranking, [], function (results) {
            res.render('rankings/ingredients_ranking', {rows: results, session: req.session});
        });
    }
});

function parse_menus(results) {
    var final = [];
    var temp = {};
    results.forEach(function (e) {
        if (!temp[e["menu_name"]]) temp[e["menu_name"]] = {recipes: []};
        temp[e["menu_name"]].id_menu = e["id_menu"];
        temp[e["menu_name"]].recipes.push({recipe_name: e["recipe_name"], avg: e["avg"], id_recipe: e["id_recipe"]});
    });

    for (var key in temp) {
        if (temp.hasOwnProperty(key)) {
            final.push({menu_name: key, id_menu: temp[key].id_menu, recipes: temp[key].recipes})
        }
    }

    return final;
}

module.exports = router;