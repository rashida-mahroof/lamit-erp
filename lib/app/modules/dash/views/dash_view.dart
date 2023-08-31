import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:external_path/external_path.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lamit/app/modules/LeaveApplication/ViewLeaveApplication.dart';
import 'package:lamit/app/modules/asmquotation/quotation-view.dart';
import 'package:lamit/app/modules/closed/views/closed_view.dart';
import 'package:lamit/app/modules/converted-leads-view/contractorList.dart';
import 'package:lamit/app/modules/converted-leads-view/engineerList.dart';
import 'package:lamit/app/modules/converted-leads-view/shopList.dart';

import 'package:lamit/app/modules/newleads/views/newleads_view.dart';
import 'package:lamit/app/modules/opentask/views/opentask_view.dart';
import 'package:lamit/app/modules/overdue/views/overdue_view.dart';
import 'package:lamit/app/modules/taskmainview/views/taskmainview_view.dart';
import 'package:lamit/attendence.dart';
import 'package:lamit/attendencelist.dart';
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/globals.dart' as globals;
import 'package:open_filex/open_filex.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:http/http.dart' as http;
import 'package:lamit/app/modules/addtaskdash/views/addtaskdash_view.dart';

import 'package:lamit/app/modules/hotlead/views/hotlead_view.dart';
import 'package:lamit/app/modules/lead/views/lead_view.dart';
import 'package:lamit/app/modules/login/views/login_view.dart';

import 'package:lamit/app/routes/constants.dart';

import 'package:lamit/tocken/tockn.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../lead/views/lead-view-new.dart';

class DashView extends StatefulWidget {
  final String id;
  final String editid;

  const DashView(this.id, this.editid);

  @override
  State<DashView> createState() => _DashViewState();
}

