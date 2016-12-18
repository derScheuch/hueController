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


	function drawUnSelectedLight(dc, lightData,x, y) {
		System.println(lightData);
		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
		var name = lightData["name"];
        var reachable = lightData["state"]["reachable"];
        var on = lightData["state"]["on"];
        var storedSession = (null != lightData["storedSession"]);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
	    dc.drawText(x, y, Graphics.FONT_SYSTEM_TINY, name,Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
	    drawLightCircle(dc,lightData, x-14,y,6);	    
 	}
	
	function drawLightCircle(dc,lightData,x,y, size) {
	   	var reachable = lightData["state"]["reachable"];
        var on = lightData["state"]["on"];
        var storedSession = (null != lightData["storedSession"]);
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
        dc.fillCircle(x, y, size);
	}
	
    function drawSelectedLight(dc, lightData,x, y) {
     	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
		var name = lightData["name"];
		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
	    dc.drawText(x, y, Graphics.FONT_SYSTEM_MEDIUM, name,Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
	    dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_BLACK);
	    dc.drawLine(DC_LINE_SPACE, y-DC_LINE_DELTA, DC_WIDTH-DC_LINE_SPACE, y-DC_LINE_DELTA);
	    dc.drawLine(DC_LINE_SPACE, y+DC_LINE_DELTA, DC_WIDTH-DC_LINE_SPACE, y +DC_LINE_DELTA);
		drawLightCircle(dc,lightData, x-12,y,8);	    
    }
	
    function onUpdateLightsList(dc) {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
    	dc.clear();
    	if (hueData.lights == null || hueData.lights.isEmpty()) {
    	   return;
        }
    	var keys = hueData.lights.keys();
    	var y = 15;
    	
    	var startIndex = hueData.selectedLight - 2;
    	var endIndex = hueData.selectedLight +2;
    	if (startIndex < 0) {
    	   startIndex += hueData.lights.size();
    	} 
    	if (endIndex > hueData.lights.size() -1) {
    		endIndex -= hueData.lights.size();
    	}
    	var i = startIndex;
    	if (keys.size() > 3){drawUnSelectedLight(dc,hueData.lights[keys[startIndex]], X_TEXT_START, Y_TEXT_1);}
    	if (keys.size() > 1){drawUnSelectedLight(dc,hueData.lights[keys[(startIndex+1)%keys.size()]], X_TEXT_START, Y_TEXT_2);}	
    	drawSelectedLight  (dc, hueData.lights[keys[hueData.selectedLight]], X_TEXT_START, Y_TEXT_3);
   		if (keys.size() > 2){drawUnSelectedLight(dc,hueData.lights[keys[(startIndex+3)%keys.size()]], X_TEXT_START, Y_TEXT_4);}
   		if (keys.size() > 4){drawUnSelectedLight(dc,hueData.lights[keys[(startIndex+4)%keys.size()]], X_TEXT_START, Y_TEXT_5);}
   		dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_BLACK);
   		dc.drawLine(DC_LINE_SPACE,181, DC_WIDTH-DC_LINE_SPACE, 181);
   		drawLightArc(dc);		
    }
    
    var X_TEXT_START;
    var Y_TEXT_2;
    var Y_TEXT_1;
    var Y_TEXT_3;
    var Y_TEXT_4;
    var Y_TEXT_5;
    var DC_WIDTH;
    var DC_HEIGHT;
    var dc_initialized = false;
    var DC_MIN_RAD;
    var DC_WIDTH_HALF;
    var DC_HEIGHT_HALF;
    var DC_LINE_DELTA;
    var DC_LINE_SPACE;
    function initialieDcParams(dc) {
    dc_initialized = true;
    	DC_WIDTH = dc.getWidth();
    	DC_HEIGHT = dc.getHeight();
    	X_TEXT_START = DC_WIDTH / 4;
    	Y_TEXT_1 = 50;
    	Y_TEXT_2 = 74;
    	Y_TEXT_3 = DC_WIDTH / 2;
    	Y_TEXT_4 = 142;
    	Y_TEXT_5 = 166;
    	DC_MIN_RAD = DC_WIDTH > DC_HEIGHT ? DC_HEIGHT/2 : DC_WIDTH/2;
    	DC_WIDTH_HALF = DC_WIDTH/2;
    	DC_HEIGHT_HALF = DC_HEIGHT/2;
    	DC_LINE_DELTA = 20;
    	DC_LINE_SPACE = 24;
    }
    	
    
    function getCurrentLightData() {
    	return hueData.lights["" + (hueData.selectedLight + 1)];
    }
    
 	function drawLightArc(dc) {
    	var lightData = getCurrentLightData();
    	var brightness = lightData["state"]["bri"];
    	var reachable = lightData["state"]["reachable"];
        var on = lightData["state"]["on"];
        
    	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
    	
    	dc.drawArc(DC_WIDTH_HALF, DC_HEIGHT_HALF , 
    		DC_MIN_RAD-4,
    		dc.ARC_CLOCKWISE,
    		225,
    		315); 
    	
    	dc.setPenWidth(5);
    	if (reachable && on) {
    	   dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_BLACK);
    	} else {
    	   dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_BLACK);
    	}
    	dc.drawArc(DC_WIDTH_HALF,DC_HEIGHT_HALF , 
    		DC_MIN_RAD,
    		dc.ARC_CLOCKWISE,
    		225,
    		brightness +15 > 225 ? 360 + (225-(brightness+15)) :225 - (brightness+15)); 
    	dc.setPenWidth(1);
    }
    
    function onUpdateSingleLight(dc) {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        var startIndex = hueData.lightMode - 2;
    	var endIndex = hueData.lightMode +2;
    	if (startIndex < 0) {
    	   startIndex += AppData.lightModes.size();
    	} 
    	if (endIndex >AppData.lightModes.size() -1) {
    		endIndex -= AppData.lightModes.size();
    	}
    	var keys = AppData.lightModes.keys();
        drawUnSelectedLightMode(dc,AppData.lightModes[keys[startIndex]], X_TEXT_START, Y_TEXT_1);
    	drawUnSelectedLightMode(dc,AppData.lightModes[keys[(startIndex+1)%keys.size()]], X_TEXT_START, Y_TEXT_2);	
    	drawSelectedLightMode  (dc,AppData.lightModes[keys[hueData.lightMode]], X_TEXT_START, Y_TEXT_3);
   		drawUnSelectedLightMode(dc,AppData.lightModes[keys[(startIndex+3)%keys.size()]], X_TEXT_START, Y_TEXT_4);
   		drawUnSelectedLightMode(dc,AppData.lightModes[keys[(startIndex+4)%keys.size()]], X_TEXT_START, Y_TEXT_5);
   		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
   		dc.drawText(DC_WIDTH_HALF, 192,	Graphics.FONT_SYSTEM_TINY, hueData.lights[""+(hueData.selectedLight+1)]["name"],Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
   		dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_BLACK);
   		dc.drawLine(DC_LINE_SPACE,181, DC_WIDTH-DC_LINE_SPACE, 181);
   		drawLightArc(dc);		
    }
    function drawUnSelectedLightMode(dc, lightMode, x, y) {
        var lightData = getCurrentLightData();
        if (isValidLightModeForLight(lightData, lightMode)) {
        	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        } else {
        	dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_BLACK);
        }
    	dc.drawText(x,y, Graphics.FONT_SYSTEM_TINY,lightMode["name"], Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
    }     
    function drawSelectedLightMode(dc,lightMode,x,y) {
    	var lightData = getCurrentLightData();
        if (isValidLightModeForLight(lightData, lightMode)) {
        	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        } else {
        	dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_BLACK);
        }
        dc.drawText(x, y, Graphics.FONT_SYSTEM_MEDIUM, lightMode["name"],Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_BLACK);
	    dc.drawLine(DC_LINE_SPACE, y-DC_LINE_DELTA, DC_WIDTH-DC_LINE_SPACE, y-DC_LINE_DELTA);
	    dc.drawLine(DC_LINE_SPACE, y+DC_LINE_DELTA, DC_WIDTH-DC_LINE_SPACE, y +DC_LINE_DELTA);
    }
    function isValidLightModeForLight(lightData, lightMode) {
    	var reachable = lightData["state"]["reachable"];
    	if (!reachable) {
    	   return false;
    	}
    	if (lightMode["color"]) {
    	   return (lightData["type"].find("color") != null);
    	} 
    	return true;  
    }
        
        
    
    function onUpdate(dc) {
    	if (!dc_initialized) {
    		initialieDcParams(dc);
    	}
        if (hueData.stage == 1) {
           onUpdateLightsList(dc);
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