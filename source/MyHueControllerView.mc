using Toybox.WatchUi as Ui;


// origin programming for FenixDisplay#
// Fenix			x	geht				rund
// Fenix HR			x	geht				rund
// fenix Chronos 		geht nicht			rund	Absturz Fehler in json=????
// Forerunner 630 		geht 	 	Touch	rund	adjust Diemsnions (bisschenkleiner)
// Forerunner 235 		geht				rund	Adjust Dimesnions					
// Forerunner 735xt 	geht				rund	adjust dimensions
// Forerunner 230 		geht				rund	adjust dimensions
// Forerunner 920xt 	geht				quadr 	quadratisch
// vivoactive, 			geht nicht					Absturz, Fehler in json ...auﬂerdem quadratisch
// vivoactive HR        geht nicht					ABSTURZ; fEHLER IM JSON:::auﬂerdem quadratisch, TOUCH??
// D2 Bravo			x 	geht				rund
// Titanium 		x	geht				rund
// EDGE	1000			geht 		Touch	groﬂ	adjus Dimesnions
// EDGE 520				geht				groﬂ, 	adjust Dimension
// EDGE 820				geht 		Touch	groﬂ 	adjust Dimensions
// Oregon 7				geht		touch	groﬂ	adjust Dimension
// RINO 7				geht		touch	groﬂ	adjust Dimension
//
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
    	System.println(hueData.lights);
    	if (hueData.lights == null || hueData.lights.size() == 0) {
    	   return;
        }
    	var keys = hueData.lights.keys();
    	
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
   		dc.drawLine(DC_LINE_SPACE,Y_BOTTOM_LINE, DC_WIDTH-DC_LINE_SPACE, Y_BOTTOM_LINE);
   		drawLightArc(dc);		
    }
    
    var X_TEXT_START;
    var Y_TEXT_2;
    var Y_TEXT_1;
    var Y_TEXT_3;
    var Y_TEXT_4;
    var Y_TEXT_5;
    var Y_TEXT_6;
    var Y_BOTTOM_LINE;
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
    	System.println(DC_HEIGHT + " " + DC_WIDTH);
    	X_TEXT_START =  Ui.loadResource(Rez.Strings.x_text_start).toNumber();
    	Y_TEXT_1 = Ui.loadResource(Rez.Strings.y_text_1).toNumber();
    	Y_TEXT_2 = Ui.loadResource(Rez.Strings.y_text_2).toNumber() ; 
    	Y_TEXT_3 = Ui.loadResource(Rez.Strings.y_text_3).toNumber() ;
    	Y_TEXT_4 = Ui.loadResource(Rez.Strings.y_text_4).toNumber() ;
    	Y_TEXT_5 = Ui.loadResource(Rez.Strings.y_text_5).toNumber() ;
    	Y_TEXT_6 = Ui.loadResource(Rez.Strings.y_text_6).toNumber() ;
    	DC_MIN_RAD = DC_WIDTH > DC_HEIGHT ? DC_HEIGHT/2 : DC_WIDTH/2;
    	DC_WIDTH_HALF = DC_WIDTH/2;
    	DC_HEIGHT_HALF = DC_HEIGHT/2;
    	DC_LINE_DELTA =  Ui.loadResource(Rez.Strings.dc_line_delta).toNumber(); //20;
    	DC_LINE_SPACE = 24;
    	Y_BOTTOM_LINE = Ui.loadResource(Rez.Strings.y_bottom_line).toNumber(); 
    }
    	
    
    function getCurrentLightData() {
    	var light = hueData.lights.keys()[hueData.selectedLight];
    	return hueData.lights[light];
    }
    
 	function drawLightArc(dc) {
    	var lightData = getCurrentLightData();
    	var brightness = lightData["state"]["bri"];
    	var reachable = lightData["state"]["reachable"];
        var on = lightData["state"]["on"];
        
    	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
    	
    	dc.drawArc(DC_WIDTH_HALF, DC_HEIGHT_HALF , 
    		DC_MIN_RAD-5,
    		dc.ARC_CLOCKWISE,
    		225,
    		315); 
    	
    	dc.setPenWidth(9);
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
   		var light = hueData.lights.keys()[hueData.selectedLight];
   		dc.drawText(DC_WIDTH_HALF, Y_TEXT_6, Graphics.FONT_SYSTEM_TINY, hueData.lights[light]["name"],Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
   		dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_BLACK);
   		dc.drawLine(DC_LINE_SPACE,Y_BOTTOM_LINE, DC_WIDTH-DC_LINE_SPACE, Y_BOTTOM_LINE);
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