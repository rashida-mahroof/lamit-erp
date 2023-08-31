// import 'dart:convert';
// import 'dart:developer';

// import 'package:http/http.dart' as http;

// import 'package:lamit/globals.dart' as globals;
// import '../../../../tocken/config/url.dart';
// import '../../../../tocken/tockn.dart';

// var areaList = [];
// fetchLacs() async {
//   var userId = globals.loginId;

//   var baseUrl = urlMain +
//       'api/resource/Assign Sale Area?filters=[["sales_officer", "=", "$userId"]]&limit=100000&order_by=creation%20desc';

//   http.Response response = await http.get(Uri.parse(baseUrl), headers: {
//     'Content-type': 'application/json',
//     'Accept': 'application/json',
//     'Authorization': Tocken,
//   });

//   if (response.statusCode == 200) {
//     String data = response.body;
//     //var jsonData;

//     // jsonData = json.decode(data)["data"];

//     var lacList = jsonDecode(data)["data"];
//     for (int i = 0; i < lacList.length; i++) {
//       areaList.add(lacList[i]["name"]);
//     }
//     print(areaList.toString() + 'looo');

//     // custmearea(jsonDecode(data)["data"], cust);
//     // log(jsonData.toString());
//     // setState(() {});
//   }
//   return areaList;
// }
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../tocken/config/url.dart';
import '../../../../tocken/tockn.dart';
import 'package:lamit/globals.dart' as globals;
dynamic areas = '';
 fetchAllLacs() async {
   var userId = globals.loginId;
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var userID = preferences.getString("userid");
  http.Response response = await http.get(
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken.toString(),
    },
    Uri.parse(
        // addURL,
        urlMain +
            'api/resource/Assign Sale Area?filters=[["sales_officer", "=", "$userId"]]&limit=100000&order_by=creation%20desc'),
  );
  if (response.statusCode == 200) {
    // print(response.body + 'hlo');
    String data = response.body;
    var areaList = [];
    var aList = jsonDecode(data)["data"];
    for (int i = 0; i < aList.length; i++) {
      areaList.add(aList[i]["name"]);
    }

    areas = areaList.toString();

    print(areas.toString() + 'hlo12');
  } else {
    print(response.reasonPhrase.toString());
  }
  return areas;
}
