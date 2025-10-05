import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class FindYourPeaceApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {

        Application.Storage.setValue("currentScreen", 1);
        Application.Storage.setValue("numberofscreens", 3); // number of total screens of app
        Application.Storage.setValue("menu", 0);
        Application.Storage.setValue("ActivityBreathing", 0);

        // inicializácia noveho pouzivatela
        if(Application.Storage.getValue("level") == null){
            Application.Storage.setValue("level", 1);
            Application.Storage.setValue("levelProgress", 0);
            Application.Storage.setValue("nextlevelneededpoints", 50);
            Application.Storage.setValue("hotstreak", 0); //pocet dni dychoveho cvicenia

        }
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [ new FindYourPeaceView(), new FindYourPeaceDelegate() ];
    }

}

function getApp() as FindYourPeaceApp {
    return Application.getApp() as FindYourPeaceApp;
}