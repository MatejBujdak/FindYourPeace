import Toybox.WatchUi;
import Toybox.Graphics;

class Meditation {

    static var _startMeditation;

    function draw(dc as Dc) {
 
        if(Application.Storage.getValue("ActivityMeditation") == 0){  //vyprazdni instanciu na aktivitu breathing (reset casovacu, premennych)
            _startMeditation = null;
        }

        //zacatie aktivity breathing
        if (_startMeditation == null && Application.Storage.getValue("ActivityMeditation") != 0) {
            _startMeditation = new StartBreathing();
        }

        //aktivita breathing zacata
        if (_startMeditation != null && Application.Storage.getValue("ActivityMeditation") != 0) {
            dc.clear();
            _startMeditation.draw(dc);
            return;
        }

        dc.drawText(FindYourPeaceView.width/2, FindYourPeaceView.height/2,Graphics.FONT_SMALL, "Meditation", Graphics.TEXT_JUSTIFY_CENTER);

        dc.setColor(Graphics.COLOR_DK_BLUE, Graphics.COLOR_WHITE);
        dc.fillRectangle(0, FindYourPeaceView.height * 0.769, FindYourPeaceView.width, FindYourPeaceView.height * 0.769);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);

        dc.drawText(FindYourPeaceView.width/2, FindYourPeaceView.height * 0.808, Graphics.FONT_SMALL, "Start", Graphics.TEXT_JUSTIFY_CENTER);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
    }

}