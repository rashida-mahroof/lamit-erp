import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';

import 'package:http/http.dart' as http;
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:lamit/app/modules/addtaskdash/views/addtaskdash_view.dart';
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/tocken/tockn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../widget/customeappbar.dart';

class TaskmainviewView extends StatefulWidget {
  const TaskmainviewView({Key? key}) : super(key: key);

  @override
  State<TaskmainviewView> createState() => _TaskmainviewViewState();
}

class _TaskmainviewViewState extends State<TaskmainviewView> {
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
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight),
        child: CustomAppBar(
          title: 'DAILY TASK',
        ),
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
                                                      const EdgeInsets.all(8.0),
                                                  child: GestureDetector(
                                                    onTap: (() {
                                                      productLis[index]["status"] == "Closed"
                                                          ? ""
                                                          : Get.to(AddtaskdashView(
                                                              productLis[index]["lead_name"] == null
                                                                  ? "Customer"
                                                                  : "Lead",
                                                              "Closed",
                                                              productLis[index]["name"] == null
                                                                  ? productLis[index]
                                                                      ["name"]
                                                                  : productLis[index]["name"]
                                                                      .toString(),
                                                              productLis[index]["select_lead_name"] == "null"
                                                                  ? productLis[index][
                                                                      "select_customer"]
                                                                  : productLis[index][
                                                                      "select_lead_name"],
                                                              productLis[index]["due_date"] == null
                                                                  ? ""
                                                                  : productLis[index]
                                                                      [
                                                                      "due_date"],
                                                              productLis[index]["task_type"] == null
                                                                  ? ""
                                                                  : productLis[index]
                                                                      ["task_type"],
                                                              productLis[index]["from_time"] == null ? "" : productLis[index]["from_time"],
                                                              productLis[index]["subject"] == null ? "" : productLis[index]["subject"]));
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
                                                                  Container(
                                                                    width: 250,
                                                                    child: Text(
                                                                      productLis[index]["subject"] ==
                                                                              "null"
                                                                          ? ""
                                                                          : "Subject : " +
                                                                              productLis[index]["subject"].toUpperCase(),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                      maxLines:
                                                                          2,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  
                                                                  Row(
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(right: 3.0),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .timer,
                                                                          size:
                                                                              18,
                                                                          color: Colors
                                                                              .grey
                                                                              .shade400,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        "Scheduled Time :" +
                                                                            productLis[index]["contact_time_in_hour"] +
                                                                            " : " +
                                                                            productLis[index]["contact_time_in_min"] +
                                                                            " " +
                                                                            productLis[index]["time2"],
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
                                                                  SizedBox(
                                                                    height: 3,
                                                                  ),
                                                                  productLis[index]["mobile"]
                                                                              .toString() ==
                                                                          "null"
                                                                      ? Container()
                                                                      : Row(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 3.0),
                                                                              child: Icon(
                                                                                Icons.phone,
                                                                                size: 18,
                                                                                color: Colors.grey.shade400,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              productLis[index]["mobile"].toString() == "null" ? "" : "Phone: " + productLis[index]["mobile"].toString(),
                                                                              style: TextStyle(fontSize: 11, color: Color.fromARGB(255, 4, 52, 91), fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                  SizedBox(
                                                                    height: 3,
                                                                  ),
                                                                  productLis[index]["lead_name"]
                                                                              .toString() ==
                                                                          "null"
                                                                      ? Container()
                                                                      : Row(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 3.0),
                                                                              child: Icon(
                                                                                Icons.person,
                                                                                size: 18,
                                                                                color: Colors.grey.shade400,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              productLis[index]["lead_name"].toString() == "null" ? "" : 'Lead name: ' + productLis[index]["lead_name"].toString(),
                                                                              style: TextStyle(fontSize: 11, color: Color.fromARGB(255, 4, 52, 91), fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                  SizedBox(
                                                                    height: 3,
                                                                  ),
                                                                  productLis[index]["customer_name"]
                                                                              .toString() ==
                                                                          "null"
                                                                      ? Container()
                                                                      : Row(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 3.0),
                                                                              child: Icon(
                                                                                Icons.verified_user,
                                                                                size: 18,
                                                                                color: Colors.grey.shade400,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              productLis[index]["customer_name"].toString() == "null" ? "" : "Customer name: " + "" + productLis[index]["customer_name"].toString(),
                                                                              style: TextStyle(fontSize: 11, color: Color.fromARGB(255, 4, 52, 91), fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                  SizedBox(
                                                                    height: 3,
                                                                  ),
                                                                  productLis[index]["lead_location"]
                                                                              .toString() ==
                                                                          "null"
                                                                      ? Container()
                                                                      : Row(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 3.0),
                                                                              child: Icon(
                                                                                Icons.location_pin,
                                                                                size: 18,
                                                                                color: Colors.grey.shade400,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              productLis[index]["lead_location"].toString() == "null" ? "" : "lead location: " + "" + productLis[index]["lead_location"].toString(),
                                                                              style: TextStyle(fontSize: 11, color: Color.fromARGB(255, 4, 52, 91), fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                  SizedBox(
                                                                    height: 3,
                                                                  ),
                                                                  productLis[index]["customer_location"]
                                                                              .toString() ==
                                                                          "null"
                                                                      ? Container()
                                                                      : Row(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 3.0),
                                                                              child: Icon(
                                                                                Icons.location_pin,
                                                                                size: 18,
                                                                                color: Colors.grey.shade400,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              productLis[index]["customer_location"].toString() == "null" ? "" : "customer location: " + "" + productLis[index]["customer_location"].toString(),
                                                                              style: TextStyle(fontSize: 11, color: Color.fromARGB(255, 4, 52, 91), fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                  SizedBox(
                                                                    height: 3,
                                                                  ),
                                                                  productLis[index]["lead_souce"]
                                                                              .toString() ==
                                                                          "null"
                                                                      ? Container()
                                                                      : Row(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 3.0),
                                                                              child: Icon(
                                                                                Icons.source,
                                                                                size: 18,
                                                                                color: Colors.grey.shade400,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              productLis[index]["lead_souce"].toString() == "null" ? "" : "lead souce : " + "" + productLis[index]["lead_souce"].toString(),
                                                                              style: TextStyle(fontSize: 11, color: Color.fromARGB(255, 4, 52, 91), fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                  SizedBox(
                                                                    height: 3,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 3,
                                                                  ),
                                                                  productLis[index]["customer_source"]
                                                                              .toString() ==
                                                                          "null"
                                                                      ? Container()
                                                                      : Row(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 3.0),
                                                                              child: Icon(
                                                                                Icons.source,
                                                                                size: 18,
                                                                                color: Colors.grey.shade400,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              productLis[index]["customer_source"].toString() == "null" ? "" : "customer source : " + "" + productLis[index]["customer_source"].toString(),
                                                                              style: TextStyle(fontSize: 11, color: Color.fromARGB(255, 4, 52, 91), fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                  SizedBox(
                                                                    height: 3,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(right: 3.0),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .hourglass_bottom,
                                                                          size:
                                                                              18,
                                                                          color: Colors
                                                                              .grey
                                                                              .shade400,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        productLis[index]["status"].toString() ==
                                                                                "null"
                                                                            ? ""
                                                                            : "Status : " +
                                                                                productLis[index]["status"].toString(),
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
                                                            ],
                                                          ),

                                                          subtitle: Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    Container(),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    Container(),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    // Get.to(LeaddetailsView(
                                                                    //   productList[index]["lead_name"],
                                                                    //   productList[index]["status"],
                                                                    //   0,
                                                                    //   "",
                                                                    //   productList[index]["email"],
                                                                    //   productList[index]["name"],
                                                                    //  ));
                                                                  },
                                                                  child: productLis[index]
                                                                              [
                                                                              "status"] ==
                                                                          "Closed"
                                                                      ? Container()
                                                                      : Container(
                                                                          child: Container(
                                                                              child: Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                TextButton(
                                                                              onPressed: (() {
                                                                                Get.to(AddtaskdashView(productLis[index]["lead_name"] == null ? "Customer" : "Lead", "Closed", productLis[index]["name"] == null ? productLis[index]["name"] : productLis[index]["name"].toString(), productLis[index]["select_lead_name"] == "null" ? productLis[index]["select_customer"] : productLis[index]["select_lead_name"], productLis[index]["due_date"] == null ? "" : productLis[index]["due_date"], productLis[index]["task_type"] == null ? "" : productLis[index]["task_type"], productLis[index]["from_time"] == null ? "" : productLis[index]["from_time"], productLis[index]["subject"] == null ? "" : productLis[index]["subject"]));
                                                                              }),
                                                                              child: Text("Close", style: TextStyle(color: Color.fromARGB(255, 2, 24, 41), fontSize: 14)),
                                                                            ),
                                                                          )),
                                                                        ),
                                                                ),
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
    );
  }

  Taskview() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    log(id.toString());
    log(formattedDate.toString());
    var a = "$id";
    http.Response response = await http.get(
        Uri.parse(urlMain +
            'api/resource/Task?fields=["status","task_type","from_time","select_customer","select_lead_name","due_date","lead_name","customer_name","name","mobile","subject","contact_time_in_hour","contact_time_in_min","time2","lead_name","customer_name","lead_location","customer_location","lead_souce","customer_source"]&filters=[["due_date","=","$formattedDate"],["sales_officer2","=","$id"]]&limit=100000&order_by=creation%20desc'),
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
