import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Attention;
import Toybox.System;
import Toybox.Sensor;
import Toybox.Graphics;

class Resulting {

    var eff = 0;
    var points = 0;
    var eff_multipler = 0;

    function resulting(seconds, avg_stres, max_stress, stress_median){
        if(seconds != 0){
            eff = (max_stress - stress_median).toNumber();
            eff_multipler = (avg_stres/seconds * 1.0) / stress_median;
            points = Math.round(eff_multipler * (seconds/10)).toNumber();
            if(eff < 0) {eff = 0;}
        }

        Application.Storage.setValue("levelProgress", Application.Storage.getValue("levelProgress") + points);

        if(Application.Storage.getValue("levelProgress") >= Application.Storage.getValue("nextlevelneededpoints")){ //LEVEL UP ! 
            var playerlvl = Application.Storage.getValue("level") + 1;  //LVL UP
            Application.Storage.setValue("level", playerlvl);                 //lvl + Math.floor(lvl / 3)
            Application.Storage.setValue("levelProgress", Application.Storage.getValue("levelProgress") - Application.Storage.getValue("nextlevelneededpoints"));
            Application.Storage.setValue("nextlevelneededpoints", 50+50*((playerlvl)*(playerlvl)));
        }
        
    }

    function draw(dc){
        dc.clear();
        dc.drawText(FindYourPeaceView.width/2, (FindYourPeaceView.height*0.4), Graphics.FONT_TINY, "Efficiency: "  + eff, Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(FindYourPeaceView.width/2, (FindYourPeaceView.height*0.5), Graphics.FONT_TINY, "Points: " + points, Graphics.TEXT_JUSTIFY_CENTER);

        dc.setColor(Graphics.COLOR_DK_BLUE, Graphics.COLOR_WHITE);
        dc.fillRectangle(0, FindYourPeaceView.height * 0.769, FindYourPeaceView.width, FindYourPeaceView.height * 0.769);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);

        dc.drawText(FindYourPeaceView.width/2, FindYourPeaceView.height * 0.808, Graphics.FONT_SMALL, "Exit", Graphics.TEXT_JUSTIFY_CENTER);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
    }

}