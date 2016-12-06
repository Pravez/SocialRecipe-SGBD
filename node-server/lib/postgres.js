var pg = require('pg');

var PostGres = function(config){
    this.client = new pg.Client(config);
    this.client.connect(function(err){ if(err) throw err; });
};

PostGres.prototype.doQuery = function(query, args, callback){
    var array = [];
    var result = this.client.query(query, args);
    result.on('row', (row) => {
        array.push(row);
    });

    result.on('end', () => callback(array));
};

module.exports = PostGres;