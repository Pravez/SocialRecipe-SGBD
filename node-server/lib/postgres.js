const pg = require('pg');

var PostGres = function(config){
    this.client = new pg.Client(config);
    this.client.connect(function(err){ if(err) throw err; });
};

PostGres.prototype.doQuery = function(query, args, callback){
    let array = [];
    let result = this.client.query(query, args);
    result.on('row', (row) => {
        array.push(row);
    });

    result.on('end', () => callback(array));
};

module.exports = PostGres;