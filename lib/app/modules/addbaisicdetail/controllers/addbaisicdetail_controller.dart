import 'dart:convert';
import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lamit/app/modules/leaddetails/views/leaddetails_view.dart';

import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/tocken/tockn.dart';

class AddbaisicdetailController extends GetxController {
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

  //

  addbaisicDetail(
      String name,
      String social_group,
      String marital_status,
      String education,
      String noofkid,
      String company,
      String designation,
      String leadtok) async {
    log("message");
    log(noofkid.toString());
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    };
    log(social_group.toString());
    final msg = jsonEncode(
      {
        "social_group1": social_group.toString() == "null" ? "" : social_group,
        "marital_status1": marital_status.toString() == "null"
            ? "----Select----"
            : marital_status,
        // "family_background": "hbjhghghghhhhhh",
        "education1": education.toString() == "null" ? "" : education,
        "no_of_kids": noofkid.toString() == "null" ? "" : noofkid,
        "company_name1": company.toString() == "null" ? "" : company,
        "occupation": designation.toString() == "null" ? "" : designation,
      },
    );

    http.Response respons = await http.put(
        Uri.parse(urlMain + "api/resource/Lead/$leadtok"),
        body: msg,
        headers: headers);
    print(respons.body);
    log(respons.statusCode.toString());
    if (respons.statusCode == 200) {
      Fluttertoast.showToast(msg: "Baisic detail added");
      Get.to(LeaddetailsView(name, "isedit", 3, "", "", leadtok));

      log(respons.body);
    } else {}
  }

  updatedd(
      String status,
      String member,
      String name,
      String social_group,
      String marital_status,
      String education,
      String noofkid,
      String company,
      String designation,
      String leadtok) async {
    log("message");
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    };
    final msg = jsonEncode(
      {
        "social_group1":
            social_group == "null" ? "----Select----" : social_group,
        "marital_status1":
            marital_status == "null" ? "----Select----" : marital_status,
        // "family_background": "hbjhghghghhhhhh",
        "education1": education == "null" ? "----Select----" : education,
        "numberofkids": noofkid.toString() == "null" ? "" : noofkid,
        "company_name1": company.toString() == "null" ? "" : company,
        "occupation": designation.toString() == "null" ? "" : designation,
      },
    );
    log(designation.toString());
    http.Response respons = await http.put(
        Uri.parse(urlMain + "api/resource/Lead/$leadtok"),
        body: msg,
        headers: headers);
    print(respons.body);
    log(respons.statusCode.toString());
    if (respons.statusCode == 200) {
      Get.to(LeaddetailsView(name, "isedit", 3, "", "", leadtok));
      status == "add"
          ? Fluttertoast.showToast(msg: "Baisic detail added")
          : Fluttertoast.showToast(msg: "Baisic detail updated");
      log(respons.body);
    } else {}
  }

  addmemberDetail(
      String membername,
      String gender,
      String relation,
      String age,
      String date,
      String material,
      String education,
      String lead,
      String occu) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    };

    final msg = jsonEncode(
      {
        "doc_type": "Lead",
        "reference_doc": lead,
        "table_name": "member_details1",
        "member_name": membername == "null" ? "" : membername,
        "gender": gender.toString() == "null" ? "" : gender,
        "relation_with_lead": relation == "null" ? "" : relation,
        "age": age.toString() == "null" ? "" : age,
        "education": education.toString() == "null" ? "" : education.toString(),
        //"occupation": "sm",
        "dob": date.toString() == "null" ? "" : date,
        "marital_status": material == "null" ? "" : material,
        "occupation": occu.toString() == "null" ? "" : occu.toString()
        // "blood_group": "O+"
      },
    );
    log(occu.toString());
    print(education.toString());
    http.Response respons = await http.post(
        Uri.parse(urlMain + "api/resource/UpdateTable"),
        body: msg,
        headers: headers);
    print(respons.body);
    log(respons.statusCode.toString());
    if (respons.statusCode == 200) {
      log(respons.body);
      String data = respons.body;
      Get.to(LeaddetailsView(membername, "isedit", 3, "", "", lead));

      if (jsonDecode(data)["data"] != null) {
        Fluttertoast.showToast(msg: "Member detail added");
      } else {
        Fluttertoast.showToast(msg: "Member detail not added");
      }
    } else {}
  }

  updatememberDetail(
      String membername,
      String gender,
      String relation,
      String age,
      String date,
      String material,
      String education,
      String lead,
      int idx,
      String occu,
      String row,
      String name) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    };
    log(row.toString());
    log(education.toString());
    final msg = jsonEncode({
      "doc_type": "Lead",
      "reference_doc": lead == "" ? "" : lead.toString(),
      "table_name": "member_details1",
      "member_name": membername == "" ? "" : membername.toString(),
      "row_id": row.toString() == "" ? "" : row.toString(),
      "gender": gender == "null" ? "" : gender,
      "relation_with_lead": relation == "" ? "" : relation,
      "age": age == "" ? "" : age,
      "education": education == "null" ? "" : education,
      "occupation": occu == "" ? "" : occu.toString(),
      "dob": date == "null" ? "" : date.toString(),
      "marital_status": material == "null" ? "" : material.toString(),
      "blood_group": ""
    });
    print(education.toString());
    http.Response respons = await http.post(
        Uri.parse(urlMain + "api/resource/UpdateTable"),
        body: msg,
        headers: headers);
    print(respons.body);
    log(respons.statusCode.toString());
    if (respons.statusCode == 200) {
      log(respons.body);
      String data = respons.body;

      if (jsonDecode(data)["data"] != null) {
        Fluttertoast.showToast(msg: "Member detail updated");
        Get.to(LeaddetailsView(name, "isedit", 3, "", "", lead));
      } else {
        Fluttertoast.showToast(msg: "Member detail not updated");
      }
    } else {}
  }
}
// https://lamit.erpeaz.com/api/resource/Lead/LMT-LEAD-2022-00169