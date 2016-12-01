function search_value(value, expression, attribute, id){
    rows.forEach((e) =>{
        if(!e[value].match(new RegExp(expression, 'i'))){
            document.querySelector('['+attribute+'="'+e[id]+'"]').style.display = "none";
        }else{
            document.querySelector('['+attribute+'="'+e[id]+'"]').style.display = "";
        }
    });
}