// import 'dart:convert';
// import 'dart:developer';

// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:intl/intl.dart';
// import 'package:lamit/app/modules/home/views/home_view.dart';
// import 'package:lamit/globals.dart' as globals;
// import 'package:lamit/app/modules/leaddetails/views/leaddetails_view.dart';
// import 'package:lamit/tocken/config/url.dart';
// import 'package:lamit/tocken/tockn.dart';
// import 'package:lamit/widget/customeappbar.dart';
// import 'package:maps_launcher/maps_launcher.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';

// import '../../converted-leads-view/popupitemWidget.dart';

// class NewleadsView extends StatefulWidget {
//   const NewleadsView({Key? key}) : super(key: key);

//   @override
//   State<NewleadsView> createState() => _NewleadsViewState();
// }

// class _NewleadsViewState extends State<NewleadsView> {
//   var productList = [];
//   // ignore: unused_field
//   int _index = 0;
//   String? akey;
//   String? skey;
//   String? email;
//   String? em;
//   String? userId;
//   var laclist;
//   var mobileList = [];
//   var selectedKey = 'all';
//   var cusdropdownvalue;
//   var custDropDown = [];
//   var statusList = [];
//   var productList3;
//   @override
//   void initState() {
//     // getsf();
//     super.initState();
//   }

//   SelectedItem(BuildContext context, item) {
//     switch (item) {
//       case 1:
//         setState(() {
//           selectedKey = 'name';
//           cusdropdownvalue = null;
//         });
//         break;
//       case 2:
//         setState(() {
//           selectedKey = 'mobile';
//           cusdropdownvalue = null;
//         });

//         break;
//       case 3:
//         setState(() {
//           selectedKey = 'all';
//           cusdropdownvalue = null;
//         });

//         break;
//       case 4:
//         setState(() {
//           selectedKey = 'status';
//           cusdropdownvalue = null;
//         });

//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Get.to(HomeView(""));
//         return false;
//       },
//       child: Scaffold(
//           appBar: PreferredSize(
//             preferredSize:
//                 Size(MediaQuery.of(context).size.width, kToolbarHeight),
//             child: CustomAppBar(
//               title: 'NEW LEAD LIST',
//               actions: <Widget>[
//                 PopupMenuButton<int>(
//                   position: PopupMenuPosition.under,
//                   itemBuilder: (context) => [
//                     PopupMenuItem(
//                         value: 0,
//                         enabled: false,
//                         child: Text(
//                           'Filter By',
//                           style: TextStyle(fontSize: 11, color: Colors.black45),
//                         )),
//                     const PopupMenuDivider(),
//                     const PopupMenuItem<int>(
//                         value: 1,
//                         child: PopUpMenuItemWidget(
//                           icon: CupertinoIcons.person,
//                           title: 'Name',
//                         )),
//                     const PopupMenuItem<int>(
//                         value: 2,
//                         child: PopUpMenuItemWidget(
//                           icon: CupertinoIcons.phone,
//                           title: 'Mobile',
//                         )),
//                     const PopupMenuItem<int>(
//                         value: 4,
//                         child: PopUpMenuItemWidget(
//                           icon: CupertinoIcons.hourglass,
//                           title: 'status',
//                         )),
//                     const PopupMenuItem<int>(
//                         value: 3,
//                         child: PopUpMenuItemWidget(
//                           icon: CupertinoIcons.square_list,
//                           title: 'All',
//                         )),
//                   ],
//                   onSelected: (item) => SelectedItem(context, item),
//                 ),