class _DashViewState extends State<DashView> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  String? name;
  String? id;
  var laclist;
  var taski = [];
  var pat;
  var plist;
  var leadlist;
  String? salelistlist;
  var productListlea;
  List imgList = [
    Image.asset('Images/S1.png'),
    Image.asset('Images/S3.png'),
    Image.asset('Images/S2.png'),
  ];
  var productList;
  var productLis;
  var productListhot;
  var overdue = [];
  String? fullname;
  String? achive;
  var areaList = [];
  fetchLacs() async {
    var userId = globals.loginId;

    var baseUrl = urlMain +
        'api/resource/Assign Sale Area?filters=[["sales_officer", "=", "$userId"]]&limit=100000&order_by=creation%20desc';

    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    });

    if (response.statusCode == 200) {
      String data = response.body;
      //var jsonData;
      setState(() {
        // jsonData = json.decode(data)["data"];

        var lacList = jsonDecode(data)["data"];
        for (int i = 0; i < lacList.length; i++) {
          areaList.add(lacList[i]["name"]);
        }
        globals.aList = areaList;
        print(areaList.toString() + 'looo');
      });

      // custmearea(jsonDecode(data)["data"], cust);
      // log(jsonData.toString());
      // setState(() {});
    }
  }

  Taskview() async {
    DateTime now = DateTime.now();

    ///String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    log(id.toString() + 'idid');
    //log(formattedDate.toString());
    var a = globals.loginId;

    http.Response response = await http.get(
        Uri.parse(urlMain +
            'api/resource/Task?fields=["name","status","mobile","subject","contact_time_in_hour","contact_time_in_min","time2","lead_name","contact_to_time_in_hour","contact_to_time_in_min","time1"]&filters=[["status","=","Overdue"],["sales_officer2","=","$a"]]'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': Tocken,
        });
    log(response.body.toString() + '...response');
    String data = response.body;
    if (response.statusCode == 200) {
      log(data + "overdueeeee");
      setState(() {
        overdue = jsonDecode(data)["data"];
      });
    } else {
      print(response.statusCode.toString() + 'kllll');
    }

    return null;
  }

  var closed;
  closedTaskview() async {
    DateTime now = DateTime.now();

    ///String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    log(id.toString());
    //log(formattedDate.toString());
    var a = "$id";
    http.Response response = await http.get(
        Uri.parse(urlMain +
            'api/resource/Task?fields=["name","status","mobile","subject","contact_time_in_hour","contact_time_in_min","time2","lead_name","contact_to_time_in_hour","contact_to_time_in_min","time1"]&filters=[["status","=","Closed"],["sales_officer2","=","$id"]]'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': Tocken,
        });
    String data = response.body;

    log(data + "hmhghgggfgfggffffffffffffffffffffffffffffgff");
    setState(() {
      closed = jsonDecode(data)["data"];
    });

    return null;
  }

  var productlist;
  var openn;
  var complist;
  openTaskview() async {
    DateTime now = DateTime.now();

    ///String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    log(id.toString());
    //log(formattedDate.toString());
    var a = "$id";
    http.Response response = await http.get(
        Uri.parse(urlMain +
            'api/resource/Task?fields=["name","status","mobile","subject","contact_time_in_hour","contact_time_in_min","time2","lead_name","contact_to_time_in_hour","contact_to_time_in_min","time1"]&filters=[["status","=","Open"],["sales_officer2","=","$id"]]&limit=100000&'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': Tocken,
        });
    String data = response.body;

    log(data + "hmhghgggfgfggffffffffffffffffffffffffffffgff");
    setState(() {
      openn = jsonDecode(data)["data"];
    });

    return null;
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Do you want to exit an App?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),

                style: ElevatedButton.styleFrom(primary: Colors.blue),
                //return false when click on "NO"
                child: Text('No'),
              ),
              ElevatedButton(
                onPressed: () => SystemNavigator.pop(),

                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                //return true when click on "Yes"
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  @override
  void initState() {
    print('myrole: ' + globals.role);
    getsf();
    fetchLacs();
    name;
    id;
    setState(() {});

    super.initState();
  }

  var pdfData = ["mfmgm"];

  Widget build(BuildContext context) {
    DateTime _lastExitTime = DateTime.now();
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            // Color.fromARGB(255, 48, 1, 122)
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.white),
              accountName: Text(
                globals.name,
                //  name.toString(),
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              accountEmail: Text(
                globals.role,
                //id.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black45,
                    fontSize: 12),
              ),
              currentAccountPicture: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    height: 400,
                    width: 400,
                    child: Image.asset(
                      "assets/l.png",
                      height: 400,
                      width: 400,
                    )),
              ),
            ),

            ListTile(
              leading: Icon(
                Icons.mark_as_unread,
              ),
              title: const Text('Attendance'),
              onTap: () {
                Get.to(AttendencelistView(id.toString()));
                //  Navigator.pop(context);
                //
              },
            ),
            ListTile(
              leading: Icon(
                Icons.hot_tub,
              ),
              title: const Text('Hot lead'),
              onTap: () {
                Get.to(HotleadView());
                //  Navigator.pop(context);
                //
              },
            ),
            ListTile(
              leading: Icon(
                Icons.new_label,
              ),
              title: const Text('New lead'),
              onTap: () {
                Get.to(NewleadsView());
                //  Navigator.pop(context);
                //
              },
            ),

            ListTile(
              leading: Icon(
                Icons.leaderboard,
              ),
              title: const Text('Lead'),
              onTap: () {
                Get.to(LeadView());
                //  Navigator.pop(context);
                //
              },
            ),
            // if (globals.role == "Area Sales Manager")
            //   ListTile(
            //     leading: Icon(
            //       Icons.list_alt_outlined,
            //     ),
            //     title: const Text('Quotation'),
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => ASMQuotationView()));
            //       //  Navigator.pop(context);
            //       //
            //     },
            //   ),

            ListTile(
              leading: Icon(
                Icons.work_off,
              ),
              title: const Text('Leave Application'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewLeaveApplication()));
                //  Navigator.pop(context);
                //
              },
            ),
            ListTile(
              leading: Icon(
                Icons.engineering,
              ),
              title: const Text('Engineer'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EngineerListView()));
                //  Navigator.pop(context);
                //
              },
            ),
            ListTile(
              leading: Icon(
                Icons.construction,
              ),
              title: const Text('Contractor'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ContractorListView()));
                //  Navigator.pop(context);
                //
              },
            ),
            ListTile(
              leading: Icon(
                Icons.shop,
              ),
              title: const Text('Shop'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ShopListView()));
                //  Navigator.pop(context);
                //
              },
            ),
            // AboutListTile(
            //   // <-- SEE HERE
            //   // icon: Icon(
            //   //   Icons.info,
            //   // ),
            //   child: Column(
            //     children: [
            //       ListTile(
            //         leading: Icon(
            //           Icons.mark_as_unread,
            //         ),
            //         title: const Text('Attendence View'),
            //         onTap: () {
            //           Get.to(AttendencelistView());
            //           //  Navigator.pop(context);
            //           //
            //         },
            //       ),
            //     ],
            //   ),
            //   applicationName: 'My Cool App',
            //   applicationVersion: '1.0.25',
            //   applicationLegalese: '© 2019 Company',
            //   aboutBoxChildren: [
            //     ///Content goes here...
            //   ],
            // ),
          ],
        ),
      ),
      key: scaffoldKey,
      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[50],
        leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
              //
            }),
        title: Row(
          children: [
            Text(
              "DASHBOARD",
              style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 7, 38, 210),
                  fontWeight: FontWeight.bold),
            ),
            Expanded(child: Container()),
            GestureDetector(
              onTap: (() {
                //  exportPdf("ggh", "dfg");
                logout();
                // pdfl();
                // pdfl();
              }),
              child: Container(
                height: 30,
                child: Icon(
                  Icons.logout,
                  color: Colors.black,
                  size: 18,
                ),
              ),
            )
          ],
        ),
        actions: <Widget>[
          // IconButton(
          //     icon: Icon(FontAwesomeIcons.chartLine),
          //     onPressed: () {
          //       //
          //     }),
        ],
      ),
      body: productList == null
          ? Container()
          : productList == null
              ? Container()
              : SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: Constants(context).scrnHeight + 349,
                          //  width: Constants(context).scrnWidth,
                          //color: HexColor("#EEf3f9"),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0, right: 0),
                            child: Container(
                              // color: HexColor("#EEf3f9"),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // if (taski.length != 0)
                                    //   Padding(
                                    //     padding: const EdgeInsets.only(
                                    //       left: 8,
                                    //       right: 8,
                                    //     ),
                                    //     child: Column(
                                    //       crossAxisAlignment:
                                    //           CrossAxisAlignment.start,
                                    //       children: [
                                    //         Padding(
                                    //           padding:
                                    //               const EdgeInsets.all(8.0),
                                    //           child: Text(
                                    //             "TASK",
                                    //             style: TextStyle(
                                    //                 fontSize: 13,
                                    //                 fontWeight:
                                    //                     FontWeight.w600),
                                    //           ),
                                    //         ),
                                    //         SizedBox(
                                    //           height: 5,
                                    //         ),
                                    //         GestureDetector(
                                    //           onTap: () {
                                    //             Get.to(TaskstatusView());
                                    //           },
                                    //           child: Padding(
                                    //             padding:
                                    //                 const EdgeInsets.all(
                                    //                     8.0),
                                    //             child: Container(
                                    //                 height: Constants(
                                    //                             context)
                                    //                         .scrnHeight /
                                    //                     6.3,
                                    //                 child: Container(
                                    //                     width: Constants(
                                    //                             context)
                                    //                         .scrnWidth,
                                    //                     decoration:
                                    //                         BoxDecoration(
                                    //                             border:
                                    //                                 Border
                                    //                                     .all(
                                    //                               color: Colors
                                    //                                   .grey,
                                    //                             ),
                                    //                             borderRadius:
                                    //                                 BorderRadius.all(Radius.circular(
                                    //                                     20))),
                                    //                     child: Center(
                                    //                         child: Text(
                                    //                             "TASK LIST")))),
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),

                                    // SizedBox(
                                    //   height: 20,
                                    // ),
                                    productLis.length == 0 ||
                                            productLis == null ||
                                            productLis == "null" ||
                                            productLis.length == null
                                        ? Container()
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                left: 24.0, top: 15),
                                            child: Container(
                                              child: Text("DAILY TASK",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                    SizedBox(
                                      height: 10,
                                    ),

                                    productLis.length == 0
                                        ? Container()
                                        : GestureDetector(
                                            onTap: () {
                                              Get.to(TaskmainviewView());
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Container(
                                                // color: Color.fromARGB(
                                                // 255, 219, 237, 174),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade300),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    CarouselSlider.builder(
                                                      options: CarouselOptions(
                                                        height: 80.0,
                                                        enlargeCenterPage: true,
                                                        autoPlay: true,
                                                        aspectRatio: 16 / 9,
                                                        autoPlayCurve: Curves
                                                            .fastOutSlowIn,
                                                        enableInfiniteScroll:
                                                            true,
                                                        autoPlayAnimationDuration:
                                                            Duration(
                                                                milliseconds:
                                                                    400),
                                                        viewportFraction: 0.8,
                                                      ),
                                                      itemCount: productLis
                                                                  .length ==
                                                              null
                                                          ? 0
                                                          : productLis.length,
                                                      itemBuilder: ((context,
                                                          index, realIndex) {
                                                        return Card(
                                                          elevation: 0,
                                                          child: ListTile(
                                                            title: Text(
                                                              productLis[index]
                                                                  ["subject"],
                                                              style: TextStyle(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .deepPurple
                                                                      .shade900,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                              maxLines: 2,
                                                            ),
                                                            subtitle: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  productLis[index]
                                                                              [
                                                                              "lead_name"] ==
                                                                          null
                                                                      ? productLis[
                                                                              index]
                                                                          [
                                                                          "select_customer"]
                                                                      : productLis[
                                                                              index]
                                                                          [
                                                                          "lead_name"],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      color: Colors
                                                                          .black54,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                                if (productLis[
                                                                            index]
                                                                        [
                                                                        "mobile"] !=
                                                                    "null")
                                                                  Text(
                                                                    productLis[index]
                                                                            [
                                                                            "mobile"]
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            9,
                                                                        color: Colors
                                                                            .black45),
                                                                  )
                                                              ],
                                                            ),
                                                            trailing: Text(
                                                              productLis[index]
                                                                      [
                                                                      "contact_time_in_hour"] +
                                                                  " : " +
                                                                  productLis[
                                                                          index]
                                                                      [
                                                                      "contact_time_in_min"] +
                                                                  " " +
                                                                  productLis[
                                                                          index]
                                                                      ["time2"],
                                                              style: TextStyle(
                                                                  fontSize: 9,
                                                                  color: Colors
                                                                      .black45),
                                                            ),
                                                          ),
                                                        );
                                                        // return Container(
                                                        //   height: 400,
                                                        //   width: Constants(
                                                        //               context)
                                                        //           .scrnWidth +
                                                        //       600,
                                                        //   child: Column(
                                                        //     mainAxisAlignment:
                                                        //         MainAxisAlignment
                                                        //             .center,
                                                        //     crossAxisAlignment:
                                                        //         CrossAxisAlignment
                                                        //             .center,
                                                        //     children: [
                                                        //       SizedBox(
                                                        //         height: 0,
                                                        //       ),
                                                        //       Text(
                                                        //         productLis[index]["subject"] ==
                                                        //                 "null"
                                                        //             ? ""
                                                        //             : productLis[index]["subject"]
                                                        //                 .toUpperCase(),
                                                        //         style: TextStyle(
                                                        //             fontSize:
                                                        //                 10,
                                                        //             fontWeight:
                                                        //                 FontWeight
                                                        //                     .w600,
                                                        //             color: Colors
                                                        //                 .blue
                                                        //                 .shade900),
                                                        //       ),
                                                        //       Padding(
                                                        //         padding:
                                                        //             const EdgeInsets.all(
                                                        //                 8.0),
                                                        //         child:
                                                        //             Column(
                                                        //           children: [
                                                        //             Row(
                                                        //               mainAxisAlignment:
                                                        //                   MainAxisAlignment.center,
                                                        //               children: [
                                                        //                 Icon(
                                                        //                   Icons.timer,
                                                        //                   color: Colors.grey.shade400,
                                                        //                   size: 18,
                                                        //                 ),
                                                        //                 SizedBox(
                                                        //                   width: 6,
                                                        //                 ),
                                                        //                 Text(
                                                        //                   productLis[index]["contact_time_in_hour"] + " : " + productLis[index]["contact_time_in_min"] + " " + productLis[index]["time2"],
                                                        //                   style: TextStyle(fontSize: 12),
                                                        //                 ),
                                                        //               ],
                                                        //             ),
                                                        //             if (productLis[index]["mobile"] !=
                                                        //                 "null")
                                                        //               Padding(
                                                        //                 padding:
                                                        //                     const EdgeInsets.all(8.0),
                                                        //                 child:
                                                        //                     Row(
                                                        //                   mainAxisAlignment: MainAxisAlignment.center,
                                                        //                   children: [
                                                        //                     Icon(
                                                        //                       Icons.mobile_friendly,
                                                        //                       color: Colors.grey.shade400,
                                                        //                       size: 18,
                                                        //                     ),
                                                        //                     SizedBox(
                                                        //                       width: 6,
                                                        //                     ),
                                                        //                     Text(
                                                        //                       productLis[index]["mobile"].toString() == "null" ? "" : productLis[index]["mobile"].toString(),
                                                        //                       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                                                        //                     ),
                                                        //                   ],
                                                        //                 ),
                                                        //               ),
                                                        //             Row(
                                                        //               mainAxisAlignment:
                                                        //                   MainAxisAlignment.center,
                                                        //               children: [
                                                        //                 Icon(
                                                        //                   Icons.account_circle,
                                                        //                   color: Colors.grey.shade400,
                                                        //                   size: 18,
                                                        //                 ),
                                                        //                 SizedBox(
                                                        //                   width: 6,
                                                        //                 ),
                                                        //                 Text(
                                                        //                   productLis[index]["lead_name"] == null ? productLis[index]["select_customer"] : productLis[index]["lead_name"],
                                                        //                   style: TextStyle(fontSize: 12),
                                                        //                 ),
                                                        //               ],
                                                        //             ),
                                                        //           ],
                                                        //         ),
                                                        //       ),
                                                        //     ],
                                                        //   ),
                                                        // );
                                                      }),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                    // SizedBox(
                                    //   height: 20,
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 24.0, top: 5),
                                      child: Container(
                                        child: Text("MONTHLY SALE",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    SizedBox(
                                        //   height: 3,
                                        ),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 10),
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                child: Container(
                                                    color: Colors.grey[50],
                                                    height: 100,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0.0),
                                                      child: Card(
                                                          // color:
                                                          // Colors.amber[900],
                                                          child: Container(
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                            Text(
                                                              "TARGET",
                                                              style: TextStyle(
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            
                                                              Text( (salelistlist ==
                                                                    null ||
                                                                salelistlist ==
                                                                    "null")?'0':
                                                                '₹ ' +
                                                                    salelistlist
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                        .black54,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                          ],
                                                        ),
                                                      )),
                                                    )),
                                              ),
                                            )),
                                            Expanded(
                                                child: Container(
                                                    color: Colors.grey[50],
                                                    height: 100,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0.0),
                                                      child: Card(
                                                          // color: Colors
                                                          //     .deepPurple[900],
                                                          child: Container(
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                           
                                                              Text(
                                                                "ACHIEVED",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        11,
                                                                    color: Colors
                                                                        .black54,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              (achive ==
                                                                    null ||
                                                                achive ==
                                                                    "null")?'0':
                                                              '₹ ' +
                                                                  achive
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          ],
                                                        ),
                                                      )),
                                                    ))),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16),
                                          child: Text("LEAD VIEW",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Container(
                                        color: Colors.white,
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: Container(
                                              color: Colors.white,
                                            )),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      //height: Constants(context).scrnHeight,
                                      width: Constants(context).scrnWidth,
                                      decoration: BoxDecoration(
                                        // color: HexColor("#EEf3f9"),
                                        borderRadius: BorderRadius.only(

                                            //  topRight: Radius.circular(20.0),
                                            bottomRight: Radius.circular(30.0),
                                            bottomLeft: Radius.circular(30.0)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 100,
                                                width: Constants(context)
                                                    .scrnWidth,
                                                child: ListView(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.to(HotleadView());
                                                      },
                                                      child: Container(
                                                        // color: Colors.blue[50],
                                                        height: 40,
                                                        width: 100,
                                                        child: Card(
                                                            // color: Colors
                                                            //     .green[50],
                                                            child: Container(
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 25,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Container(
                                                                    child: Text(
                                                                  "HOT LEAD",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black54,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )),
                                                              ),
                                                              productListhot ==
                                                                      null
                                                                  ? Container()
                                                                  : Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              0.0),
                                                                      child: Container(
                                                                          child: Text(
                                                                        productListhot
                                                                            .length
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15,
                                                                            color:
                                                                                Colors.black54,
                                                                            fontWeight: FontWeight.bold),
                                                                      )),
                                                                    ),
                                                            ],
                                                          ),
                                                          // color: Colors.blue,
                                                        )),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.to(LeadView());
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        width: 110,
                                                        child: Card(
                                                            // color: Colors
                                                            //     .purple[50],
                                                            child: Container(
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 25,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Container(
                                                                    child: Text(
                                                                  "LEADS",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black54,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )),
                                                              ),
                                                              productListlea ==
                                                                      null
                                                                  ? Container()
                                                                  : Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              0.0),
                                                                      child: Container(
                                                                          child: Text(
                                                                        productListlea
                                                                            .length
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15,
                                                                            color:
                                                                                Colors.black54,
                                                                            fontWeight: FontWeight.bold),
                                                                      )),
                                                                    ),
                                                            ],
                                                          ),
                                                          // color: Colors.blue,
                                                        )),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.to(AddtaskdashView(
                                                            "",
                                                            "Open",
                                                            "",
                                                            "",
                                                            '',
                                                            "",
                                                            "",
                                                            ""));
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        width: 110,
                                                        child: Card(
                                                            // color: Colors
                                                            //     .amber[50],
                                                            child: Container(
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 25,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Container(
                                                                    child: Text(
                                                                  "ADD TASK",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black54,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        0.0),
                                                                child: Container(
                                                                    child: Text(
                                                                  '',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .black54,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )),
                                                              ),
                                                            ],
                                                          ),
                                                          // color: Colors.blue,
                                                        )),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              SizedBox(
                                                height: 10,
                                              ),
                                              productList.length == 0
                                                  ? Container()
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        child: Text("NEW LEADS",
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ),
                                              SizedBox(
                                                height: 10,
                                              ),

                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(NewleadsView());
                                                },
                                                child: Container(
                                                  height: productList.length ==
                                                          0
                                                      ? 0
                                                      : productList.length == 1
                                                          ? 100
                                                          : productList
                                                                      .length ==
                                                                  2
                                                              ? 150
                                                              : 200,
                                                  width: Constants(context)
                                                      .scrnWidth,
                                                  child: ListView.builder(
                                                      itemCount:
                                                          productList.length,
                                                      itemBuilder:
                                                          ((context, index) {
                                                        return Container(
                                                            height: 80,
                                                            child: Card(
                                                              // shape: Border(
                                                              //     left: BorderSide(
                                                              //         color: Colors
                                                              //             .purple
                                                              //             .shade900,
                                                              //         width:
                                                              //             5)),
                                                              color:
                                                                  Colors.white,
                                                              child: ListTile(
                                                                  title: Text(
                                                                    productList[index]
                                                                            [
                                                                            "lead_name"]
                                                                        .toUpperCase(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          11,
                                                                      color: Colors
                                                                          .black,
                                                                      // fontWeight:
                                                                      //     FontWeight
                                                                      //         .bold
                                                                    ),
                                                                  ),
                                                                  subtitle:
                                                                      Column(
                                                                    children: [
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Container(
                                                                        child:
                                                                            Row(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            // Expanded(
                                                                            //     child:
                                                                            //         Container(child: Text(""))),

                                                                            Text(
                                                                              "Click Detail",
                                                                              style: TextStyle(fontSize: 9, color: Colors.blue),
                                                                            ),
                                                                            // Icon(
                                                                            //   Icons.arrow_circle_down,
                                                                            //   size:
                                                                            //       12,
                                                                            // )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  trailing:
                                                                      Text(
                                                                    DateFormat(
                                                                            "dd-MM-y")
                                                                        .format(DateTime.parse(productList[index]
                                                                            [
                                                                            "date"]))
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  )),
                                                            ));
                                                      })),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              // productLis.length == 0
                                              //     ? Container()
                                              //     : GestureDetector(
                                              //         onTap: () {
                                              //           Get.to(NewleadsView());
                                              //         },
                                              //         child:
                                              //             productList.length == 0
                                              //                 ? Container()
                                              //                 : Container(
                                              //                     child: Row(
                                              //                       children: [
                                              //                         Expanded(
                                              //                             child: Container(
                                              //                                 child:
                                              //                                     Text(""))),
                                              //                         Text(
                                              //                           "VIEW MORE TAP HERE",
                                              //                           style: TextStyle(
                                              //                               fontSize:
                                              //                                   12,
                                              //                               color:
                                              //                                   Colors.blue),
                                              //                         ),
                                              //                         Icon(
                                              //                           Icons
                                              //                               .arrow_circle_down,
                                              //                           size: 12,
                                              //                         )
                                              //                       ],
                                              //                     ),
                                              //                   ),
                                              //       ),

                                              SizedBox(
                                                height: 10,
                                              ),
                                              // productLis.length == 0
                                              //     ? Container()
                                              //     : Padding(
                                              //         padding:
                                              //             const EdgeInsets.all(
                                              //                 8.0),
                                              //         child: Container(
                                              //           child: Text("DAILY TASK",
                                              //               style: TextStyle(
                                              //                   fontSize: 13,
                                              //                   color:
                                              //                       Colors.black,
                                              //                   fontWeight:
                                              //                       FontWeight
                                              //                           .bold)),
                                              //         ),
                                              //       ),
                                              // SizedBox(
                                              //   height: 10,
                                              // ),

                                              // Container(
                                              //   height: productLis.length == 0
                                              //       ? 0
                                              //       : productLis.length == 1
                                              //           ? 100
                                              //           : productLis.length == 2
                                              //               ? 150
                                              //               : 130,
                                              //   width:
                                              //       Constants(context).scrnWidth,
                                              //   child: ListView.builder(
                                              //       itemCount: productLis.length,
                                              //       itemBuilder:
                                              //           ((context, index) {
                                              //         return Container(
                                              //             height: 80,
                                              //             child: Card(
                                              //               child: Container(
                                              //                 child: ListTile(
                                              //                     title: Text(
                                              //                       productLis[index]
                                              //                               [
                                              //                               "lead_name"]
                                              //                           .toUpperCase()
                                              //                           .toString(),
                                              //                       style:
                                              //                           TextStyle(
                                              //                         fontWeight:
                                              //                             FontWeight
                                              //                                 .bold,
                                              //                         fontSize:
                                              //                             11,
                                              //                         color: Colors
                                              //                             .black,
                                              //                         // fontWeight:
                                              //                         //     FontWeight
                                              //                         //         .bold
                                              //                       ),
                                              //                     ),
                                              //                     subtitle:
                                              //                         Column(
                                              //                       children: [
                                              //                         SizedBox(
                                              //                           height:
                                              //                               30,
                                              //                         ),
                                              //                         Container(
                                              //                           child:
                                              //                               Row(
                                              //                             crossAxisAlignment:
                                              //                                 CrossAxisAlignment.start,
                                              //                             children: [
                                              //                               // Expanded(
                                              //                               //     child:
                                              //                               //         Container(child: Text(""))),

                                              //                               Text(
                                              //                                 "Click Detail",
                                              //                                 style:
                                              //                                     TextStyle(fontSize: 9, color: Colors.blue),
                                              //                               ),
                                              //                               // Icon(
                                              //                               //   Icons.arrow_circle_down,
                                              //                               //   size:
                                              //                               //       12,
                                              //                               // )
                                              //                             ],
                                              //                           ),
                                              //                         ),
                                              //                       ],
                                              //                     ),
                                              //                     trailing:
                                              //                         Column(
                                              //                       children: [
                                              //                         Text(
                                              //                           productLis[
                                              //                                   index]
                                              //                               [
                                              //                               "lead_location"],
                                              //                           style: TextStyle(
                                              //                               fontSize:
                                              //                                   12),
                                              //                         ),
                                              //                         Padding(
                                              //                           padding:
                                              //                               const EdgeInsets.all(
                                              //                                   8.0),
                                              //                           child:
                                              //                               Column(
                                              //                             children: [
                                              //                               Text(
                                              //                                 productLis[index]["contact_time"] +
                                              //                                     productLis[index]["time1"],
                                              //                                 style:
                                              //                                     TextStyle(fontSize: 12),
                                              //                               ),
                                              //                               // Text(
                                              //                               //   productLis[index]
                                              //                               //       [
                                              //                               //       "contact_time"],
                                              //                               //   style: TextStyle(
                                              //                               //       fontSize:
                                              //                               //           12),
                                              //                               // ),
                                              //                             ],
                                              //                           ),
                                              //                         ),
                                              //                       ],
                                              //                     )),
                                              //               ),
                                              //             ));
                                              //       })),
                                              // ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              // productLis.length == 0
                                              //     ? Container()
                                              //     : GestureDetector(
                                              //         onTap: () {
                                              //           Get.to(NewleadsView());
                                              //         },
                                              //         child:
                                              //             productLis.length == 0
                                              //                 ? Container()
                                              //                 : Container(
                                              //                     child: Row(
                                              //                       children: [
                                              //                         Expanded(
                                              //                             child: Container(
                                              //                                 child:
                                              //                                     Text(""))),
                                              //                         Text(
                                              //                           "VIEW MORE TAP HERE",
                                              //                           style: TextStyle(
                                              //                               fontSize:
                                              //                                   12,
                                              //                               color:
                                              //                                   Colors.blue),
                                              //                         ),
                                              //                         Icon(
                                              //                           Icons
                                              //                               .arrow_circle_down,
                                              //                           size: 12,
                                              //                         )
                                              //                       ],
                                              //                     ),
                                              //                   ),
                                              //       ),

                                              // // Row(
                                              //   children: [
                                              //     Column(
                                              //       crossAxisAlignment:
                                              //           CrossAxisAlignment.start,
                                              //       children: [
                                              //         Padding(
                                              //           padding:
                                              //               const EdgeInsets.only(left: 8),
                                              //           child: Text(
                                              //             "Good Afternoon",
                                              //             style: TextStyle(
                                              //               color: Color.fromARGB(
                                              //                   255, 7, 38, 210),
                                              //             ),
                                              //           ),
                                              //         ),
                                              //         Padding(
                                              //           padding: const EdgeInsets.all(8.0),
                                              //           child: Container(
                                              //             child: Text(
                                              //               name == null
                                              //                   ? ""
                                              //                   : name.toString(),
                                              //               style: TextStyle(
                                              //                 fontSize: 17,
                                              //                 fontWeight: FontWeight.bold,
                                              //                 color: Color.fromARGB(
                                              //                     255, 7, 38, 210),
                                              //               ),
                                              //             ),
                                              //           ),
                                              //         ),
                                              //       ],
                                              //     ),
                                              //     Expanded(child: Container()),
                                              //     Column(
                                              //       children: [
                                              //         Container(
                                              //           color: Colors.white,
                                              //           child: Padding(
                                              //             padding:
                                              //                 const EdgeInsets.only(top: 00),
                                              //             child: GestureDetector(
                                              //                 onTap: (() {
                                              //                   // logout();
                                              //                 }),
                                              //                 child: Center(
                                              //                   child: Container(
                                              //                     height: 60,
                                              //                     width: 80,
                                              //                     child: CircleAvatar(
                                              //                       backgroundImage: NetworkImage(
                                              //                           "https://lamit.erpeaz.com/files/A 7562  Shinil pp (1) copy.jpg"),
                                              //                       radius: 100,
                                              //                     ),
                                              //                   ),
                                              //                 )),
                                              //           ),
                                              //         ),
                                              //         Container(
                                              //           height: 20,
                                              //         ),
                                              //         // SizedBox(
                                              //         //   height: 20,
                                              //         // ),

                                              //         id == null
                                              //             ? Text("")
                                              //             : Text(
                                              //                 "Employee ID \n" +
                                              //                     id.toString(),
                                              //                 style: TextStyle(
                                              //                   color: Color.fromARGB(
                                              //                       255, 7, 38, 210),
                                              //                 ),
                                              //               ),
                                              //         Container()
                                              //       ],
                                              //     ),
                                              //   ],
                                              // ),
                                              // // SizedBox(
                                              // //   height: 10,
                                              // // ),

                                              SizedBox(
                                                height: 30,
                                              ),
                                              // Container(

                                              //   // decoration: BoxDecoration(
                                              //   //   color: Colors.white,
                                              //   //   borderRadius: BorderRadius.all(
                                              //   //     Radius.circular(100.0),
                                              //   // ),
                                              //   // ),
                                              //   height: 110,
                                              //   width: Constants(context).scrnWidth,
                                              //   child: Card(
                                              //     shape: RoundedRectangleBorder(
                                              //         //side: BorderSide(color: Colors.white70, width: 1),
                                              //         borderRadius:
                                              //             BorderRadius.circular(20)),
                                              //     color: Color.fromARGB(255, 4, 7, 105),
                                              //     child: Column(
                                              //       crossAxisAlignment:
                                              //           CrossAxisAlignment.center,
                                              //       children: [
                                              //         SizedBox(
                                              //           height: 20,
                                              //         ),
                                              //         Text(
                                              //           "CONGRAGULATION YOU ACHIVED",
                                              //           style: TextStyle(
                                              //               color: Colors.white,
                                              //               fontSize: 13.04),
                                              //         ),
                                              //         SizedBox(
                                              //           height: 5,
                                              //         ),
                                              //         Center(
                                              //           child: Container(
                                              //             child: Row(
                                              //               children: [
                                              //                 Text(
                                              //                     "                                       Rs:  ",
                                              //                     style: TextStyle(
                                              //                         color: Colors.white,
                                              //                         fontSize: 11,
                                              //                         fontWeight:
                                              //                             FontWeight.bold)),
                                              //                 Container(
                                              //                   child: Center(
                                              //                     child: Text(
                                              //                       "30,000",
                                              //                       style: TextStyle(
                                              //                           color: Colors.white,
                                              //                           fontSize: 17,
                                              //                           fontWeight:
                                              //                               FontWeight.bold),
                                              //                     ),
                                              //                   ),
                                              //                 ),
                                              //               ],
                                              //             ),
                                              //           ),
                                              //         ),
                                              //         SizedBox(
                                              //           height: 5,
                                              //         ),
                                              //         Text(
                                              //           "as incentive",
                                              //           style: TextStyle(color: Colors.white),
                                              //         ),
                                              //         SizedBox(
                                              //           height: 10,
                                              //         )
                                              //       ],
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16),
                                          child: Text("TASK VIEW",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Container(
                                        color: Colors.white,
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: Container(
                                              color: Colors.white,
                                            )),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      //height: Constants(context).scrnHeight,
                                      width: Constants(context).scrnWidth,
                                      decoration: BoxDecoration(
                                        // color: HexColor("#EEf3f9"),
                                        borderRadius: BorderRadius.only(

                                            //  topRight: Radius.circular(20.0),
                                            bottomRight: Radius.circular(30.0),
                                            bottomLeft: Radius.circular(30.0)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 100,
                                                width: Constants(context)
                                                    .scrnWidth,
                                                child: ListView(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.to(OpentaskView());
                                                      },
                                                      child: Container(
                                                        // color: Colors.blue[50],
                                                        height: 40,
                                                        width: 100,
                                                        child: Card(
                                                            // color: Colors
                                                            //     .amber[50],
                                                            child: Container(
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 25,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Container(
                                                                    child: Text(
                                                                  "OPEN",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black54,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )),
                                                              ),
                                                              openn == null
                                                                  ? Container()
                                                                  : Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child: Container(
                                                                          child: Text(
                                                                        openn
                                                                            .length
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.black54,
                                                                            fontWeight: FontWeight.bold),
                                                                      )),
                                                                    ),
                                                            ],
                                                          ),
                                                          // color: Colors.blue,
                                                        )),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.to(ClosedView());
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        width: 110,
                                                        child: Card(
                                                            // color:
                                                            //     Colors.red[50],
                                                            child: Container(
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 25,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Container(
                                                                    child: Text(
                                                                  "CLOSED",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black54,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )),
                                                              ),
                                                              closed == null
                                                                  ? Container()
                                                                  : Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child: Container(
                                                                          child: Text(
                                                                        closed
                                                                            .length
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.black54,
                                                                            fontWeight: FontWeight.bold),
                                                                      )),
                                                                    ),
                                                            ],
                                                          ),
                                                          // color: Colors.blue,
                                                        )),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.to(OverdueView());
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        width: 110,
                                                        child: Card(
                                                            // color:
                                                            //     Colors.blue[50],
                                                            child: Container(
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 25,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Container(
                                                                    child: Text(
                                                                  "OVERDUE",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black54,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Container(
                                                                    child: Text(
                                                                  overdue.length
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: Colors
                                                                          .black54,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800),
                                                                )),
                                                              ),
                                                            ],
                                                          ),
                                                          // color: Colors.blue,
                                                        )),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              // SizedBox(
                                              //   height: 10,
                                              // ),
                                              // productList.length == 0
                                              //     ? Container()
                                              //     : Padding(
                                              //         padding:
                                              //             const EdgeInsets
                                              //                 .all(8.0),
                                              //         child: Container(
                                              //           child: Text(
                                              //               "NEW LEADS",
                                              //               style: TextStyle(
                                              //                   fontSize:
                                              //                       13,
                                              //                   color: Colors
                                              //                       .black,
                                              //                   fontWeight:
                                              //                       FontWeight
                                              //                           .bold)),
                                              //         ),
                                              //       ),
                                              // SizedBox(
                                              //   height: 10,
                                              // ),

                                              // Container(
                                              //   height: productList
                                              //               .length ==
                                              //           0
                                              //       ? 0
                                              //       : productList.length ==
                                              //               1
                                              //           ? 100
                                              //           : productList
                                              //                       .length ==
                                              //                   2
                                              //               ? 150
                                              //               : 200,
                                              //   width: Constants(context)
                                              //       .scrnWidth,
                                              //   child: ListView.builder(
                                              //       itemCount:
                                              //           productList.length,
                                              //       itemBuilder:
                                              //           ((context, index) {
                                              //         return Container(
                                              //             height: 80,
                                              //             child: Card(
                                              //               child:
                                              //                   Container(
                                              //                 child: ListTile(
                                              //                     title: Text(
                                              //                       productList[index]["lead_name"]
                                              //                           .toUpperCase(),
                                              //                       style:
                                              //                           TextStyle(
                                              //                         fontWeight:
                                              //                             FontWeight.bold,
                                              //                         fontSize:
                                              //                             11,
                                              //                         color:
                                              //                             Colors.black,
                                              //                         // fontWeight:
                                              //                         //     FontWeight
                                              //                         //         .bold
                                              //                       ),
                                              //                     ),
                                              //                     subtitle: Column(
                                              //                       children: [
                                              //                         SizedBox(
                                              //                           height:
                                              //                               30,
                                              //                         ),
                                              //                         Container(
                                              //                           child:
                                              //                               Row(
                                              //                             crossAxisAlignment: CrossAxisAlignment.start,
                                              //                             children: [
                                              //                               // Expanded(
                                              //                               //     child:
                                              //                               //         Container(child: Text(""))),

                                              //                               Text(
                                              //                                 "Click Detail",
                                              //                                 style: TextStyle(fontSize: 9, color: Colors.blue),
                                              //                               ),
                                              //                               // Icon(
                                              //                               //   Icons.arrow_circle_down,
                                              //                               //   size:
                                              //                               //       12,
                                              //                               // )
                                              //                             ],
                                              //                           ),
                                              //                         ),
                                              //                       ],
                                              //                     ),
                                              //                     trailing: Text(
                                              //                       productList[index]
                                              //                           [
                                              //                           "date"],
                                              //                       style: TextStyle(
                                              //                           fontSize:
                                              //                               12),
                                              //                     )),
                                              //               ),
                                              //             ));
                                              //       })),
                                              // ),
                                              // SizedBox(
                                              //   height: 5,
                                              // ),
                                              // productLis.length == 0
                                              //     ? Container()
                                              //     : GestureDetector(
                                              //         onTap: () {
                                              //           Get.to(NewleadsView());
                                              //         },
                                              //         child:
                                              //             productList.length == 0
                                              //                 ? Container()
                                              //                 : Container(
                                              //                     child: Row(
                                              //                       children: [
                                              //                         Expanded(
                                              //                             child: Container(
                                              //                                 child:
                                              //                                     Text(""))),
                                              //                         Text(
                                              //                           "VIEW MORE TAP HERE",
                                              //                           style: TextStyle(
                                              //                               fontSize:
                                              //                                   12,
                                              //                               color:
                                              //                                   Colors.blue),
                                              //                         ),
                                              //                         Icon(
                                              //                           Icons
                                              //                               .arrow_circle_down,
                                              //                           size: 12,
                                              //                         )
                                              //                       ],
                                              //                     ),
                                              //                   ),
                                              //       ),

                                              SizedBox(
                                                height: 10,
                                              ),
                                              // productLis.length == 0
                                              //     ? Container()
                                              //     : Padding(
                                              //         padding:
                                              //             const EdgeInsets.all(
                                              //                 8.0),
                                              //         child: Container(
                                              //           child: Text("DAILY TASK",
                                              //               style: TextStyle(
                                              //                   fontSize: 13,
                                              //                   color:
                                              //                       Colors.black,
                                              //                   fontWeight:
                                              //                       FontWeight
                                              //                           .bold)),
                                              //         ),
                                              //       ),
                                              // SizedBox(
                                              //   height: 10,
                                              // ),

                                              // Container(
                                              //   height: productLis.length == 0
                                              //       ? 0
                                              //       : productLis.length == 1
                                              //           ? 100
                                              //           : productLis.length == 2
                                              //               ? 150
                                              //               : 130,
                                              //   width:
                                              //       Constants(context).scrnWidth,
                                              //   child: ListView.builder(
                                              //       itemCount: productLis.length,
                                              //       itemBuilder:
                                              //           ((context, index) {
                                              //         return Container(
                                              //             height: 80,
                                              //             child: Card(
                                              //               child: Container(
                                              //                 child: ListTile(
                                              //                     title: Text(
                                              //                       productLis[index]
                                              //                               [
                                              //                               "lead_name"]
                                              //                           .toUpperCase()
                                              //                           .toString(),
                                              //                       style:
                                              //                           TextStyle(
                                              //                         fontWeight:
                                              //                             FontWeight
                                              //                                 .bold,
                                              //                         fontSize:
                                              //                             11,
                                              //                         color: Colors
                                              //                             .black,
                                              //                         // fontWeight:
                                              //                         //     FontWeight
                                              //                         //         .bold
                                              //                       ),
                                              //                     ),
                                              //                     subtitle:
                                              //                         Column(
                                              //                       children: [
                                              //                         SizedBox(
                                              //                           height:
                                              //                               30,
                                              //                         ),
                                              //                         Container(
                                              //                           child:
                                              //                               Row(
                                              //                             crossAxisAlignment:
                                              //                                 CrossAxisAlignment.start,
                                              //                             children: [
                                              //                               // Expanded(
                                              //                               //     child:
                                              //                               //         Container(child: Text(""))),

                                              //                               Text(
                                              //                                 "Click Detail",
                                              //                                 style:
                                              //                                     TextStyle(fontSize: 9, color: Colors.blue),
                                              //                               ),
                                              //                               // Icon(
                                              //                               //   Icons.arrow_circle_down,
                                              //                               //   size:
                                              //                               //       12,
                                              //                               // )
                                              //                             ],
                                              //                           ),
                                              //                         ),
                                              //                       ],
                                              //                     ),
                                              //                     trailing:
                                              //                         Column(
                                              //                       children: [
                                              //                         Text(
                                              //                           productLis[
                                              //                                   index]
                                              //                               [
                                              //                               "lead_location"],
                                              //                           style: TextStyle(
                                              //                               fontSize:
                                              //                                   12),
                                              //                         ),
                                              //                         Padding(
                                              //                           padding:
                                              //                               const EdgeInsets.all(
                                              //                                   8.0),
                                              //                           child:
                                              //                               Column(
                                              //                             children: [
                                              //                               Text(
                                              //                                 productLis[index]["contact_time"] +
                                              //                                     productLis[index]["time1"],
                                              //                                 style:
                                              //                                     TextStyle(fontSize: 12),
                                              //                               ),
                                              //                               // Text(
                                              //                               //   productLis[index]
                                              //                               //       [
                                              //                               //       "contact_time"],
                                              //                               //   style: TextStyle(
                                              //                               //       fontSize:
                                              //                               //           12),
                                              //                               // ),
                                              //                             ],
                                              //                           ),
                                              //                         ),
                                              //                       ],
                                              //                     )),
                                              //               ),
                                              //             ));
                                              //       })),
                                              // ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              // productLis.length == 0
                                              //     ? Container()
                                              //     : GestureDetector(
                                              //         onTap: () {
                                              //           Get.to(NewleadsView());
                                              //         },
                                              //         child:
                                              //             productLis.length == 0
                                              //                 ? Container()
                                              //                 : Container(
                                              //                     child: Row(
                                              //                       children: [
                                              //                         Expanded(
                                              //                             child: Container(
                                              //                                 child:
                                              //                                     Text(""))),
                                              //                         Text(
                                              //                           "VIEW MORE TAP HERE",
                                              //                           style: TextStyle(
                                              //                               fontSize:
                                              //                                   12,
                                              //                               color:
                                              //                                   Colors.blue),
                                              //                         ),
                                              //                         Icon(
                                              //                           Icons
                                              //                               .arrow_circle_down,
                                              //                           size: 12,
                                              //                         )
                                              //                       ],
                                              //                     ),
                                              //                   ),
                                              //       ),

                                              // // Row(
                                              //   children: [
                                              //     Column(
                                              //       crossAxisAlignment:
                                              //           CrossAxisAlignment.start,
                                              //       children: [
                                              //         Padding(
                                              //           padding:
                                              //               const EdgeInsets.only(left: 8),
                                              //           child: Text(
                                              //             "Good Afternoon",
                                              //             style: TextStyle(
                                              //               color: Color.fromARGB(
                                              //                   255, 7, 38, 210),
                                              //             ),
                                              //           ),
                                              //         ),
                                              //         Padding(
                                              //           padding: const EdgeInsets.all(8.0),
                                              //           child: Container(
                                              //             child: Text(
                                              //               name == null
                                              //                   ? ""
                                              //                   : name.toString(),
                                              //               style: TextStyle(
                                              //                 fontSize: 17,
                                              //                 fontWeight: FontWeight.bold,
                                              //                 color: Color.fromARGB(
                                              //                     255, 7, 38, 210),
                                              //               ),
                                              //             ),
                                              //           ),
                                              //         ),
                                              //       ],
                                              //     ),
                                              //     Expanded(child: Container()),
                                              //     Column(
                                              //       children: [
                                              //         Container(
                                              //           color: Colors.white,
                                              //           child: Padding(
                                              //             padding:
                                              //                 const EdgeInsets.only(top: 00),
                                              //             child: GestureDetector(
                                              //                 onTap: (() {
                                              //                   // logout();
                                              //                 }),
                                              //                 child: Center(
                                              //                   child: Container(
                                              //                     height: 60,
                                              //                     width: 80,
                                              //                     child: CircleAvatar(
                                              //                       backgroundImage: NetworkImage(
                                              //                           "https://lamit.erpeaz.com/files/A 7562  Shinil pp (1) copy.jpg"),
                                              //                       radius: 100,
                                              //                     ),
                                              //                   ),
                                              //                 )),
                                              //           ),
                                              //         ),
                                              //         Container(
                                              //           height: 20,
                                              //         ),
                                              //         // SizedBox(
                                              //         //   height: 20,
                                              //         // ),

                                              //         id == null
                                              //             ? Text("")
                                              //             : Text(
                                              //                 "Employee ID \n" +
                                              //                     id.toString(),
                                              //                 style: TextStyle(
                                              //                   color: Color.fromARGB(
                                              //                       255, 7, 38, 210),
                                              //                 ),
                                              //               ),
                                              //         Container()
                                              //       ],
                                              //     ),
                                              //   ],
                                              // ),
                                              // // SizedBox(
                                              // //   height: 10,
                                              // // ),

                                              SizedBox(
                                                height: 30,
                                              ),
                                              // Container(

                                              //   // decoration: BoxDecoration(
                                              //   //   color: Colors.white,
                                              //   //   borderRadius: BorderRadius.all(
                                              //   //     Radius.circular(100.0),
                                              //   // ),
                                              //   // ),
                                              //   height: 110,
                                              //   width: Constants(context).scrnWidth,
                                              //   child: Card(
                                              //     shape: RoundedRectangleBorder(
                                              //         //side: BorderSide(color: Colors.white70, width: 1),
                                              //         borderRadius:
                                              //             BorderRadius.circular(20)),
                                              //     color: Color.fromARGB(255, 4, 7, 105),
                                              //     child: Column(
                                              //       crossAxisAlignment:
                                              //           CrossAxisAlignment.center,
                                              //       children: [
                                              //         SizedBox(
                                              //           height: 20,
                                              //         ),
                                              //         Text(
                                              //           "CONGRAGULATION YOU ACHIVED",
                                              //           style: TextStyle(
                                              //               color: Colors.white,
                                              //               fontSize: 13.04),
                                              //         ),
                                              //         SizedBox(
                                              //           height: 5,
                                              //         ),
                                              //         Center(
                                              //           child: Container(
                                              //             child: Row(
                                              //               children: [
                                              //                 Text(
                                              //                     "                                       Rs:  ",
                                              //                     style: TextStyle(
                                              //                         color: Colors.white,
                                              //                         fontSize: 11,
                                              //                         fontWeight:
                                              //                             FontWeight.bold)),
                                              //                 Container(
                                              //                   child: Center(
                                              //                     child: Text(
                                              //                       "30,000",
                                              //                       style: TextStyle(
                                              //                           color: Colors.white,
                                              //                           fontSize: 17,
                                              //                           fontWeight:
                                              //                               FontWeight.bold),
                                              //                     ),
                                              //                   ),
                                              //                 ),
                                              //               ],
                                              //             ),
                                              //           ),
                                              //         ),
                                              //         SizedBox(
                                              //           height: 5,
                                              //         ),
                                              //         Text(
                                              //           "as incentive",
                                              //           style: TextStyle(color: Colors.white),
                                              //         ),
                                              //         SizedBox(
                                              //           height: 10,
                                              //         )
                                              //       ],
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    //   Container(
                                    //     color: HexColor("#EEf3f9"),
                                    //     // color: Colors.red,
                                    //     // height: Constants(context).scrnHeight,
                                    //     child: Column(
                                    //       children: [
                                    //         Padding(
                                    //           padding: const EdgeInsets.all(8.0),
                                    //           child: Container(
                                    //             height: 320,
                                    //             child: GridView.count(
                                    //               scrollDirection: Axis.vertical,
                                    //               primary: false,
                                    //               padding: const EdgeInsets.all(20),
                                    //               crossAxisSpacing: 10,
                                    //               mainAxisSpacing: 20,
                                    //               crossAxisCount: 2,
                                    //               children: <Widget>[
                                    //                 Container(
                                    //                   decoration: BoxDecoration(
                                    //                     borderRadius:
                                    //                         BorderRadius.circular(20.0),
                                    //                     // color: Colors.green,
                                    //                     color: Colors.white,
                                    //                   ),
                                    //                   padding: const EdgeInsets.all(8),
                                    //                   child: Column(
                                    //                     children: [
                                    //                       SizedBox(
                                    //                         height: 15,
                                    //                       ),
                                    //                       Container(
                                    //                         height: 30.0,
                                    //                         width: 30.0,
                                    //                         decoration: BoxDecoration(
                                    //                           image: DecorationImage(
                                    //                             image:
                                    //                                 AssetImage('assets/1.png'),
                                    //                             fit: BoxFit.fill,
                                    //                           ),
                                    //                           shape: BoxShape.circle,
                                    //                         ),
                                    //                       ),
                                    //                       SizedBox(
                                    //                         height: 10,
                                    //                       ),
                                    //                       Text(
                                    //                         "ACHIEVED",
                                    //                         style: TextStyle(
                                    //                             fontSize: 10,
                                    //                             color: HexColor("#01017A")),
                                    //                       ),
                                    //                       SizedBox(
                                    //                         height: 5,
                                    //                       ),
                                    //                       Text(
                                    //                         "Rs : 10000",
                                    //                         style: TextStyle(
                                    //                             fontSize: 15,
                                    //                             color: HexColor('#01017A'),
                                    //                             fontWeight: FontWeight.bold),
                                    //                       ),
                                    //                     ],
                                    //                   ),
                                    //                   // child: const Text(
                                    //                   //
                                    //                   //
                                    //                   //     "He'd have you all unravel at the"),
                                    //                 ),
                                    //                 Container(
                                    //                   decoration: BoxDecoration(
                                    //                     borderRadius:
                                    //                         BorderRadius.circular(20.0),
                                    //                     // color: Colors.green,
                                    //                     color: Colors.white,
                                    //                   ),
                                    //                   padding: const EdgeInsets.all(8),
                                    //                   child: Column(
                                    //                     children: [
                                    //                       SizedBox(
                                    //                         height: 15,
                                    //                       ),
                                    //                       Container(
                                    //                         height: 30.0,
                                    //                         width: 30.0,
                                    //                         decoration: BoxDecoration(
                                    //                           image: DecorationImage(
                                    //                             image:
                                    //                                 AssetImage('assets/8.png'),
                                    //                             fit: BoxFit.fill,
                                    //                           ),
                                    //                           shape: BoxShape.circle,
                                    //                         ),
                                    //                       ),
                                    //                       SizedBox(
                                    //                         height: 10,
                                    //                       ),
                                    //                       Text(
                                    //                         "TARGET",
                                    //                         style: TextStyle(
                                    //                             fontSize: 10,
                                    //                             color: HexColor("#01017A")),
                                    //                       ),
                                    //                       SizedBox(
                                    //                         height: 5,
                                    //                       ),
                                    //                       Text(
                                    //                         "Rs : 10,0000",
                                    //                         style: TextStyle(
                                    //                           fontWeight: FontWeight.bold,
                                    //                           fontSize: 15,
                                    //                           color: HexColor('#01017A'),
                                    //                         ),
                                    //                       ),
                                    //                     ],
                                    //                   ),
                                    //                   // color: Colors.white,
                                    //                   // child: const Text('Heed not the rabble'),
                                    //                 ),
                                    //                 Container(
                                    //                   child: GestureDetector(
                                    //                     onTap: () {
                                    //                       Get.to(HotleadView());
                                    //                     },
                                    //                     child: Container(
                                    //                       padding: const EdgeInsets.all(8),
                                    //                       decoration: BoxDecoration(
                                    //                         borderRadius:
                                    //                             BorderRadius.circular(20.0),
                                    //                         // color: Colors.green,
                                    //                         color: Colors.white,
                                    //                       ),
                                    //                       child: Column(
                                    //                         children: [
                                    //                           SizedBox(
                                    //                             height: 15,
                                    //                           ),
                                    //                           Container(
                                    //                             height: 30.0,
                                    //                             width: 30.0,
                                    //                             decoration: BoxDecoration(
                                    //                               image: DecorationImage(
                                    //                                 image: AssetImage(
                                    //                                     'assets/3.png'),
                                    //                                 fit: BoxFit.fill,
                                    //                               ),
                                    //                               shape: BoxShape.circle,
                                    //                             ),
                                    //                           ),
                                    //                           SizedBox(
                                    //                             height: 10,
                                    //                           ),
                                    //                           Text(
                                    //                             "HOT LEAD",
                                    //                             style: TextStyle(
                                    //                                 fontSize: 10,
                                    //                                 color: HexColor("#01017A")),
                                    //                           ),
                                    //                           SizedBox(
                                    //                             height: 5,
                                    //                           ),
                                    //                           Text(
                                    //                             "Rs : 10000",
                                    //                             style: TextStyle(
                                    //                               fontWeight: FontWeight.bold,
                                    //                               fontSize: 15,
                                    //                               color: HexColor('#01017A'),
                                    //                             ),
                                    //                           ),
                                    //                         ],
                                    //                       ),
                                    //                       // child: const Text('Sound of screams but the'),
                                    //                     ),
                                    //                   ),
                                    //                 ),
                                    //                 Container(
                                    //                   child: GestureDetector(
                                    //                     onTap: () {
                                    //                       Get.to(LeadView());
                                    //                     },
                                    //                     child: Container(
                                    //                       padding: const EdgeInsets.all(8),
                                    //                       decoration: BoxDecoration(
                                    //                         borderRadius:
                                    //                             BorderRadius.circular(20.0),
                                    //                         // color: Colors.green,
                                    //                         color: Colors.white,
                                    //                       ),
                                    //                       // child: const Text('Who scream'),

                                    //                       child: Column(
                                    //                         children: [
                                    //                           SizedBox(
                                    //                             height: 15,
                                    //                           ),
                                    //                           Container(
                                    //                             height: 30.0,
                                    //                             width: 30.0,
                                    //                             decoration: BoxDecoration(
                                    //                               image: DecorationImage(
                                    //                                 image: AssetImage(
                                    //                                     'assets/4.png'),
                                    //                                 fit: BoxFit.fill,
                                    //                               ),
                                    //                               shape: BoxShape.circle,
                                    //                             ),
                                    //                           ),
                                    //                           SizedBox(
                                    //                             height: 10,
                                    //                           ),
                                    //                           Text(
                                    //                             "LEADS",
                                    //                             style: TextStyle(
                                    //                                 fontSize: 10,
                                    //                                 color: HexColor("#01017A")),
                                    //                           ),
                                    //                           SizedBox(
                                    //                             height: 5,
                                    //                           ),
                                    //                           Text(
                                    //                             "450",
                                    //                             style: TextStyle(
                                    //                                 fontSize: 15,
                                    //                                 color: HexColor('#01017A'),
                                    //                                 fontWeight:
                                    //                                     FontWeight.bold),
                                    //                           ),
                                    //                         ],
                                    //                       ),
                                    //                     ),
                                    //                   ),
                                    //                 ),
                                    //                 Container(
                                    //                   padding: const EdgeInsets.all(8),
                                    //                   decoration: BoxDecoration(
                                    //                     borderRadius:
                                    //                         BorderRadius.circular(20.0),
                                    //                     // color: Colors.green,
                                    //                     color: Colors.white,
                                    //                   ),
                                    //                   child: Column(
                                    //                     children: [
                                    //                       SizedBox(
                                    //                         height: 15,
                                    //                       ),
                                    //                       Container(
                                    //                         height: 30.0,
                                    //                         width: 30.0,
                                    //                         decoration: BoxDecoration(
                                    //                           image: DecorationImage(
                                    //                             image:
                                    //                                 AssetImage('assets/5.png'),
                                    //                             fit: BoxFit.fill,
                                    //                           ),
                                    //                           shape: BoxShape.circle,
                                    //                         ),
                                    //                       ),
                                    //                       SizedBox(
                                    //                         height: 10,
                                    //                       ),
                                    //                       Text(
                                    //                         "CUSTOMER",
                                    //                         style: TextStyle(
                                    //                             fontSize: 10,
                                    //                             color: HexColor("#01017A")),
                                    //                       ),
                                    //                       SizedBox(
                                    //                         height: 5,
                                    //                       ),
                                    //                       Text(
                                    //                         "10",
                                    //                         style: TextStyle(
                                    //                           fontWeight: FontWeight.bold,
                                    //                           fontSize: 15,
                                    //                           color: HexColor('#01017A'),
                                    //                         ),
                                    //                       ),
                                    //                     ],
                                    //                   ),
                                    //                   // child: const Text('Revolution is coming...'),
                                    //                 ),
                                    //                 Container(
                                    //                   padding: const EdgeInsets.all(8),
                                    //                   decoration: BoxDecoration(
                                    //                     borderRadius:
                                    //                         BorderRadius.circular(20.0),
                                    //                     // color: Colors.green,
                                    //                     color: Colors.white,
                                    //                   ),
                                    //                   child: Column(
                                    //                     children: [
                                    //                       SizedBox(
                                    //                         height: 15,
                                    //                       ),
                                    //                       Container(
                                    //                         height: 30.0,
                                    //                         width: 30.0,
                                    //                         decoration: BoxDecoration(
                                    //                           image: DecorationImage(
                                    //                             image:
                                    //                                 AssetImage('assets/6.png'),
                                    //                             fit: BoxFit.fill,
                                    //                           ),
                                    //                           shape: BoxShape.circle,
                                    //                         ),
                                    //                       ),
                                    //                       SizedBox(
                                    //                         height: 10,
                                    //                       ),
                                    //                       Text(
                                    //                         "FOLLOW UP",
                                    //                         style: TextStyle(
                                    //                             fontSize: 10,
                                    //                             color: HexColor("#01017A")),
                                    //                       ),
                                    //                       SizedBox(
                                    //                         height: 5,
                                    //                       ),
                                    //                       Text(
                                    //                         "00",
                                    //                         style: TextStyle(
                                    //                           fontWeight: FontWeight.bold,
                                    //                           fontSize: 15,
                                    //                           color: HexColor('#01017A'),
                                    //                         ),
                                    //                       ),
                                    //                     ],
                                    //                   ),
                                    //                   // child: const Text('Revolution, they...'),
                                    //                 ),
                                    //               ],
                                    //             ),
                                    //           ),
                                    //         )
                                    //       ],
                                    //     ),
                                    //   )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
    );
  }

  getsf() async {
    Taskview();
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      id = preferences.getString("userid");
      name = preferences.getString("name");
    });

    getlac();

    // sales();
    task();
    await overTaskview();
    closedTaskview();
    openTaskview();
    sales();
    target();

    print(id.toString());
    print(name.toString());

    // newleadView(id.toString());
  }

  // newleadView(String id) async {
  //   print("object");

  //   http.Response response = await http.get(
  //     Uri.parse(
  //         'https://lamit.erpeaz.com/api/resource/Customer?fields=["name","lead_name"]&filters=[["customer_area", "in","NEDUMANGAD"]]'),
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
  //       productList = jsonDecode(data)["data"];
  //     });

  //     // log(productList[0]["note"]);
  //     print(data);
  //     // baisicDetailView2();
  //   } else {}
  // }

  Future getlac() async {
    log(id.toString() +
        "idddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
    print("hiiiiiiiii");
    // https://lamit.erpeaz.com/api/resource/Customer Area?filters=[["allocated_by", "=", "1232435456"]] & limit=100

    var baseUrl = urlMain +
        'api/resource/Assign Sale Area?filters=[["sales_officer", "=", "$id"]] &limit=10000000000';

    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
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
      //  var jsonData;
      setState(() {
        // jsonData = json.decode(data)["data"];
        // laclist = jsonData;
        laclist = jsonDecode(data)["data"];
      });

      ///  hotleadview(leadview(jsonDecode(data)["data"]));
      leadview(jsonDecode(data)["data"]);
      hotview((jsonDecode(data)["data"]));
      leaview(jsonDecode(data)["data"]);

      //  listLedgers((jsonDecode(data)["data"]));
      // log(jsonData.toString());
      // setState(() {});
    }
  }

  leadview(var lac) async {
    print("hbbbbbbbbbbbbbbbbbbb" + lac.toString());
    //print(skey);

    var l = [];
    // List<String> customerList = ["KANHANGAD", "MANJESHWAR"];

    var i;
    var la = [];
    for (i = 0; i < lac.length; i++) {
      l.add({"name": lac[i]["name"]});
      la.add(l[i]["name"]);
    }
    List<String> e = [
      "",
      "",
    ];
    // e = la;
    log(la.toString() +
        "gfdghfgfcgghghggjhjhjjjjhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
    log(l.toString() + "nbnbbbbbbbbnbbnnbbbnbnbnnbbnbnbnbnnbnbnbnb");
    print(l.toString() + "b bnbnbbnbnnm");

    for (var i = 0; i < l.length; i++) {
      var c = l[i]["name"];
      e.add("$c,$c");
    }
    log(e.toString() +
        "bvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvc");
    // = l.toString();

    http.Response response = await http.get(
        Uri.parse(urlMain +
            'api/resource/Lead?filters=[["new_lead", "=", "1"],["lac", "in","$e"]]&fields=["lead_name","date","source","lead_category","status","email_id","mobile_no","lac","new_lead"]&limit=10000000000'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': Tocken,
        });
    String data = response.body;

    // log(data);
    setState(() {
      productList = jsonDecode(data)["data"];
    });
    // for (var i = 0; i < productList.length; i++) {
    // //  ledgers.add({'name': productList[i]['data'], 'id': i});
    //   searchResults.add({
    //     "name": productList[i]['first_name'],
    //   });
    // }
    //items.addAll(searchResults);

    // print(leadArray);

    // print("laedarray" + leadArray);

    return null;
  }

  overTaskview() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    log(id.toString());
    log(formattedDate.toString());
    var a = "$id";
    http.Response response = await http.get(
        Uri.parse(urlMain +
            'api/resource/Task?fields=["name","mobile","subject","contact_time_in_hour","contact_time_in_min","time2","lead_name","select_customer"]&filters=[["due_date","=","$formattedDate"],["status","=","Open"],["sales_officer2","=","$id"]]&limit=10000000000'),
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

  // hotleadview(var lac) async {
  //   print("hbbbbbbbbbbbbbbbbbbb" + lac.toString());
  //   //print(skey);

  //   var l = [];
  //   // List<String> customerList = ["KANHANGAD", "MANJESHWAR"];

  //   var i;
  //   var la = [];
  //   for (i = 0; i < lac.length; i++) {
  //     l.add({"name": lac[i]["name"]});
  //     la.add(l[i]["name"]);
  //   }
  //   List<String> e = [
  //     "",
  //     "",
  //   ];
  //   // e = la;
  //   log(la.toString() +
  //       "gfdghfgfcgghghggjhjhjjjjhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
  //   log(l.toString() + "nbnbbbbbbbbnbbnnbbbnbnbnnbbnbnbnbnnbnbnbnb");
  //   print(l.toString() + "b bnbnbbnbnnm");

  //   for (var i = 0; i < l.length; i++) {
  //     var c = l[i]["name"];
  //     e.add("$c,$c");
  //   }
  //   log(e.toString() +
  //       "bvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvc");
  //   // = l.toString();

  //   http.Response response = await http.get(
  //       Uri.parse(
  //           'https://lamit.erpeaz.com/api/resource/Lead?order_by=name desc&filters=[["lac", "in","$e"],["status", "=", "Hot"]]&fields=["*"]'),
  //       headers: {
  //         'Content-type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': Tocken,
  //       });
  //   String data = response.body;

  //   log(data);
  //   setState(() {
  //     productListhot = jsonDecode(data)["data"];
  //   });
  //   // for (var i = 0; i < productList.length; i++) {
  //   // //  ledgers.add({'name': productList[i]['data'], 'id': i});
  //   //   searchResults.add({
  //   //     "name": productList[i]['first_name'],
  //   //   });
  //   // }
  //   //items.addAll(searchResults);

  //   // print(leadArray);

  //   // print("laedarray" + leadArray);

  //   return null;
  // }

  hotview(var lac) async {
    print("hbbbbbbbbbbbbbbbbbbb" + lac.toString());
    // print(skey);

    var l = [];
    // List<String> customerList = ["KANHANGAD", "MANJESHWAR"];

    var i;
    var la = [];
    for (i = 0; i < lac.length; i++) {
      l.add({"name": lac[i]["name"]});
      la.add(l[i]["name"]);
    }
    List<String> e = [
      "",
      "",
    ];
    // e = la;
    log(la.toString() +
        "gfdghfgfcgghghggjhjhjjjjhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
    log(l.toString() + "nbnbbbbbbbbnbbnnbbbnbnbnnbbnbnbnbnnbnbnbnb");
    print(l.toString() + "b bnbnbbnbnnm");

    for (var i = 0; i < l.length; i++) {
      var c = l[i]["name"];
      e.add("$c,$c");
    }
    log(e.toString() +
        "bvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvc");
    // = l.toString();

    http.Response response = await http.get(
        Uri.parse(urlMain +
            'api/resource/Lead?order_by=name desc&filters=[["lac", "in","$e"],["stage", "=", "Hot"]]&fields=["*"]&limit=10000000000'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': Tocken,
        });
    String data = response.body;

    // log(data);
    setState(() {
      productListhot = jsonDecode(data)["data"];
    });
    // for (var i = 0; i < productList.length; i++) {
    //   ledgers.add({'name': productList[i]['data'], 'id': i});
    //   searchResults.add({
    //     "name": productList[i]['first_name'],
    //   });
    // }
    // items.addAll(searchResults);

    // print(leadArray);

    // print("laedarray" + leadArray);

    return null;
  }

  leaview(var lead) async {
    var l = [];
    // List<String> customerList = ["KANHANGAD", "MANJESHWAR"];

    var i;
    var la = [];
    for (i = 0; i < lead.length; i++) {
      l.add({"name": lead[i]["name"]});
      la.add(l[i]["name"]);
    }
    List<String> e = [
      "",
      "",
    ];
    // e = la;
    log(la.toString() +
        "gfdghfgfcgghghggjhjhjjjjhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
    log(l.toString() + "nbnbbbbbbbbnbbnnbbbnbnbnnbbnbnbnbnnbnbnbnb");
    print(l.toString() + "b bnbnbbnbnnm");

    for (var i = 0; i < l.length; i++) {
      var c = l[i]["name"];
      e.add("$c,$c");
    }
    log(e.toString() +
        "bvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvc");
    // = l.toString();

    // var l;
    // for (var i = 0; i < lead.length; i++) {
    //   l = lead[i]["name"];
    // }
    // log(l.toString() + "nbnbbbbbbbbnbbnnbbbnbnbnnbbnbnbnbnnbnbnbnb");
    // print(l.toString() + "b bnbnbbnbnnm");
    // var la = l.toString();

    // var a = email;
    // var b = skey;
    // print(a);
    // print("$b bbzbxb");
    //  var email = this.email;
    //  log(email + "hhhhh");
    // print(skey);
    http.Response response = await http.get(
        Uri.parse(urlMain +
            'api/resource/Lead?filters=[["lac", "in", "$e"]]&fields=["*"]&limit=10000000000'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': Tocken,
        });
    String data = response.body;
    // log(data);
    setState(() {
      productListlea = jsonDecode(data)["data"];
    });

    print("object");
    // print(leadArray);

    // print("laedarray" + leadArray);

    return null;
  }

  logout() async {
    showDialog(
        context: context,
        builder: (builder) => CupertinoAlertDialog(
              title: Text('Do you really want to logout ?'),
              actions: [
                CupertinoButton(
                    child: Text('No'),
                    borderRadius: BorderRadius.circular(0),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                CupertinoButton(
                    child: Text('Yes', style: TextStyle(color: Colors.blue)),
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.clear();
                      Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                              builder: (builder) => LoginView()));
                    })
              ],
            ));
  }

  sales() async {
    print("hiiiiiiiii");
    // https://lamit.erpeaz.com/api/resource/Customer Area?filters=[["allocated_by", "=", "1232435456"]] & limit=100

    // var baseUrl = urlMain +
    //     'api/resource/Incentive?filters=[["employee","=","$id"],["active","=",1]]&fields=["target_amount","incentive_amount"]';
    var baseUrl = urlMain +
        'api/resource/Incentive?filters=[["employee","=","$id"],["active","=",1]]&fields=["*"]';

    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    });
    print(response.body);
    print(response.statusCode);
    print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
    if (response.statusCode == 200) {
      log(response.body.toString() + '---------response');
      print("haaaaaaaaaaaaaaaaaaaaaaaaa");
      String data = response.body;
      //  var jsonData;
      setState(() {
        // jsonData = json.decode(data)["data"];
        // laclist = jsonData;
       
        achive = jsonDecode(data)["data"][0]["incentive_amount"];
        print(salelistlist.toString() +
            'taramunt' +
            '   achived:' +
            achive.toString());
      });
      // log(salelistlist = jsonDecode(data)["data"][0]["target"]);

      ///  hotleadview(leadview(jsonDecode(data)["data"]));
      // leadview(laclist);
      //  hotview((jsonDecode(data)["data"]));
      // leaview(jsonDecode(data)["data"]);

      //  listLedgers((jsonDecode(data)["data"]));
      // log(jsonData.toString());
      // setState(() {});
    } else {
      print(response.reasonPhrase.toString() + '------this is issue');
    }
  }

  target() async {
    print("hiiiiiiiii");
    // https://lamit.erpeaz.com/api/resource/Customer Area?filters=[["allocated_by", "=", "1232435456"]] & limit=100

    // var baseUrl = urlMain +
    //     'api/resource/Incentive?filters=[["employee","=","$id"],["active","=",1]]&fields=["target_amount","incentive_amount"]';
    var baseUrl = urlMain +
        'api/resource/Target?fields=["*"]&filters=[["employee","=","$id"],["active","=",1]]';

    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    });
    print(response.body);
    print(response.statusCode);
    print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
    if (response.statusCode == 200) {
      log(response.body.toString() + '---------response11');
      print("haaaaaaaaaaaaaaaaaaaaaaaaa");
      String data = response.body;
      //  var jsonData;
      setState(() {
        
        salelistlist = jsonDecode(data)["data"][0]["target"];
       
        print(salelistlist.toString() +
            '--taramount');
      });
     
    } else {
      print(response.reasonPhrase.toString() + '------this is issue');
    }
  }


  Future task() async {
    print("hiiiiiiiii");
    // https://lamit.erpeaz.com/api/resource/Customer Area?filters=[["allocated_by", "=", "1232435456"]] & limit=100

    var baseUrl = urlMain +
        'api/resource/Task?fields=["name","status","mobile","subject","contact_time_in_hour","contact_time_in_min","time2","lead_name","contact_to_time_in_hour","contact_to_time_in_min","time1"]&filters=[["sales_officer2","=","$id"]]';
    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
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
      log(data.toString());
      //  var jsonData;
      setState(() {
        // jsonData = json.decode(data)["data"];
        // laclist = jsonData;
        taski = jsonDecode(data)["data"];
      });
      log(taski.toString());

      ///  hotleadview(leadview(jsonDecode(data)["data"]));
      // leadview(laclist);
      //  hotview((jsonDecode(data)["data"]));
      // leaview(jsonDecode(data)["data"]);

      //  listLedgers((jsonDecode(data)["data"]));
      // log(jsonData.toString());
      // setState(() {});
    }
  }

  Future<void> getPath_1() async {
    var path = await ExternalPath.getExternalStorageDirectories();
    log(path.toString()); // [/storage/emulated/0, /storage/B3AE-4D28]

    // please note: B3AE-4D28 is external storage (SD card) folder name it can be any.
  }

  Future<void> getPath_2() async {
    pat = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    setState(() {
      log(pat);
    });
    // /storage/emulated/0/Download
  }

  exportPdf(var data, String heading) async {
    final pdf = pw.Document();
    final ByteData bytes = await rootBundle.load('assets/33.png');
    final Uint8List byteList = bytes.buffer.asUint8List();
    final font = await PdfGoogleFonts.nunitoExtraLight();
    pdf.addPage(
      pw.MultiPage(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        maxPages: 50,
        build: ((context) => [
              pw.Image(
                  pw.MemoryImage(
                    byteList,
                  ),
                  //  fit: pw.BoxFit.fitHeight
                  height: 80,
                  width: 80),
              pw.Padding(
                padding: pw.EdgeInsets.only(top: 2),
                child: pw.Container(
                    width: 500,
                    height: 40,
                    color: PdfColors.grey,
                    child: pw.Padding(
                        padding: pw.EdgeInsets.only(left: 210, top: 20),
                        child: pw.Container(
                            // width: 500,
                            // height: 40,
                            color: PdfColors.grey,
                            child: pw.Text("PROFORMA",
                                style: pw.TextStyle(
                                    font: font,
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColors.white))))),
              ),
              pw.SizedBox(height: 5),
              pw.Container(
                  height: 300,
                  //width: 500,
                  decoration: pw.BoxDecoration(
                      color: PdfColors.black,
                      border: pw.Border.all(color: PdfColors.black, width: 2)),
                  child: pw.Container(
                    height: 298,
                    color: PdfColors.white,
                    child: pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          // pw.Container(
                          //     width: 1, color: PdfColors.black, height: 342),
                          pw.Container(
                              width: 240,
                              color: PdfColors.white,
                              child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Container(
                                        width: 500,
                                        color: PdfColors.white,
                                        child: pw.Column(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              // pw.Container(
                                              //     height: 1,
                                              //     color: PdfColors.black,
                                              //     width: 480),

                                              pw.SizedBox(height: 2),
                                              // pw.Container(
                                              //     height: 1,
                                              //     color: PdfColors.black),
                                              // pw.SizedBox(height: 5),
                                              pw.Container(
                                                  child: pw.Paragraph(
                                                //margin: EdgeInsets.only(bottom: 20),
                                                text:
                                                    // complist["name"] == null
                                                    //     ? ""
                                                    //     : " " + complist["name"],"",""
                                                    "dmngnjnnnnhnnn",
                                                style: pw.TextStyle(
                                                    font: font,
                                                    fontWeight:
                                                        pw.FontWeight.bold,
                                                    fontSize: 19),
                                              )),
                                              pw.SizedBox(height: 2),
                                              pw.Container(
                                                  child: pw.Paragraph(
                                                //margin: EdgeInsets.only(bottom: 20),
                                                text: complist[
                                                            "address_line1"] ==
                                                        null
                                                    ? ""
                                                    : " " +
                                                        complist[
                                                            "address_line1"],
                                                style: pw.TextStyle(
                                                    font: font, fontSize: 12),
                                              )),
                                              //  pw.SizedBox(height: 2),
                                              pw.SizedBox(
                                                  width: 190,
                                                  child: pw.Container(
                                                      child: pw.Paragraph(
                                                    //margin: EdgeInsets.only(bottom: 20),
                                                    text: complist[
                                                                "address_line2"] ==
                                                            null
                                                        ? ""
                                                        : " " +
                                                            complist[
                                                                "address_line2"],
                                                    style: pw.TextStyle(
                                                        font: font,
                                                        fontSize: 12),
                                                  ))),
                                              //pw.SizedBox(height: 2),
                                              pw.SizedBox(
                                                  width: 190,
                                                  child: pw.Container(
                                                      child: pw.Paragraph(
                                                    //margin: EdgeInsets.only(bottom: 20),
                                                    text: complist["city"] ==
                                                            null
                                                        ? ""
                                                        : " " +
                                                            complist["city"],
                                                    style: pw.TextStyle(
                                                        font: font,
                                                        fontSize: 12),
                                                  ))),
                                              pw.SizedBox(height: 2),
                                              pw.SizedBox(
                                                  width: 190,
                                                  child: pw.Container(
                                                      child: pw.Paragraph(
                                                    //margin: EdgeInsets.only(bottom: 20),
                                                    text: complist["pincode"] ==
                                                            null
                                                        ? ""
                                                        : "  " +
                                                            complist["pincode"],
                                                    style: pw.TextStyle(
                                                        font: font,
                                                        fontSize: 12),
                                                  ))),
                                            ])),
                                    //   pw.SizedBox(height: 5),
                                    pw.Container(
                                        child: pw.Paragraph(
                                      //margin: EdgeInsets.only(bottom: 20),
                                      text: ' Quotation To',
                                      style: pw.TextStyle(
                                          font: font,
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 19),
                                    )),
                                    // pw.SizedBox(height: 20),
                                    pw.Container(
                                        child: pw.Paragraph(
                                      //margin: EdgeInsets.only(bottom: 20),
                                      text: productlist["customer_name"] == null
                                          ? ""
                                          : " " + productlist["customer_name"],
                                      style: pw.TextStyle(
                                        fontSize: 12,
                                        font: font,
                                      ),
                                    )),
                                    pw.SizedBox(height: 2),
                                    pw.SizedBox(
                                        width: 190,
                                        child: pw.Container(
                                            child: pw.Paragraph(
                                          //margin: EdgeInsets.only(bottom: 20),
                                          text: leadlist["address_line1"] ==
                                                  null
                                              ? ""
                                              : " " + leadlist["address_line1"],
                                          style: pw.TextStyle(
                                            fontSize: 12,
                                            font: font,
                                          ),
                                        ))),
                                    pw.SizedBox(height: 2),
                                    pw.SizedBox(
                                        width: 190,
                                        child: pw.Container(
                                            child: pw.Paragraph(
                                          //margin: EdgeInsets.only(bottom: 20),
                                          text: leadlist["address_line2"] ==
                                                  null
                                              ? ""
                                              : "" + leadlist["address_line2"],
                                          style: pw.TextStyle(
                                            fontSize: 12,
                                            font: font,
                                          ),
                                        ))),
                                    pw.SizedBox(height: 2),
                                    pw.SizedBox(
                                        width: 190,
                                        child: pw.Container(
                                            child: pw.Paragraph(
                                          //margin: EdgeInsets.only(bottom: 20),
                                          text: leadlist["city"] == null
                                              ? ""
                                              : leadlist["city"],
                                          style: pw.TextStyle(
                                              font: font, fontSize: 12),
                                        ))),
                                    pw.SizedBox(
                                        width: 190,
                                        child: pw.Container(
                                            child: pw.Paragraph(
                                          //margin: EdgeInsets.only(bottom: 20),
                                          text: leadlist["pincode"] == null
                                              ? ""
                                              : leadlist["pincode"],
                                          style: pw.TextStyle(
                                              font: font, fontSize: 12),
                                        ))),
                                    // pw.Container(
                                    //     height: 1,
                                    //     color: PdfColors.black,
                                    //     width: 340),
                                  ])),
                          // pw.Container(
                          //     width: 1, color: PdfColors.black, height: 342),
                          pw.Container(
                              width: 240,
                              color: PdfColors.white,
                              child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Container(
                                        width: 500,
                                        color: PdfColors.white,
                                        child: pw.Column(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              // pw.Container(
                                              //     height: 1,
                                              //     color: PdfColors.black,
                                              //     width: 300),

                                              pw.SizedBox(height: 5),
                                              // pw.Container(
                                              //     height: 1,
                                              //     color: PdfColors.black),
                                              pw.SizedBox(height: 5),
                                              pw.SizedBox(
                                                  width: 190,
                                                  child: pw.Container(
                                                      child: pw.Paragraph(
                                                    //margin: EdgeInsets.only(bottom: 20),
                                                    text: productlist["date"] ==
                                                            null
                                                        ? ""
                                                        : productlist["date"]
                                                            .toString(),
                                                    style: pw.TextStyle(
                                                        font: font,
                                                        fontSize: 12),
                                                  ))),
                                              pw.SizedBox(height: 2),
                                              pw.SizedBox(
                                                  width: 190,
                                                  child: pw.Container(
                                                      child: pw.Paragraph(
                                                    //margin: EdgeInsets.only(bottom: 20),
                                                    text: productlist["name"]
                                                                .toString() ==
                                                            "null"
                                                        ? ""
                                                        : ' No : ' +
                                                            productlist["name"]
                                                                .toString(),
                                                    style: pw.TextStyle(
                                                        font: font,
                                                        fontSize: 12),
                                                  ))),
                                              pw.SizedBox(height: 2),

                                              // pw.Container(
                                              //     height: 1,
                                              //     color: PdfColors.black,
                                              //     width: 480),

                                              pw.SizedBox(
                                                  width: 190,
                                                  child: pw.Container(
                                                      height: 90,
                                                      child: pw.Row(children: [
                                                        pw.Paragraph(
                                                          //margin: EdgeInsets.only(bottom: 20),
                                                          text:
                                                              ' QOUTATION MADE BY :',
                                                          style: pw.TextStyle(
                                                              font: font,
                                                              fontSize: 10,
                                                              fontWeight: pw
                                                                  .FontWeight
                                                                  .bold),
                                                        ),
                                                        pw.Expanded(
                                                            child: pw.Paragraph(
                                                          //margin: EdgeInsets.only(bottom: 20),
                                                          text: fullname == null
                                                              ? ""
                                                              : fullname,
                                                          style: pw.TextStyle(
                                                              font: font,
                                                              fontSize: 10),
                                                        ))
                                                      ]))),
                                            ])),
                                    // pw.Container(
                                    //     height: 1,
                                    //     color: PdfColors.black,
                                    //     width: 480),
                                    pw.Container(height: 172.5),
                                    // pw.Container(
                                    //     height: 1,
                                    //     color: PdfColors.black,
                                    //     width: 480),
                                  ])),
                          // pw.Container(
                          //     width: 1, color: PdfColors.black, height: 342),
                        ]),
                  )),
              pw.Container(
                color: PdfColor.fromInt(0xFF1A237E),
                child: pw.Row(children: [
                  pw.Expanded(
                    child: pw.Text('sl No',
                        style: pw.TextStyle(
                          color: PdfColors.white,
                          font: font,
                        )),
                  ),
                  pw.Expanded(
                    child: pw.Text('Product',
                        style: pw.TextStyle(
                          color: PdfColors.white,
                          font: font,
                        )),
                  ),
                  pw.Expanded(
                    child: pw.Text('Series',
                        style: pw.TextStyle(
                          color: PdfColors.white,
                          font: font,
                        )),
                  ),
                  pw.Expanded(
                    child: pw.Text('Qty',
                        style: pw.TextStyle(
                          color: PdfColors.white,
                          font: font,
                        )),
                  ),
                  pw.Expanded(
                    child: pw.Text('Total',
                        style: pw.TextStyle(
                          color: PdfColors.white,
                          font: font,
                        )),
                  ),
                  // pw.SizedBox(
                  //     width: 75, child: pw.Column(children: [pw.Text("Arundas")]))
                ]),
              ),
              pw.ListView.builder(
                itemCount: plist.length,
                itemBuilder: ((context, i) => pw.Column(children: [
                      pw.Row(children: [
                        pw.Expanded(
                          child: pw.Text(plist[i]["idx"].toString(),
                              style: pw.TextStyle(
                                font: font,
                              )),
                        ),
                        pw.Expanded(
                          child: pw.Text(
                              plist[i]["item_name"] == null
                                  ? ""
                                  : plist[i]["item_name"],
                              style: pw.TextStyle(
                                font: font,
                              )),
                        ),
                        pw.Expanded(
                          child: pw.Text(
                              plist[i]["item_series"] == null
                                  ? ""
                                  : plist[i]["item_series"],
                              style: pw.TextStyle(
                                font: font,
                              )),
                        ),
                        pw.Expanded(
                          child: pw.Text(
                              plist[i]["qty"] == null
                                  ? ""
                                  : plist[i]["qty"].toString(),
                              style: pw.TextStyle(
                                font: font,
                              )),
                        ),
                        pw.Expanded(
                          child: pw.Text(
                              plist[i]["amount"] == null
                                  ? ""
                                  : plist[i]["amount"].toString(),
                              style: pw.TextStyle(
                                font: font,
                              )),
                        ),
                      ]),
                    ])),
                // itemCount: 2
              ),
              pw.Container(
                color: PdfColors.grey,
                child: pw.Row(children: [
                  pw.Expanded(child: pw.Container()),
                  pw.Expanded(child: pw.Container()),

                  pw.Expanded(
                    child: pw.Text("",
                        style: pw.TextStyle(
                          font: font,
                        )),
                  ),
                  pw.Expanded(
                    child: pw.Text("Total : " + productlist["total"].toString(),
                        style: pw.TextStyle(
                          font: font,
                        )),
                  ),
                  // pw.Expanded(
                  //   child: pw.Text("",
                  //       style: pw.TextStyle(
                  //         font: font,
                  //       )),
                  // ),
                  pw.Expanded(
                    child: pw.Text(
                        "Grand Total :" + productlist["grand_total"].toString(),
                        style: pw.TextStyle(
                          font: font,
                        )),
                  ),
                  // pw.SizedBox(
                  //     width: 75, child: pw.Column(children: [pw.Text("Arundas")]))
                ]),
              ),
              pw.Container(
                  height: 350,
                  //width: 500,
                  color: PdfColors.black,
                  child: pw.Container(
                    height: 298,
                    color: PdfColors.white,
                    child: pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          // pw.Container(
                          //     width: 1, color: PdfColors.black, height: 327),
                          pw.Container(
                              width: 480,
                              color: PdfColors.white,
                              child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Container(
                                        width: 500,
                                        color: PdfColors.white,
                                        child: pw.Column(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Container(
                                                  height: 1,
                                                  color: PdfColors.black,
                                                  width: 480),

                                              //  pw.SizedBox(height: 5),
                                              // pw.Container(
                                              //     height: 1,
                                              //     color: PdfColors.black),
                                              // pw.SizedBox(height: 5),
                                              pw.SizedBox(
                                                  width: 500,
                                                  child: pw.Container(
                                                      height: 50,
                                                      color: PdfColor.fromInt(
                                                          0xFF1A237E),
                                                      child: pw.Paragraph(
                                                        //margin: EdgeInsets.only(bottom: 20),
                                                        text:
                                                            ' TERMS AND CONDITION :',
                                                        style: pw.TextStyle(
                                                            color:
                                                                PdfColors.white,
                                                            font: font,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .bold,
                                                            fontSize: 19),
                                                      ))),
                                              pw.SizedBox(height: 20),
                                              pw.SizedBox(
                                                  width: 480,
                                                  child: pw.Container(
                                                      child: pw.Paragraph(
                                                    //margin: EdgeInsets.only(bottom: 20),
                                                    text:
                                                        '* 30 of total amount should be aid in advance',
                                                    style: pw.TextStyle(
                                                        font: font,
                                                        fontSize: 12),
                                                  ))),
                                              pw.SizedBox(height: 2),
                                              pw.SizedBox(
                                                  width: 480,
                                                  child: pw.Container(
                                                      child: pw.Paragraph(
                                                    //margin: EdgeInsets.only(bottom: 20),
                                                    text:
                                                        '* Balance amount should be paid before container arrival port',
                                                    style: pw.TextStyle(
                                                        font: font,
                                                        fontSize: 12),
                                                  ))),
                                              pw.SizedBox(height: 2),
                                              pw.SizedBox(
                                                  width: 480,
                                                  child: pw.Container(
                                                      child: pw.Paragraph(
                                                    //margin: EdgeInsets.only(bottom: 20),
                                                    text:
                                                        '* Any increase in shipping or purchase charges will result increases in material price',
                                                    style: pw.TextStyle(
                                                        font: font,
                                                        fontSize: 12),
                                                  ))),
                                              pw.SizedBox(height: 2),
                                              pw.SizedBox(
                                                  width: 480,
                                                  child: pw.Container(
                                                      child: pw.Paragraph(
                                                    //margin: EdgeInsets.only(bottom: 20),
                                                    text:
                                                        '* This Qutation is valid for 15 days',
                                                    style: pw.TextStyle(
                                                        font: font,
                                                        fontSize: 12),
                                                  ))),
                                            ])),
                                    pw.SizedBox(height: 5),
                                    pw.SizedBox(
                                        width: 480,
                                        child: pw.Container(
                                            child: pw.Paragraph(
                                          //margin: EdgeInsets.only(bottom: 20),
                                          text:
                                              '* Quoted price inclusive of gst and tax',
                                          style: pw.TextStyle(
                                              font: font,

                                              /// fontWeight: pw.FontWeight.bold,
                                              fontSize: 12),
                                        ))),
                                    pw.SizedBox(height: 20),
                                    pw.SizedBox(
                                        width: 480,
                                        child: pw.Container(
                                            child: pw.Paragraph(
                                          //margin: EdgeInsets.only(bottom: 20),
                                          text:
                                              '* Transportation is free for delivery',
                                          style: pw.TextStyle(
                                            fontSize: 12,
                                            font: font,
                                          ),
                                        ))),
                                    pw.SizedBox(height: 2),
                                    pw.SizedBox(
                                        width: 480,
                                        child: pw.Container(
                                            child: pw.Paragraph(
                                          //margin: EdgeInsets.only(bottom: 20),
                                          text:
                                              '* unloading is parties responsibility',
                                          style: pw.TextStyle(
                                            fontSize: 12,
                                            font: font,
                                          ),
                                        ))),
                                    pw.SizedBox(height: 2),
                                    pw.SizedBox(
                                        width: 480,
                                        child: pw.Container(
                                            child: pw.Paragraph(
                                          //margin: EdgeInsets.only(bottom: 20),
                                          text: '* 1% breaking normal',
                                          style: pw.TextStyle(
                                            fontSize: 12,
                                            font: font,
                                          ),
                                        ))),
                                    pw.SizedBox(height: 2),
                                    // pw.Container(
                                    //     height: 1,
                                    //     color: PdfColors.black,
                                    //     width: 400),
                                  ])),
                          // pw.Container(
                          //     width: 1, color: PdfColors.black, height: 329),
                        ]),
                  )),
            ]),
      ),
    );
    var pathi = pat.toString();
    log(pat);
    final file = File('$pat/filesssss.pdf');

    File(file.toString()).create(recursive: true);
    var pdffile = await file.writeAsBytes(await pdf.save());

    if (Permission.manageExternalStorage.status ==
            PermissionStatus.permanentlyDenied ||
        Permission.manageExternalStorage.status == PermissionStatus.denied) {
      await Permission.manageExternalStorage.request();
    } else {
      if (pdfData.length > 0) {
        OpenFilex.open(pdffile.path);
      } else {
        Get.snackbar('No data', 'There is no data found to export',
            backgroundColor: Colors.black45, colorText: Colors.white);
        HapticFeedback.vibrate();
      }
    }

