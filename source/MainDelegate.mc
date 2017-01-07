using Toybox.Communications as Comm;
using Toybox.WatchUi as Ui;
using Toybox.Application as App;


class MainDelegate extends Ui.BehaviorDelegate {
    var notify;
    var hueData;
 
    
 
    function initialize(handler, hueDa) {
        Ui.BehaviorDelegate.initialize();
        hueData = hueDa;
        notify = handler;
    }
 
    
    function handleSelectClick() {
    	if (hueData.bridge == null || hueData.bridge["ipAdress"] == null || Util.ipAdressChanged()) {
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
    }
}