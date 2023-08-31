import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../../../tocken/config/url.dart';
import '../../../tocken/tockn.dart';

var dataList = [];
var engNameList = [];
var engMobileList = [];

var contNameList = [];
var contMobileList = [];

var shopNameList = [];
var shopMobileList = [];

fetchData(type) async {
  var api;
  if (type == 1) {
    api =
        'api/resource/Engineer?fields=["name1","mobile","email","creation","lead_id"]&limit=1000000&order_by=creation%20desc';
  } else if (type == 2) {
    api =
        'api/resource/Contractor?fields=["name1","mobile","email","creation","lead_id"]&limit=1000000&order_by=creation%20desc';
  } else {
    api =
        'api/resource/Shop?fields=["organization_name","mobile","email","creation","lead_id"]&limit=1000000&order_by=creation%20desc';
  }
  http.Response response = await http.get(
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken.toString(),
    },
    Uri.parse(urlMain + api),
  );
  if (response.statusCode == 200) {
    print('successok');

    log(response.body + 'mresultt');
    var data = jsonDecode(response.body)["data"];
    if (type == 1) {
      if (engNameList.length < 1) {
        for (int i = 0; i < data.length; i++) {
          var mobile = data[i]["mobile"];
          var name = data[i]["name1"];
          engNameList.add('$name ($mobile)');
        }
      }
      if (engMobileList.length < 1) {
        for (int i = 0; i < data.length; i++) {
          var mobile = data[i]["mobile"];
          engMobileList.add('$mobile');
        }
      }
    } else if (type == 2) {
      if (contNameList.length < 1) {
        for (int i = 0; i < data.length; i++) {
          var mobile = data[i]["mobile"];
          var name = data[i]["name1"];
          contNameList.add('$name ($mobile)');
        }
      }
      if (contMobileList.length < 1) {
        for (int i = 0; i < data.length; i++) {
          var mobile = data[i]["mobile"];
          contMobileList.add('$mobile');
        }
      }
    } else {
      if (shopNameList.length < 1) {
        for (int i = 0; i < data.length; i++) {
          var mobile = data[i]["mobile"];
          var name = data[i]["organization_name"];
          shopNameList.add('$name ($mobile)');
        }
      }
      if (shopMobileList.length < 1) {
        for (int i = 0; i < data.length; i++) {
          var mobile = data[i]["mobile"];
          shopMobileList.add('$mobile');
        }
      }
    }
  } else {
    print(response.reasonPhrase.toString());
  }
  return json.decode(response.body)['data'];
}

filterData(
  int leadType,
  key,
  srch,
) async {
  var api;
  var lead;
  if (leadType == 1) {
    lead = 'Engineer';
  } else if (leadType == 2) {
    lead = 'Contractor';
  } else {
    lead = 'Shop';
  }
  if (key == 'name') {
    if (leadType == 3) {
      // organization_name
      api =
          'api/resource/$lead?fields=["organization_name","mobile","email","creation","lead_id"]&filters=[["organization_name","=","$srch"]]&limit=1000000&order_by=creation%20desc';
    } else {
      api =
          'api/resource/$lead?fields=["name1","mobile","email","creation","lead_id"]&filters=[["name1","=","$srch"]]&limit=1000000&order_by=creation%20desc';
    }
  } else {
    if(srch == null){
      srch = '';
    }
    api =
        'api/resource/$lead?fields=["*"]&filters=[["mobile","=","$srch"]]&limit=1000000&order_by=creation%20desc';
  }
  print(api);
  http.Response response = await http.get(
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken.toString(),
    },
    Uri.parse(urlMain + api),
  );
  if (response.statusCode == 200) {
    print('successok');

    log(response.body + 'mresultt');
    var data = jsonDecode(response.body)["data"];
  } else {
    print(response.reasonPhrase.toString());
  }
  return json.decode(response.body)['data'];
}