//final font = await PdfGoogleFonts.nunitoExtraLight();
  }
}

//   exportPdf(var data, String heading) async {
//     final pdf = pw.Document();
//     final ByteData bytes = await rootBundle.load('assets/33.png');
//     final Uint8List byteList = bytes.buffer.asUint8List();

//     pdf.addPage(
//       pw.MultiPage(
//         crossAxisAlignment: pw.CrossAxisAlignment.center,
//         maxPages: 50,
//         build: ((context) => [
//               pw.Image(
//                   pw.MemoryImage(
//                     byteList,
//                   ),
//                   //  fit: pw.BoxFit.fitHeight
//                   height: 80,
//                   width: 80),
//               pw.Padding(
//                 padding: pw.EdgeInsets.only(top: 2),
//                 child: pw.Container(
//                     width: 500,
//                     height: 40,
//                     color: PdfColors.grey,
//                     child: pw.Padding(
//                         padding: pw.EdgeInsets.only(left: 210, top: 20),
//                         child: pw.Container(
//                             // width: 500,
//                             // height: 40,
//                             color: PdfColors.grey,
//                             child: pw.Text("PROFORMA",
//                                 style: pw.TextStyle(
//                                     fontWeight: pw.FontWeight.bold,
//                                     color: PdfColors.white))))),
//               ),
//               pw.Container(
//                   height: 400,
//                   //width: 500,
//                   color: PdfColors.black,
//                   child: pw.Container(
//                     height: 298,
//                     color: PdfColors.white,
//                     child: pw.Row(
//                         crossAxisAlignment: pw.CrossAxisAlignment.start,
//                         children: [
//                           pw.Container(
//                               width: 1, color: PdfColors.black, height: 369),
//                           pw.Container(
//                               width: 240,
//                               color: PdfColors.white,
//                               child: pw.Column(
//                                   crossAxisAlignment:
//                                       pw.CrossAxisAlignment.start,
//                                   children: [
//                                     pw.Container(
//                                         width: 500,
//                                         color: PdfColors.white,
//                                         child: pw.Column(
//                                             crossAxisAlignment:
//                                                 pw.CrossAxisAlignment.start,
//                                             children: [
//                                               pw.Container(
//                                                   height: 1,
//                                                   color: PdfColors.black,
//                                                   width: 480),

