
$("#avg_rating").rating({stars: 3, min:0, max:3, step: 1, animate: false, showCaption: false, displayOnly: true, size:"lg"});
$("#rating").rating({stars: 3, min:0, max:3, step: 1, animate: false, showCaption: false, clearButton: "<i class=\"glyphicon glyphicon-minus\"></i>"});
$(".user-rate").rating({stars: 3, min:0, max:3, step: 1, animate: false, showCaption: false, displayOnly: true, size:"xs"});
$(".rating-container").css("font-size", "1.3em").css("display", "inline");

$("#all_preparations").click(function(event){
    event.preventDefault();

    $.post("/recipe", { preparations: recipe_id }, function(results){
        if(results.length > 1){
            $("#all_preparations_div").remove();
            for(var i=1;i<results.length;i++){
                $("#descriptions").append("<h4>Preparation by " + results[i]["pseudo"] + "</h4>");
                $("#descriptions").append("<p>" + results[i]["description_text"] + "</p>");
            }
        }else{
            $(this).remove();
            $("#preparations_result").html("Finally, it was the only preparation we found !");
        }
    });
});

function toggleDescription(){
    if($("#new_description").css("display") == "none"){
        $("#new_description").css("display", "block");
        $("#add_description").html("<small><a href=\"#\" onclick=\"event.preventDefault();toggleDescription();\">Hide preparation creation</a></small>");
    }else{
        $("#new_description").css("display", "none");
        $("#add_description").html("<small>Want to create one ? <a href=\"#\" onclick=\"event.preventDefault();toggleDescription();\">Click here</a></small>");
    }
}