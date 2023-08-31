import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lamit/tocken/config/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../tocken/tockn.dart';
import '../../addtaskdash/views/addtaskdash_view.dart';
import 'package:http/http.dart' as http;

class TaskstatusView extends StatefulWidget {
  @override
  State<TaskstatusView> createState() => _TaskstatusViewState();
}

class _TaskstatusViewState extends State<TaskstatusView> {
  @override
  var productLis;
  String? id;
  getsf() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      id = preferences.getString("userid");
    });

    Taskview();

    print(id.toString());

    // newleadView(id.toString());
  }

  @override
  void initState() {
    getsf();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: Container(
      //   height: 70,
      //   decoration: BoxDecoration(
      //     color: Color.fromARGB(255, 4, 7, 105),
      //     // borderRadius: const BorderRadius.only(
      //     //   topLeft: Radius.circular(60),
      //     //   topRight: Radius.circular(60),
      //     // ),
      //   ),
      //   child: Container(height: 70),
      //   //   child: Container(
      //   //     child: BottomNavigationBar(
      //   //       unselectedItemColor: Colors.white,
      //   //       selectedItemColor: Colors.grey,
      //   //       backgroundColor: Color.fromARGB(255, 4, 7, 105),
      //   //       onTap: onTabTapped,
      //   //       currentIndex: _index,
      //   //       items: [
      //   //         BottomNavigationBarItem(
      //   //           icon: Icon(Icons.dashboard),
      //   //           label: 'Dashboard',
      //   //         ),
      //   //         // BottomNavigationBarItem(
      //   //         //   icon: Icon(Icons.leaderboard),
      //   //         //   label: 'Lead',
      //   //         // ),
      //   //         BottomNavigationBarItem(
      //   //           icon: GestureDetector(
      //   //             onTap: (() {
      //   //               Get.to(HomeView("isedit"));
      //   //             }),
      //   //             child: Container(
      //   //               child: Icon(
      //   //                 Icons.event,
      //   //               ),
      //   //             ),
      //   //           ),
      //   //           label: 'Events',
      //   //         )
      //   //       ],
      //   //     ),
      //   //   ),
      // ),

      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(),
      //   child: CircleAvatar(
      //     backgroundColor: Colors.white,
      //     radius: 40,
      //     child: Container(
      //         color: Colors.white,
      //         child: FloatingActionButton(
      //             backgroundColor: Color.fromARGB(255, 4, 7, 105),
      //             child: Icon(Icons.close),
      //             onPressed: () {
      //               Get.to(HomeView(""));
      //             })),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: Column(
      //   children: [
      //     // Expanded(
      //     //   child: Container(),
      //     // ),
      //     Expanded(child: Container()),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Row(
      //         children: [
      //           Expanded(child: Container()),
      //           FloatingActionButton(
      //             // isExtended: true,
      //             child: Icon(Icons.add),
      //             backgroundColor: Colors.blue,
      //             onPressed: () {
      //               Get.to(LeadaddView());
      //             },
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        title: const Text(
          'TASK VIEW',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 5, 51, 88)),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        //centerTitle: true,
      ),
      body:
          //  productList.length == 0
          //     ?
          // Container(
          //     color: Colors.grey[50],
          //     child: Center(
          //       child: new Container(
          //           width: 100.00,
          //           height: 100.00,
          //           decoration: new BoxDecoration(
          //             image: new DecorationImage(
          //               image: ExactAssetImage('assets/2.gif'),
          //               fit: BoxFit.fitHeight,
          //             ),
          //           )),
          //     ),
          //   )
          productLis == null
              ? Container()
              : Container(
                  color: Colors.grey[50],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        // Expanded(child: _children[_index]),
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: ListView.builder(
                                    itemCount: productLis.length,
                                    itemBuilder: ((context, index) {
                                      return Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Card(
                                              // shape: RoundedRectangleBorder(
                                              //     borderRadius: BorderRadius.only(
                                              //         topLeft: Radius.circular(20),
                                              //         topRight: Radius.circular(20),
                                              //         bottomLeft:
                                              //             Radius.circular(20),
                                              //         bottomRight:
                                              //             Radius.circular(20))),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: GestureDetector(
                                                      onTap: (() {
                                                        Get.to(AddtaskdashView(
                                                            productLis[index]["lead_name"] == null
                                                                ? "Customer"
                                                                : "Lead",
                                                            "Closed",
                                                            productLis[index]["lead_name"] == null
                                                                ? productLis[index]
                                                                    ["name"]
                                                                : productLis[index]["lead_name"]
                                                                    .toString(),
                                                            productLis[index]["select_lead_name"] ==
                                                                    "null"
                                                                ? productLis[index][
                                                                    "select_custome"]
                                                                : productLis[index][
                                                                    "select_lead_name"],
                                                            productLis[index]["due_date"] == null
                                                                ? ""
                                                                : productLis[index]
                                                                    [
                                                                    "due_date"],
                                                            productLis[index]["task_type"] ==
                                                                    null
                                                                ? ""
                                                                : productLis[index]
                                                                    ["task_type"],
                                                            productLis[index]["from_time"] == null ? "" : productLis[index]["from_"],
                                                            productLis[index]["subject"] == null ? "" : productLis[index]["subject"]));

                                                        // contact_date
                                                        // Get.to(LeaddetailsView(
                                                        //   productList[index]
                                                        //       ["first_name"],
                                                        //   productList[index]
                                                        //       ["status"],
                                                        //   0,
                                                        //   "",
                                                        //   productList[index]
                                                        //       ["email"],
                                                        //   productList[index]
                                                        //       ["name"],
                                                        // ));
                                                      }),
                                                      child: Container(
                                                        child: Container(
                                                          // height: 200,
                                                          child: ListTile(
                                                            title: Row(
                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      productLis[index]["subject"] ==
                                                                              "null"
                                                                          ? ""
                                                                          : productLis[index]["subject"]
                                                                              .toUpperCase()
                                                                      // productList[index]["first_name"]
                                                                      // controller
                                                                      //     .productList[index]["name"]
                                                                      //     .value[index],
                                                                      //"hhh"
                                                                      //  controller.productList[index],
                                                                      // "ggg",
                                                                      ,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              11,
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                      productLis[index]["contact_time_in_hour"] +
                                                                          " : " +
                                                                          productLis[index]
                                                                              [
                                                                              "contact_time_in_min"] +
                                                                          " " +
                                                                          productLis[index]
                                                                              [
                                                                              "time2"],
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              11,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              4,
                                                                              52,
                                                                              91),
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    Text(
                                                                      productLis[index]["mobile"] ==
                                                                              null
                                                                          ? ""
                                                                          : productLis[index]
                                                                              [
                                                                              "mobile"],
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              11,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              4,
                                                                              52,
                                                                              91),
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),

                                                            subtitle: Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      Container(),
                                                                ),
                                                                Container(
                                                                  child:
                                                                      Container(
                                                                          child:
                                                                              Column(
                                                                    children: [
                                                                      TextButton(
                                                                        onPressed:
                                                                            (() {
                                                                          Get.to(AddtaskdashView(
                                                                              productLis[index]["lead_name"] == null ? "Customer" : "Lead",
                                                                              "Closed",
                                                                              productLis[index]["lead_name"] == null ? productLis[index]["name"] : productLis[index]["lead_name"].toString(),
                                                                              productLis[index]["select_lead_name"] == "null" ? productLis[index]["select_custome"] : productLis[index]["select_lead_name"],
                                                                              productLis[index]["due_date"] == null ? "" : productLis[index]["due_date"],
                                                                              productLis[index]["task_type"] == null ? "" : productLis[index]["task_type"],
                                                                              productLis[index]["from_time"] == null ? "" : productLis[index]["from_"],
                                                                              productLis[index]["subject"] == null ? "" : productLis[index]["subject"]));
                                                                        }),
                                                                        child: Text(
                                                                            "    Status " + ":" + productLis[index]["status"] == "null"
                                                                                ? ""
                                                                                : productLis[index]["status"],
                                                                            style: TextStyle(color: Color.fromARGB(255, 2, 24, 41), fontSize: 10)),
                                                                      ),

                                                                      productLis[index]["status"] ==
                                                                              "Closed"
                                                                          ? Container()
                                                                          : TextButton(
                                                                              onPressed: (() {
                                                                                Get.to(AddtaskdashView(productLis[index]["lead_name"] == null ? "Customer" : "Lead", "Closed", productLis[index]["lead_name"] == null ? productLis[index]["name"] : productLis[index]["lead_name"].toString(), productLis[index]["select_lead_name"] == "null" ? productLis[index]["select_custome"] : productLis[index]["select_lead_name"], productLis[index]["due_date"] == null ? "" : productLis[index]["due_date"], productLis[index]["task_type"] == null ? "" : productLis[index]["task_type"], productLis[index]["from_time"] == null ? "" : productLis[index]["from_"], productLis[index]["subject"] == null ? "" : productLis[index]["subject"]));
                                                                              }),
                                                                              child: Text("    Tap to close", style: TextStyle(color: Color.fromARGB(255, 2, 24, 41), fontSize: 14)),
                                                                            ),
                                                                      // Icon(
                                                                      //   Icons.arrow_downward,
                                                                      //   size: 12,
                                                                      // ),
                                                                    ],
                                                                  )),
                                                                ),
                                                              ],
                                                            ),

                                                            //   subtitle:
                                                            //       Column(
                                                            //     crossAxisAlignment:
                                                            //         CrossAxisAlignment
                                                            //             .start,
                                                            //     children: [
                                                            //       Row(
                                                            //         children: [
                                                            //           Expanded(
                                                            //             flex: 2,
                                                            //             child: Container(
                                                            //               decoration: BoxDecoration(
                                                            //                   color: Colors.blue[900],
                                                            //                   border: Border.all(

                                                            //                       // color: Colors.red[500],
                                                            //                       ),
                                                            //                   borderRadius: BorderRadius.all(Radius.circular(10))),
                                                            //               height: 40,
                                                            //               // width:
                                                            //               //     100,
                                                            //               child: Container(
                                                            //                 //  width: 50,
                                                            //                 child: Center(
                                                            //                   child: Text(
                                                            //                     productList[index]["source"] == null ? "" : productList[index]["source"],
                                                            //                     style: TextStyle(color: Colors.white, fontSize: 12),
                                                            //                   ),
                                                            //                 ),
                                                            //               ),
                                                            //             ),
                                                            //           ),
                                                            //           Expanded(
                                                            //             flex: 3,
                                                            //             child: Padding(
                                                            //               padding: const EdgeInsets.all(8.0),
                                                            //               child: Container(
                                                            //                 decoration: BoxDecoration(
                                                            //                     color: Colors.green,
                                                            //                     border: Border.all(

                                                            //                         // color: Colors.red[500],
                                                            //                         ),
                                                            //                     borderRadius: BorderRadius.all(Radius.circular(10))),
                                                            //                 height: 40,
                                                            //                 // width:
                                                            //                 //     100,
                                                            //                 child: Container(
                                                            //                   //width: 50,
                                                            //                   child: Center(
                                                            //                     child: Text(
                                                            //                       productList[index]["status"] == "" ? "" : productList[index]["status"],
                                                            //                       style: TextStyle(color: Colors.white),
                                                            //                     ),
                                                            //                   ),
                                                            //                 ),
                                                            //               ),
                                                            //             ),
                                                            //           ),
                                                            //           Expanded(
                                                            //             flex: 2,
                                                            //             child: Container(
                                                            //               decoration: BoxDecoration(
                                                            //                   //color: Colors.blue[900],

                                                            //                   // color: Colors.red[500],

                                                            //                   borderRadius: BorderRadius.all(Radius.circular(20))),
                                                            //               // height:
                                                            //               //     30,
                                                            //               // width:
                                                            //               //     100,
                                                            //               child: Container(
                                                            //                   // width: 50,
                                                            //                   ),
                                                            //             ),
                                                            //           ),
                                                            //         ],
                                                            //       ),
                                                            //       Row(
                                                            //         children: [
                                                            //           Text(productList[index]["location"] == null
                                                            //               ? "Update ur address"
                                                            //               : productList[index]["location"]),
                                                            //           Expanded(child: Container()),
                                                            //           Icon(Icons.delete),
                                                            //         ],
                                                            //       ),
                                                            //       // Container(
                                                            //       //     height:
                                                            //       //         30,
                                                            //       //     width:
                                                            //       //         200,
                                                            //       //     child:
                                                            //       //         Container(
                                                            //       //       decoration: BoxDecoration(
                                                            //       //           color: Colors.red,

                                                            //       //           // border: Border.all(
                                                            //       //           // //  color: Colors.red[500],
                                                            //       //           // ),
                                                            //       //           borderRadius: BorderRadius.all(Radius.circular(10))),
                                                            //       //       child: Center(child: Text("Next meeting :" + productList[index]["next_contact_date"] == "" ? "Not updated" : productList[index]["next_contact_date"].toString())),
                                                            //       //     )),
                                                            //     ],
                                                            //   ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    })),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
    );
  }

  Taskview() async {
    DateTime now = DateTime.now();

    ///String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    log(id.toString());
    //log(formattedDate.toString());
    var a = "$id";
    http.Response response = await http.get(
        Uri.parse(urlMain +
            'api/resource/Task?fields=["task_type","from_time","name","status","mobile","subject","contact_time_in_hour","contact_time_in_min","time2","lead_name","contact_to_time_in_hour","contact_to_time_in_min","time1"]&filters=[["assign","=","$id"]]'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': Tocken,
        });
    String data = response.body;

    log(data + "hmhghgggfgfggffffffffffffffffffffffffffffgff");
    setState(() {
      productLis = jsonDecode(data)["data"];
    });

    return null;
  }
}
