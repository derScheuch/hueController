using Toybox.Communications as Comm;
using Toybox.WatchUi as Ui;
using Toybox.Application as App;

class HueFinder extends Ui.BehaviorDelegate { 

var hueData;
var notify;
  function initialize(handler, hue) {
     Ui.BehaviorDelegate.initialize();
     hueData = hue;
     notify = handler;
  }
  
  function onSelect() {
    System.println(hueData);
    System.println(hueData.bridge);
    if (hueData.bridge == null) {
    	hueData.bridge = {};
    } 
    var ipAdress =  App.getApp().getProperty("ipAdress");
    if (Util.isValidIpAdress(ipAdress)) {
    	hueData.bridge.put("ipAdress", "http://"+ipAdress);
    	hueData.bridge.remove("userId");
    }
  	if (hueData.bridge.get("ipAdress") == null) {
  		HueJson.makeIpRequest(method(:onReceiveIp));
  		notify.invoke("retreiving IP");
  	} else  {
  		HueJson.checkUserNameRequest(hueData, method(:onReceiveUserName));
  		notify.invoke("trying to link\nwith bridge\n"+hueData.bridge["ipAdress"]+"\npress link button\non bridge");
  	} 
  }
  
  function onBack() {
     Ui.popView(Ui.SLIDE_IMMEDIATE);
   }
  
    function onReceiveIp(code, data) {
       System.println(code + " " + data+ " " +data[0]["internalipaddress"]);
       if (code == 200) {
          var bridge = {}; 
          bridge.put("ipAdress","http://"+data[0]["internalipaddress"]);
          bridge.put("id",data[0]["id"]);
          notify.invoke ("Found hueBridge at\n"+bridge["ipAdress"]+"\npress button on bridge\nto link the bridge\nthen press SELECT");
          hueData.bridge = bridge;
          
        } else {
          notify.invoke ("Error wwhile\ncommunicating...\ncode:"+code);
        }  
    }
    function onReceiveUserName(code, data) {
        System.println(code + " " + data);
    	if (code == 200) {
    	   if (null == data[0]["error"]) {
    	   		hueData.bridge.put("userId", data[0]["success"]["username"]);
    	   		System.println("username ----"+hueData.bridge.get("userId"));
    	   		notify.invoke("connection\nestablished");
    	   		App.getApp().setProperty("bridge", hueData.bridge);
    			App.getApp().setProperty("lights", hueData.lights);
    			App.getApp().setProperty("ipAadress", hueData.bridge["ipAdress"]);
    			App.getApp().setProperty("forceNewSearch", false);
    	   } else {
    	       notify.invoke(data[0]["error"]+ "\n"+ data[0]["error"]["description"]);
    	   }
    	} else {
    	    notify.invoke ("error while\ncommunicating\nwith bridgge\ncode:"+code);
    	}
    }
    
    
    
}
