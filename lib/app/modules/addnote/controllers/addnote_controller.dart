import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lamit/app/modules/leaddetails/views/leaddetails_view.dart';
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/tocken/tockn.dart';

class AddnoteController extends GetxController {
  final count = 0.obs;
  var f = [];
  @override
  void onInit() {
    // addnote("");
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

  Future<void> addnote(String name, String Notes, String array) async {
    //  print(array);
    // for (var i = 0; i < array.length; i++) {
    //   f.add(array[i]["name"]);
    // }
    final msg = jsonEncode({
      "doc_type": "Lead",
      "reference_doc": array.toString(),
      "table_name": "notes",
      "note": Notes,
      "added_by": "admindemo@gmail.com"
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
      Get.to(LeaddetailsView(name, "isnotes", 0, "", "", array));
      Fluttertoast.showToast(msg: "added");
    } else {
      Fluttertoast.showToast(msg: "Not added");
    }
  }
}
