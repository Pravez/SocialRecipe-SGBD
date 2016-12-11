
$("#avg_rating").rating({stars: 3, min:0, max:3, step: 1, animate: false, showCaption: false, displayOnly: true, size:"xs"});
$("#rating").rating({stars: 3, min:0, max:3, step: 1, animate: false, showCaption: false, clearButton: "<i class=\"glyphicon glyphicon-minus\"></i>"});

$("#all_preparations").click(function(event){
    event.preventDefault();

    $.post("/recipe", { preparations: recipe_id }, function(results){
        $("#all_preparations_div").remove();
        if(results.length > 1){
            for(var i=1;i<results.length;i++){
                $("#descriptions").append("<h4>Preparation by " + results[i]["pseudo"] + "</h4>");
                $("#descriptions").append("<p>" + results[i]["description_text"] + "</p>");
            }
        }
    });
});