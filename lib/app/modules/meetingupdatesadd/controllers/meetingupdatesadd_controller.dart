import 'dart:convert';
import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lamit/app/modules/leaddetails/views/leaddetails_view.dart';
import 'package:lamit/tocken/config/url.dart';

import '../../../../tocken/tockn.dart';

class MeetingupdatesaddController extends GetxController {
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

  Future<void> meetingupdates(
      String Name,
      String Notes,
      var array,
      String leadtocken,
      String contactdate,
      String starttime,
      String endtime,
      String nextcdate) async {
    //  print(array);
    log(nextcdate);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    log(formattedDate);
    final msg = jsonEncode({
      "doc_type": "Lead",
      "reference_doc": leadtocken,
      "table_name": "meeting_updates2",
      "contact_date": endtime == "" ? formattedDate : contactdate.toString(),
      // "emp_id": "8989",
      // "emp_name": "webeaz Admin",
      //"contact_time": "",
      "from_time": starttime == "" ? formattedDate : starttime.toString(),
      "to_time": endtime == "" ? formattedDate : endtime.toString(),
      "next_contact_date":
          nextcdate == "null" ? formattedDate : nextcdate.toString(),
      // "notes": "sssssssssssssssaaaaaaaaaaaaaaaa1111",
      // "added_by": "admindemo@gmail.com"
    });

    http.Response response = await http.post(
        Uri.parse(urlMain + "api/resource/UpdateTable"),
        body: msg,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': Tocken,
        });

    String data = response.body;
    print(data);
    if (data != "") {
      Fluttertoast.showToast(msg: "added");
      Get.to(LeaddetailsView(Name, "ismeeting", 0, "", "", leadtocken));
    } else {
      Fluttertoast.showToast(msg: "Not added");
    }
  }
}
