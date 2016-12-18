using Toybox.Communications as Comm;
using Toybox.WatchUi as Ui;

module AppData {
   var putParams = {
  		:method => Comm.HTTP_REQUEST_METHOD_PUT,
        :headers=> {"Content-Type" => Comm.REQUEST_CONTENT_TYPE_JSON},
        :responseType => Comm.HTTP_RESPONSE_CONTENT_TYPE_JSON
    };
    
   var getParams = {
   	:method => Comm.HTTP_REQUEST_METHOD_GET,
        :headers=> {"Content-Type" => Comm.REQUEST_CONTENT_TYPE_JSON},
        :responseType => Comm.HTTP_RESPONSE_CONTENT_TYPE_JSON
   };
   
    var postParams = {
   	:method => Comm.HTTP_REQUEST_METHOD_POST,
        :headers=> {"Content-Type" => Comm.REQUEST_CONTENT_TYPE_JSON},
        :responseType => Comm.HTTP_RESPONSE_CONTENT_TYPE_JSON
   };
   
   var newUserParams = {"devicetype" => "myHueController#garmin"}; 
   
   var lightModes = {
      "night"=>{
        "name" => Ui.loadResource(Rez.Strings.night),
        "params" => {"on"=> true, "bri"=> 1},
        "reachable" => true, 
        "color" => false}
        ,
       "dimm"=>{
        "name"=>Ui.loadResource( Rez.Strings.dimm ),
        "params" => {"on"=> true, "bri"=> 50},
        "reachable" => true, 
        "color" => false}
        ,        
       "bright" => {
        "name"=> Ui.loadResource( Rez.Strings.bright ) ,
        "params" => {"on"=> true, "bri"=> 150},
        "reachable" => true, 
        "color" => false}
        ,
       "full" => {
        "name" => Ui.loadResource( Rez.Strings.full ),
        "params" => {"on"=> true, "bri"=> 254},
        "reachable" => true, 
        "color" => false}
        ,
       "off" => {
        "name"=> Ui.loadResource( Rez.Strings.off ),
        "params" => {"on"=> false},
        "reachable" => true, 
        "color" => false} 
        ,
       "cloop" => {
        "name" => Ui.loadResource( Rez.Strings.cloop),
        "params" => {"effect" => "colorloop"},
        "toggle" => {"effect" => "none"},
        "reachable" => true, 
        "color" => true}
       };      
}