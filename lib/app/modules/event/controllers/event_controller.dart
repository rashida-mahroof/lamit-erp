import 'dart:convert';
import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lamit/app/modules/leaddetails/views/leaddetails_view.dart';
import 'package:lamit/tocken/config/url.dart';

import '../../../../tocken/tockn.dart';

class EventController extends GetxController {
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

  Future<void> addnote(String name, String Notes, String datel, String leadtock,
      String Eventname) async {
    // log(leadtock.toString());
    log("mjmmmmmm" + datel.toString());

    // DateTime d = DateTime.parse(datel);
    // String formattedDate =
    //     DateFormat('yyyy-MM-dd').format(DateTime.parse(datel));
    // log(formattedDate
    //     .toString()); // String formated = DateFormat('yyyy-MM-dd').format(DateTime.parse(date));
    final msg = jsonEncode({
      "doc_type": "Lead",

      "reference_doc": leadtock.toString(),

      "table_name": "lead_events",

      "event_name": Eventname == "" ? "" : Eventname.toString(),

      "event_date": datel == ""
          ? ""
          : DateFormat('yyyy-MM-dd').format(DateTime.parse(datel)).toString(),

      "remarks": Notes == "" ? "" : Notes
      // "doc_type": "Lead",
      // "reference_doc": "LMT-LEAD-2022-00084",
      // "table_name": "notes",
      // "note": Notes,
      // "added_by": "admindemo@gmail.com"
    });
    log("mjmmmmmm" + datel.toString());
    log(leadtock.toString());
    log(datel.toString());

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
      Get.to(LeaddetailsView(name, "isevent", 0, "", "", leadtock));
    } else {
      Fluttertoast.showToast(msg: "Not added");
    }
  }
}
