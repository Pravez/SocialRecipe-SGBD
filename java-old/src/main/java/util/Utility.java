package main.java.util;

import java.awt.*;

public class Utility {
    public static int[] IntegerArray(int... values){
        return values;
    }
    public static GridBagConstraints constraints(int gridx, int gridy, int gridwidth, int gridheight, double weightx, double weighty, int fill){
        GridBagConstraints b = new GridBagConstraints();
        b.gridx = gridx;
        b.gridy = gridy;
        b.gridwidth = gridwidth;
        b.gridheight = gridheight;
        b.weightx = weightx;
        b.weighty = weighty;

        b.fill = fill;

        return b;
    }
}
