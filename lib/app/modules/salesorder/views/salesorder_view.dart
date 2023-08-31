import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:lamit/app/modules/salesordercreate/views/salesordercreate_view.dart';
import 'package:lamit/app/modules/salesview/views/salesview_view.dart';
import 'package:lamit/app/routes/constants.dart';
import 'package:http/http.dart' as http;
import 'package:lamit/tocken/config/url.dart';

import 'package:lamit/tocken/tockn.dart';

class SalesorderView extends StatefulWidget {
  final String leadtok;
  final String customer;

  const SalesorderView(this.leadtok, this.customer);

  @override
  State<SalesorderView> createState() => _SalesorderViewState();
}

class _SalesorderViewState extends State<SalesorderView> {
  var productlist = [];
  @override
  void initState() {
    detailinvoceView();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Stack(
        children: [
          Container(
            height: Constants(context).scrnHeight,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    color: HexColor("#F9F9F9"),
                    child: Column(children: [
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: GestureDetector(
                      //     onTap: (() {
                      //       // var i;
                      //       // for (var i = 0; i < productList.length; i++) {
                      //       //   productList[i];
                      //       // }
                      //       Get.to(SalesordercreateView(
                      //           widget.leadtok, widget.customer));
                      //     }),
                      //     child: Container(
                      //       child: Row(
                      //         children: [
                      //           Icon(Icons.add_outlined),
                      //           Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: Text(
                      //               "ADD SALES ORDER",
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

                      Container(
                        child: Container(
                          height: Constants(context).scrnHeight - 190,
                          width: Constants(context).scrnWidth,
                          child: ListView.builder(
                              itemCount: productlist.length,
                              itemBuilder: ((context, index) {
                                return GestureDetector(
                                  onTap: (() {
                                    Get.to(SalesviewView(
                                        productlist[index]["name"],
                                        widget.customer,
                                        widget.leadtok));
                                  }),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              //mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text("Cusomer name"),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text("Mobile no"),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text("Total Amount"),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text("Tax Amount"),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text("Grand total"),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child:
                                                      Text("Transaction Date"),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text("Status"),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text("Locations"),
                                                ),
                                                // if (productlist[index]
                                                //         ["note"] !=
                                                //     null)
                                                //   Padding(
                                                //     padding:
                                                //         const EdgeInsets.all(
                                                //             8.0),
                                                //     child: Text("Note"),
                                                //   ),
                                              ],
                                            ),
                                            Column(
                                              //mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(":"),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(":"),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(":"),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(":"),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(":"),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(":"),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(":"),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(":"),
                                                ),
                                                // if (productlist[index]
                                                //         ["note"] !=
                                                //     null)
                                                //   Padding(
                                                //     padding:
                                                //         const EdgeInsets.all(
                                                //             8.0),
                                                //     child: Text(":"),
                                                //   ),
                                              ],
                                            ),
                                            Column(
                                              //mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(productlist[index]
                                                              ["customer"] ==
                                                          null
                                                      ? ""
                                                      : productlist[index]
                                                              ["customer"]
                                                          .toString()),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(productlist[index]
                                                          ["mobile_no"]
                                                      .toString()),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(productlist[index]
                                                          ["total"]
                                                      .toString()),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(productlist[index]
                                                          [
                                                          "total_taxes_and_charges"]
                                                      .toString()),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(productlist[index]
                                                          ["grand_total"]
                                                      .toString()),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(productlist[index]
                                                          ["transaction_date"]
                                                      .toString()),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(productlist[index]
                                                          ["status"]
                                                      .toString()),
                                                ),
                                                if(productlist[index]
                                                          ["customer_location"]!=null)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(productlist[index]
                                                          ["customer_location"]
                                                      .toString()),
                                                ),
                                                // if (productlist[index]
                                                //         ["note"] !=
                                                //     null)
                                                //   Padding(
                                                //     padding:
                                                //         const EdgeInsets.all(
                                                //             8.0),
                                                //     child: Container(
                                                //       height: 150,
                                                //       width:
                                                //           MediaQuery.of(context)
                                                //                   .size
                                                //                   .width /
                                                //               2.5,
                                                //       child: Text(
                                                //         productlist[index]
                                                //                 ["note"]
                                                //             .toString(),
                                                //         overflow: TextOverflow
                                                //             .visible,
                                                //       ),
                                                //     ),
                                                //   ),
                                              
                                              ],
                                            ),

                                            //   Column(
                                            //     children: [
                                            //       GestureDetector(
                                            //         onTap: () {
                                            //           Get.to(SalesordercreateView(
                                            //               widget.leadtok,
                                            //               widget.customer));
                                            //           log(productlist[index]["name"]
                                            //               .toString());
                                            //           log(productlist[index]
                                            //                   ["customer"]
                                            //               .toString());
                                            //           // Get.to(
                                            //           // SalesinvoicereportView(
                                            //           //     productlist[index]["name"]
                                            //           //                 .toString() ==
                                            //           //             ""
                                            //           //         ? ""
                                            //           //         : productlist[index]["name"]
                                            //           //             .toString(),
                                            //           //     widget.seris.toString(),
                                            //           //     productlist[index]
                                            //           //                 ["customer"] ==
                                            //           //             ""
                                            //           //         ? ""
                                            //           //         : productlist[index]
                                            //           //                 ["customer"]
                                            //           //             .toString(),
                                            //           //     productlist[index]
                                            //           //                 ["customer"] ==
                                            //           //             ""
                                            //           //         ? ""
                                            //           //         : productlist[index]
                                            //           //                 ["customer"]
                                            //           //             .toString()),
                                            //           // );
                                            //         },
                                            //         child: Padding(
                                            //           padding: const EdgeInsets.only(
                                            //             top: 16.0,
                                            //           ),
                                            //           child: Container(
                                            //             child: Container(
                                            //                 child: Row(
                                            //               children: [
                                            //                 //Expanded(child: Container()),
                                            //                 Padding(
                                            //                   padding:
                                            //                       const EdgeInsets
                                            //                           .all(16.0),
                                            //                   child: Text(
                                            //                     "detail",
                                            //                     style: TextStyle(
                                            //                         color:
                                            //                             Colors.blue),
                                            //                   ),
                                            //                 ),
                                            //                 // Icon(
                                            //                 //   Icons.arrow_downward,
                                            //                 //   size: 12,
                                            //                 // ),
                                            //               ],
                                            //             )),
                                            //           ),
                                            //         ),
                                            //       ),
                                            //     ],
                                            //   ),
                                          ],
                                        ),

                                        // Padding(
                                        //   padding: const EdgeInsets.symmetric(
                                        //       horizontal: 10.0),
                                        //   child: Text(
                                        //     'Note                          :     ' +
                                        //         productlist[index]["note"],
                                        //     style: TextStyle(
                                        //         color: Colors.black54),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                );
                              })),
                        ),
                      )
                    ])),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  detailinvoceView() async {
    print("object");
    var s = widget.leadtok;
    log(s + ",nsbhwvcxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    // var Tocken;
    http.Response response = await http.get(
      Uri.parse(urlMain +
          'api/resource/Sales Order?filters=[["lead_id", "=", "$s"]]&fields=["*"]&limit=100000&order_by=creation%20desc'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Tocken,
      },
    );
    log(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      String data = response.body;
      setState(() {
        //baisicDetail = jsonDecode(data)["data"];
        productlist = jsonDecode(data)["data"];
      });
      log(productlist.toString() + "bvgvgbbgvgvvbvvv");
      // log(productList[0]["note"]);
      print(data);
      //  baisicDetailView2();
    } else {}
  }
}
