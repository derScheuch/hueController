using Toybox.Communications as Comm;
using Toybox.WatchUi as Ui;
using Toybox.Application as App;


class MainDelegate extends Ui.BehaviorDelegate {
    var notify;
    var hueData;
    function initialize(handler) {
        Ui.BehaviorDelegate.initialize();
        hueData = new HueData();
    	hueData.lights = App.getApp().getProperty("lights");
        hueData.bridge = App.getApp().getProperty("bridge");
        if (hueData.bridge == null || hueData.bridge["ipAdress"] == null) {
            handler.invoke("no hueBridge\nconfigured"); 
        } else {
            var m = "hueBridge configured\n";
            if (hueData.lights == null) {
                m+= "no";
            } else {
          	    m+= hueData.lights.keys().size();
            } 
            m += " lights stored\nfrom last session.";   
            handler.invoke(m);
        }
        notify = handler;
    }
    
    // Handle menu button press
    function onMenu() {
       if (hueData.bridge == null || hueData.bridge["ipAdress"] == null) {
           createFinderView();
       } else {
           createNewView();
       }
    }

    function onSelect() {
       if (hueData.bridge == null || hueData.bridge["ipAdress"] == null) {
           createFinderView();
       } else {
           createNewView();
        }
        return true;
    }
    function  createNewView() {
        var myHueView = new MyHueControllerView();
        var myHueDelegate = new MyHueDelegate(myHueView.method(:onReceive), hueData);
        Ui.pushView(myHueView, myHueDelegate, Ui.SLIDE_IMMEDIATE);
    }
    function createFinderView() {
    	var myFinderView = new HueFinderView();
    	var myHueDelegate = new HueFinder(myFinderView.method(:onReceive), hueData);
    	Ui.pushView(myFinderView, myHueDelegate, Ui.SLIDE_IMMEDIATE);
    	myHueDelegate.makeIpRequest();
    }
}