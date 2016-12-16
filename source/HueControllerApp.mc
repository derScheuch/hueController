using Toybox.Application as App;

class MyHueControllerApp extends App.AppBase {
    hidden var mView;  
    function initialize() {
        AppBase.initialize();
    }

    function onStart(state) {
    }
    function onStop(state) {
    }

    function getInitialView() {
    	mView = new MainView();
        return [mView, new MainDelegate(mView.method(:onReceive))];
     
    }
}

 