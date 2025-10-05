import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Attention;
import Toybox.System;
import Toybox.Sensor;
import Toybox.Graphics;

class StartMeditation {

    var _Resulting = new Resulting();
    var seconds = 0;

    var phase = 0;                 // 0 = nádych, 1 = výdych
    var phaseDurationMs = 5000;    // trvanie jednej fázy (5 s)
    var numberOfPhases = 0;        // počet ukončených fáz
    var startTime = 0;             // čas štartu v ms

    var pauze_now = 0;
    var pauze_total = 0;
    var pauze_start = false;
    var pauze_start_time = 0;

    var choice = 1;

    var stress;
    var avg_stres = 0;
    var last_sec = 0;
    var max_stress = 0;
    var stress_median = [];

    function initialize() {
        startTime = System.getTimer(); // uložíme aktuálny čas v ms
    }

    function draw(dc as Dc) {

        //vykreslenie vyslednej obrazovky po aktivite
        if( Application.Storage.getValue("ActivityMeditation") == 3){
            _Resulting.draw(dc);
            return;
        }

        stress = ActivityMonitor.getInfo().stressScore;
        if(seconds > last_sec){
            last_sec = seconds;
            if(stress > max_stress){
                max_stress = stress;
            }
            stress_median.add(stress);
            avg_stres += stress;
        }

        //aktivita pauznuta
        if(Application.Storage.getValue("ActivityMeditation") == 2){

            pauzeBreathing();
            var con_but_height = FindYourPeaceView.height * 0.4;
            var stop_but_height = FindYourPeaceView.height * 0.5;
            dc.setColor(Graphics.COLOR_DK_GREEN, Graphics.COLOR_WHITE);
            dc.fillRectangle(0, stop_but_height + 5 + (choice * (con_but_height - stop_but_height)), FindYourPeaceView.width, 25);
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            dc.drawText(FindYourPeaceView.width/2, stop_but_height, Graphics.FONT_TINY, "STOP", Graphics.TEXT_JUSTIFY_CENTER);
            dc.drawText(FindYourPeaceView.width/2, con_but_height, Graphics.FONT_TINY, "CONTINUE", Graphics.TEXT_JUSTIFY_CENTER);
            
            return; //skonci sa vykreslovanie
        }

        System.println("pauze total " + pauze_total);
        var now = System.getTimer();          // aktuálny čas v ms
        var totalTimeMs = now - startTime - pauze_total;    // koľko ms uplynulo od začiatku
        var phaseTimeMs = totalTimeMs - (phaseDurationMs * numberOfPhases);

        // ak fáza prešla, prepni
        if (phaseTimeMs >= phaseDurationMs) {
            numberOfPhases += 1;
            phase = (phase + 1) % 2;

            // krátka vibrácia pri každej zmene fázy
            if (Attention has :vibrate) {
                var vibe = [ new Attention.VibeProfile(60, 300) ];
                Attention.vibrate(vibe);
            }

            // reset fázy
            phaseTimeMs = 0;
        }

        // priebeh aktuálnej fázy (0..1)
        


        // rozmery
        var w = FindYourPeaceView.width;
        var h = FindYourPeaceView.height;
        var cx = w / 2;
        var cy = h / 2;
        var maxR = (w > h) ? (h / 2.0) : (w / 2.0);

        var t = (phaseTimeMs * maxR) / phaseDurationMs;

        // veľkosť kruhu podľa fázy
        var r = (phase == 0) ? t : maxR - t;

        // kreslenie
        dc.clear();
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_WHITE);
        dc.fillCircle(cx, cy, r);

        // text fázy
        var phaseText = (phase == 0) ? "Breath in" : "Breath out";
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(cx, cy, Graphics.FONT_MEDIUM, phaseText, Graphics.TEXT_JUSTIFY_CENTER);

        // celkový čas
        seconds = (totalTimeMs / 1000.0).toNumber();
        var timeStr = Lang.format("$1$:$2$", [pad2(((seconds % 3600) / 60).toNumber(), "m"), pad2((seconds % 60).toNumber(), "s")]);
        dc.drawText(cx, cy + 40, Graphics.FONT_XTINY, "Time: " + timeStr, Graphics.TEXT_JUSTIFY_CENTER);

        var HR = Activity.getActivityInfo().currentHeartRate;
        if(HR == null) {
            HR = 0;
        }
        if(stress == null){
            stress = 0;
        }

        dc.drawText(FindYourPeaceView.width * 0.2, FindYourPeaceView.height * 0.1, Graphics.FONT_TINY, "Stress: " + stress, Graphics.TEXT_JUSTIFY_LEFT);
        dc.drawText(FindYourPeaceView.width * 0.2, FindYourPeaceView.height * 0.2, Graphics.FONT_TINY, "HR: " + HR, Graphics.TEXT_JUSTIFY_LEFT);

    }   

    function pad2(n, k){
        if(k.equals("m")){
            return n;
        }
        return (n < 10 ? "0" + n : n);

    }

    function endBreathing(){  // vyhodnotenie + presunutie vysledkov a screen do result menu
        System.println("ended breathing");  

        _Resulting.resulting(seconds, avg_stres, max_stress, getMedian(stress_median));

        Application.Storage.setValue("ActivityMeditation", 3); //zrusenie aktivty breathing, vratenie do hlavneho menu
    }

    function continueBreathing(){
        pauze_total += pauze_now;
        pauze_start = false;
        pauze_now = 0;
        Application.Storage.setValue("ActivityMeditation", 1); //pokracovanie aktivita dychanie
    }

    function pauzeBreathing(){ //zastavit cas
        System.println("pauze breathing");  
        if(pauze_start == false){
            pauze_start = true;
            pauze_start_time = System.getTimer();
        }

        pauze_now = System.getTimer() - pauze_start_time;
    
    }

    function getMedian(values) {
        if (values == null || values.size() == 0) {
            return 0.0;
        }

        // 1️⃣ Skopíruj pole, aby sme nepísali do pôvodného
        var arr = [];
        for (var i = 0; i < values.size(); i += 1) {
            arr.add(values[i]);
        }
        var n = arr.size();

        // 2️⃣ Jednoduchý bubble sort (vzostupne)
        for (var i = 0; i < n - 1; i += 1) {
            for (var j = 0; j < n - i - 1; j += 1) {
                if (arr[j] > arr[j + 1]) {
                    var temp = arr[j];
                    arr[j] = arr[j + 1];
                    arr[j + 1] = temp;
                }
            }
        }

        // 3️⃣ Výpočet mediánu
        if (n % 2 == 1) {
            // Nepárny počet prvkov → stredný
            return arr[n / 2];
        } else {
            // Párny počet → priemer dvoch stredných
            var mid1 = arr[n / 2 - 1];
            var mid2 = arr[n / 2];
            return (mid1 + mid2) / 2.0;
        }
    }



}
