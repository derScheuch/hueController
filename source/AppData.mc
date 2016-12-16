using Toybox.Communications as Comm;
using Toybox.WatchUi as Ui;

class AppData {
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
   
   var newUserParams = {"devicetype" => "myHueController#garmin"}; // TODO Username of watch into user 
   
   var lightModes = {
      "night"=>{
        "name" => "Night",
        "params" => {"on"=> true, "bri"=> 1}}
        
        ,
       "dimm"=>{
        "name"=>"Dimm",
        "params" => {"on"=> true, "bri"=> 50}}
        
        ,        
       "bright" => {
        "name"=>"Bright",
        "params" => {"on"=> true, "bri"=> 150}}
        ,
       "full" => {
        "name" => "Full",
        "params" => {"on"=> true, "bri"=> 254}}
        ,
       "off" => {
        "name"=> "off",
        "params" => {"on"=> false}} 
        ,
       "cloop" => {
        "name" => "ColorLoop",
        "params" => {"effect" => "colorloop"},
        "toggle" => {"effect" => "none"}}
       };      
}