import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../tocken/config/url.dart';
import '../../../tocken/tockn.dart';

dynamic areas = '';
 fetchAreas() async {
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
            'api/resource/Assign Sale Area?filters=[["area_sales_manager", "=","$userID"]]&limit=10000000'),
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
