import Toybox.WatchUi;
import Toybox.Graphics;

class LevelScreen {

     function draw(dc as Dc) {
        var level = Application.Storage.getValue("level");
        var progress = Application.Storage.getValue("levelProgress");
        var needed = Application.Storage.getValue("nextlevelneededpoints");
        var hotstreak = Application.Storage.getValue("hotstreak");

        var width  = dc.getWidth();
        var height  = dc.getHeight();
        var minimalWatches = 219;

        var barW = width * 0.462;
        var barH = height * 0.058;
        //var bmp  = WatchUi.loadResource(Rez.Drawables.id_logo);

        // if(width > 320){
        //     bmp  = WatchUi.loadResource(Rez.Drawables.id_logo_v2);
        //     dc.drawBitmap(width/2-37.5, height * 0.058, bmp); 
        // }else if(width > minimalWatches){
        //     dc.drawBitmap(width/2-25, height * 0.058, bmp); 
        // }

        // bmp = WatchUi.loadResource(Rez.Drawables.id_hotstreak);

        // if(width > 320){
        //     bmp = WatchUi.loadResource(Rez.Drawables.id_hotstreak_v2);
        //     dc.drawBitmap(width * 0.115, height * 0.596, bmp);
        // }else{
        //     dc.drawBitmap(width * 0.115, height * 0.596, bmp);
        // }

 
        if(width > (minimalWatches-30)){
            dc.drawText(width/2, height * 0.231, Graphics.FONT_SMALL, "Level: " + level, Graphics.TEXT_JUSTIFY_CENTER);
            drawLevelBar(dc, (width - barW)/2, height * 0.346, barW, barH, progress, needed);
        }else{
            dc.drawText(10, height * 0.131, Graphics.FONT_SMALL, "Level: " + level, Graphics.TEXT_JUSTIFY_LEFT); //0.231
            drawLevelBar(dc,  10, height * 0.246 + 5, barW, barH, progress, needed);        //0.346
        }

        dc.drawText(width/2, height * 0.423, Graphics.FONT_SMALL, "Progress: " + progress + "/" + needed, Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(width * 0.231, height * 0.577, Graphics.FONT_SMALL, "Hotstreak: " + hotstreak, Graphics.TEXT_JUSTIFY_LEFT);

    }


    function drawLevelBar(dc, middle_x, y, barW, barH, progress, needed) {
        var percentual_needed = progress * 1.0 / needed;
        if (percentual_needed > 1) { percentual_needed = 1; }

        // edge bar (white bar)
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawRectangle(middle_x, y, barW, barH);

        barW -= 4;
        // red bar presenting remaining enemy hp
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
        dc.fillRectangle(middle_x+2, y+2, barW * percentual_needed, barH-4);

        // reset color 
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
    }
}

