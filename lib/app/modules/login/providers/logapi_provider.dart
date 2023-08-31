// import 'dart:convert';
// import 'dart:developer';

// import 'package:get/get.dart';
// import 'package:lamit/app/modules/home/views/home_view.dart';

// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Logapi {
//   final String? username;
//   final String? password;

//   Logapi(this.username, this.password);
//   var array;

//   Future<Logapi?> login() async {
//     var user = this.username;
//     var passwor = this.password;
//     http.Response response = await http.get(
//         Uri.parse(
//           'https://lamit.erpeaz.com/api/method/erpnext.api.login?usr=$user&pwd=$passwor',
//         ),
//         headers: {
//           'Content-type': 'application/json',
//           'Accept': 'application/json',
//           "Authorization": "Some token"
//         });
//     String data = response.body;
//     print(data);
//     if (response.statusCode == 200) {
//       //array = jsonDecode(data)["message"];
//       // print("array$array");

//       if (jsonDecode(data)["message"]["message"] == "Authentication Error!") {
//         Fluttertoast.showToast(
//           msg: "invalid user name and password",
//           backgroundColor: Colors.blue[100],
//           textColor: Colors.black,
//         );
//       } else {
//         loguserdetails(jsonDecode(data)["message"]["api_key"],
//             jsonDecode(data)["message"]["api_secret"]);

//         log("""""" "haaaaaaaaaa" """""");
//         Get.to(HomeView());
//       }
//     } else {}
//     return null;
//   }

//   loguserdetails(String a, String b) async {
//     print(a);
//     print(b);
//     http.Response response = await http.get(
//         Uri.parse(
//           'https://lamit.erpeaz.com/api/resource/User/adminwebeaz@gmail.com',
//         ),
//         headers: {
//           'Content-type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Token $a:$b',
//         });
//     String data = response.body;
//     savesf(a, b);

//     array = jsonDecode(data)["data"];

//     print(response.statusCode);
//     print(data);
//   }

//   savesf(String a, String b) async {
//     print(a + "jjhjhhjjh");
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     //preferences.setString("emailid", array["email"]);

//     preferences.setString("akey", a);
//     preferences.setString("skey", b);

//     //print(array["email"]);
//   }
// }
