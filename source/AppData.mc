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
        "name" => "Night",
        "params" => {"on"=> true, "bri"=> 1},
        "reachable" => true, 
        "color" => false}
        ,
       "dimm"=>{
        "name"=>"Dimm",
        "params" => {"on"=> true, "bri"=> 50},
        "reachable" => true, 
        "color" => false}
        ,        
       "bright" => {
        "name"=>"Bright",
        "params" => {"on"=> true, "bri"=> 150},
        "reachable" => true, 
        "color" => false}
        ,
       "full" => {
        "name" => "Full",
        "params" => {"on"=> true, "bri"=> 254},
        "reachable" => true, 
        "color" => false}
        ,
       "off" => {
        "name"=> "off",
        "params" => {"on"=> false},
        "reachable" => true, 
        "color" => false} 
        ,
       "cloop" => {
        "name" => "ColorLoop",
        "params" => {"effect" => "colorloop"},
        "toggle" => {"effect" => "none"},
        "reachable" => true, 
        "color" => true}
       };      
}