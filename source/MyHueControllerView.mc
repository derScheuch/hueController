using Toybox.WatchUi as Ui;

class MyHueControllerView extends Ui.View {
   var displayLines = {};
   var hueData;
    function initialize() {
        View.initialize();
    }

    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    function onShow() {
    }

    function onUpdateAllLights(dc) {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
    	dc.clear();
    	var width = dc.getWidth();
    	var height = dc.getHeight();
    	var widthHalf = width / 2;
    	if (hueData.lights == null || hueData.lights.isEmpty()) {
    	   return;
        }
    	var keys = hueData.lights.keys();
    	var y = 15;
    	for (var i = 0; i < keys.size(); ++ i) {
    	     
    		var lightData = hueData.lights[keys[i]];
          	var name = lightData["name"];
          	var reachable = lightData["state"]["reachable"];
          	var on = lightData["state"]["on"];
          	var storedSession = (null != lightData["storedSession"]);
          	var selected = (hueData.selectedLight == i);
          	var dim = dc.getTextDimensions(name, selected ? Graphics.FONT_SYSTEM_MEDIUM : Graphics.FONT_SYSTEM_TINY);
          	var dimx = dim[0];
          	var dimy = dim[1];
			dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
	       	dc.drawText(widthHalf-dimx/2-5, y, selected ? Graphics.FONT_SYSTEM_MEDIUM : Graphics.FONT_SYSTEM_TINY, name,Graphics.TEXT_JUSTIFY_LEFT);
           	var color;
           	if (storedSession) {
           	   color = Graphics.COLOR_LT_GRAY;
           	} else {
           		if (reachable) {
           			if (on) {
           				color = Graphics.COLOR_WHITE;
           			} else {
           				color = Graphics.COLOR_DK_GREEN;
           			}
           		} else {
           		   color = Graphics.COLOR_DK_RED;
           		}
           	}
           	dc.setColor(color, Graphics.COLOR_BLACK);
           	dc.fillCircle(widthHalf+ dimx/2+5, y +dimy/2, 8);
    	    y += dimy+4;
    	}
    }
    
    function onUpdateSingleLight(dc) {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        var y = 15;
   	    var width = dc.getWidth();
    	var height = dc.getHeight();
    	var widthHalf = width / 2;
    	
    
		var keys = AppData.lightModes.keys();
    	for (var i = 0; i < keys.size(); ++ i) {
    	    var d = AppData.lightModes[keys[i]];
    	    var name = d["name"];
    	    var selected = (i == hueData.lightMode);
    	    var dim = dc.getTextDimensions(name, selected ? Graphics.FONT_SYSTEM_MEDIUM : Graphics.FONT_SYSTEM_TINY);
          	var dimx = dim[0];
          	var dimy = dim[1];
    		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
	       	dc.drawText(widthHalf-dimx/2-5, y, selected ? Graphics.FONT_SYSTEM_MEDIUM : Graphics.FONT_SYSTEM_TINY, name,Graphics.TEXT_JUSTIFY_LEFT);
    		y += dimy +4;   
    	}
    }
    
    function onUpdate(dc) {
        if (hueData.stage == 1) {
           onUpdateAllLights(dc);
        } else {
          onUpdateSingleLight(dc);
         }   
    }

    function onHide() {
    	// aktuelles setup IP-Adresse, User, Lights speichern
        // TODO alle requests canceln
    }
 
    function onReceive(hueD) {
        hueData = hueD;
  		Ui.requestUpdate();
  	}	
 }