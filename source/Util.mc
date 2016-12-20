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
static function isValidIpAdress(ipAdress) {
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