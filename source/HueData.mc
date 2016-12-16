class HueData {
  var myBridge = { "ipAdress" => "http://192.168.178.87", "userId" => "TeVXBtHIEKIhmLkY0bqMSQjVtKmUiMnlSbD9Of-7" };
  var bridge = {};
  var lights = {};
  var selectedLight = -1;
  var lightMode = 2;
  var stage = 1;
  function initialize(){}
  function setCommandResult(result) {
  	var key = result.keys()[0];
  	var arr = splitString(key, "/");
  	System.println(key + " "+arr);
  	if (arr[1].equals("lights")) {
  		var i = 2;
  		var data = lights;
  		while (i < arr.size()-1) {
  			data = data[arr[i]];
  			++ i;
  		}
  		data.remove(arr[i]);
  		data.put(arr[i],result.get(key));
  	}
  }
  function splitString(string, delim) {
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
}