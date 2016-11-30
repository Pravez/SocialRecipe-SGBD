package main.java.view.description;


import javax.swing.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;


public class IngredientDescriber extends DescriberPane {

    public IngredientDescriber(){
        super();

        mainQualifier = "ingredient.ingredient_name";

        describers = new ArrayList<>();
        addDescriber("ingredient_name", "Ingredient name :");

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
