import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/tocken/tockn.dart';

class RequirementController extends GetxController {
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

  Future addRequirement(
    int inde,
    List a,
    String lead,
  ) async {
    print(a.toString());
    log(a.toString() + "ngvvvvvvvvvvvbbbbbbbbbbbbbb");
    var productc = [];
    var array = [];
    String? product;
    String? Series;
    String? Qty;
    for (var d = 0; d < a.length; d++) {
      log(array[d].toString() + "hggvgvgvgvghggghghgh");
      array.add({
        "name": a[d]["name"] == null ? "" : a[d]["name"],
        'quantity': a[d]["qty"] == null ? "" : a[d]["qty"],
        "color": a[d]["color"] == null ? "" : a[d]["color"],
        "index": d,
      });
      log(array[d]["name"]);
      log(array[d].toString() + "hggvgvgvgvghggghghgh");

      product = array[d]["name"];
      Qty = array[d]["quantity"];
      Series = array[d]["color"];

      //
    }
    // print(array[d]["name"]);
    // print(d.toString() + "hbmbhmbmbmnnmnmnm");
    productc.toString();
    log(product.toString());
    // log(array[d]["qty"].toString() + "mnhbbcfbbbbbbbbbgvgvhbjhjkljiikk");
    var baseUrl = urlMain + 'api/resource/UpdateTable';
    final msg = jsonEncode({
      "doc_type": "Lead",
      "reference_doc": lead,
      "table_name": "customer_requirements",
      "product": product.toString(),
      "color": Series.toString(),
      "quantity": Qty.toString(),
      "uom": "Nos"
    });

    http.Response response =
        await http.post(Uri.parse(baseUrl), body: msg, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    });

    print(response.body);
    print(response.statusCode);
    print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
    if (response.statusCode == 200) {
      print(response.body);
      print("haaaaaaaaaaaaaaaaaaaaaaaaa");
      String data = response.body;

      // setState(() {
      //   jsonData = json.decode(data)["data"];
      //   arealist = jsonData;
      //   for (var i = 0; i <= jsonData.length; i++) {
      //     setState(() {
      //       jsonData[i]["index"] = i;
      //     });

      //     ;
      //   }
      // });
      ;

      // log(jsonData.toString());
      // setState(() {});
    }
  }
}
