import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lamit/app/routes/constants.dart';
import 'package:http/http.dart' as http;
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/tocken/tockn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CollectionreportView extends StatefulWidget {
  final String ids;
  final String party;

  const CollectionreportView(this.ids, this.party);
  @override
  State<CollectionreportView> createState() => _CollectionreportViewState();
}

class _CollectionreportViewState extends State<CollectionreportView> {
  var collectioArray;
  var productlistsaleinvo;
  String? id;
  @override
  void initState() {
    getsf();
    super.initState();
  }

  Widget build(BuildContext context) {
    // bool isRotated = false;
    return Scaffold(
        body: collectioArray == null
            ? Container()
            : Stack(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: GestureDetector(
                  //     onTap: (() {
                  //       // var i;
                  //       // for (var i = 0; i < productList.length; i++) {
                  //       //   productList[i];
                  //       // }
                  //       Get.to(CollectionView());
                  //     }),
                  //     child: Container(
                  //       child: Row(
                  //         children: [
                  //           Icon(Icons.add_outlined),
                  //           Padding(
                  //             padding: const EdgeInsets.all(8.0),
                  //             child: Text(
                  //               "ADD COLLECTION",
                  //               style: TextStyle(
                  //                   color: Colors.grey,
                  //                   fontWeight: FontWeight.bold),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      height: Constants(context).scrnHeight,
                      width: Constants(context).scrnWidth,
                      child: ListView.builder(
                          itemCount: collectioArray.length,
                          itemBuilder: ((context, index) {
                            return Card(
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:
                                            Container(child: Text("Customer")),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(child: Text("Date")),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            child: Text("Mode of payment")),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            child: Text("Collected amount")),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.all(8.0),
                                      //   child: Container(
                                      //       child: Text("Advanced amount")),
                                      // )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(child: Text(":")),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(child: Text(":")),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(child: Text(":")),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(child: Text(":")),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.all(8.0),
                                      //   child: Container(child: Text(":")),
                                      // )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            child: Text(collectioArray[index]
                                                    ["party_name"]
                                                .toString())),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            child: Text(DateFormat('yyyy-MM-dd')
                                                    .format(DateTime.parse(
                                                        collectioArray[index]
                                                                ["posting_date"]
                                                            .toString()))

                                                // Text(DateTime.parse(DateFormat(
                                                //             "yyyy-MM-dd")
                                                //         .format()))
                                                //     .toString())
                                                )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(collectioArray[index]
                                                ["mode_of_payment"]
                                            .toString()),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(collectioArray[index]
                                                  ["paid_amount"]
                                              .toString())),
                                    ],
                                  )
                                ],
                              ),
                            );
                          })),
                    ),
                  )
                ],
              ));
  }

  getsf() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString("userid");
      // name = preferences.getString("name");
    });
    // detailinvoceView();
    getReport();

    // print(id.toString());
    // print(name.toString());
    // getlac();
    // newleadView(id.toString());
  }

  // detailinvoceView() async {
  //   log(widget.ids.toString());
  //   print("object");
  //   log(widget.party);
  //   var s = widget.ids;
  //   // var Tocken;
  //   http.Response response = await http.get(
  //     Uri.parse(
  //         'https://lamit.erpeaz.com/api/resource/Payment Entry?filters=[["party","=","$s"]]&fields=["*"]'),
  //     headers: {
  //       'Content-type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': Tocken,
  //     },
  //   );
  //   log(response.body);
  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     String data = response.body;
  //     log(data);
  //     String? invoid;
  //     setState(() {
  //       //baisicDetail = jsonDecode(data)["data"];
  //       // productlistsaleinvo = jsonDecode(data)["data"];
  //       // invoid = jsonDecode(data)["data"][0]["name"];
  //     });
  //     getReport(invoid.toString());

  //     // log(productList[0]["note"]);
  //     print(data);
  //     //  baisicDetailView2();
  //   } else {}
  // }

  getReport() async {
    print("hii");
    log(widget.party.toString());
    String s = widget.party;
    log(s.toString());
    //log(widget.ids);
    http.Response response = await http.get(
      Uri.parse(urlMain +
          'api/resource/Payment Entry?filters=[["party","=","$s"]]&fields=["*"]'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Tocken,
      },
    );
    print("jjjjjjjjjjjjj");
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      String data = response.body.toString();
      log(response.statusCode.toString());
      log(data);
      setState(() {
        collectioArray = jsonDecode(data)["data"];
      });
    }
  }

  // detailinvoceView() async {
  //   log(widget.ids.toString());
  //   print("object");
  //   var s = widget.ids;
  //   // var Tocken;
  //   http.Response response = await http.get(
  //     Uri.parse(
  //         'https://lamit.erpeaz.com/api/resource/Sales Invoice?filters=[["lead_id", "=", "$s"]]&fields=["customer","name","posting_date","grand_total","outstanding_amount"]'),
  //     headers: {
  //       'Content-type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': Tocken,
  //     },
  //   );
  //   log(response.body);
  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     String data = response.body;
  //     setState(() {
  //       //baisicDetail = jsonDecode(data)["data"];
  //       productlistsaleinvo = jsonDecode(data)["data"];
  //     });

  //     // log(productList[0]["note"]);
  //     print(data);
  //     //  baisicDetailView2();
  //   } else {}
  // }
}

class HeadingText extends StatelessWidget {
  final String? name;
  HeadingText(this.name);
  @override
  Widget build(BuildContext context) {
    return Text(
      name!,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
    );
  }
}

class ListText extends StatelessWidget {
  final String? name;
  ListText(this.name);
  @override
  Widget build(BuildContext context) {
    return Text(
      name!,
      style: TextStyle(color: Colors.blue),
    );
  }
}
