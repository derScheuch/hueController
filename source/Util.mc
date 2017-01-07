using Toybox.Application as App;

class Util {

static function splitString(string, delim) {
    var arr = [];
  	while (string.length() > 0) {
  		var index = string.find(delim);
  		if (index != null) {
  			arr.add(string.substring(0, index));
  			string = string.substring(index+1, string.length());
  		} else {
  			arr.add(string);
  			string = ""; 
  		}
  	}return arr;
  }
  static function ipAdressChanged() {
    	var ipAdress =  App.getApp().getProperty("ipAdress");
    	var forceNewSearch = App.getApp().getProperty("forceNewSearch");
    	return (forceNewSearch && Util.isValidIpAdress(ipAdress));
    }
static function isValidIpAdress(ipAdress) {
    if (ipAdress == null) {
        return false;
    }
	var arr = splitString(ipAdress, ".");
	if (arr == null) {
		return false;
	}
	if (arr.size() != 4) {
		return false;
	}
	for (var i = 0; i < 4; ++ i) {
		var num = arr[i].toNumber();
		if (num < 0 || num > 255) {
		  return false;
		}
	}
	return true;
}  
}