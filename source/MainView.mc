using Toybox.WatchUi as Ui;
using Toybox.Application as App;

class MainView extends Ui.View {
    var mMessage = "";
    var hueData;
    function initialize(hueDa) {
    	hueData = hueDa;
        View.initialize();
    }

    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    function onShow() {
    }

    function onUpdate(dc) {
    	mMessage = "HueController v0.58\n"+checkSystem();
    	System.println("OnUpdate MainView");
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        dc.drawText(dc.getWidth()/2, dc.getHeight()/2, Graphics.FONT_MEDIUM, mMessage, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
      
    }

    function onHide() {
      // TODO alle requests canceln
    }
    
    function onReceive(data) {
   		   
        Ui.requestUpdate();
    }
    
      function checkSystem() {
        var ipAdress =  App.getApp().getProperty("ipAdress");
        hueData.lights = App.getApp().getProperty("lights");
        hueData.bridge = App.getApp().getProperty("bridge");
        if (hueData.bridge == null || hueData.bridge["ipAdress"] == null) {
             return "no hueBridge\nconfigured";
        } else if (Util.ipAdressChanged()) {
            var ipAdress =  App.getApp().getProperty("ipAdress");
            return "hueBridgesIp\nchanged in settings\nto"+ipAdress+"\nPress Select to\nstart!";
        } else {
            var m = "hueBridge configured\n";
            if (hueData.lights == null) {
                m+= "no";
            } else {
          	    m+= hueData.lights.keys().size();
            } 
            m += " lights stored\nfrom last session.";   
            return m;
        }
    }
  
}
