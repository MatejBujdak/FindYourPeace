import Toybox.WatchUi;
import Toybox.Graphics;

class Breathing {

    var _startBreathing;

    function draw(dc as Dc) {

        if (_startBreathing == null && Application.Storage.getValue("Activity") == 1) {
            _startBreathing = new StartBreathing();
        }

        if (_startBreathing != null && Application.Storage.getValue("Activity") == 1) {
            dc.clear();
            _startBreathing.draw(dc);
            return;
        }

        dc.drawText(FindYourPeaceView.width/2, FindYourPeaceView.height/2, Graphics.FONT_SMALL, "Resonant breathing", Graphics.TEXT_JUSTIFY_CENTER);

        dc.setColor(Graphics.COLOR_DK_BLUE, Graphics.COLOR_WHITE);
        dc.fillRectangle(0, FindYourPeaceView.height * 0.769, FindYourPeaceView.width, FindYourPeaceView.height * 0.769);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);

        dc.drawText(FindYourPeaceView.width/2, FindYourPeaceView.height * 0.808, Graphics.FONT_SMALL, "START", Graphics.TEXT_JUSTIFY_CENTER);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
    }

}