//                 // IconButton(
//                 //     icon: Icon(FontAwesomeIcons.chartLine),
//                 //     onPressed: () {
//                 //       //
//                 //     }),
//               ],
//             ),
//           ),
//           body:
//               //  productList.length == 0 ?
//               Column(
//             children: [
//               if (selectedKey != 'all')
//                 Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: DropdownSearch<dynamic>(
//                       showSearchBox: true,
//                       popupTitle: Text('Select $selectedKey'),
//                       popupElevation: 1,
//                       maxHeight: MediaQuery.of(context).size.height / 1.2,
//                       showClearButton: true,
//                       // showSelectedItems: true,
//                       clearButtonBuilder: (context) {
//                         return IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 selectedKey = 'all';
//                                 cusdropdownvalue = null;
//                               });
//                               // getlac();
//                               // setState(() {});
//                             },
//                             icon: Icon(Icons.close));
//                       },
//                       popupShape: BeveledRectangleBorder(),
//                       // popupProps: PopupProps.dialog(),
//                       items: (selectedKey == 'name')
//                           ? custDropDown
//                           : (selectedKey == 'mobile')
//                               ? mobileList
//                               : globals.stageList,
//                       onChanged: (Value) {
//                         print(Value);
//                         setState(() {
//                           if (selectedKey == 'name') {
//                             cusdropdownvalue =
//                                 Value.toString().split(" (").first;
//                           } else {
//                             cusdropdownvalue = Value.toString();
//                           }
//                         });
//                         // getlac();
//                         // setState(() {});
//                       },
//                       selectedItem: cusdropdownvalue == null
//                           ? 'Select $selectedKey'
//                           : cusdropdownvalue),
//                 ),
//               Expanded(
//                 child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       child: FutureBuilder<List<dynamic>>(
//                           future: leadview(globals.aList),
//                           builder: (context, AsyncSnapshot snapshot) {
//                             if (snapshot.hasData) {
//                               if(snapshot.data.length > 0 ){
//                                 return ListView.builder(
//                                   itemCount: snapshot.data.length,
//                                   itemBuilder: ((context, index) {
//                                     return Card(
//                                       color: Colors.white,
//                                       child: ListTile(
//                                         onTap: () {
//                                           Get.to(LeaddetailsView(
//                                             snapshot.data[index]["lead_name"],
//                                             snapshot.data[index]["status"],
//                                             2,
//                                             "",
//                                             snapshot.data[index]["email"],
//                                             snapshot.data[index]["name"],
//                                           ));
//                                         },
//                                         title: Text(
//                                           snapshot.data[index]["lead_name"]
//                                               .toString()
//                                               .toUpperCase(),
//                                           style: TextStyle(
//                                               fontSize: 13,
//                                               color: Colors.black,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         subtitle: Text(
//                                           snapshot.data[index]["date"] == null
//                                               ? "No date added"
//                                               : DateFormat("dd-MM-yyy").format(
//                                                   DateTime.parse(snapshot
//                                                       .data[index]["date"]
//                                                       .toString())),
//                                           style: TextStyle(
//                                               fontSize: 11,
//                                               color: Color.fromARGB(
//                                                   255, 4, 52, 91),
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         trailing: Wrap(
//                                           children: [
//                                             if (snapshot.data[index]
//                                                         ["latitude"] !=
//                                                     null ||
//                                                 snapshot.data[index]
//                                                         ["longitude"] !=
//                                                     null)
//                                               IconButton(
//                                                   onPressed: (() {
//                                                     MapsLauncher
//                                                         .launchCoordinates(
//                                                             double.parse(snapshot
//                                                                     .data[index]
//                                                                 ["latitude"]),
//                                                             double.parse(snapshot
//                                                                     .data[index]
//                                                                 ["longitude"]),
//                                                             '');
//                                                   }),
//                                                   icon:
//                                                       Icon(Icons.location_pin)),
//                                             IconButton(
//                                               onPressed: () {
//                                                 _makePhoneCall(snapshot
//                                                     .data[index]["mobile_no"]);
//                                               },
//                                               icon: Icon(Icons.call),
//                                               color: kDefaultIconDarkColor,
//                                             ),
//                                             IconButton(
//                                               onPressed: () {
//                                                 launch(
//                                                     'whatsapp://send?text=sample text&phone=' +
//                                                         snapshot.data[index]
//                                                             ["whatsapp_no"]);
//                                               },
//                                               icon: Container(
//                                                   height: 20,
//                                                   width: 20,
//                                                   child: Image.asset(
//                                                     'assets/55.png',
//                                                     height: 20,
//                                                     scale: 2.5,
//                                                     // color: Color.fromARGB(255, 15, 147, 59),
//                                                     // opacity:
//                                                     //     const AlwaysStoppedAnimation<double>(
//                                                     //         0.5)
//                                                   )),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     );
//                                   }));
                            
//                               }else{
//                                   return Center(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.error_outline,
//                                   color: Colors.grey.shade300,
//                                   size: 100,
//                                 ),
//                                 Text(
//                                   'No Leads Available',
//                                   style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.black45),
//                                 )
//                               ],
//                             ),
//                           );
                      
//                               }
//                               } else {
//                               return Center(child: CircularProgressIndicator());
//                             }
//                           }),
//                     )),
//               ),

//               // Expanded(
//               //  child: Container(
//               //       color: HexColor("#EEf3f9"),
//               //       child: Center(
//               //         child: new Container(
//               //             width: 100.00,
//               //             height: 100.00,
//               //             decoration: new BoxDecoration(
//               //               image: new DecorationImage(
//               //                 image: ExactAssetImage('assets/2.gif'),
//               //                 fit: BoxFit.fitHeight,
//               //               ),
//               //             )),
//               //       ),
//               //     ),
//               // ),
//             ],
//           )),
//     );
//   }

//   getsf() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     userId = preferences.getString("userid");
//     em = preferences.getString("fullname");
//     email = preferences.getString("email");

//     skey = preferences.getString("name");
//     print(skey.toString() + "hhhhhhh");
//     print(userId.toString() +
//         "hhhhhhhhhhhhhhhdddddddddddddddddddddddddddddddddddddddddd");

//     print("haai");
//     getlac();
//     // LeadAPI(akey, skey).login();
//     // email = preferences.getString("emailid");
//   }

//   // leadDetails() {
//   Future<List<dynamic>> leadview(var lac) async {
//     var lacs = await jsonEncode(lac);
//     print("hbbbbbbbbbbbbbbbbbbb" + lac.toString());
//     var api;
//     if (selectedKey == 'name') {
//       api =
//           'api/resource/Lead?filters=[["new_lead", "=", "1"],["lac", "in",$lacs],["lead_name", "in","$cusdropdownvalue"]]&fields=["name","lead_name","date","source","lead_category","status","email_id","mobile_no","lac","new_lead","whatsapp_no","longitude","latitude"]&limit=1000000&order_by=creation%20desc';
//     } else if (selectedKey == 'mobile') {
//       api =
//           'api/resource/Lead?filters=[["new_lead", "=", "1"],["lac", "in",$lacs],["mobile_no", "in","$cusdropdownvalue"]]&fields=["name","lead_name","date","source","lead_category","status","email_id","mobile_no","lac","new_lead","whatsapp_no","longitude","latitude"]&limit=1000000&order_by=creation%20desc';
//     } else if (selectedKey == 'status') {
//       api =
//           'api/resource/Lead?filters=[["new_lead", "=", "1"],["lac", "in",$lacs],["status", "in","$cusdropdownvalue"]]&fields=["name","lead_name","date","source","lead_category","status","email_id","mobile_no","lac","new_lead","whatsapp_no","longitude","latitude"]&limit=1000000&order_by=creation%20desc';
//     } else {
//       api =
//           'api/resource/Lead?filters=[["new_lead", "=", "1"],["lac", "in",$lacs]]&fields=["name","lead_name","date","source","lead_category","status","email_id","mobile_no","lac","new_lead","whatsapp_no","longitude","latitude"]&limit=1000000&order_by=creation%20desc';
//     }
//     http.Response response = await http.get(Uri.parse(urlMain + api), headers: {
//       'Content-type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': Tocken,
//     });
//     log(api + '=====api');
//     String data = response.body;
//     productList3 = jsonDecode(data)["data"];
//     if (custDropDown.length < 1) {
//       for (var i = 0; i < productList3.length; i++) {
//         var name = productList3[i]['lead_name'];
//         var mobile = productList3[i]['mobile_no'];
//         custDropDown.add('$name ($mobile)');
//       }
//     }
//     if (mobileList.length < 1) {
//       for (var i = 0; i < productList3.length; i++) {
//         mobileList.add(productList3[i]['mobile_no']);
//       }
//     }

   

//     return jsonDecode(data)["data"];
//   }

//   void onTabTapped(int index) {
//     setState(() {
//       _index = index;
//     });
//   }

//   Future getlac() async {
//     // //  log(id.toString() +
//     //       "idddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
//     print("hiiiiiiiii");
//     // https://lamit.erpeaz.com/api/resource/Customer Area?filters=[["allocated_by", "=", "1232435456"]] & limit=100

//     var baseUrl = urlMain +
//         'api/resource/Assign Sale Area?filters=[["sales_officer", "=", "$userId"]] &limit=10000000000';

//     http.Response response = await http.get(Uri.parse(baseUrl), headers: {
//       'Content-type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': Tocken,
//     });
//     print(response.body);
//     print(response.statusCode);
//     print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
//     if (response.statusCode == 200) {
//       print(response.body);
//       print("haaaaaaaaaaaaaaaaaaaaaaaaa");
//       String data = response.body;
//       //  var jsonData;
//       setState(() {
//         // jsonData = json.decode(data)["data"];
//         // laclist = jsonData;
//         laclist = jsonDecode(data)["data"];
//       });

//       ///  hotleadview(leadview(jsonDecode(data)["data"]));
//       leadview(jsonDecode(data)["data"]);
//       // hotview((jsonDecode(data)["data"]));
//       // leaview(jsonDecode(data)["data"]);

//       //  listLedgers((jsonDecode(data)["data"]));
//       // log(jsonData.toString());
//       // setState(() {});
//     }
//   }

//   Future<void> _makePhoneCall(String phoneNumber) async {
//     final Uri launchUri = Uri(
//       scheme: 'tel',
//       path: phoneNumber,
//     );
//     await launchUrl(launchUri);
//   }
// }
import 'dart:convert';
import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:lamit/app/modules/home/views/home_view.dart';
import 'package:lamit/globals.dart' as globals;
import 'package:lamit/app/modules/leaddetails/views/leaddetails_view.dart';
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/tocken/tockn.dart';
import 'package:lamit/widget/customeappbar.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../converted-leads-view/popupitemWidget.dart';

class NewleadsView extends StatefulWidget {
  const NewleadsView({Key? key}) : super(key: key);

  @override
  State<NewleadsView> createState() => _NewleadsViewState();
}

class _NewleadsViewState extends State<NewleadsView> {
  var productList = [];
  // ignore: unused_field
  int _index = 0;
  String? akey;
  String? skey;
  String? email;
  String? em;
  String? userId;
  var laclist;
  var mobileList = [];
  var selectedKey = 'all';
  var cusdropdownvalue;
  var custDropDown = [];
   var searchText = '';
  var statusList = [];
  var productList3;
  @override
  void initState() {
    // getsf();
    super.initState();
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
        // selectDate();

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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.to(HomeView(""));
        return false;
      },
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize:
                Size(MediaQuery.of(context).size.width, kToolbarHeight),
            child: CustomAppBar(
              title: 'NEW LEAD LIST',
              actions: <Widget>[
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
                    // const PopupMenuItem<int>(
                    //     value: 2,
                    //     child: PopUpMenuItemWidget(
                    //       icon: CupertinoIcons.calendar,
                    //       title: 'Date',
                    //     )),
                    // const PopupMenuItem<int>(
                    //     value: 3,
                    //     child: PopUpMenuItemWidget(
                    //       icon: CupertinoIcons.map_pin,
                    //       title: 'Lac',
                    //     )),
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
              
                // IconButton(
                //     icon: Icon(FontAwesomeIcons.chartLine),
                //     onPressed: () {
                //       //
                //     }),
              ],
            ),
          ),
          body:
              //  productList.length == 0 ?
              Column(
            children: [
              Visibility(
                visible: selectedKey == 'all'
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
                    popupShape: BeveledRectangleBorder(),
                    // popupProps: PopupProps.dialog(),
                    items:(selectedKey == 'stage')?globals.stageList:
                    (selectedKey == 'status') ? globals.statusList:
                    (selectedKey == 'mobile') ? mobileList :
                    custDropDown,
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
              ), Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: FutureBuilder<List<dynamic>>(
                          future: leadview(globals.aList),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              if(snapshot.data.length > 0 ){
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
                                            2,
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
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
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
                                                color: Color.fromARGB(255, 150, 153, 2)),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: snapshot.data[index]
                                                          ["stage"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:  Color.fromARGB(
                                                                  255,
                                                                  12,
                                                                  73,
                                                                  122)
                                                             )),
                                            ],
                                          ),
                                        ),
                                            Text(
                                              snapshot.data[index]["date"] == null
                                                  ? "No date added"
                                                  : 'Created Date:'+DateFormat("dd-MM-yyy").format(
                                                      DateTime.parse(snapshot
                                                          .data[index]["date"]
                                                          .toString())),
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color: Color.fromARGB(
                                                      255, 4, 52, 91),
                                                  fontWeight: FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                        trailing: Wrap(
                                          children: [
                                            if (snapshot.data[index]
                                                        ["latitude"] !=
                                                    null ||
                                                snapshot.data[index]
                                                        ["longitude"] !=
                                                    null)
                                              IconButton(
                                                  onPressed: (() {
                                                    MapsLauncher
                                                        .launchCoordinates(
                                                            double.parse(snapshot
                                                                    .data[index]
                                                                ["latitude"]),
                                                            double.parse(snapshot
                                                                    .data[index]
                                                                ["longitude"]),
                                                            '');
                                                  }),
                                                  icon:
                                                      Icon(Icons.location_pin)),
                                            IconButton(
                                              onPressed: () {
                                                _makePhoneCall(snapshot
                                                    .data[index]["mobile_no"]);
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
                            
                              }else{
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
                    )),
              ),

              // Expanded(
              //  child: Container(
              //       color: HexColor("#EEf3f9"),
              //       child: Center(
              //         child: new Container(
              //             width: 100.00,
              //             height: 100.00,
              //             decoration: new BoxDecoration(
              //               image: new DecorationImage(
              //                 image: ExactAssetImage('assets/2.gif'),
              //                 fit: BoxFit.fitHeight,
              //               ),
              //             )),
              //       ),
              //     ),
              // ),
            ],
          )),
    );
  }

  getsf() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString("userid");
    em = preferences.getString("fullname");
    email = preferences.getString("email");

    skey = preferences.getString("name");
    print(skey.toString() + "hhhhhhh");
    print(userId.toString() +
        "hhhhhhhhhhhhhhhdddddddddddddddddddddddddddddddddddddddddd");

    print("haai");
    getlac();
    // LeadAPI(akey, skey).login();
    // email = preferences.getString("emailid");
  }

  // leadDetails() {
  Future<List<dynamic>> leadview(var lac) async {
    var lacs = await jsonEncode(lac);
    print("hbbbbbbbbbbbbbbbbbbb" + lac.toString());
    var api;
    if (selectedKey == 'name') {
      api =
          'api/resource/Lead?filters=[["new_lead", "=", "1"],["lac", "in",$lacs],["lead_name", "in","$searchText"]]&fields=["name","lead_name","date","source","lead_category","status","email_id","mobile_no","lac","new_lead","whatsapp_no","longitude","latitude","stage"]&limit=1000000&order_by=creation%20desc';
    } else if (selectedKey == 'mobile') {
      api =
          'api/resource/Lead?filters=[["new_lead", "=", "1"],["lac", "in",$lacs],["mobile_no", "in","$searchText"]]&fields=["name","lead_name","date","source","lead_category","status","email_id","mobile_no","lac","new_lead","whatsapp_no","longitude","latitude","stage"]&limit=1000000&order_by=creation%20desc';
    } else if (selectedKey == 'status') {
      api =
          'api/resource/Lead?filters=[["new_lead", "=", "1"],["lac", "in",$lacs],["status", "in","$searchText"]]&fields=["name","lead_name","date","source","lead_category","status","email_id","mobile_no","lac","new_lead","whatsapp_no","longitude","latitude","stage"]&limit=1000000&order_by=creation%20desc';
    } else if(selectedKey == 'stage'){
      api =
          'api/resource/Lead?filters=[["new_lead", "=", "1"],["lac", "in",$lacs],["stage", "in","$searchText"]]&fields=["name","lead_name","date","source","lead_category","status","email_id","mobile_no","lac","new_lead","whatsapp_no","longitude","latitude","stage"]&limit=1000000&order_by=creation%20desc';
    }else {
      api =
          'api/resource/Lead?filters=[["new_lead", "=", "1"],["lac", "in",$lacs]]&fields=["name","lead_name","date","source","lead_category","status","email_id","mobile_no","lac","new_lead","whatsapp_no","longitude","latitude","stage"]&limit=1000000&order_by=creation%20desc';
    }
    http.Response response = await http.get(Uri.parse(urlMain + api), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    });
    log(api + '=====api');
    String data = response.body;
    productList3 = jsonDecode(data)["data"];
    if (custDropDown.length < 1) {
      for (var i = 0; i < productList3.length; i++) {
        var name = productList3[i]['lead_name'];
        var mobile = productList3[i]['mobile_no'];
        custDropDown.add('$name ($mobile)');
      }
    }
    if (mobileList.length < 1) {
      for (var i = 0; i < productList3.length; i++) {
        mobileList.add(productList3[i]['mobile_no']);
      }
    }

   

    return jsonDecode(data)["data"];
  }

  void onTabTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  Future getlac() async {
    // //  log(id.toString() +
    //       "idddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
    print("hiiiiiiiii");
    // https://lamit.erpeaz.com/api/resource/Customer Area?filters=[["allocated_by", "=", "1232435456"]] & limit=100

    var baseUrl = urlMain +
        'api/resource/Assign Sale Area?filters=[["sales_officer", "=", "$userId"]] &limit=10000000000';

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
      // hotview((jsonDecode(data)["data"]));
      // leaview(jsonDecode(data)["data"]);

      //  listLedgers((jsonDecode(data)["data"]));
      // log(jsonData.toString());
      // setState(() {});
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
