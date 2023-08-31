import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:lamit/tocken/config/url.dart';

class LeadAPI {
  final String? email;
  final String? skey;

  //final String email;

  LeadAPI(
    this.email,
    this.skey,
  );
  // name=leadArray[]
  //this.email);
  var leadArray;
  Future<LeadAPI?> login() async {
    var a = email;
    // var b = skey;
    // print(a);
    // print("$b bbzbxb");
    // var email = this.email;
    http.Response response = await http.get(
        Uri.parse(urlMain +
            'api/resource/User?fields=["name","email"]&filters=[["full_name","=","$a"]]'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token f623e318d6be1f4:1961b7886dd26c7',
        });
    String data = response.body;

    leadArray = jsonDecode(data)["data"];
    print(leadArray);

    // print("laedarray" + leadArray);
    log(data);

    return null;
  }
}
