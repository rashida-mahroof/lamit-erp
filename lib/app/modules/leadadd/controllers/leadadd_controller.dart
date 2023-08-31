import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:lamit/app/modules/hotlead/views/hotlead_view.dart';
import 'package:lamit/app/modules/lead/views/lead_view.dart';
import 'package:lamit/tocken/config/url.dart';

import 'package:lamit/tocken/tockn.dart';

import '../../lead/views/lead-view-new.dart';

class LeadaddController extends GetxController {
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

  Future<void> leadadd(
      String gender,
      String first_name,
      String last_name,
      String expected_time_to_purchase,
      String sales_area,
      String source,
      String lead_owners,
      String referenced_by,
      String referenced_name,
      String date,
      String lead_category,
      String email_id,
      String mobile_no,
      String phone,
      String whatsapp_no,
      String lac,
      String distri,
      String leadname,
      String customer1,
      String status,
      String leadstaus,
      String? location,
      String? stage
      ) async {
    // var x =);
    log("hlw");
    log(location.toString()+'909090');

    log(expected_time_to_purchase.toString() + "expected date");

    // log(x);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    };
    final msg = jsonEncode({
      "first_name": first_name,
      "last_name": last_name == "null" ? "" : last_name.toString(),
      "expected_time_to_purchas": expected_time_to_purchase == "null"
          ? ""
          : expected_time_to_purchase.toString(),
      "sales_area": sales_area,
      "district": distri,
      "source": source,
      "lead_owners": lead_owners,
      //"referenced_by": referenced_by == "null" ? "" : referenced_by.toString(),
      "sale_area": lac,
      "sale_district": distri,

      //"referenced_name": referenced_name,

      "customer1": status == ""
          ? ""
          : status == "a"
              ? customer1
              : "",
      "shop1": status == ""
          ? ""
          : status == "b"
              ? customer1
              : "",
      "employee1": status == ""
          ? ""
          : status == "c"
              ? customer1
              : "",
      "engineer1": status == ""
          ? ""
          : status == "d" && source == 'ENGINEER / ARCHITECTS'
              ? customer1
              : "",
              "contractor":source == 'CONTRACTORS / TRUSS WORKERS' ?customer1:"",
      "dealer":source == 'DEALER' ? customer1 : '',
      "sub_dealer" : source == 'SUB DEALER' ? customer1 : '',
      // "date": "",
      "lead_category": lead_category,
      "email_id": email_id,
      "mobile_no": mobile_no,
      "phone": phone,
      "whatsapp_no": whatsapp_no == "null" ? "" : whatsapp_no,
      "lac": lac,
      //"leadname": leadname,
      "gender": gender.toString(),
      "states": "Kerala",
      "status": "Lead",
      "locations":location.toString(),
      "stage":stage =="null" ? "":stage
    });

    log(msg+'msg123456');
    print(last_name);
    print(mobile_no);
    print(expected_time_to_purchase);
    print(lead_category);
    http.Response response = await http.post(
        Uri.parse(urlMain + "api/resource/Lead"),
        headers: headers,
        body: msg);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      String data = response.body;
      print(data);

      if (jsonDecode(data)["data"]["message"] == "Success") {
        Fluttertoast.showToast(
            textColor: Colors.black,
            msg: "Lead Added",
            backgroundColor: Colors.blue[100]);
        leadstaus == "Lead" ? Get.to(LeadView()) : Get.to(HotleadView());
      } else {
       
      }
    } else if (response.statusCode == 417) {
      String dat = response.body;
      if (jsonDecode(dat)["exc_type"] == "InvalidEmailAddressError") {
        Fluttertoast.showToast(
            msg: "enter valid email address",
            textColor: Colors.black,
            backgroundColor: Colors.blue[100]);
      }
    } else if (response.statusCode == 409) {
      print(response.statusCode);
      log(response.body);

      Fluttertoast.showToast(
          msg:
              "This email id aleardy used/customer area and district is not match",
          backgroundColor: Colors.blue[100],
          textColor: Colors.black);

      // Get.to(RequirementView(""));
    } else {
       Fluttertoast.showToast(
            textColor: Colors.black,
            msg: response.reasonPhrase.toString(),
            backgroundColor: Colors.blue[100]);
      print("error");
    }
  }

  Future<void> leadedit(
      String id,
      String gender,
      String first_name,
      String last_name,
      String expected_time_to_purchase,
      String sales_area,
      String source,
      String lead_owners,
      String referenced_by,
      String referenced_name,
      String date,
      String lead_category,
      String email_id,
      String mobile_no,
      String phone,
      String whatsapp_no,
      String lac,
      String distri,
      String leadname,
      String customer1,
      String status,
      String leadstaus,
      String location,
      String? stage
      ) async {
    // var x =);
    log(expected_time_to_purchase.toString() + "expected date");
    // log("helloo");

    // log(x);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    };
    log("hii");
    final msg = jsonEncode({
      "first_name": first_name,
      "last_name": last_name == "null" ? "" : last_name.toString(),
      "expected_time_to_purchas": expected_time_to_purchase == "null"
          ? ""
          : expected_time_to_purchase.toString(),
      "sales_area": sales_area,
      "district": distri,
      "source": source,
      "lead_owners": lead_owners,
      //"referenced_by": referenced_by == "null" ? "" : referenced_by.toString(),
      "sale_area": lac,
      "sale_district": distri,

      //"referenced_name": referenced_name,

      "customer1": status == ""
          ? ""
          : status == "a"
              ? customer1
              : "",
      "shop1": status == ""
          ? ""
          : status == "b"
              ? customer1
              : "",
      "employee1": status == ""
          ? ""
          : status == "c"
              ? customer1
              : "",
      "engineer1": status == ""
          ? ""
          : status == "d" && source == 'ENGINEER / ARCHITECTS'
              ? customer1
              : "",
              "contractor":source == 'CONTRACTORS / TRUSS WORKERS' ?customer1:"",
              "dealer":source == 'DEALER' ? customer1 : '',
      "sub_dealer" : source == 'SUB DEALER' ? customer1 : '',
// "date": "",
      "lead_category": lead_category,
      "email_id": email_id,
      "mobile_no": mobile_no,
      "phone": phone,
      "whatsapp_no": whatsapp_no == "null" ? "" : whatsapp_no,
      "lac": lac,
      //"leadname": leadname,
      "gender": gender.toString(),
      "states": "Kerala",
      // "status": leadstaus.toString(),
      "status": "Lead",
      "locations":location.toString(),
      "stage":stage =="null" ? "":stage
    });

//     first_name
// last_name
// lead_name

// source
// date

// lead_category

// lead_owners

// email_id
// mobile_no

// phone
// whatsapp_no

// rt-987
    log(msg+'msg123456');
    print(last_name);
    print(mobile_no);
    print(expected_time_to_purchase);
    print(lead_category);
    http.Response response = await http.put(
        Uri.parse(urlMain + "api/resource/Lead/$id"),
        headers: headers,
        body: msg);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      String data = response.body;
      print(data);

      if (jsonDecode(data)["data"]["message"] == "Success") {
        Fluttertoast.showToast(
            textColor: Colors.black,
            msg: "Lead Edited",
            backgroundColor: Colors.blue[100]);
        leadstaus == "Lead" ? Get.to(LeadView()) : Get.to(HotleadView());
      } else {}
    } else if (response.statusCode == 417) {
      String dat = response.body;
      if (jsonDecode(dat)["exc_type"] == "InvalidEmailAddressError") {
        Fluttertoast.showToast(
            msg: "enter valid email address",
            textColor: Colors.black,
            backgroundColor: Colors.blue[100]);
      }
    } else if (response.statusCode == 409) {
      print(response.statusCode);
      log(response.body);

      Fluttertoast.showToast(
          msg:
              "This email id aleardy used/customer area and district is not match",
          backgroundColor: Colors.blue[100],
          textColor: Colors.black);

      // Get.to(RequirementView(""));
    } else {
      print("error");
       Fluttertoast.showToast(
            textColor: Colors.black,
            msg: response.reasonPhrase.toString(),
            backgroundColor: Colors.blue[100]);
    }

    // print("error");
  }
}
