using Toybox.Communications as Comm;
using Toybox.WatchUi as Ui;
using Toybox.Application as App;


class MainDelegate extends Ui.BehaviorDelegate {
    var notify;
    var hueData;
    function ipAdressChanged() {
    	var ipAdress =  App.getApp().getProperty("ipAdress");
    	var forceNewSearch = App.getApp().getProperty("forceNewSearch");
    	return (forceNewSearch && Util.isValidIpAdress(ipAdress));
    }
    function initialize(handler) {
        Ui.BehaviorDelegate.initialize();
        hueData = new HueData();
        var ipAdress =  App.getApp().getProperty("ipAdress");
        
        
        hueData.lights = App.getApp().getProperty("lights");
        hueData.bridge = App.getApp().getProperty("bridge");
        if (hueData.bridge == null || hueData.bridge["ipAdress"] == null) {
            handler.invoke("no hueBridge\nconfigured");
        } else if (ipAdressChanged()) {
            var ipAdress =  App.getApp().getProperty("ipAdress");
            handler.invoke("hueBridgesIp\nchanged in settings\nto"+ipAdress+"\nPress Select to\nstart!");
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
    
    function handleSelectClick() {
      if (hueData.bridge == null || hueData.bridge["ipAdress"] == null || ipAdressChanged()) {
           createFinderView();
       } else {
           createNewView();
       }
       return true;
    }
     
    function onMenu() {
       return handleSelectClick();
    }

    function onSelect() {
		return handleSelectClick();       
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
    	//myHueDelegate.makeIpRequest();
    }
}