//                                               pw.SizedBox(height: 5),
//                                               // pw.Container(
//                                               //     height: 1,
//                                               //     color: PdfColors.black),
//                                               pw.SizedBox(height: 5),
//                                               pw.SizedBox(
//                                                   width: 190,
//                                                   child: pw.Container(
//                                                       child: pw.Paragraph(
//                                                     //margin: EdgeInsets.only(bottom: 20),
//                                                     text: ' Super Stockist 1 :',
//                                                     style: pw.TextStyle(
//                                                         fontWeight:
//                                                             pw.FontWeight.bold,
//                                                         fontSize: 19),
//                                                   ))),
//                                               pw.SizedBox(height: 20),
//                                               pw.SizedBox(
//                                                   width: 190,
//                                                   child: pw.Container(
//                                                       child: pw.Paragraph(
//                                                     //margin: EdgeInsets.only(bottom: 20),
//                                                     text: ' Thayyil',
//                                                     style: pw.TextStyle(
//                                                         fontSize: 12),
//                                                   ))),
//                                               pw.SizedBox(height: 2),
//                                               pw.SizedBox(
//                                                   width: 190,
//                                                   child: pw.Container(
//                                                       child: pw.Paragraph(
//                                                     //margin: EdgeInsets.only(bottom: 20),
//                                                     text: ' chembra',
//                                                     style: pw.TextStyle(
//                                                         fontSize: 12),
//                                                   ))),
//                                               pw.SizedBox(height: 2),
//                                               pw.SizedBox(
//                                                   width: 190,
//                                                   child: pw.Container(
//                                                       child: pw.Paragraph(
//                                                     //margin: EdgeInsets.only(bottom: 20),
//                                                     text: ' kerala',
//                                                     style: pw.TextStyle(
//                                                         fontSize: 12),
//                                                   ))),
//                                               pw.SizedBox(height: 2),
//                                               pw.SizedBox(
//                                                   width: 190,
//                                                   child: pw.Container(
//                                                       child: pw.Paragraph(
//                                                     //margin: EdgeInsets.only(bottom: 20),
//                                                     text: ' India',
//                                                     style: pw.TextStyle(
//                                                         fontSize: 12),
//                                                   ))),
//                                             ])),
//                                     pw.SizedBox(height: 5),
//                                     pw.SizedBox(
//                                         width: 190,
//                                         child: pw.Container(
//                                             child: pw.Paragraph(
//                                           //margin: EdgeInsets.only(bottom: 20),
//                                           text: ' Quotation For',
//                                           style: pw.TextStyle(
//                                               fontWeight: pw.FontWeight.bold,
//                                               fontSize: 19),
//                                         ))),
//                                     pw.SizedBox(height: 20),
//                                     pw.SizedBox(
//                                         width: 190,
//                                         child: pw.Container(
//                                             child: pw.Paragraph(
//                                           //margin: EdgeInsets.only(bottom: 20),
//                                           text: ' Super Stockist calicut',
//                                           style: pw.TextStyle(fontSize: 12),
//                                         ))),
//                                     pw.SizedBox(height: 2),
//                                     pw.SizedBox(
//                                         width: 190,
//                                         child: pw.Container(
//                                             child: pw.Paragraph(
//                                           //margin: EdgeInsets.only(bottom: 20),
//                                           text: ' kozhikod',
//                                           style: pw.TextStyle(fontSize: 12),
//                                         ))),
//                                     pw.SizedBox(height: 2),
//                                     pw.SizedBox(
//                                         width: 190,
//                                         child: pw.Container(
//                                             child: pw.Paragraph(
//                                           //margin: EdgeInsets.only(bottom: 20),
//                                           text: ' kerala',
//                                           style: pw.TextStyle(fontSize: 12),
//                                         ))),
//                                     pw.SizedBox(height: 2),
//                                     pw.SizedBox(
//                                         width: 190,
//                                         child: pw.Container(
//                                             child: pw.Paragraph(
//                                           //margin: EdgeInsets.only(bottom: 20),
//                                           text: ' India',
//                                           style: pw.TextStyle(fontSize: 12),
//                                         ))),
//                                     pw.Container(
//                                         height: 1,
//                                         color: PdfColors.black,
//                                         width: 480),
//                                   ])),
//                           pw.Container(
//                               width: 1, color: PdfColors.black, height: 369),
//                           pw.Container(
//                               width: 240,
//                               color: PdfColors.white,
//                               child: pw.Column(
//                                   crossAxisAlignment:
//                                       pw.CrossAxisAlignment.start,
//                                   children: [
//                                     pw.Container(
//                                         width: 500,
//                                         color: PdfColors.white,
//                                         child: pw.Column(
//                                             crossAxisAlignment:
//                                                 pw.CrossAxisAlignment.start,
//                                             children: [
//                                               pw.Container(
//                                                   height: 1,
//                                                   color: PdfColors.black,
//                                                   width: 480),

