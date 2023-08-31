import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/tocken/tockn.dart';

import '../../leaddetails/views/leaddetails_view.dart';

class AddaddressController extends GetxController {
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
//https://lamit.erpeaz.com/api/resource/Lead/LMT-LEAD-2022-00207

// PUT{
//         "address_line1": "ghhzxsjhg",
//         "pin_code": "049759",
//         "address_line2": "ghz",
//         "city": "hsz"

// }

  // addAddress(
  //     String? lead_name,
  //     String distr,
  //     String name,
  //     String address_line1,
  //     String city,
  //     String address_title,
  //     String pincode,
  //     String addresstok) async {
  //   Map<String, String> headers = {
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': Tocken,
  //   };
  //   print("haai");
  //   log(lead_name.toString());

  //   http.Response response = await http.post(
  //     Uri.parse("https://lamit.erpeaz.com/api/resource/Address"),
  //     headers: headers,
  //     body: json.encode({
  //       "address_line1": address_line1,
  //       "address_title": lead_name,
  //       "city": city,
  //       "country": "India",
  //       "address_line2": address_title,
  //       "state": "Kerala",
  //       "pin_code": pincode,
  //       "districts": distr,
  //       //"phone": phone,
  //       //"email_id": email_id,
  //       "tax_category": "INSTATE",
  //       "links": [
  //         {"link_doctype": "Lead", "link_name": addresstok}
  //       ]
  //     }),
  //   );
  //   if (response.statusCode == 200) {
  //     Fluttertoast.showToast(
  //         msg: "Address Added Successfully",
  //         backgroundColor: Color.fromARGB(255, 1, 23, 87));

  //     Get.to(LeaddetailsView(name, "iseditaddr", 0, "", "", addresstok));

  //     String data = response.body;
  //     print(data);
  //   } else {
  //     print(response.body);
  //   }
  // }
  addAddress(
      String status,
      String? lead_name,
      String district,
      String name,
      String address_title,
      String city,
      String address_line1,
      String pincode,
      String addresstok) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    };
    print("haai");
    log(addresstok.toString() + "b bgbbbbbbb");
    http.Response response = await http.post(
      Uri.parse(urlMain + "api/resource/Address"),
      headers: headers,
      body: json.encode({
        "address_line1": address_line1,
        "city": city,
        "country": "India",
        "address_title": lead_name,
        "address_line2": address_title,
        "state": "Kerala",
        "pincode": pincode,
        "districts": district,
        //"phone": phone,
        //"email_id": email_id,
        "tax_category": "INSTATE",
        "links": [
          {"link_doctype": "Lead", "link_name": addresstok}
        ]
      }),
    );
    log(response.statusCode.toString());
    log(response.body + 'hlooooooooooo');
    if (response.statusCode == 200) {
      log(response.body.toString() + 'its working');
      updateaddAddress("", lead_name, district, name, address_title, city,
          address_line1, pincode, addresstok);
      status == "added"
          ? Fluttertoast.showToast(
              msg: "Address Added Successfully",
              backgroundColor: Colors.blue[200],
              textColor: Colors.black)
          : Fluttertoast.showToast(
              msg: "Address Added Successfully",
              backgroundColor: Colors.blue[200],
              textColor: Colors.black);

      // Get.to(LeaddetailsView(name, "iseditaddr", 0, "", "", addresstok));

      // String data = response.body;
      // print(data);
    } else {
      print(response.reasonPhrase.toString() + 'reasonmy');
    }
  }

  updateaddAddress(
      String status,
      String? lead_name,
      String district,
      String name,
      String address_title,
      String city,
      String address_line1,
      String pincode,
      String addresstok) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    };
    print("haai");
    log(name.toString() + "b bgbbbbbbb");
    http.Response response = await http.put(
      Uri.parse(urlMain + "api/resource/Lead/$addresstok"),
      headers: headers,
      body: json.encode({
        "address_line1": address_line1,
        "city": city,
        "country": "India",
        "address_title": lead_name,
        "address_line2": address_title,
        "state": "Kerala",
        "pin_code": pincode,
        "districts": district,
        //"phone": phone,
        //"email_id": email_id,
        "tax_category": "INSTATE",
        "links": [
          {"link_doctype": "Lead", "link_name": addresstok}
        ]
      }),
    );
    log(response.body.toString());
    if (response.statusCode == 200) {
      String data = response.body;

      updateaddAddress2(lead_name, district, name, address_title, city,
          address_line1, pincode, addresstok, "");

      status == "edit"
          ? Fluttertoast.showToast(
              msg: "Address Updated Successfully",
              backgroundColor: Colors.blue[200],
              textColor: Colors.black)
          : Fluttertoast.showToast(
              msg: "Address Updated Successfully",
              backgroundColor: Colors.blue[200],
              textColor: Colors.black);

      // Get.to(LeaddetailsView(name, "iseditaddr", 0, "", "", addresstok));

      //  String data = response.body;
      print(data);
    } else {
      print(response.body);
    }
  }

  updateaddAddress2(
      String? lead_name,
      String district,
      String name,
      String address_title,
      String city,
      String address_line1,
      String pincode,
      String addresstok,
      String addressname) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    };
    print("haai");
    //  log(addressname.toString() + "b bgbbbbbbb");
    http.Response response = await http.put(
      Uri.parse(urlMain + "api/resource/Address/$name-billing"),
      headers: headers,
      body: json.encode({
        "address_line1": address_line1,
        "city": city,
        "country": "India",
        "address_title": lead_name,
        "address_line2": address_title,
        "state": "Kerala",
        "pin_code": pincode,
        "districts": district,
        //"phone": phone,
        //"email_id": email_id,
        "tax_category": "INSTATE",
        "links": [
          {"link_doctype": "Lead", "link_name": addresstok}
        ]
      }),
    );
    log(response.body.toString());
    if (response.statusCode == 200) {
      // Fluttertoast.showToast(
      //     msg: "Address Updated Successfully",
      //     textColor: Colors.black,
      //     backgroundColor: Colors.blue[200]);

      Get.to(LeaddetailsView(name, "iseditaddr", 0, "", "", addresstok));

      String data = response.body;
      print(data);
    } else {
      print(response.body);
    }
  }
}
