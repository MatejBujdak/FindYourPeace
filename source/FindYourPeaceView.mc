import Toybox.Graphics;
import Toybox.WatchUi;

class FindYourPeaceView extends WatchUi.View {

    var screen;  //current screen to view
    static var width;
    static var height;
    static var foregroundColor = Graphics.COLOR_WHITE;
    static var backgroundColor =  Graphics.COLOR_BLACK;
    var _level;
    var _breathing; 
    var _meditation; 
    var _others;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        //setLayout(Rez.Layouts.MainLayout(dc));
        width = dc.getWidth();
        height = dc.getHeight();
        _level = new LevelScreen();
        _breathing = new Breathing();
        _meditation = new Meditation();
        _others = new Others();
        
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        dc.setColor(foregroundColor, backgroundColor);
        dc.clear();
        
        screen = Application.Storage.getValue("currentScreen");

        if (screen == 1) {
            _level.draw(dc);
        } else if(screen == 2) {
            _breathing.draw(dc);
        }else if(screen == 3) {
            _meditation.draw(dc);
        }else if(screen == 4) {
            _others.draw(dc);
        }
        
        

        WatchUi.requestUpdate();
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}
