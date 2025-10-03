import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Attention;
import Toybox.System;

class StartBreathing {

    var phase = 0;                 // 0 = nádych, 1 = výdych
    var phaseDurationMs = 5000;    // trvanie jednej fázy (5 s)
    var numberOfPhases = 0;        // počet ukončených fáz
    var startTime = 0;             // čas štartu v ms

    function initialize() {
        startTime = System.getTimer(); // uložíme aktuálny čas v ms
    }

    function draw(dc as Dc) {
        var now = System.getTimer();          // aktuálny čas v ms
        var totalTimeMs = now - startTime;    // koľko ms uplynulo od začiatku
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
        var phaseText = (phase == 0) ? "Nádych" : "Výdych";
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(cx, cy, Graphics.FONT_MEDIUM, phaseText, Graphics.TEXT_JUSTIFY_CENTER);

        // celkový čas
        var seconds = (totalTimeMs / 1000.0).toNumber();
        var timeStr = "Čas: " + seconds.format("%d") + " s";
        dc.drawText(cx, cy + 40, Graphics.FONT_XTINY, timeStr, Graphics.TEXT_JUSTIFY_CENTER);
    }
}
