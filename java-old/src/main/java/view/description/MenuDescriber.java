package main.java.view.description;


import javax.swing.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;


public class MenuDescriber extends DescriberPane{

    public MenuDescriber(){
        super();

        mainQualifier = "menu.menu_name";

        describers = new ArrayList<>();
        addDescriber("menu_name", "Menu name :");

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