//                                               pw.SizedBox(height: 5),
//                                               // pw.Container(
//                                               //     height: 1,
//                                               //     color: PdfColors.black),
//                                               pw.SizedBox(height: 5),
//                                               pw.SizedBox(
//                                                   width: 190,
//                                                   child: pw.Container(
//                                                       child: pw.Paragraph(
//                                                     //margin: EdgeInsets.only(bottom: 20),
//                                                     text: ' Date :3/7/2022',
//                                                     style: pw.TextStyle(
//                                                         fontSize: 12),
//                                                   ))),
//                                               pw.SizedBox(height: 2),
//                                               pw.SizedBox(
//                                                   width: 190,
//                                                   child: pw.Container(
//                                                       child: pw.Paragraph(
//                                                     //margin: EdgeInsets.only(bottom: 20),
//                                                     text: ' No of lead:66789',
//                                                     style: pw.TextStyle(
//                                                         fontSize: 12),
//                                                   ))),
//                                               pw.SizedBox(height: 2),

//                                               pw.Container(
//                                                   height: 1,
//                                                   color: PdfColors.black,
//                                                   width: 480),

//                                               pw.SizedBox(
//                                                   width: 190,
//                                                   child: pw.Container(
//                                                       height: 90,
//                                                       child: pw.Row(children: [
//                                                         pw.Paragraph(
//                                                           //margin: EdgeInsets.only(bottom: 20),
//                                                           text:
//                                                               ' QOUTATION MADE BY :',
//                                                           style: pw.TextStyle(
//                                                               fontSize: 10,
//                                                               fontWeight: pw
//                                                                   .FontWeight
//                                                                   .bold),
//                                                         ),
//                                                         pw.Expanded(
//                                                             child: pw.Paragraph(
//                                                           //margin: EdgeInsets.only(bottom: 20),
//                                                           text: 'Arun',
//                                                           style: pw.TextStyle(
//                                                               fontSize: 10),
//                                                         ))
//                                                       ]))),
//                                             ])),
//                                     pw.Container(
//                                         height: 1,
//                                         color: PdfColors.black,
//                                         width: 480),
//                                     pw.Container(height: 202.5),
//                                     pw.Container(
//                                         height: 1,
//                                         color: PdfColors.black,
//                                         width: 480),
//                                   ])),
//                           pw.Container(
//                               width: 1, color: PdfColors.black, height: 369),
//                         ]),
//                   )),
//               pw.Container(
//                 color: PdfColors.blue,
//                 child: pw.Row(children: [
//                   pw.Expanded(
//                     child: pw.Text(
//                       'sl No',
//                     ),
//                   ),
//                   pw.Expanded(
//                     child: pw.Text(
//                       'Product',
//                     ),
//                   ),
//                   pw.Expanded(
//                     child: pw.Text(
//                       'Series',
//                     ),
//                   ),
//                   pw.Expanded(
//                     child: pw.Text(
//                       'Qty',
//                     ),
//                   ),
//                   pw.Expanded(
//                     child: pw.Text(
//                       'Total',
//                     ),
//                   ),
//                   // pw.SizedBox(
//                   //     width: 75, child: pw.Column(children: [pw.Text("Arundas")]))
//                 ]),
//               ),
//               pw.ListView.builder(
//                   itemBuilder: ((context, i) => pw.Column(children: [
//                         pw.Row(children: [
//                           pw.Expanded(
//                             child: pw.Text(
//                               'sl No',
//                             ),
//                           ),
//                           pw.Expanded(
//                             child: pw.Text(
//                               'Product',
//                             ),
//                           ),
//                           pw.Expanded(
//                             child: pw.Text(
//                               'Series',
//                             ),
//                           ),
//                           pw.Expanded(
//                             child: pw.Text(
//                               'Qty',
//                             ),
//                           ),
//                           pw.Expanded(
//                             child: pw.Text(
//                               'Total',
//                             ),
//                           ),
//                         ]),
//                       ])),
//                   itemCount: 2),
//               pw.Container(
//                 color: PdfColors.grey,
//                 child: pw.Row(children: [
//                   pw.Expanded(child: pw.Container()),
//                   pw.Expanded(child: pw.Container()),
//                   pw.Expanded(child: pw.Container()),
//                   pw.Expanded(
//                     child: pw.Text(
//                       'Total',
//                     ),
//                   ),
//                   pw.Expanded(
//                     child: pw.Text(
//                       '500',
//                     ),
//                   ),
//                   // pw.SizedBox(
//                   //     width: 75, child: pw.Column(children: [pw.Text("Arundas")]))
//                 ]),
//               ),
//               pw.Container(
//                   height: 350,
//                   //width: 500,
//                   color: PdfColors.black,
//                   child: pw.Container(
//                     height: 298,
//                     color: PdfColors.white,
//                     child: pw.Row(
//                         crossAxisAlignment: pw.CrossAxisAlignment.start,
//                         children: [
//                           pw.Container(
//                               width: 1, color: PdfColors.black, height: 327),
//                           pw.Container(
//                               width: 480,
//                               color: PdfColors.white,
//                               child: pw.Column(
//                                   crossAxisAlignment:
//                                       pw.CrossAxisAlignment.start,
//                                   children: [
//                                     pw.Container(
//                                         width: 500,
//                                         color: PdfColors.white,
//                                         child: pw.Column(
//                                             crossAxisAlignment:
//                                                 pw.CrossAxisAlignment.start,
//                                             children: [
//                                               pw.Container(
//                                                   height: 1,
//                                                   color: PdfColors.black,
//                                                   width: 480),

