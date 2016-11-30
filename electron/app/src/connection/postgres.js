var pg = require('pg');

class PostGres{

    constructor(config){
        this.client = new pg.Client(config);
        this.client.connect(function(err){ if(err) throw err; });
    }

    doQuery(query, args, callback) {
        let result = this.client.query(query, args);
        result.on('row', function (row) {
            callback(row);
        });
    }
}

module.exports = PostGres;