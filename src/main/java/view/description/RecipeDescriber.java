package main.java.view.description;

import javax.swing.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class RecipeDescriber extends DescriberPane{

    public RecipeDescriber(){
        super();

        mainQualifier = "recipe.recipe_name";

        describers = new ArrayList<>();
        addDescriber("recipe_name", "Recipe Name :");

        this.setVisibilityAll(true);
    }

    @Override
    public void updateDescriber(HashMap<String, Object> values) {
        super.updateDescriber(values);
        for(Map.Entry<String, Map.Entry<JLabel, JTextArea>> entry : this.describers){
            if(values.containsKey(entry.getKey())){
                entry.getValue().getValue().setText((String)values.get(entry.getKey()));
            }
        }
    }

    @Override
    void update(String[] set) {

    }
}
