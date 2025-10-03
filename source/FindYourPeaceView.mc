import Toybox.Graphics;
import Toybox.WatchUi;

class FindYourPeaceView extends WatchUi.View {

    var screen;
    static var width;
    static var height;
    var _level;
    var _breathing;

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
        
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        dc.clear();
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        screen = Application.Storage.getValue("currentScreen");

        if (screen == 1) {
            _level.draw(dc);
        } else if(screen == 2) {
            _breathing.draw(dc);
        }

        WatchUi.requestUpdate();
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}
