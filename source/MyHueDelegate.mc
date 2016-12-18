using Toybox.Communications as Comm;
using Toybox.WatchUi as Ui;
using Toybox.Application as App;

class MyHueDelegate extends Ui.BehaviorDelegate {

   var hueData;
  
   var notify;
   
   var selectFromStageOneToTwo = false;
   
   function initialize(handler, data) {
        Ui.BehaviorDelegate.initialize();
        hueData = data;
        notify = handler;
        hueData.stage = 1;
        setLights();
        HueJson.makeLightsRequest(hueData,method(:onReceiveLights));
    }
   
    function onKey(evt) {
        if (evt.getKey() == Ui.KEY_ENTER) {
            return onSelect();
        } else if (evt.getKey() == Ui.KEY_DOWN) {
            return onNextPage();
        } else if (evt.getKey() == Ui.KEY_UP) {
            return onPreviousPage();
        } else if (evt.getKey() == Ui.KEY_ESC) {
          return onBack();
        }
        return false;
    }
  
    function onReceiveLights(responseCode, data) {
       hueData.lights = data;
       setLights();
    }
 
    function onSetLight(responseCode, data) {
    	if (responseCode == 200) {
    		for (var i = 0; i < data.size(); ++ i) {
    			var commandResult = data[i].get("success");
    			if (null!= commandResult) {
    				hueData.setCommandResult(commandResult);
    			} 
    		}
    		onBack();
    	}
    }   
    
    function onSelect() {
    	if (hueData.stage == 1) {
    	    hueData.stage +=1;
    	    hueData.lightMode = 2;
    	    repaint();
    	    selectFromStageOneToTwo = true;
    	} else if (hueData.stage == 2) {
    	    selectFromStageOneToTwo = false;
    		HueJson.setLight(hueData, method(:onSetLight));
    	}
    	return true;
    }
    
    function onPreviousPage() {
    	if (hueData.stage == 1) {
     	  if (hueData.selectedLight >0) {
    		   hueData.selectedLight -=1;
    		} else {
    	       hueData.selectedLight = hueData.lights.size() - 1;
    	    }
    		repaint();
    	}
    	else if (hueData.stage == 2 && hueData.lightMode >0) {
    	   hueData.lightMode -= 1;
    	   repaint();
    	}
    	return true;
    }
    
    function onNextPage() {
    	if (hueData.stage == 1) {
    	    if (hueData.selectedLight +1 < hueData.lights.size()) {
    		   hueData.selectedLight +=1;
    		} else {
    		   hueData.selectedLight = 0;
    		}
    		repaint();
    	}
    	if (hueData.stage == 2 && hueData.lightMode +1 < AppData.lightModes.size()) {
    		hueData.lightMode += 1;
    		repaint();
    	}
    	return true;
    }
    function onNextMode() {
    	return true;
    }
    function onPreviousMode() {
    	return true;
    }
    function onMenu() {
    	return true;
    }
    function onBack() {
    	if (hueData.stage == 2) {
    	   hueData.stage = 1;
    	   repaint();
    	   return true;
    	}
    	else if (hueData.stage == 1) {
    	   hueData.stage = 0;
    	   Ui.popView(Ui.SLIDE_IMMEDIATE);
    	   var keys = hueData.lights.keys();
    	   for (var i = 0; i < keys.size(); ++ i) {
    	       hueData.lights.get(keys[i]).put("storedSession", "yes");
    	   }
    	   App.getApp().setProperty("bridge", hueData.bridge);
    	   App.getApp().setProperty("lights", hueData.lights);
    	   return true;
    	}
    	return false;
    }

    function repaint() {
      notify.invoke(hueData);
    }
    
    function setLights() {
       if (hueData.selectedLight < 0){
       	  hueData.selectedLight = 0;
       }
       hueData.stage = 1;
       repaint();
    }
}