//                                               //  pw.SizedBox(height: 5),
//                                               // pw.Container(
//                                               //     height: 1,
//                                               //     color: PdfColors.black),
//                                               // pw.SizedBox(height: 5),
//                                               pw.SizedBox(
//                                                   width: 500,
//                                                   child: pw.Container(
//                                                       height: 40,
//                                                       color: PdfColors.blue,
//                                                       child: pw.Paragraph(
//                                                         //margin: EdgeInsets.only(bottom: 20),
//                                                         text:
//                                                             ' TERMS AND CONDITION :',
//                                                         style: pw.TextStyle(
//                                                             fontWeight: pw
//                                                                 .FontWeight
//                                                                 .bold,
//                                                             fontSize: 19),
//                                                       ))),
//                                               pw.SizedBox(height: 20),
//                                               pw.SizedBox(
//                                                   width: 480,
//                                                   child: pw.Container(
//                                                       child: pw.Paragraph(
//                                                     //margin: EdgeInsets.only(bottom: 20),
//                                                     text:
//                                                         '* 30 of total amount should be aid in advance',
//                                                     style: pw.TextStyle(
//                                                         fontSize: 12),
//                                                   ))),
//                                               pw.SizedBox(height: 2),
//                                               pw.SizedBox(
//                                                   width: 480,
//                                                   child: pw.Container(
//                                                       child: pw.Paragraph(
//                                                     //margin: EdgeInsets.only(bottom: 20),
//                                                     text:
//                                                         '* Balance amount should be paid before container arrival port',
//                                                     style: pw.TextStyle(
//                                                         fontSize: 12),
//                                                   ))),
//                                               pw.SizedBox(height: 2),
//                                               pw.SizedBox(
//                                                   width: 480,
//                                                   child: pw.Container(
//                                                       child: pw.Paragraph(
//                                                     //margin: EdgeInsets.only(bottom: 20),
//                                                     text:
//                                                         '* Any increase in shipping or purchase charges will result increases in material price',
//                                                     style: pw.TextStyle(
//                                                         fontSize: 12),
//                                                   ))),
//                                               pw.SizedBox(height: 2),
//                                               pw.SizedBox(
//                                                   width: 480,
//                                                   child: pw.Container(
//                                                       child: pw.Paragraph(
//                                                     //margin: EdgeInsets.only(bottom: 20),
//                                                     text:
//                                                         '* This Qutation is valid for 15 days',
//                                                     style: pw.TextStyle(
//                                                         fontSize: 12),
//                                                   ))),
//                                             ])),
//                                     pw.SizedBox(height: 5),
//                                     pw.SizedBox(
//                                         width: 480,
//                                         child: pw.Container(
//                                             child: pw.Paragraph(
//                                           //margin: EdgeInsets.only(bottom: 20),
//                                           text:
//                                               '* Quoted price inclusive of gst and tax',
//                                           style: pw.TextStyle(

