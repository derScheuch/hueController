using Toybox.Communications as Comm;

module HueJson {
 
   function makeLightsRequest(hueData, receiver) {
      Comm.makeWebRequest(
         hueData.bridge["ipAdress"]+"/api/"+hueData.bridge["userId"] +"/lights/",
         {},
         AppData.getParams,
         receiver
       );
    }
    function setLight(hueData, receiver) {
      var params;
      var light = "" + (hueData.selectedLight + 1);
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
    function checkUserNameRequest(hueData, receiver) {
       Comm.makeWebRequest(
          hueData.bridge["ipAdress"]+"/api/",
        AppData.newUserParams,
        AppData.postParams,
        receiver);
    }
    
    function makeIpRequest(	receiver) {
       Comm.makeWebRequest(
       "https://www.meethue.com/api/nupnp",
       {},
       AppData.getParams,
       receiver
       );
    }
  
 }