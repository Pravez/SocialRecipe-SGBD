var pg = require('pg');

var PostGres = function(config){
    this.client = new pg.Client(config);
    this.client.connect(function(err){ if(err) throw err; });
};

PostGres.prototype.doQuery = function(query, args, callback){
    var array = [];
    var result = this.client.query(query, args);
    result.on('row', function(row){
        array.push(row);
    });

    result.on('end', function(){callback(array)});
};

module.exports = PostGres;