let selected_servings = 2;
let selected_category = 0;

$("#servings-list").find("li a").on("click", function (e) {
    $("#servings-list").find("li").removeClass("active");
    $(this).parent().addClass("active");
    selected_servings = parseInt($(this).parent().attr("id-selection"));
    search_value();
});

$("#categories-list").find("li a").on('click', function (e) {
    $("#categories-list").find("li").removeClass("active");
    $(this).parent().addClass("active");
    selected_category = parseInt($(this).parent().attr("id-category"));
    $("#search_categories").val($(this).html());
    search_value();
});

function test_servings(type, value, totest) {
    if (value < 0)
        return true;

    switch (type) {
        case 1:
            return value == totest;
        case 2:
            return value >= totest;
        case 3:
            return value <= totest;
    }

    return true;
}

function search_value() {
    let search_name = $("#search_name").val();
    let search_servings = $("#search_servings").val();
    let search_category = $("#search_categories").val();
    if (search_servings === "")
        search_servings = -1;

    if (search_category === "" || search_category === "All")
        search_category = "";

    let found = 0;

    rows.forEach(function (e) {
        if (e[name].match(new RegExp(search_name, 'i')) && test_servings(selected_servings, parseInt(search_servings), e[quantity]) && validate_category(e, new RegExp(search_category, "i"))) {
            document.querySelector('[' + id_field + '="' + e[id] + '"]').style.display = "";
            found++;
        } else {
            document.querySelector('[' + id_field + '="' + e[id] + '"]').style.display = "none";
        }
    });

    if (found > 0)
        document.querySelector("#nothing-found").style.display = "none";
    else
        document.querySelector("#nothing-found").style.display = "";
}

function validate_category(element, regex) {
    for (var i = 0; i < element[category].length; i++) {
        if (element[category][i].match(regex)) {
            return true;
        }
    }

    return false;
}

$("#honeysalt").click(function (event) {
    $.post("/recipe", {honeysalt: true}, function (results) {
        $(".recipe-item").css("display", "none");
        results.forEach(function (e) {
            $("[" + id_field + "=\"" + e[id] + "\"]").css("display", "block");
        });
    });
});

$("#top_recipes").click(function (event) {
    $.post("/recipe", {top_recipes:true}, function(results){
        $(".recipe-item").css("display", "none");
        results.forEach(function(e){
            $("[" + id_field + "=\"" + e[id] + "\"]").css("display", "block");
        });
    });
});