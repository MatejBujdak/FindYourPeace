import Toybox.Lang;
import Toybox.WatchUi;

class FindYourPeaceDelegate extends WatchUi.BehaviorDelegate {
    var _StartBreathing;

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new FindYourPeaceMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    function onKey(keyEvent) {
        var key = keyEvent.getKey();

        //ovladanie ked je pauznuta aktivitaBreathing
        if(Application.Storage.getValue("ActivityBreathing") == 2){
            _StartBreathing = Breathing._startBreathing;
            if(key == KEY_DOWN){
                _StartBreathing.choice = (_StartBreathing.choice + 1) % 2;
                return true;
            } else if(key == KEY_UP){
                _StartBreathing.choice = (_StartBreathing.choice + 1) % 2;
                return true;
            } else if(key == 4){

                if(_StartBreathing.choice == 1){
                    _StartBreathing.continueBreathing();
                  
                }else{
                    _StartBreathing.endBreathing();
                }   
                return true;
            }

        //moznost pauznut aktivitu ked je aktivna
        }else if(Application.Storage.getValue("ActivityBreathing") == 1){
            if(key == 4){
                Application.Storage.setValue("ActivityBreathing", 2);
                return true;
            }
        }   

        ////MEDITATION////////////////
        //ovladanie ked je pauznuta aktivitaBreathing
        if(Application.Storage.getValue("ActivityMeditation") == 2){
            _StartBreathing = Breathing._startBreathing;
            if(key == KEY_DOWN){
                _StartBreathing.choice = (_StartBreathing.choice + 1) % 2;
                return true;
            } else if(key == KEY_UP){
                _StartBreathing.choice = (_StartBreathing.choice + 1) % 2;
                return true;
            } else if(key == 4){

                if(_StartBreathing.choice == 1){
                    _StartBreathing.continueBreathing();
                  
                }else{
                    _StartBreathing.endBreathing();
                }   
                return true;
            }

        //moznost pauznut aktivitu ked je aktivna
        }else if(Application.Storage.getValue("ActivityMeditation") == 1){
            if(key == 4){
                Application.Storage.setValue("ActivityMeditation", 2);
                return true;
            }
        }   

        //zacanie aktivity breathing
        if(Application.Storage.getValue("currentScreen") == 2 && Application.Storage.getValue("ActivityBreathing") == 0){
            if(key == 4){
                System.println("Aktivita zacata");
                Application.Storage.setValue("ActivityBreathing", 1);
                return true;
            }
        }

        //prepinanie medzi hlavnymi view screenami
        if(Application.Storage.getValue("ActivityBreathing") == 0){  //podmienky kedy sa nema menit aktualna pozicia hlavnych screenov
            if(key == KEY_DOWN){
            checkScreen(Application.Storage.getValue("currentScreen") - 1);
            return true;
            }
            else if(key == KEY_UP){
                checkScreen(Application.Storage.getValue("currentScreen") + 1);
                return true;
            }
        }else if(Application.Storage.getValue("ActivityBreathing") == 1){
            if(key == 4){
                System.println("Aktivita zacata");
                Application.Storage.setValue("ActivityBreathing", 1);
            }
        }   

        
        return false;
    }

    //ovladanie dotykovim displejom - swipe
    function onSwipe(swipeEvent) {
        
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