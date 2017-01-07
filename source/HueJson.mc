using Toybox.Communications as Comm;
using Toybox.WatchUi as Ui;
using Toybox.Application as App;
class HueJson {
 
   static function makeLightsRequest(hueData, receiver) {
      Comm.makeWebRequest(
         hueData.bridge["ipAdress"]+"/api/"+hueData.bridge["userId"] +"/lights/",
         {},
         AppData.getParams,
         receiver
       );
    }
    static function setLight(hueData, receiver) {
      var params;
      //var light = "" + (hueData.selectedLight + 1);
      //System.println("hueData.selectedLight");
      var light = hueData.lights.keys()[hueData.selectedLight];
      var lightMode = AppData.lightModes.keys()[hueData.lightMode];
      if (lightMode.equals("cloop") && "colorloop".equals(hueData.lights[light]["state"]["effect"])) {
        params = AppData.lightModes[lightMode]["toggle"];
      } else {
        params =  AppData.lightModes[lightMode]["params"];
      }
      Comm.makeWebRequest(	
        hueData.bridge["ipAdress"]+"/api/"+hueData.bridge["userId"]+"/lights/"+light+"/state",
        params,
        AppData.putParams,
        receiver);
    }
    static function checkUserNameRequest(hueData, receiver) {
       Comm.makeWebRequest(
          hueData.bridge["ipAdress"]+"/api/",
        AppData.newUserParams,
        AppData.postParams,
        receiver);
    }
    
    static function makeIpRequest(	receiver) {
       Comm.makeWebRequest(
       "https://www.meethue.com/api/nupnp",
       {},
       AppData.getParams,
       receiver
       );
    }
  
 }