import Toybox.Lang;
import Toybox.WatchUi;

class FindYourPeaceDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new FindYourPeaceMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    function onKey(keyEvent) {
        var key = keyEvent.getKey();
        if(Application.Storage.getValue("currentScreen") == 2){
            if(key == 4){
                System.println("Aktivita zacata");
                Application.Storage.setValue("Activity", 1);
            }
        }

        if(key == KEY_DOWN){
            checkScreen(Application.Storage.getValue("currentScreen") - 1);
            return true;
        }
        else if(key == KEY_UP){
            checkScreen(Application.Storage.getValue("currentScreen") + 1);
            return true;
        }
        return false;
    }

    function onSwipe(swipeEvent) {
        
        var direction = swipeEvent.getDirection();
        if(direction == WatchUi.SWIPE_DOWN){
            checkScreen(Application.Storage.getValue("currentScreen") - 1);
            return true;
        }
        else if(direction == WatchUi.SWIPE_UP){
            checkScreen(Application.Storage.getValue("currentScreen") + 1);
            return true;
        }
        return false;
    }

    
    function checkScreen(current){
        if(current < 1){
            current = Application.Storage.getValue("numberofscreens");
        }else if (current > Application.Storage.getValue("numberofscreens")){
            current = 1;
        }
        Application.Storage.setValue("currentScreen", current);
    }

}