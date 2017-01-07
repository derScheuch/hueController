using Toybox.Application as App;

class MyHueControllerApp extends App.AppBase {
    hidden var mView;  
    function initialize() {
    //	App.getApp().setProperty("lights",null);
    //    App.getApp().setProperty("bridge",null);
        AppBase.initialize();
    }

    function onStart(state) {
    }
    function onStop(state) {
    }

    function getInitialView() {
    	var hueData = new HueData();
    	mView = new MainView(hueData);
        return [mView, new MainDelegate(mView.method(:onReceive), hueData)];
     
    }
}

 