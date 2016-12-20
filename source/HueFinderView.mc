using Toybox.WatchUi as Ui;
using Toybox.Application as App;


class HueFinderView extends Ui.View {
    var mMessage = "Attempting to\nlocate Bridge\nPress Select";
    
    function initialize() {
    	mMessage = "Attempting to\nlocate Bridge\n";
    	var ipAdress =  App.getApp().getProperty("ipAdress");
    	if(Util.isValidIpAdress(ipAdress)) {
    		mMessage += "trying "+ipAdress+"\n";
    	} else {
    		mMessage += "automatically\n";
    	}
    	mMessage +="Press Select";
        View.initialize();
    }

    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    function onShow() {
    }

    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        dc.drawText(dc.getWidth()/2, dc.getHeight()/2, Graphics.FONT_MEDIUM, mMessage, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }

    function onHide() {
      // TODO alle requests canceln
    }
    function onReceive(data) {
      mMessage = "HueController v0.20\n"+data;
      Ui.requestUpdate();
    }
 }
