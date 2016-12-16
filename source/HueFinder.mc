using Toybox.Communications as Comm;
using Toybox.WatchUi as Ui;
using Toybox.Application as App;

class HueFinder extends Ui.BehaviorDelegate { 
var appData = new AppData();
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
  	if (hueData.bridge.get("ipAdress") == null) {
  		makeIpRequest();
  		notify.invoke("retreiving IP");
  	} else if (hueData.bridge["userId"] == null) {
  		checkUserNameRequest();
  		notify.invoke("trying to link\nwith bridge\npress link button\non bridge");
  	} 
  }
  
  function onBack() {
     Ui.popView(Ui.SLIDE_IMMEDIATE);
   }
  
  function makeIpRequest() {
     Comm.makeWebRequest(
       "https://www.meethue.com/api/nupnp",
       {},
       appData.getParams,
       method(:onReceiveIp)
       );
    }
    
    function onReceiveIp(code, data) {
    System.println(code + " " + data+ " " +data[0]["internalipaddress"]);
       if (code == 200) {
          var bridge = {}; 
          bridge.put("ipAdress","http://"+data[0]["internalipaddress"]);
          bridge.put("id",data[0]["id"]);
          //bridge = {"ipAdress" => data.get("internalipaddress"), "id" => data.get("id")};
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
    	   } else {
    	       notify.invoke(data[0]["error"]+ "\n"+ data[0]["error"]["description"]);
    	   }
    	} else {
    	  notify.invoke ("error while\ncommunicating\nwith bridgge\ncode:"+code);
    	}
    }
    
    
    function checkUserNameRequest() {
       Comm.makeWebRequest(
          hueData.bridge["ipAdress"]+"/api/",
        appData.newUserParams,
        appData.postParams,
        method(:onReceiveUserName));
    }
}
