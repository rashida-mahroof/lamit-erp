import 'dart:convert';
import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lamit/widget/customeappbar.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lamit/globals.dart' as globals;
import '../../../../tocken/config/url.dart';
import '../../../../tocken/tockn.dart';
import '../../home/views/home_view.dart';
import '../../leaddetails/views/leaddetails_view.dart';

class LeadView extends StatefulWidget {
  const LeadView({super.key});

  @override
  State<LeadView> createState() => _LeadViewState();
}

class _LeadViewState extends State<LeadView> {
  final nameController = TextEditingController();
  var areaList = [];
  var selectedKey = 'all';
  var searchText = '';
  List<String> nameList = [];
  var mobileList = [];

  DateTime selectedDate = DateTime.now();
  void initState() {
    super.initState();
    areaList = globals.aList;
    // fetchLacs();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.to(HomeView(""));
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: CustomAppBar(
              title: 'LEADS',
              actions: [
                // Visibility(
                //   visible: isLoading,
                //   child: new Container(
                //     width: 50.0,
                //     height: 5,
                //     child: Padding(
                //       padding: const EdgeInsets.all(13.0),
                //       child: new CircularProgressIndicator(),
                //     ),
                //   ),
                // ),
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
                        value: 1,
                        child: PopUpMenuItemWidget(
                          icon: CupertinoIcons.person,
                          title: 'Name',
                        )),
                    const PopupMenuItem<int>(
                        value: 2,
                        child: PopUpMenuItemWidget(
                          icon: CupertinoIcons.calendar,
                          title: 'Date',
                        )),
                    const PopupMenuItem<int>(
                        value: 3,
                        child: PopUpMenuItemWidget(
                          icon: CupertinoIcons.map_pin,
                          title: 'Lac',
                        )),
                    const PopupMenuItem<int>(
                        value: 4,
                        child: PopUpMenuItemWidget(
                          icon: CupertinoIcons.phone,
                          title: 'Mobile',
                        )),
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
            )),
        body: Padding(
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
                            });
                          },
                          icon: Icon(Icons.close));
                    },
                    searchFieldProps: TextFieldProps(),
                    popupShape: BeveledRectangleBorder(),
                    // popupProps: PopupProps.dialog(),
                    items: (selectedKey == 'name')
                        ? nameList
                        : (selectedKey == 'lac')
                            ? areaList
                            : (selectedKey == 'mobile')?mobileList:
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
              // Visibility(
              //   visible: selectedKey == 'all' || selectedKey == 'date'
              //       ? false
              //       : true,
              //   child: CustomSearchableDropDown(
              //     decoration: BoxDecoration(
              //         border: Border.all(color: Colors.grey.shade400)),
              //     dropdownHintText: 'Search For $selectedKey Here... ',
              //     showLabelInMenu: true,
              //     primaryColor: Colors.black54,
              //     menuMode: false,
              //     hideSearch: false,

              //     // labelStyle:
              //     //     TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              //     items: (selectedKey == 'name')
              //         ? nameList
              //         : (selectedKey == 'lac')
              //             ? areaList
              //             : mobileList,
              //     label: 'Select $selectedKey',
              //     prefixIcon: Padding(
              //       padding: const EdgeInsets.all(0.0),
              //       child: Icon(Icons.search),
              //     ),
              //     dropDownMenuItems: (selectedKey == 'name')
              //         ? nameList
              //         : (selectedKey == 'lac')
              //             ? areaList
              //             : mobileList,
              //     onChanged: (value) {
              //       print(value);
              //       setState(() {
              //         searchText = value;
              //       });
              //     },
              //   ),
              // ),

              Expanded(
                child: FutureBuilder<List<dynamic>>(
                    future: fetchLeads(areaList),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.length > 0) {
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: ((context, index) {
                                return Card(
                                  color: Colors.white,
                                  child: ListTile(
                                    onTap: () {
                                      Get.to(LeaddetailsView(
                                        snapshot.data[index]["lead_name"],
                                        snapshot.data[index]["status"],
                                        0,
                                        "",
                                        snapshot.data[index]["email"],
                                        snapshot.data[index]["name"],
                                      ));
                                    },
                                    title: Text(
                                      snapshot.data[index]["lead_name"]
                                          .toString()
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 3,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: 'Status: ',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black45),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: snapshot.data[index]
                                                          ["status"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: snapshot.data[index]
                                                                  ["status"] ==
                                                              'Hot'
                                                          ? Colors.green
                                                          : (snapshot.data[index]
                                                                      [
                                                                      "status"] ==
                                                                  'Lead')
                                                              ? Color.fromARGB(
                                                                  255,
                                                                  12,
                                                                  73,
                                                                  122)
                                                              : (snapshot.data[index][
                                                                          "status"] ==
                                                                      'Lost')
                                                                  ? Colors.red
                                                                  : Colors
                                                                      .black54)),
                                            ],
                                          ),
                                        ),
                                        if(snapshot.data[index]
                                                          ["stage"] !=null)
                                          RichText(
                                          text: TextSpan(
                                            text: 'Stage: ',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color.fromARGB(207, 124, 106, 1)),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: snapshot.data[index]
                                                          ["stage"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: 
                                                                   Colors
                                                                      .indigo[900])),
                                            ],
                                          ),
                                        ),
                                        
                                        Text(
                                          'Created on:  ' +
                                              DateTime.parse(snapshot
                                                      .data[index]["date"])
                                                  .day
                                                  .toString() +
                                              '-' +
                                              DateTime.parse(snapshot
                                                      .data[index]["date"])
                                                  .month
                                                  .toString() +
                                              '-' +
                                              DateTime.parse(snapshot
                                                      .data[index]["date"])
                                                  .year
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black38),
                                        )
                                      ],
                                    ),
                                    trailing: Wrap(
                                      children: [
                                        if (snapshot.data[index]["latitude"] !=
                                                null ||
                                            snapshot.data[index]["longitude"] !=
                                                null)
                                          IconButton(
                                              onPressed: (() {
                                                MapsLauncher.launchCoordinates(
                                                    double.parse(
                                                        snapshot.data[index]
                                                            ["latitude"]),
                                                    double.parse(
                                                        snapshot.data[index]
                                                            ["longitude"]),
                                                    '');
                                              }),
                                              icon: Icon(Icons.location_pin)),
                                        IconButton(
                                          onPressed: () {
                                            _makePhoneCall(snapshot.data[index]
                                                ["mobile_no"]);
                                          },
                                          icon: Icon(Icons.call),
                                          color: kDefaultIconDarkColor,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            launch(
                                                'whatsapp://send?text=sample text&phone=' +
                                                    snapshot.data[index]
                                                        ["whatsapp_no"]);
                                          },
                                          icon: Container(
                                              height: 20,
                                              width: 20,
                                              child: Image.asset(
                                                'assets/55.png',
                                                height: 20,
                                                scale: 2.5,
                                                // color: Color.fromARGB(255, 15, 147, 59),
                                                // opacity:
                                                //     const AlwaysStoppedAnimation<double>(
                                                //         0.5)
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }));
                        } else {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.grey.shade300,
                                  size: 100,
                                ),
                                Text(
                                  'No Leads Available',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black45),
                                )
                              ],
                            ),
                          );
                        }
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SelectedItem(BuildContext context, item) {
    switch (item) {
      case 1:
        setState(() {
          selectedKey = 'name';
          searchText = '';
        });
        break;
      case 2:
        setState(() {
          selectedKey = 'date';
          searchText = '';
        });
        selectDate();

        break;
      case 3:
        setState(() {
          selectedKey = 'lac';
          searchText = '';
        });
        break;
      case 4:
        setState(() {
          selectedKey = 'mobile';
          searchText = '';
        });
        break;
      case 5:
        setState(() {
          selectedKey = 'all';
          searchText = '';
        });
        break;
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

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<List<dynamic>> fetchLeads(lacs) async {
    var lac = await jsonEncode(lacs);
    var api;
    if (searchText == '') {
      api =
          'api/resource/Lead?fields=["mobile_no","name","lead_name","status","lac","source","lead_category","date","whatsapp_no","longitude","latitude","expected_time_to_purchas","email","stage"]&filters=[["sale_area", "in",$lac]]&limit=1000000&order_by=creation%20desc';
    } else {
      if (selectedKey == 'name') {
        api =
            'api/resource/Lead?fields=["mobile_no","name","lead_name","status","lac","source","lead_category","date","whatsapp_no","longitude","latitude","expected_time_to_purchas","email","stage"]&filters=[["lac", "in", $lac],["lead_name", "=", "$searchText"]]&limit=1000000&order_by=creation%20desc';
      } else if (selectedKey == 'lac') {
        api = 'api/resource/Lead?fields=["mobile_no","name","lead_name","status","lac","source","lead_category","date","whatsapp_no","longitude","latitude","expected_time_to_purchas","email","stage"]&filters=[["lac", "in", ["$searchText"]]]&limit=1000000&order_by=creation%20desc';
        // api =
        //     'api/resource/Lead?fields=["mobile_no","name","lead_name","status","lac","source","lead_category","date","whatsapp_no","longitude","latitude","expected_time_to_purchas","email","stage"]&filters=[["lac", "=", "$searchText"],["stage", "=", "Hot"],["lac","in",$lac]]&limit=1000000&order_by=creation%20desc';
      } else if (selectedKey == 'mobile') {
        api ='api/resource/Lead?fields=["mobile_no","name","lead_name","status","lac","source","lead_category","date","whatsapp_no","longitude","latitude","expected_time_to_purchas","email","stage"]&filters=[["mobile_no", "=", "$searchText"],["lac", "in", $lac]]&limit=1000000&order_by=creation%20desc';
        // api =
        //     'api/resource/Lead?fields=["mobile_no","name","lead_name","status","lac","source","lead_category","date","whatsapp_no","longitude","latitude","expected_time_to_purchas","email","stage"]&filters=[["mobile_no", "=", "$searchText"],["stage", "=", "Hot"],["lac","in",$lac]]&limit=1000000&order_by=creation%20desc';
      }
      else if(selectedKey == 'status'){
         api =
            'api/resource/Lead?fields=["mobile_no","name","lead_name","status","lac","source","lead_category","date","whatsapp_no","longitude","latitude","expected_time_to_purchas","email","stage"]&filters=[["status", "=", "$searchText"],["lac", "in", $lac]]&limit=1000000&order_by=creation%20desc';
     
      } 
      else if(selectedKey == 'stage') {
        api =
            'api/resource/Lead?fields=["mobile_no","name","lead_name","status","lac","source","lead_category","date","whatsapp_no","longitude","latitude","expected_time_to_purchas","email","stage"]&filters=[["stage", "=", "$searchText"],["lac", "in", $lac]]&limit=1000000&order_by=creation%20desc';
      }else{
         api =
            'api/resource/Lead?fields=["mobile_no","name","lead_name","status","lac","source","lead_category","date","whatsapp_no","longitude","latitude","expected_time_to_purchas","email","stage"]&filters=[["date", "=", "$searchText"],["lac", "in", $lac]]&limit=1000000&order_by=creation%20desc';
     
      }
    }

    // var baseUrl = urlMain +
    //     'api/resource/Lead?fields=["mobile_no","name","lead_name","status","lac","source","lead_category","date"]&filters=[["lead_name", "in", "add das"]]&limit=1000000';
    var baseUrl = urlMain + api;
log(baseUrl+'===');
    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    });
    if (response.statusCode == 200) {
      String response1 = response.body;
      var data = jsonDecode(response1)["data"];
      if (nameList.length < 1) {
        for (int i = 0; i < data.length; i++) {
          var mobile = data[i]["mobile_no"];
          var name = data[i]["lead_name"];
          nameList.add('$name ($mobile)');
        }
        print(nameList.toString() + 'oiooioo');
      }
      if (mobileList.length < 1) {
        for (int i = 0; i < data.length; i++) {
          mobileList.add(data[i]["mobile_no"]);
        }
        print(mobileList);
      }
    }
    // setState(() {
    //   isLoading = false;
    // });
    return jsonDecode(response.body)["data"];
  }

  selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        searchText = selectedDate.toString().split(" ").first;
      });
    }
  }
}

class PopUpMenuItemWidget extends StatelessWidget {
  const PopUpMenuItemWidget({
    required this.icon,
    required this.title,
    Key? key,
  }) : super(key: key);
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.black54,
            size: 18,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