//                                               /// fontWeight: pw.FontWeight.bold,
//                                               fontSize: 12),
//                                         ))),
//                                     pw.SizedBox(height: 20),
//                                     pw.SizedBox(
//                                         width: 480,
//                                         child: pw.Container(
//                                             child: pw.Paragraph(
//                                           //margin: EdgeInsets.only(bottom: 20),
//                                           text:
//                                               '* Transportation is free for delivery',
//                                           style: pw.TextStyle(fontSize: 12),
//                                         ))),
//                                     pw.SizedBox(height: 2),
//                                     pw.SizedBox(
//                                         width: 480,
//                                         child: pw.Container(
//                                             child: pw.Paragraph(
//                                           //margin: EdgeInsets.only(bottom: 20),
//                                           text:
//                                               '* unloading is parties responsibility',
//                                           style: pw.TextStyle(fontSize: 12),
//                                         ))),
//                                     pw.SizedBox(height: 2),
//                                     pw.SizedBox(
//                                         width: 480,
//                                         child: pw.Container(
//                                             child: pw.Paragraph(
//                                           //margin: EdgeInsets.only(bottom: 20),
//                                           text: '* 1% breaking normal',
//                                           style: pw.TextStyle(fontSize: 12),
//                                         ))),
//                                     pw.SizedBox(height: 2),
//                                     pw.Container(
//                                         height: 1,
//                                         color: PdfColors.black,
//                                         width: 480),
//                                   ])),
//                           pw.Container(
//                               width: 1, color: PdfColors.black, height: 329),
//                         ]),
//                   )),
//             ]),
//       ),
//     );
// //final font = await PdfGoogleFonts.nunitoExtraLight();
//     var path = '/storage/emulated/0/Documents/lamit.pdf';
//     final file = File(path);
//     var pdffile = await file.writeAsBytes(await pdf.save());

