import 'dart:convert';
import 'dart:developer';

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lamit/app/modules/addactivity/views/addactivity_view.dart';
import 'package:http/http.dart' as http;
import 'package:lamit/app/modules/addlocation/views/addlocation_view.dart';
import 'package:lamit/app/modules/addnote/views/addnote_view.dart';
import 'package:lamit/app/modules/addnotes/views/addnotes_view.dart';
import 'package:lamit/app/modules/addressview/views/addressview_view.dart';
import 'package:lamit/app/modules/addtask/views/addtask_view.dart';
import 'package:lamit/app/modules/baisicdetail/views/baisicdetail_view.dart';
import 'package:lamit/app/modules/details/views/details_view.dart';
import 'package:lamit/app/modules/evetview/views/evetview_view.dart';
import 'package:lamit/app/modules/home/views/home_view.dart';
import 'package:lamit/app/modules/hotlead/views/hotlead_view.dart';
import 'package:lamit/app/modules/lead/views/lead_view.dart';
import 'package:lamit/app/modules/meentingupdateview/views/meentingupdateview_view.dart';
import 'package:lamit/app/modules/newleads/views/newleads_view.dart';

import 'package:lamit/app/modules/reminder/views/reminder_view.dart';
import 'package:lamit/app/modules/salesdetail/views/salesdetail_view.dart';

import 'package:lamit/app/modules/statusofsite/views/statusofsite_view.dart';
import 'package:lamit/app/routes/constants.dart';
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/widget/customeappbar.dart';

import '../../../../tocken/tockn.dart';
import '../../lead/views/lead-view-new.dart';

class LeaddetailsView extends StatefulWidget {
  final String? name;
  final String? status;
  final int? index;
  final String? email;
  final String? direction;
  final String? series;

  LeaddetailsView(this.name, this.status, this.index, this.email,
      this.direction, this.series);

  @override
  State<LeaddetailsView> createState() => _LeaddetailsViewState();
}

var selectedStatus;

