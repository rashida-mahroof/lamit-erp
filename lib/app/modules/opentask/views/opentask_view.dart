import 'dart:convert';
import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:lamit/app/modules/addtaskdash/views/addtaskdash_view.dart';
import 'package:lamit/tocken/config/url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lamit/globals.dart' as globals;
import '../../../../tocken/tockn.dart';
import '../../lead/views/lead-view-new.dart';

class OpentaskView extends StatefulWidget {
  @override
  State<OpentaskView> createState() => _OpentaskViewState();
}

class _OpentaskViewState extends State<OpentaskView> {
  @override
  
  String? id;
    var selectedKey = 'all';
  var searchText = '';
  var fullname;
  getsf() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {

      id = preferences.getString("userid");
      fullname = preferences.getString("fullname");
    });

    // Taskview();

    print(id.toString());

    // newleadView(id.toString());
  }

  @override
  void initState() {
    getsf();
    super.initState();
  }
  SelectedItem(BuildContext context, item) {
    switch (item) {
      case 1:
       
         case 6:
        setState(() {
          selectedKey = 'status';
          searchText = '';
        });
        break;
         case 7:
        setState(() {
          selectedKey = 'stage';
          searchText = '';
        });
        break;
    }
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
          'OPEN TASK VIEW',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 5, 51, 88)),
        ),
        actions: [
           PopupMenuButton<int>(
                  position: PopupMenuPosition.under,
                  itemBuilder: (context) => [
                    PopupMenuItem(
                        value: 0,
                        enabled: false,
                        child: Text(
                          'Filter By',
                          style: TextStyle(fontSize: 11, color: Colors.black45),
                        )),
                    const PopupMenuDivider(),
                    
                        const PopupMenuItem<int>(
                        value: 6,
                        child: PopUpMenuItemWidget(
                          icon: CupertinoIcons.hourglass,
                          title: 'Status',
                        )),
                        const PopupMenuItem<int>(
                        value: 7,
                        child: PopUpMenuItemWidget(
                          icon: CupertinoIcons.line_horizontal_3_decrease_circle,
                          title: 'Stage',
                        )),
                    const PopupMenuItem<int>(
                        value: 5,
                        child: PopUpMenuItemWidget(
                          icon: CupertinoIcons.list_bullet,
                          title: 'All',
                        )),
                  ],
                  onSelected: (item) => SelectedItem(context, item),
                ),
              
        ],
        
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        //centerTitle: true,
      ),
      body:
          //  snapshot.datat.length == 0
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
           Container(
                  color: Colors.grey[50],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Visibility(
                visible: selectedKey == 'all' || selectedKey == 'date'
                    ? false
                    : true,
                child: DropdownSearch<dynamic>(
                    showSearchBox: true,
                    popupTitle: Text('Select $selectedKey'),
                    popupElevation: 1,
                    maxHeight: MediaQuery.of(context).size.height / 1.2,
                    showClearButton: true,

                    // showSelectedItems: true,
                    clearButtonBuilder: (context) {
                      return IconButton(
                          onPressed: () {
                            setState(() {
                              searchText = '';
                              //  Taskview();
                               setState(() {
                                 
                               });
                            });
                          },
                          icon: Icon(Icons.close));
                    },
                    searchFieldProps: TextFieldProps(),
                    popupShape: BeveledRectangleBorder(),
                    // popupProps: PopupProps.dialog(),
                    items: 
                       
                            (selectedKey == 'stage')?globals.stageList:globals.statusList,
                    onChanged: (Value) {
                      setState(() {
                        if (selectedKey == 'name') {
                          searchText = Value.toString().split(' (').first;
                        } else {
                          searchText = Value.toString();
                        }
                      });
                    },
                    selectedItem:
                        searchText == '' ? 'Select $selectedKey' : searchText),
              ),
              
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: FutureBuilder<List<dynamic>>(
                                  future: Taskview(),
                                  builder: (context,AsyncSnapshot snapshot) {
                                    
                                    if(snapshot.hasData)
                                    {
                                      
                                      if(snapshot.data.length > 0){
                                        return ListView.builder(
                                        itemCount: snapshot.data.length,
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
                                                                snapshot.data[index]["lead_name"] == null
                                                                    ? "Customer"
                                                                    : "Lead",
                                                                "Closed",
                                                                snapshot.data[index]["name"] == null
                                                                    ? snapshot.data[index]
                                                                        ["name"]
                                                                    : snapshot.data[index]
                                                                            ["name"]
                                                                        .toString(),
                                                                snapshot.data[index]["select_lead_name"] ==
                                                                        "null"
                                                                    ? snapshot.data[index][
                                                                        "select_customer"]
                                                                    : snapshot.data[index][
                                                                        "select_lead_name"],
                                                                snapshot.data[index]["due_date"] == null
                                                                    ? ""
                                                                    : snapshot.data[index][
                                                                        "due_date"],
                                                                snapshot.data[index]["task_type"] ==
                                                                        null
                                                                    ? ""
                                                                    : snapshot.data[index]
                                                                        ["task_type"],
                                                                snapshot.data[index]["from_time"] == null ? "" : snapshot.data[index]["from_time"],
                                                                snapshot.data[index]["subject"] == null ? "" : snapshot.data[index]["subject"]));
                                                            // Get.to(LeaddetailsView(
                                                            //   snapshot.datat[index]
                                                            //       ["first_name"],
                                                            //   snapshot.datat[index]
                                                            //       ["status"],
                                                            //   0,
                                                            //   "",
                                                            //   snapshot.datat[index]
                                                            //       ["email"],
                                                            //   snapshot.datat[index]
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
                                                                          width: MediaQuery.of(context)
                                                                                  .size
                                                                                  .width /
                                                                              1.5,
                                                                          child:
                                                                              Text(
                                                                            snapshot.data[index]["subject"] ==
                                                                                    "null"
                                                                                ? ""
                                                                                : "Subject : " +
                                                                                    snapshot.data[index]["subject"].toUpperCase().toString(),
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                    13,
                                                                                color:
                                                                                    Colors.black54,
                                                                                fontWeight: FontWeight.bold),
                                                                            // overflow:
                                                                            //     TextOverflow.ellipsis,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(
                                                                                  right: 3.0,
                                                                                  bottom: 4),
                                                                              child:
                                                                                  Icon(
                                                                                Icons.timer,
                                                                                size:
                                                                                    14,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              "TIME : " +
                                                                                  snapshot.data[index]["contact_time_in_hour"] +
                                                                                  " : " +
                                                                                  snapshot.data[index]["contact_time_in_min"] +
                                                                                  " " +
                                                                                  snapshot.data[index]["time2"],
                                                                              style: TextStyle(
                                                                                  fontSize: 11,
                                                                                  color: Color.fromARGB(255, 4, 52, 91),
                                                                                  fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        if (snapshot.data[index]
                                                                                [
                                                                                "mobile"] !=
                                                                            null)
                                                                          Row(
                                                                            children: [
                                                                              Padding(
                                                                                padding:
                                                                                    const EdgeInsets.only(right: 3.0, bottom: 4),
                                                                                child:
                                                                                    Icon(
                                                                                  Icons.mobile_friendly_outlined,
                                                                                  size: 14,
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                "Mobile : " +
                                                                                    snapshot.data[index]["mobile"].toString(),
                                                                                style: TextStyle(
                                                                                    fontSize: 11,
                                                                                    color: Color.fromARGB(255, 4, 52, 91),
                                                                                    fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        if (snapshot.data[index]
                                                                                [
                                                                                "lead_name"] !=
                                                                            null)
                                                                          Row(
                                                                            children: [
                                                                              Padding(
                                                                                padding:
                                                                                    const EdgeInsets.only(right: 3.0, bottom: 4),
                                                                                child:
                                                                                    Icon(
                                                                                  Icons.person,
                                                                                  size: 14,
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                "Lead name : " +
                                                                                    snapshot.data[index]["lead_name"],
                                                                                style: TextStyle(
                                                                                    fontSize: 11,
                                                                                    color: Color.fromARGB(255, 4, 52, 91),
                                                                                    fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        Row(
                                                                          children: [
                                                                            Padding(
                                                                                padding:
                                                                                    const EdgeInsets.only(right: 3.0, bottom: 4),
                                                                                child:
                                                                                    Icon(
                                                                                  Icons.source,
                                                                                  size: 14,
                                                                                ),
                                                                              ),
                                                                            Text(
                                                                              snapshot.data[index]["lead_souce"] ==
                                                                                      "null"
                                                                                  ? ""
                                                                                  : "Lead Source : " +
                                                                                      snapshot.data[index]["lead_souce"].toString(),
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
                                                                              maxLines:
                                                                                  2,
                                                                              overflow:
                                                                                  TextOverflow
                                                                                      .ellipsis,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Padding(
                                                                                padding:
                                                                                    const EdgeInsets.only(right: 3.0, bottom: 4),
                                                                                child:
                                                                                    Icon(
                                                                                  Icons.location_pin,
                                                                                  size: 14,
                                                                                ),
                                                                              ),
                                                                            Text(
                                                                              snapshot.data[index]["lead_location"] ==
                                                                                      "null"
                                                                                  ? ""
                                                                                  : "Location : " +
                                                                                      snapshot.data[index]["lead_location"].toString(),
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
                                                                              maxLines:
                                                                                  2,
                                                                              overflow:
                                                                                  TextOverflow
                                                                                      .ellipsis,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Padding(
                                                                                padding:
                                                                                    const EdgeInsets.only(right: 3.0, bottom: 4),
                                                                                child:
                                                                                    Icon(
                                                                                  Icons.task,
                                                                                  size: 14,
                                                                                ),
                                                                              ),
                                                                            Text(
                                                                              snapshot.data[index]["task_type"] ==
                                                                                      "null"
                                                                                  ? ""
                                                                                  : "Task Type : " +
                                                                                      snapshot.data[index]["task_type"].toString(),
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
                                                                              maxLines:
                                                                                  2,
                                                                              overflow:
                                                                                  TextOverflow
                                                                                      .ellipsis,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        if (snapshot.data[index]
                                                                                [
                                                                                "customer_name"] !=
                                                                            null)
                                                                          Row(
                                                                            children: [
                                                                              Padding(
                                                                                padding:
                                                                                    const EdgeInsets.only(right: 3.0, bottom: 4),
                                                                                child:
                                                                                    Icon(
                                                                                  Icons.person_outline_outlined,
                                                                                  size: 14,
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                "Customer name: " +
                                                                                    snapshot.data[index]["customer_name"].toString(),
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
                                                                                maxLines:
                                                                                    2,
                                                                                overflow:
                                                                                    TextOverflow.ellipsis,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        Row(
                                                                          children: [
                                                                            Padding(
                                                                                padding:
                                                                                    const EdgeInsets.only(right: 3.0, bottom: 4),
                                                                                child:
                                                                                    Icon(
                                                                                  Icons.date_range,
                                                                                  size: 14,
                                                                                ),
                                                                              ),
                                                                            Text(
                                                                              snapshot.data[index]["due_date"] ==
                                                                                      "null"
                                                                                  ? ""
                                                                                  : "Due Date: " +
                                                                                      snapshot.data[index]["due_date"].toString(),
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
                                                                              maxLines:
                                                                                  2,
                                                                              overflow:
                                                                                  TextOverflow
                                                                                      .ellipsis,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Visibility(
                                                                          visible: (snapshot.data[index]["lead_location1"] == null ||
                                                                                  snapshot.data[index]["lead_location1"] == "")
                                                                              ? false
                                                                              : true,
                                                                          child:
                                                                              Row(
                                                                                children: [
                                                                                  Padding(
                                                                                padding:
                                                                                    const EdgeInsets.only(right: 3.0, bottom: 4),
                                                                                child:
                                                                                    Icon(
                                                                                  Icons.location_on_rounded,
                                                                                  size: 14,
                                                                                ),
                                                                              ),
                                                                                  Text(
                                                                            'Lead Location: ' +
                                                                                    snapshot.data[index]["lead_location1"].toString(),
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
                                                                            maxLines:
                                                                                    2,
                                                                            overflow:
                                                                                    TextOverflow.ellipsis,
                                                                          ),
                                                                                ],
                                                                              ),
                                                                        ),
                                                                        Visibility(
                                                                          visible: (snapshot.data[index]["customer_location1"] == null ||
                                                                                  snapshot.data[index]["customer_location1"] == "")
                                                                              ? false
                                                                              : true,
                                                                          child:
                                                                              Row(
                                                                                children: [
                                                                                  Padding(
                                                                                padding:
                                                                                    const EdgeInsets.only(right: 3.0, bottom: 4),
                                                                                child:
                                                                                    Icon(
                                                                                  Icons.person_2,
                                                                                  size: 14,
                                                                                ),
                                                                              ),
                                                                                  Text(
                                                                            'Customer Location: ' +
                                                                                    snapshot.data[index]["customer_location1"].toString(),
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
                                                                            maxLines:
                                                                                    2,
                                                                            overflow:
                                                                                    TextOverflow.ellipsis,
                                                                          ),
                                                                                ],
                                                                              ),
                                                                        ),
                                                                        if(snapshot.data[index]["lead_status"] != null)
                                                                        Row(
                                                                          children: [
                                                                            Padding(
                                                                                padding:
                                                                                    const EdgeInsets.only(right: 3.0, bottom: 4),
                                                                                child:
                                                                                    Icon(
                                                                                  Icons.hourglass_bottom,
                                                                                  size: 14,
                                                                                ),
                                                                              ),
                                                                            Text(
                                                                              snapshot.data[index]["lead_status"] ==
                                                                                      "null"
                                                                                  ? ""
                                                                                  : "Lead Status: " +
                                                                                      snapshot.data[index]["lead_status"].toString(),
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
                                                                              maxLines:
                                                                                  2,
                                                                              overflow:
                                                                                  TextOverflow
                                                                                      .ellipsis,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                       if(snapshot.data[index]["lead_stage"] != null)
                                                                        Row(
                                                                          children: [
                                                                            Padding(
                                                                                padding:
                                                                                    const EdgeInsets.only(right: 3.0, bottom: 4),
                                                                                child:
                                                                                    Icon(
                                                                                  Icons.stairs,
                                                                                  size: 14,
                                                                                ),
                                                                              ),
                                                                            Text(
                                                                              snapshot.data[index]["lead_stage"] ==
                                                                                      "null"
                                                                                  ? ""
                                                                                  : "Lead Stage: " +
                                                                                      snapshot.data[index]["lead_stage"].toString(),
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
                                                                              maxLines:
                                                                                  2,
                                                                              overflow:
                                                                                  TextOverflow
                                                                                      .ellipsis,
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
                                                                    Container(
                                                                      child:
                                                                          Container(
                                                                              child:
                                                                                  Column(
                                                                        children: [
                                                                          // TextButton(
                                                                          //   onPressed:
                                                                          //       (() {
                                                                          //     Get.to(AddtaskdashView(
                                                                          //         "Closed",
                                                                          //         snapshot.data[index]["lead_name"] == "null" ? "" : snapshot.data[index]["lead_name"],
                                                                          //         snapshot.data[index]["lead_name"] == "null" ? "" : snapshot.data[index]["name"]));
                                                                          //   }),
                                                                          //   child: Text(
                                                                          //       "    Status " + ":" + snapshot.data[index]["status"] == "null"
                                                                          //           ? ""
                                                                          //           : snapshot.data[index]["status"],
                                                                          //       style: TextStyle(color: Color.fromARGB(255, 2, 24, 41), fontSize: 10)),
                                                                          // ),

                                                                          snapshot.data[index]["status"] ==
                                                                                  "Closed"
                                                                              ? Container()
                                                                              : TextButton(
                                                                                  onPressed: (() {
                                                                                    Get.to(AddtaskdashView(snapshot.data[index]["lead_name"] == null ? "Customer" : "Lead", "Closed", snapshot.data[index]["name"] == null ? snapshot.data[index]["name"] : snapshot.data[index]["name"].toString(), snapshot.data[index]["select_lead_name"] == "null" ? snapshot.data[index]["select_customer"] : snapshot.data[index]["select_lead_name"], snapshot.data[index]["due_date"] == null ? "" : snapshot.data[index]["due_date"], snapshot.data[index]["task_type"] == null ? "" : snapshot.data[index]["task_type"], snapshot.data[index]["from_time"] == null ? "" : snapshot.data[index]["from_time"], snapshot.data[index]["subject"] == null ? "" : snapshot.data[index]["subject"]));
                                                                                  }),
                                                                                  child: Text("Close", style: TextStyle(color: Color.fromARGB(255, 2, 24, 41), fontSize: 14)),
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
                                                                //                     snapshot.datat[index]["source"] == null ? "" : snapshot.datat[index]["source"],
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
                                                                //                       snapshot.datat[index]["status"] == "" ? "" : snapshot.datat[index]["status"],
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
                                                                //           Text(snapshot.datat[index]["location"] == null
                                                                //               ? "Update ur address"
                                                                //               : snapshot.datat[index]["location"]),
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
                                                                //       //       child: Center(child: Text("Next meeting :" + snapshot.datat[index]["next_contact_date"] == "" ? "Not updated" : snapshot.datat[index]["next_contact_date"].toString())),
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
                                        }));
                                  
                                      }else{
                                        return Center(child: Text('No data'));
                                      }
                                    }else{
                                    return Center(child: CircularProgressIndicator());
                                  }
                                  }
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
    );
  }

  Future<List<dynamic>> Taskview() async {
    DateTime now = DateTime.now();

    ///String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    var api;
    if(fullname == null){
      fullname = globals.fullName;
    }
     if (searchText == '') {
     api = 'api/resource/Task?fields=["*"]&filters=[["status","in",["Open"]],["sales_officer2","=","$id"]]&limit=100000&order_by=creation%20desc';
     }else if(selectedKey == 'status'){
      api = 'api/resource/Task?fields=["*"]&filters=[["lead_status","=","$searchText"],["status","in",["Open"]],["assign","=","$fullname"]]&limit=100000&order_by=creation%20desc';
     }else{
 api = 'api/resource/Task?fields=["*"]&filters=[["lead_stage","=","$searchText"],["status","in",["Open"]],["assign","=","$fullname"]]&limit=100000&order_by=creation%20desc';
     
     }
    var a = "$id";
    http.Response response = await http.get(
        Uri.parse(urlMain +api),
                    headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': Tocken,
        });
     
    String data = response.body;
print(data+'kkkkk');
    
   

    return jsonDecode(response.body)["data"];
  }
}
