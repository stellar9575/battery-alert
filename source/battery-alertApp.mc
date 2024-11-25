import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Background;
import Toybox.Time;
import Toybox.Attention;

// Because this is referenced in the application object
// constructor, it must be marked as background.
(:background)
var globalMember;

// Your application object has to be marked as background
// so that the service delegate can be referenced
(:background)
class battery_alertApp extends Application.AppBase {

    // Constructor. Remember everything referenced in this function
    // must be marked as background
    public function initialize() {
        AppBase.initialize();
        // Register to run every five seconds
        if(Background.getTemporalEventRegisteredTime() != null) {
            Background.registerForTemporalEvent(new Time.Duration(5));
        }
        // Initialize a global member
        $.globalMember = true;
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [ new battery_alertView(), new battery_alertDelegate() ];
    }

}

function getApp() as battery_alertApp {
    return Application.getApp() as battery_alertApp;
}

// Your service delegate has to be marked as background
// so it can handle your service callbacks
(:background)
class MyServiceDelegate extends System.ServiceDelegate {

    public function initialize() {
        ServiceDelegate.initialize();
    }

    public function onTemporalEvent() as Void {
        var myStats = System.getSystemStats();
        System.println(myStats.battery);
        if (myStats.battery <= 30 && !myStats.charging){
            if (Attention has :vibrate) {
                var vibeData =
                [
                    new Attention.VibeProfile(50, 2000), // On for two seconds
                    new Attention.VibeProfile(0, 2000),  // Off for two seconds
                    new Attention.VibeProfile(50, 2000), // On for two seconds
                    new Attention.VibeProfile(0, 2000),  // Off for two seconds
                    new Attention.VibeProfile(50, 2000)  // on for two seconds
                ];
                // Attention.vibrate(vibeData);
            }
        }
    }

}