class _LeaddetailsViewState extends State<LeaddetailsView> {
  // var selectedStatus;
  var productlist;
  @override
  void initState() {
    // TODO: implement initState
    selectedStatus = widget.status;

    detailView();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: WillPopScope(
        onWillPop: () async {
          if (widget.status == 'new') {
            return true;
          } else {
            widget.index == 1
                ? Get.to(HotleadView())
                : widget.index == 0
                    ? Get.to(LeadView())
                    : Get.to(NewleadsView());
            return false;
          }
        },
        child: Scaffold(
          // backgroundColor: HexColor("#EEf3f9"),
          //floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          // floatingActionButton: FloatingActionButton(
          //   // isExtended: true,
          //   child: Column(
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Text(
          //           "TASK",
          //           style: TextStyle(fontSize: 9),
          //         ),
          //       ),
          //       Icon(
          //         Icons.add,
          //         size: 13,
          //         color: Colors.black,
          //       ),
          //     ],
          //   ),
          //   // backgroundColor: Colors.blue,
          //   onPressed: () {
          //     setState(() {
          //       _showMyDialog();
          //     });
          //   },
          // ),
          // appBar: AppBar(
          //   elevation: 0,
          //   backgroundColor: HexColor("#EEf3f9"),
          //   // title: Container(height: 200, child: const Text('LEAD DETAIL')),
          //   // leading: Padding(
          //   //   padding: const EdgeInsets.all(8.0),
          //   //   child: Container(
          //   //     child: IconButton(
          //   //       icon: Icon(Icons.menu, color: Colors.black),
          //   //       onPressed: () => Navigator.of(context).pop(),
          //   //     ),
          //   //   ),
          //   // ),
          //   // centerTitle: true,
          // ),
          //   PreferredSize(
          //   preferredSize:
          //       Size(MediaQuery.of(context).size.width, kToolbarHeight),
          //   child: CustomAppBar(
          //     title: 'LEAD DETAILS',
          //   ),
          // ),

          appBar: PreferredSize(
            preferredSize:
                Size(MediaQuery.of(context).size.width, kToolbarHeight),
            child: CustomAppBar(
              title: 'LEAD DETAILS',
            ),
          ),
          body: WillPopScope(
            onWillPop: () async {
              Get.to(HomeView(""));
              return false;
            },
            child: Container(
              // color: HexColor("#EEf3f9"),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(SalesdetailView(widget.name, "leaddetail",
                                "", widget.email, "", widget.series));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                // color: Colors.white,
                                height: 30,
                                // width: 150,
                                // color: Colors.blue[100],
                                child: Row(
                                  children: [
                                    Center(
                                        child: Text(
                                      "ADD REQUIREMENT",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    )),
                                    Icon(
                                      Icons.add,
                                      color: Colors.black,
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Container(
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40.0),
                                topLeft: Radius.circular(40.0)),
                          ),
                          // shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.only(
                          //         topLeft: Radius.circular(40),
                          //         topRight: Radius.circular(40))),

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              //   scrollDirection: Axis.horizontal,
                              physics: NeverScrollableScrollPhysics(),
                              child: Container(
                                // color: Colors.blue,
                                width: Constants(context).scrnWidth,
                                height: Constants(context).scrnHeight + 200,
                                child: Container(
                                  child: ContainedTabBarView(
                                    tabBarProperties:
                                        TabBarProperties(isScrollable: true),
                                    // tabBarViewProperties: TabBarViewProperties(
                                    //   physics: BouncingScrollPhysics(),
                                    // ),
                                    initialIndex: widget.status == "isedit"
                                        ? 2
                                        : widget.status == "iseditaddr"
                                            ? 1
                                            : widget.status == "ismeeting"
                                                ? 2
                                                : widget.status == "isnotes"
                                                    ? 3
                                                    : widget.status == "isevent"
                                                        ? 4
                                                        : widget.status ==
                                                                "issitestatus"
                                                            ? 5
                                                            : 0,

                                    tabs: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          //width: 100,

                                          child: Text(
                                            'DETAILS',
                                            style: TextStyle(fontSize: 9),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          //width: 100,

                                          child: Text(
                                            'ADDRESS',
                                            style: TextStyle(fontSize: 9),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Text('BASIC DETAILS',
                                              style: TextStyle(fontSize: 9)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Text('MEEETING DETAILS',
                                              style: TextStyle(fontSize: 9)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Text('EVENTS',
                                              style: TextStyle(fontSize: 9)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Text('STATUS OF SITES',
                                              style: TextStyle(fontSize: 9)),
                                        ),
                                      ),
                                    ],
                                    views: [
                                      DetailsView(widget.series),
                                      AddressviewView(widget.series),
                                      BaisicdetailView(widget.series),
                                      MeentingupdateviewView(
                                          widget.series, widget.name),
                                      EvetviewView(widget.series, widget.name),
                                      StatusofsiteView(
                                          widget.series, widget.name),
                                    ],
                                    onChange: (index) => print(index),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              border: Border.all(
                  // color: Colors.red[500],
                  ),
              borderRadius: BorderRadius.all(Radius.circular(40))),
          // color: Colors.blue,
          child: AlertDialog(
            //title: const Text('AlertDialog Title'),
            content: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    // border: Border.all(
                    //     // color: Colors.red,
                    //     ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Center(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(AddtaskView());
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.task,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Text(
                                        "ADD TASK",
                                        style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: (() {
                                  Get.to(AddlocationView());
                                }),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.add_location,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Text(
                                        "ADD LOCATION",
                                        style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (() {
                                Get.to(AddactivityView());
                              }),
                              child: Container(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.local_activity,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Text(
                                      "ADD ACTIVITY",
                                      style: TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.share,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          Text(
                                            "SHARED LEAD",
                                            style: TextStyle(
                                                fontSize: 9,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(AddnoteView("", ""));
                                        },
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.note,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              Text(
                                                "ADD NOTE",
                                                style: TextStyle(
                                                    fontSize: 9,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(ReminderView());
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.remember_me,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              Text(
                                                "REMINDER",
                                                style: TextStyle(
                                                    fontSize: 9,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            ////
                            GestureDetector(
                              onTap: () {
                                Get.to(AddnoteView(widget.series, widget.name));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.note,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Text(
                                        "FOLLOW UP DETAILS",
                                        style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Back'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  detailView() async {
    print("object");
    var s = widget.series;
    http.Response response = await http.get(
      Uri.parse(urlMain + "api/resource/Lead/$s"),
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

      // log(productList[0]["note"]);
      print(data);
      //  baisicDetailView2();
    } else {}
  }

 }
