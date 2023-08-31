import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as developer;
import 'package:get/get.dart';

import 'package:lamit/app/modules/dash/views/dash_view.dart';
import 'package:lamit/app/modules/home/controllers/home_controller.dart';
import 'package:lamit/app/modules/leadadd/views/leadadd_view.dart';
import 'package:lamit/app/modules/login/views/login_view.dart';
import 'package:lamit/app/modules/tools/views/tools_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  final String? edit;
  // final String? name;
  // final String? empid;

  HomeView(
    this.edit,
  );

  final controller = Get.put(HomeController());

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  String? akey;
  String? skey;
  String? email;
  int _index = 0;
  var ctime;
  String? id;

  final List<Widget> _children = [
    DashView("", ""),
    // LeadView(),
    ToolsView(),
  ];
  final List<Widget> children = [
    // LeadView(),
    ToolsView(),
    DashView("", "isedit"),
  ];

  @override
  void initState() {
    //Get.put(HomeController());
    //  loguserdetails();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    initConnectivity();
    log(_connectionStatus.toString() + "mmkmmmmmmmmmmmmmmmmmmmmm");
    // _connectivitySubscription =
    //     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    getsf();
    getsf();
    //id=widget.edit;
    super.initState();
  }

  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
      log(result.toString() + "vvvvvvvvvvvvvvvvvvvvvvvvv");
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      log(result.toString() + "xxxxvvvvvvvvvvvvvvvvvvvvvvvv");
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
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
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        bottomNavigationBar: widget.edit != "isedit"
            ? Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: BottomNavigationBar(
                  unselectedItemColor: Colors.white,
                  selectedItemColor: Colors.grey,
                  backgroundColor: Color.fromARGB(255, 4, 7, 105),
                  onTap: onTabTapped,
                  currentIndex: _index,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.dashboard),
                      label: 'Dashboard',
                    ),
                    // BottomNavigationBarItem(
                    //   icon: Icon(Icons.leaderboard),
                    //   label: 'Lead',
                    // ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.people,
                      ),
                      label: 'Customer',
                    )
                  ],
                ),
              )
            : Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: BottomNavigationBar(
                  unselectedItemColor: Colors.white,
                  selectedItemColor: Colors.grey,
                  backgroundColor: Color.fromARGB(255, 4, 7, 105),
                  onTap: onTabTapped,
                  currentIndex: _index,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.event),
                      label: 'Event',
                    ),
                    // BottomNavigationBarItem(
                    //   icon: Icon(Icons.leaderboard),
                    //   label: 'Lead',
                    // ),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.dashboard,
                        ),
                        label: 'Dashboard')
                  ],
                ),
              ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(),
          child: Container(
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 40,
                  child: Container(
                      color: Colors.white,
                      child: FloatingActionButton(
                          backgroundColor: Color.fromARGB(255, 4, 7, 105),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Get.to(LeadaddView("", "", "", "", "", "", "", "",
                                "", "", "", "", "", "", "","",""));
                          })),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 90, left: 10),
                  child: Text(
                    "Lead Create",
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // appBar: AppBar(
        //   leading: Padding(
        //     padding: const EdgeInsets.only(left: 30),
        //     child: Container(
        //       // height: 200,
        //       child: Column(
        //         children: [
        //           SizedBox(
        //             height: 20,
        //           ),
        //           GestureDetector(
        //             onTap: () {
        //               logout();
        //             },
        //             child: Container(
        //               child: Icon(
        //                 Icons.menu,
        //                 color: Colors.black,
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        //   // title: Container(
        //   //   height: 200,
        //   //   child: Row(
        //   //     children: [
        //   //       Column(
        //   //         children: [
        //   //           SizedBox(
        //   //             height: 40,
        //   //           ),
        //   //           Text(
        //   //               _children[_index].toString() != "DashView"
        //   //                   ? "DASHBOARD"
        //   //                   : "TOOLS",
        //   //               style: TextStyle(
        //   //                   fontSize: 18,
        //   //                   color: Color.fromARGB(255, 7, 38, 210),
        //   //                   fontWeight: FontWeight.bold)),
        //   //         ],
        //   //       ),
        //   //       Expanded(child: Container()),
        //   //     ],
        //   //   ),
        //   // ),
        //   // // centerTitle: true,
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        // ),

        body: _connectionStatus.toString() == "ConnectivityResult.none"
            ? Padding(
                padding: const EdgeInsets.only(top: 300.0),
                child: Center(
                  child: Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "Check your network connection status",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
                ),
              )
            : WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    child: Column(
                      children: [
                        widget.edit != "isedit"
                            ? Expanded(child: _children[_index])
                            : Expanded(child: children[_index])

                        // SizedBox(
                        //   height: 30,
                        // ),
                        // Container(
                        //     height: 80,
                        //     width: 80,
                        //     decoration: new BoxDecoration(
                        //         image: new DecorationImage(
                        //       image: new AssetImage("assets/logo-svg.png"),
                        //       fit: BoxFit.fill,
                        //     ))),
                        // Expanded(
                        //   child: CustomScrollView(
                        //     primary: false,
                        //     slivers: <Widget>[
                        //       SliverPadding(
                        //         padding: const EdgeInsets.all(30),
                        //         sliver: SliverGrid.count(
                        //           crossAxisSpacing: 10,
                        //           mainAxisSpacing: 10,
                        //           crossAxisCount: 2,
                        //           children: <Widget>[
                        //             GestureDetector(
                        //               onTap: (() {
                        //                 Get.to(CustomrcreationView());
                        //               }),
                        //               child: Container(
                        //                 decoration: BoxDecoration(
                        //                     color: Colors.white,
                        //                     border: Border.all(
                        //                       color: Colors.black,
                        //                     ),
                        //                     borderRadius: BorderRadius.all(
                        //                         Radius.circular(20))),
                        //                 padding: const EdgeInsets.all(8),
                        //                 child: Column(
                        //                   children: [
                        //                     Padding(
                        //                       padding: const EdgeInsets.all(8.0),
                        //                       child: GestureDetector(
                        //                         onTap: (() {
                        //                           Get.to(CustomrcreationView());
                        //                         }),
                        //                         child: Container(
                        //                             height: 60,
                        //                             width: 60,
                        //                             decoration: new BoxDecoration(
                        //                                 image: new DecorationImage(
                        //                               image: new AssetImage(
                        //                                   "assets/add.png"),
                        //                               fit: BoxFit.fill,
                        //                             ))),
                        //                       ),
                        //                     ),
                        //                     SizedBox(
                        //                       height: 10,
                        //                     ),
                        //                     Text(
                        //                       "Lead",
                        //                       style: TextStyle(
                        //                           fontSize: 12,
                        //                           fontWeight: FontWeight.bold),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //             ),
                        //             GestureDetector(
                        //               onTap: (() {
                        //                 Get.to(CustomrlistView());
                        //               }),
                        //               child: Container(
                        //                 decoration: BoxDecoration(
                        //                     color: Colors.white,
                        //                     border: Border.all(
                        //                       color: Colors.black,
                        //                     ),
                        //                     borderRadius: BorderRadius.all(
                        //                         Radius.circular(20))),
                        //                 padding: const EdgeInsets.all(8),
                        //                 child: Column(
                        //                   children: [
                        //                     Padding(
                        //                       padding: const EdgeInsets.all(8.0),
                        //                       child: Container(
                        //                           height: 60,
                        //                           width: 60,
                        //                           decoration: new BoxDecoration(
                        //                               image: new DecorationImage(
                        //                             image: new AssetImage(
                        //                                 "assets/summary_report.png"),
                        //                             fit: BoxFit.fill,
                        //                           ))),
                        //                     ),
                        //                     SizedBox(
                        //                       height: 10,
                        //                     ),
                        //                     Text(
                        //                       "Lead List",
                        //                       style: TextStyle(
                        //                           fontSize: 12,
                        //                           fontWeight: FontWeight.bold),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //             ),
                        //             GestureDetector(
                        //               onTap: (() {
                        //                 Get.to(CustomrcreationView());
                        //               }),
                        //               child: Container(
                        //                 decoration: BoxDecoration(
                        //                     color: Colors.white,
                        //                     border: Border.all(
                        //                       color: Colors.black,
                        //                     ),
                        //                     borderRadius: BorderRadius.all(
                        //                         Radius.circular(20))),
                        //                 padding: const EdgeInsets.all(8),
                        //                 child: Column(
                        //                   children: [
                        //                     Padding(
                        //                       padding: const EdgeInsets.all(8.0),
                        //                       child: GestureDetector(
                        //                         onTap: (() {
                        //                           Get.to(CustomrcreationView());
                        //                         }),
                        //                         child: Container(
                        //                             height: 60,
                        //                             width: 60,
                        //                             decoration: new BoxDecoration(
                        //                                 image: new DecorationImage(
                        //                               image: new AssetImage(
                        //                                   "assets/cr.png"),
                        //                               fit: BoxFit.fill,
                        //                             ))),
                        //                       ),
                        //                     ),
                        //                     SizedBox(
                        //                       height: 10,
                        //                     ),
                        //                     Text(
                        //                       "Customer Creation",
                        //                       style: TextStyle(
                        //                           fontSize: 12,
                        //                           fontWeight: FontWeight.bold),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //             ),
                        //             GestureDetector(
                        //               onTap: (() {
                        //                 Get.to(CustomrlistView());
                        //               }),
                        //               child: Container(
                        //                 decoration: BoxDecoration(
                        //                     color: Colors.white,
                        //                     border: Border.all(
                        //                       color: Colors.black,
                        //                     ),
                        //                     borderRadius: BorderRadius.all(
                        //                         Radius.circular(20))),
                        //                 padding: const EdgeInsets.all(8),
                        //                 child: Column(
                        //                   children: [
                        //                     Padding(
                        //                       padding: const EdgeInsets.all(8.0),
                        //                       child: Container(
                        //                           height: 60,
                        //                           width: 60,
                        //                           decoration: new BoxDecoration(
                        //                               image: new DecorationImage(
                        //                             image: new AssetImage(
                        //                                 "assets/customer.png"),
                        //                             fit: BoxFit.fill,
                        //                           ))),
                        //                     ),
                        //                     SizedBox(
                        //                       height: 10,
                        //                     ),
                        //                     Text(
                        //                       "Customer List",
                        //                       style: TextStyle(
                        //                           fontSize: 12,
                        //                           fontWeight: FontWeight.bold),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //             ),
                        //             GestureDetector(
                        //               onTap: () {
                        //                 Get.to(OrderView());
                        //               },
                        //               child: Container(
                        //                 decoration: BoxDecoration(
                        //                     color: Colors.white,
                        //                     border: Border.all(
                        //                       color: Colors.black,
                        //                     ),
                        //                     borderRadius: BorderRadius.all(
                        //                         Radius.circular(20))),
                        //                 padding: const EdgeInsets.all(8),
                        //                 child: Column(
                        //                   children: [
                        //                     Padding(
                        //                       padding: const EdgeInsets.all(8.0),
                        //                       child: Container(
                        //                           height: 60,
                        //                           width: 60,
                        //                           decoration: new BoxDecoration(
                        //                               image: new DecorationImage(
                        //                             image: new AssetImage(
                        //                                 "assets/inovice.png"),
                        //                             fit: BoxFit.fill,
                        //                           ))),
                        //                     ),
                        //                     SizedBox(
                        //                       height: 10,
                        //                     ),
                        //                     Text(
                        //                       "Order",
                        //                       style: TextStyle(
                        //                           fontSize: 12,
                        //                           fontWeight: FontWeight.bold),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //             ),
                        //             GestureDetector(
                        //               onTap: (() {
                        //                 Get.to(OrderlistView());
                        //               }),
                        //               child: Container(
                        //                 decoration: BoxDecoration(
                        //                     color: Colors.white,
                        //                     border: Border.all(
                        //                       color: Colors.black,
                        //                     ),
                        //                     borderRadius: BorderRadius.all(
                        //                         Radius.circular(20))),
                        //                 padding: const EdgeInsets.all(8),
                        //                 child: Column(
                        //                   children: [
                        //                     Padding(
                        //                       padding: const EdgeInsets.all(8.0),
                        //                       child: Container(
                        //                           height: 60,
                        //                           width: 60,
                        //                           decoration: new BoxDecoration(
                        //                               image: new DecorationImage(
                        //                             image: new AssetImage(
                        //                                 "assets/sales-report.png"),
                        //                             fit: BoxFit.fill,
                        //                           ))),
                        //                     ),
                        //                     SizedBox(
                        //                       height: 10,
                        //                     ),
                        //                     Text(
                        //                       "Order Report",
                        //                       style: TextStyle(
                        //                           fontSize: 12,
                        //                           fontWeight: FontWeight.bold),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //             ),
                        //             GestureDetector(
                        //               onTap: () {
                        //                 Get.to(AddcollectView());
                        //               },
                        //               child: Container(
                        //                 decoration: BoxDecoration(
                        //                     color: Colors.white,
                        //                     border: Border.all(
                        //                       color: Colors.black,
                        //                     ),
                        //                     borderRadius: BorderRadius.all(
                        //                         Radius.circular(20))),
                        //                 padding: const EdgeInsets.all(8),
                        //                 child: Column(
                        //                   children: [
                        //                     Padding(
                        //                       padding: const EdgeInsets.all(8.0),
                        //                       child: Container(
                        //                           height: 60,
                        //                           width: 60,
                        //                           decoration: new BoxDecoration(
                        //                               image: new DecorationImage(
                        //                             image: new AssetImage(
                        //                                 "assets/collection.png"),
                        //                             fit: BoxFit.fill,
                        //                           ))),
                        //                     ),
                        //                     SizedBox(
                        //                       height: 10,
                        //                     ),
                        //                     Text(
                        //                       "Add Collection",
                        //                       style: TextStyle(
                        //                           fontSize: 12,
                        //                           fontWeight: FontWeight.bold),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //             ),
                        //             GestureDetector(
                        //               onTap: () {
                        //                 Get.to(CollectionreportView());
                        //               },
                        //               child: Container(
                        //                 decoration: BoxDecoration(
                        //                     color: Colors.white,
                        //                     border: Border.all(
                        //                       color: Colors.black,
                        //                     ),
                        //                     borderRadius: BorderRadius.all(
                        //                         Radius.circular(20))),
                        //                 padding: const EdgeInsets.all(8),
                        //                 child: Column(
                        //                   children: [
                        //                     Padding(
                        //                       padding: const EdgeInsets.all(8.0),
                        //                       child: Container(
                        //                           height: 60,
                        //                           width: 60,
                        //                           decoration: new BoxDecoration(
                        //                               image: new DecorationImage(
                        //                             image: new AssetImage(
                        //                                 "assets/collection report.png"),
                        //                             fit: BoxFit.fill,
                        //                           ))),
                        //                     ),
                        //                     SizedBox(
                        //                       height: 10,
                        //                     ),
                        //                     Text(
                        //                       "Collection Report",
                        //                       style: TextStyle(
                        //                           fontSize: 12,
                        //                           fontWeight: FontWeight.bold),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //             ),
                        //             GestureDetector(
                        //               onTap: () {
                        //                 Get.to(LedgerView());
                        //               },
                        //               child: Container(
                        //                 decoration: BoxDecoration(
                        //                     color: Colors.white,
                        //                     border: Border.all(
                        //                       color: Colors.black,
                        //                     ),
                        //                     borderRadius: BorderRadius.all(
                        //                         Radius.circular(20))),
                        //                 padding: const EdgeInsets.all(8),
                        //                 child: Column(
                        //                   children: [
                        //                     Padding(
                        //                       padding: const EdgeInsets.all(8.0),
                        //                       child: Container(
                        //                           height: 60,
                        //                           width: 60,
                        //                           decoration: new BoxDecoration(
                        //                               image: new DecorationImage(
                        //                             image: new AssetImage(
                        //                                 "assets/ledger_add.png"),
                        //                             fit: BoxFit.fill,
                        //                           ))),
                        //                     ),
                        //                     SizedBox(
                        //                       height: 10,
                        //                     ),
                        //                     Text(
                        //                       "Ledger",
                        //                       style: TextStyle(
                        //                           fontSize: 12,
                        //                           fontWeight: FontWeight.bold),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //             ),
                        //             GestureDetector(
                        //               onTap: () {
                        //                 Get.to(LedgerlistView());
                        //               },
                        //               child: Container(
                        //                 decoration: BoxDecoration(
                        //                     color: Colors.white,
                        //                     border: Border.all(
                        //                       color: Colors.black,
                        //                     ),
                        //                     borderRadius: BorderRadius.all(
                        //                         Radius.circular(20))),
                        //                 padding: const EdgeInsets.all(8),
                        //                 child: Column(
                        //                   children: [
                        //                     Padding(
                        //                       padding: const EdgeInsets.all(8.0),
                        //                       child: Container(
                        //                           height: 60,
                        //                           width: 60,
                        //                           decoration: new BoxDecoration(
                        //                               image: new DecorationImage(
                        //                             image: new AssetImage(
                        //                                 "assets/ledger .png"),
                        //                             fit: BoxFit.fill,
                        //                           ))),
                        //                     ),
                        //                     SizedBox(
                        //                       height: 10,
                        //                     ),
                        //                     Text(
                        //                       "Ledger List",
                        //                       style: TextStyle(
                        //                           fontSize: 12,
                        //                           fontWeight: FontWeight.bold),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //         color: Colors.blue[100],

                        //         //color: Colors.white,
                        //         border: Border.all(
                        //           color: Colors.black,
                        //         ),
                        //         borderRadius: BorderRadius.all(Radius.circular(20))),
                        //     child: ExpansionTile(
                        //       title: Text(
                        //         "Sales Billing",
                        //         style: TextStyle(
                        //             fontSize: 16.0, fontWeight: FontWeight.w500),
                        //       ),
                        //       children: <Widget>[
                        //         Container(
                        //           height: 170,
                        //           decoration: BoxDecoration(
                        //               // border: Border.all(
                        //               //   color: Colors.tr,
                        //               // ),
                        //               borderRadius:
                        //                   BorderRadius.all(Radius.circular(40))),
                        //           width: Constants(context).scrnWidth,
                        //           child: Card(
                        //             shape: RoundedRectangleBorder(
                        //               //<-- SEE HERE
                        //               side: BorderSide(
                        //                 color: Colors.black,
                        //               ),
                        //             ),
                        //             //color: Colors.blue[200],
                        //             child: Column(
                        //               children: [
                        //                 Row(
                        //                   children: [
                        //                     Expanded(
                        //                       child: GestureDetector(
                        //                         onTap: () {
                        //                           Get.to(SalesinvoiceView());
                        //                         },
                        //                         child: Container(
                        //                           child: Column(
                        //                             children: [
                        //                               Padding(
                        //                                 padding:
                        //                                     const EdgeInsets.all(8.0),
                        //                                 child: Container(
                        //                                     height: 40,
                        //                                     width: 40,
                        //                                     decoration:
                        //                                         new BoxDecoration(
                        //                                             image:
                        //                                                 new DecorationImage(
                        //                                       image: new AssetImage(
                        //                                           "assets/inovice.png"),
                        //                                       fit: BoxFit.fill,
                        //                                     ))),
                        //                               ),
                        //                               Text("Sales Invoice")
                        //                             ],
                        //                           ),
                        //                         ),
                        //                       ),
                        //                     ),
                        //                     Expanded(
                        //                       child: GestureDetector(
                        //                         onTap: (() {
                        //                           Get.to(SalesinvoicereportView());
                        //                         }),
                        //                         child: Container(
                        //                           child: Column(
                        //                             children: [
                        //                               Padding(
                        //                                 padding:
                        //                                     const EdgeInsets.all(8.0),
                        //                                 child: Container(
                        //                                     height: 40,
                        //                                     width: 40,
                        //                                     decoration:
                        //                                         new BoxDecoration(
                        //                                             image:
                        //                                                 new DecorationImage(
                        //                                       image: new AssetImage(
                        //                                           "assets/return.png"),
                        //                                       fit: BoxFit.fill,
                        //                                     ))),
                        //                               ),
                        //                               Text("Sales Report")
                        //                             ],
                        //                           ),
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 Row(
                        //                   children: [
                        //                     Expanded(
                        //                       child: GestureDetector(
                        //                         onTap: () {
                        //                           Get.to(SalesreturnView());
                        //                         },
                        //                         child: Container(
                        //                           child: Column(
                        //                             children: [
                        //                               Padding(
                        //                                 padding:
                        //                                     const EdgeInsets.all(8.0),
                        //                                 child: Container(
                        //                                     height: 40,
                        //                                     width: 40,
                        //                                     decoration:
                        //                                         new BoxDecoration(
                        //                                             image:
                        //                                                 new DecorationImage(
                        //                                       image: new AssetImage(
                        //                                           "assets/return.png"),
                        //                                       fit: BoxFit.fill,
                        //                                     ))),
                        //                               ),
                        //                               Text("Sales Return ")
                        //                             ],
                        //                           ),
                        //                         ),
                        //                       ),
                        //                     ),
                        //                     Expanded(
                        //                       child: Container(
                        //                         child: Column(
                        //                           children: [
                        //                             Padding(
                        //                               padding:
                        //                                   const EdgeInsets.all(8.0),
                        //                               child: Container(
                        //                                   height: 40,
                        //                                   width: 40,
                        //                                   decoration:
                        //                                       new BoxDecoration(
                        //                                           image:
                        //                                               new DecorationImage(
                        //                                     image: new AssetImage(
                        //                                         "assets/return_reports.png"),
                        //                                     fit: BoxFit.fill,
                        //                                   ))),
                        //                             ),
                        //                             Text("Sales Return Report")
                        //                           ],
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ],
                        //                 )
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //         // ListTile(
                        //         //   title: Text(
                        //         //     "items.description",
                        //         //     style: TextStyle(fontWeight: FontWeight.w700),
                        //         //   ),
                        //         // )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  // getsf() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();

  //   akey = preferences.getString("akey");
  //   skey = preferences.getString("skey");
  //   email = preferences.getString("email");

  //   print("haai");

  //   // email = preferences.getString("emailid");
  //   //  loguserdetails();
  // }

  logout() async {
    // print(Id.toString() + "idd");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();

    print(preferences);
    // http.Response response =
    //     await http.post(Uri.parse(logtURL), body: {"user_id": Id});
    // String datas = response.body;
    // log("dataas" + datas);

    // Navigator.pop(context);

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginView()),
        (Route<dynamic> route) => false);
  }

  getsf() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      id = preferences.getString("userid");
      //  name = preferences.getString("name");
    });

    print("idddddddddddddddddddddddddddddd" + id.toString());

    // newleadView(id.toString());
  }
}