//     if (Permission.manageExternalStorage.status ==
//             PermissionStatus.permanentlyDenied ||
//         Permission.manageExternalStorage.status == PermissionStatus.denied) {
//       await Permission.manageExternalStorage.request();
//     } else {
//       if (pdfData.length > 0) {
//         OpenFilex.open(pdffile.path);
//       } else {
//         Get.snackbar('No data', 'There is no data found to export',
//             backgroundColor: Colors.black45, colorText: Colors.white);
//         HapticFeedback.vibrate();
//       }
//     }
//   }
// }
//https://lamit.erpeaz.com/api/resource/Task?fields=["name","mobile","subject","contact_time_in_hour","contact_time_in_min","time2","lead_name","contact_to_time_in_hour","contact_to_time_in_min","time1"]&filters=[["task_type","=","Visit"],["status","=","Overdue"],["assign","=","SO500"]]
//https://lamit.erpeaz.com/api/resource/Target?filters=[[%22employee%22,%22=%22,%22SOF-66%22],[%22active%22,%22=%22,%221%22]]&fields=[%22employee_name%22,%22effective_from%22,%22target%22,%22total_visit%22,%22new_customer%22]

// https://lamit.erpeaz.com/api/resource/Lead?filters=[["new_lead", "=", "1"]]

//https://lamit.erpeaz.com/api/resource/Lead?filters=[["lac", "in", ["VADAKARA","Kollam"]],["status", "=", "Hot"]]&fields=["*"]
