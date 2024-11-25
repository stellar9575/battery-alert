import Toybox.Lang;
import Toybox.WatchUi;

class battery_alertDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new battery_alertMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}