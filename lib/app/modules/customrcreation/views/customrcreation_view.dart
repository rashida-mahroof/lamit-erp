import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';

import 'package:http/http.dart' as http;
import 'package:lamit/app/modules/salesdetail/views/salesdetail_view.dart';
import 'package:lamit/tocken/config/url.dart';

import 'package:lamit/tocken/tockn.dart';

import '../../../routes/constants.dart';

class CustomrcreationView extends StatefulWidget {
  final String? lead;
  final String? name;

  // final String? leadcatagory;

  const CustomrcreationView(
    this.lead,
    this.name,
  );

  @override
  State<CustomrcreationView> createState() => _CustomrcreationViewState();
}

class _CustomrcreationViewState extends State<CustomrcreationView> {
  TextEditingController customerameController = new TextEditingController();
  String? leadcatag;
  String? lea;
  @override
  void initState() {
    leadcata();
    customerameController.text = widget.name.toString();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.to(SalesdetailView(
                    widget.name, "qt", "", "", "", widget.lead));
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          title: Text("Customer Creation"),
          backgroundColor: Colors.grey[50],
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: Constants(context).scrnHeight,
            width: Constants(context).scrnWidth,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                controller: customerameController,
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                  hintText: customerameController.text,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // leadcatag == null
                  //     ? Container()
                  //     : Row(
                  //         children: [
                  //           Expanded(
                  //             child: Container(
                  //               height: 45,
                  //               margin: EdgeInsets.all(5),
                  //               decoration: BoxDecoration(
                  //                   color: Colors.white,
                  //                   borderRadius: BorderRadius.circular(5)),
                  //               child: Padding(
                  //                 padding: const EdgeInsets.only(
                  //                     left: 8.0, right: 8.0),
                  //                 child: Align(
                  //                     alignment: Alignment.centerLeft,
                  //                     child: Text(leadcatag.toString())),
                  //               ),
                  //             ),
                  //           ),
                  //           // Expanded(
                  //           //   child: Container(
                  //           //       height: 45,
                  //           //       margin: EdgeInsets.all(5),
                  //           //       decoration: BoxDecoration(
                  //           //           color: Colors.white,
                  //           //           borderRadius: BorderRadius.circular(5)),
                  //           //       child: Padding(
                  //           //         padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  //           //         child: TextField(
                  //           //           // controller: obController,
                  //           //           textAlign: TextAlign.left,
                  //           //           keyboardType: TextInputType.number,
                  //           //           decoration: InputDecoration(
                  //           //             hintText: "OP Balance",
                  //           //             border: InputBorder.none,
                  //           //           ),
                  //           //         ),
                  //           //       )),
                  //           // ),
                  //         ],
                  //       ),

                  // Row(
                  //   children: [
                  //     Expanded(
                  //       flex: 2,
                  //       child: Container(
                  //         margin: EdgeInsets.all(5),
                  //         decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             borderRadius: BorderRadius.circular(5)),
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  //           child: TextField(
                  //             // controller: vatController,
                  //             textAlign: TextAlign.left,
                  //             keyboardType: TextInputType.number,
                  //             decoration: InputDecoration(
                  //               hintText: "House Number",
                  //               border: InputBorder.none,
                  //               // suffixIcon:
                  //               //     Icon(Icons.phone_android)
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Divider(),
                  Row(
                    children: [
                      Expanded(child: Container()),
                      Expanded(
                        child: Container(
                          height: 40,
                          width: Constants(context).scrnWidth,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              color: Colors.white)))),
                              onPressed: () {
                                addRequirement(0, [], widget.lead.toString());
                                // if (customerameController?.text == "") {
                                //   Fluttertoast.showToast(
                                //       msg: "Name Required",
                                //       textColor: Colors.white,
                                //       backgroundColor: Colors.red);
                                // } else {
                                //   if (widget.isEdit == "isEDIT") {
                                //     update();
                                //     print("kkjjjjjjjjjjj" + widget.isEdit);
                                //   } else {
                                //     insertCollectionOffline();
                                //   }
                                // }
                              },
                              child: Text(
                                'Save',
                                style: TextStyle(color: Colors.grey[900]),
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future addRequirement(
    int inde,
    List a,
    String lead,
  ) async {
    log(lea.toString());
    print(a.toString());
    log(a.toString() + "ngvvvvvvvvvvvbbbbbbbbbbbbbb");

    for (var d = 0; d < a.length; d++) {
      // log(array[d].toString() + "hggvgvgvgvghggghghgh");

      // product = array[d]["name"];
      // Qty = array[d]["quantity"];
      // Series = array[d]["color"];

      //
    }
    // print(array[d]["name"]);
    // print(d.toString() + "hbmbhmbmbmnnmnmnm");

    // for (var i = 0; i < mapList.length; i++) {
    //   name = mapList[i]["name"];
    //   series = mapList[i]["color"];
    //   series = mapList[i]["color"];
    // }

    // log(array[d]["qty"].toString() + "mnhbbcfbbbbbbbbbgvgvhbjhjkljiikk");
    var baseUrl = urlMain + 'api/resource/Customer';
    final msg = jsonEncode({
      "lead_name": lea,
      "lead": lea,
      "customer_name": customerameController.text,
      "customer_group": leadcatag,
      "territory": "India"
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
      log(data);
      Fluttertoast.showToast(msg: "Customer Added");
      Get.to(SalesdetailView(widget.name, "qt", "", "", "", widget.lead));

      setState(() {
        customerameController.clear();
      });
      // Get.to(SalesdetailView(widget.name, "", "", "", "", lea))
      // CustomrcreationView(lead, lea)

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

  leadcata() async {
    print("object");
    var s = widget.lead;
    http.Response response = await http.get(
      Uri.parse(urlMain + "api/resource/Lead/$s"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Tocken,
      },
    );
    // log(response.body);
    // print(response.statusCode);
    if (response.statusCode == 200) {
      String data = response.body;
      setState(() {
        leadcatag = jsonDecode(data)["data"]["lead_category"];
        lea = jsonDecode(data)["data"]["name"];
        //baisicDetail = jsonDecode(data)["data"];
        // productList = jsonDecode(data)["data"]["member_details1"];
      });

      // log(productList[0]["note"]);
      //  print(data);
      // baisicDetailView2();
    } else {}
  }

  // Future leadcata() async {
  //   var s = widget.lead;

  //   var baseUrl = 'https://lamit.erpeaz.com/api/resource/Lead/$s';

  //   http.Response response = await http.put(Uri.parse(baseUrl), headers: {
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': Tocken,
  //   });

  //   print(response.body);
  //   print(response.statusCode);
  //   print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
  //   if (response.statusCode == 200) {
  //     print(response.body);
  //     print("haaaaaaaaaaaaaaaaaaaaaaaaa");
  //     String data = response.body;
  //     log(data);
  //     //  Fluttertoast.showToast(msg: "Customer Added");
  //     // Get.to(AddqoutationaddView(widget.leadtok))

  //     // setState(() {
  //     //   jsonData = json.decode(data)["data"];
  //     //   arealist = jsonData;
  //     //   for (var i = 0; i <= jsonData.length; i++) {
  //     //     setState(() {
  //     //       jsonData[i]["index"] = i;
  //     //     });

  //     //     ;
  //     //   }
  //     // });
  //     ;

  //     // log(jsonData.toString());
  //     // setState(() {});
  //   }
  // }
}
