// import 'dart:convert';
// import 'dart:developer';

// import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:lamit/app/modules/home/views/home_view.dart';
// import 'package:lamit/app/modules/lead/controllers/lead_controller.dart';

// import 'package:lamit/app/routes/constants.dart';
// import 'package:lamit/tocken/config/url.dart';
// import 'package:lamit/widget/customeappbar.dart';
// import 'package:maps_launcher/maps_launcher.dart';
// import 'package:get/get.dart';

// import 'package:lamit/app/modules/leaddetails/views/leaddetails_view.dart';

// import 'package:lamit/tocken/tockn.dart';
// import 'package:lamit/widget/customtext.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';

// class HotleadView extends StatefulWidget {
//   final String restorationId = "";
//   @override
//   State<HotleadView> createState() => _HotleadViewState();
// }

// class _HotleadViewState extends State<HotleadView> with RestorationMixin {
//   String? get restorationId => widget.restorationId;
//   // final List<Widget> _children = [
//   //   // DashView(),
//   //   LeadView(),
//   //   LeadView(),
//   //   //ToolsView(),
//   // ];

//   var productList = [];
//   var productList1 = [];
//   var productList4 = [];
//   var productList3;
//   var productlistsearch;
//   var productlistsearch1;
//   var productList5 = [];
//   // ignore: unused_field
//   var customerl;
//   var customerli;
//   var customerlist;
//   var customerlis;
//   var cusdropdownvalue;
//   var cusdropdownvalu;
//   var cusdropdownval;
//   var lacd;
//   var custDropDown = [];
//   var custDropDow = [];
//   var custDropDo = [];
//   int _index = 0;
//   String? akey;
//   String? skey;
//   String? email;
//   String lls = "";
//   String? em;
//   String? userId;
//   bool _canPop = false;
//   String? ceatd;
//   String? named;
//   String? mobiled;
//   //StringproductList;
//   LeadController controller = Get.put(LeadController(""));
//   String? a;
//   String? filter;
//   var colors = [
//     Colors.red[100],
//     Colors.blue[100],
//     Colors.cyan[100],
//     Colors.green[100],
//     Colors.yellow[100],
//   ];
//   var laclist;
//   // var colorss = [
//   //  Colors.red[100],

//   // ];

//   final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());
//   late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
//       RestorableRouteFuture<DateTime?>(
//     onComplete: _selectDate,
//     onPresent: (NavigatorState navigator, Object? arguments) {
//       return navigator.restorablePush(
//         _datePickerRoute,
//         arguments: _selectedDate.value.millisecondsSinceEpoch,
//       );
//     },
//   );

//   static Route<DateTime> _datePickerRoute(
//     BuildContext context,
//     Object? arguments,
//   ) {
//     return DialogRoute<DateTime>(
//       context: context,
//       builder: (BuildContext context) {
//         return DatePickerDialog(
//           restorationId: 'date_picker_dialog',
//           initialEntryMode: DatePickerEntryMode.calendarOnly,
//           initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
//           firstDate: DateTime(2021),
//           lastDate: DateTime(2122),
//         );
//       },
//     );
//   }

//   @override
//   void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
//     registerForRestoration(_selectedDate, 'selected_date');
//     registerForRestoration(
//         _restorableDatePickerRouteFuture, 'date_picker_route_future');
//   }

//   String? datelll;
//   void _selectDate(DateTime? newSelectedDate) {
//     if (newSelectedDate != null) {
//       setState(() {
//         _selectedDate.value = newSelectedDate;

//         datelll =
//             '${_selectedDate.value.year}-${_selectedDate.value.month}-${_selectedDate.value.day}';

//         leaddupliview(laclist, datelll);
//       });
//     }
//   }

//   bool isLoading = false;

//   @override
//   void initState() {
//     getsf();
//     // getFiltList();

//     super.initState();

//     //print(akey);

//     // Get.put(LeadAPI(
//     //   akey,
//     //   skey,
//     // ).login());
//   }

//   Widget build(BuildContext context) {
//     //  LeadaddController c = Get.put(LeadaddController());
//     return Scaffold(
//         // bottomNavigationBar: Container(
//         //   height: 70,
//         //   decoration: BoxDecoration(
//         //     color: Color.fromARGB(255, 4, 7, 105),
//         //     // borderRadius: const BorderRadius.only(
//         //     //   topLeft: Radius.circular(60),
//         //     //   topRight: Radius.circular(60),
//         //     // ),
//         //   ),
//         //   child: Container(height: 70),
//         //   //   child: Container(
//         //   //     child: BottomNavigationBar(
//         //   //       unselectedItemColor: Colors.white,
//         //   //       selectedItemColor: Colors.grey,
//         //   //       backgroundColor: Color.fromARGB(255, 4, 7, 105),
//         //   //       onTap: onTabTapped,
//         //   //       currentIndex: _index,
//         //   //       items: [
//         //   //         BottomNavigationBarItem(
//         //   //           icon: Icon(Icons.dashboard),
//         //   //           label: 'Dashboard',
//         //   //         ),
//         //   //         // BottomNavigationBarItem(
//         //   //         //   icon: Icon(Icons.leaderboard),
//         //   //         //   label: 'Lead',
//         //   //         // ),
//         //   //         BottomNavigationBarItem(
//         //   //           icon: GestureDetector(
//         //   //             onTap: (() {
//         //   //               Get.to(HomeView("isedit"));
//         //   //             }),
//         //   //             child: Container(
//         //   //               child: Icon(
//         //   //                 Icons.event,
//         //   //               ),
//         //   //             ),
//         //   //           ),
//         //   //           label: 'Events',
//         //   //         )
//         //   //       ],
//         //   //     ),
//         //   //   ),
//         // ),

//         // floatingActionButton: Padding(
//         //   padding: const EdgeInsets.only(),
//         //   child: CircleAvatar(
//         //     backgroundColor: Colors.white,
//         //     radius: 40,
//         //     child: Container(
//         //         color: Colors.white,
//         //         child: FloatingActionButton(
//         //             backgroundColor: Color.fromARGB(255, 4, 7, 105),
//         //             child: Icon(Icons.close),
//         //             onPressed: () {
//         //               Get.to(HomeView(""));
//         //             })),
//         //   ),
//         // ),
//         // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

//         // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         // floatingActionButton: Column(
//         //   children: [
//         //     // Expanded(
//         //     //   child: Container(),
//         //     // ),
//         //     Expanded(child: Container()),
//         //     Padding(
//         //       padding: const EdgeInsets.all(8.0),
//         //       child: Row(
//         //         children: [
//         //           Expanded(child: Container()),
//         //           FloatingActionButton(
//         //             // isExtended: true,
//         //             child: Icon(Icons.add),
//         //             backgroundColor: Colors.blue,
//         //             onPressed: () {
//         //               Get.to(LeadaddView());
//         //             },
//         //           ),
//         //         ],
//         //       ),
//         //     ),
//         //   ],
//         // ),
//         appBar: PreferredSize(
//           preferredSize:
//               Size(MediaQuery.of(context).size.width, kToolbarHeight),
//           child: CustomAppBar(
//             title: 'HOT LEAD LIST',
//           ),
//           //  AppBar(
//           //   backgroundColor: Colors.grey[50],
//           //   title: const Text(
//           //     'LEAD LIST',
//           //     style: TextStyle(
//           //         fontSize: 16,
//           //         fontWeight: FontWeight.bold,
//           //         color: Color.fromARGB(255, 5, 51, 88)),
//           //   ),
//           //   elevation: 0,
//           //   leading: Padding(
//           //     padding: const EdgeInsets.only(left: 16.0),
//           //     child: IconButton(
//           //       icon: Icon(Icons.arrow_back, color: Colors.black),
//           //       onPressed: () => Get.to(HomeView("")),
//           //     ),
//           //   ),

//           //   //centerTitle: true,
//         ),
//         body: WillPopScope(
//           onWillPop: () async {
//             if (_canPop) {
//               return true;
//             } else {
//               Get.to(HomeView(""));
//               return false;
//             }
//           },
//           child: productList.length == 0
//               ? Container(
//                   color: Colors.grey[50],
//                   child: Center(
//                     child: new Container(
//                         width: 100.00,
//                         height: 100.00,
//                         decoration: new BoxDecoration(
//                           image: new DecorationImage(
//                             image: ExactAssetImage('assets/2.gif'),
//                             fit: BoxFit.fitHeight,
//                           ),
//                         )),
//                   ),
//                 )
//               : Padding(
//                   padding: const EdgeInsets.only(left: 16.0, right: 16, top: 0),
//                   child: Container(
//                     color: Colors.grey[50],
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Container(
//                             //  width: Constants(context).scrnWidth,
//                             child: DropdownButton(
//                               hint: Text("Filter"),
//                               value: filter,
//                               items: [
//                                 //add items in the dropdown
//                                 DropdownMenuItem(
//                                     child: Text("Name"), value: "Name"),

//                                 DropdownMenuItem(
//                                   child: Text("Date"),
//                                   value: "Date",
//                                 ),

//                                 DropdownMenuItem(
//                                   child: Text("Lac"),
//                                   value: "Lac",
//                                 ),
//                                 DropdownMenuItem(
//                                   child: Text("Mobile"),
//                                   value: "Mobile",
//                                 )
//                               ],
//                               onChanged: (value) {
//                                 //get value when changed
//                                 setState(() {
//                                   filter = value.toString();
//                                   print("You selected $value");
//                                 });
//                               },
//                             ),
//                           ),

//                           // lls == "true"
//                           //     ? Container()
//                           //     : Padding(
//                           //         padding: const EdgeInsets.only(right: 8.0),
//                           //         child: Container(
//                           //           child: ElevatedButton(
//                           //             child: const Text('Filter'),
//                           //             onPressed: () {
//                           //               setState(() {
//                           //                 lls = "true";
//                           //               });

//                           //               log(lls);
//                           //             },
//                           //           ),
//                           //         ),
//                           //       ),
//                           // filter != "Date"
//                           //     ? Container()
//                           //     : Container(
//                           //         height: 200,
//                           //         width: double.infinity,
//                           //         color: Colors.white,
//                           //         alignment: Alignment.topCenter,
//                           //         // margin: const EdgeInsets.all(20),
//                           //         // padding: const EdgeInsets.all(30),
//                           //         child: Column(
//                           //           children: [
//                           //             Padding(
//                           //               padding: const EdgeInsets.all(8.0),
//                           //               child: Text("Filter",
//                           //                   style: TextStyle(fontSize: 20)),
//                           //             ),
//                           //             Row(
//                           //               mainAxisAlignment:
//                           //                   MainAxisAlignment.center,
//                           //               children: [
//                           //                 Expanded(
//                           //                   child: GestureDetector(
//                           //                     onTap: () {
//                           //                       setState(() {
//                           //                         ceatd = "tick";
//                           //                         named = "";
//                           //                         mobiled = "";
//                           //                         lacd = "";
//                           //                       });
//                           //                     },
//                           //                     child: Padding(
//                           //                       padding:
//                           //                           const EdgeInsets.all(8.0),
//                           //                       child: Container(
//                           //                           decoration: BoxDecoration(
//                           //                             color: ceatd == "tick"
//                           //                                 ? Colors.blue[200]
//                           //                                 : Colors.grey[200],
//                           //                             borderRadius:
//                           //                                 BorderRadius.all(
//                           //                               Radius.circular(12.0),
//                           //                             ),
//                           //                           ),
//                           //                           height: 40,
//                           //                           width: Constants(context)
//                           //                               .scrnWidth,
//                           //                           //  color: Colors.grey[200],
//                           //                           child: Center(
//                           //                             child: Padding(
//                           //                               padding:
//                           //                                   const EdgeInsets
//                           //                                       .all(8.0),
//                           //                               child: Text(
//                           //                                   "Created date"),
//                           //                             ),
//                           //                           )),
//                           //                     ),
//                           //                   ),
//                           //                 ),
//                           //                 Expanded(
//                           //                   child: GestureDetector(
//                           //                     onTap: () {
//                           //                       setState(() {
//                           //                         named = "tick";
//                           //                         ceatd = "";
//                           //                         mobiled = "";
//                           //                         lacd = "";
//                           //                       });
//                           //                     },
//                           //                     child: Padding(
//                           //                       padding:
//                           //                           const EdgeInsets.all(8.0),
//                           //                       child: Container(
//                           //                         decoration: BoxDecoration(
//                           //                           color: named == "tick"
//                           //                               ? Colors.blue[200]
//                           //                               : Colors.grey[200],
//                           //                           borderRadius:
//                           //                               BorderRadius.all(
//                           //                             Radius.circular(12.0),
//                           //                           ),
//                           //                         ),
//                           //                         height: 40,
//                           //                         width: Constants(context)
//                           //                             .scrnWidth,
//                           //                         child: Center(
//                           //                           child: Padding(
//                           //                             padding:
//                           //                                 const EdgeInsets.all(
//                           //                                     8.0),
//                           //                             child: Text("Name"),
//                           //                           ),
//                           //                         ),
//                           //                       ),
//                           //                     ),
//                           //                   ),
//                           //                 ),
//                           //               ],
//                           //             ),
//                           //             Row(
//                           //               mainAxisAlignment:
//                           //                   MainAxisAlignment.center,
//                           //               children: [
//                           //                 Expanded(
//                           //                   child: GestureDetector(
//                           //                     onTap: () {
//                           //                       setState(() {
//                           //                         mobiled = "tick";
//                           //                         named = "";
//                           //                         ceatd = "";
//                           //                       });
//                           //                     },
//                           //                     child: Padding(
//                           //                       padding:
//                           //                           const EdgeInsets.all(8.0),
//                           //                       child: Container(
//                           //                           decoration: BoxDecoration(
//                           //                             color: mobiled == "tick"
//                           //                                 ? Colors.blue[200]
//                           //                                 : Colors.grey[200],
//                           //                             borderRadius:
//                           //                                 BorderRadius.all(
//                           //                               Radius.circular(12.0),
//                           //                             ),
//                           //                           ),
//                           //                           height: 40,
//                           //                           width: Constants(context)
//                           //                               .scrnWidth,
//                           //                           //  color: Colors.grey[200],
//                           //                           child: Center(
//                           //                             child: Padding(
//                           //                               padding:
//                           //                                   const EdgeInsets
//                           //                                       .all(8.0),
//                           //                               child: Text(
//                           //                                   "Mobile number"),
//                           //                             ),
//                           //                           )),
//                           //                     ),
//                           //                   ),
//                           //                 ),
//                           //                 Expanded(
//                           //                   child: GestureDetector(
//                           //                     onTap: () {
//                           //                       setState(() {
//                           //                         lacd = "tick";
//                           //                         ceatd = "";
//                           //                         mobiled = "";
//                           //                         named = "";
//                           //                       });
//                           //                     },
//                           //                     child: Padding(
//                           //                       padding:
//                           //                           const EdgeInsets.all(8.0),
//                           //                       child: Container(
//                           //                         decoration: BoxDecoration(
//                           //                           color: lacd == "tick"
//                           //                               ? Colors.blue[200]
//                           //                               : Colors.grey[200],
//                           //                           borderRadius:
//                           //                               BorderRadius.all(
//                           //                             Radius.circular(12.0),
//                           //                           ),
//                           //                         ),
//                           //                         height: 40,
//                           //                         width: Constants(context)
//                           //                             .scrnWidth,
//                           //                         child: Center(
//                           //                           child: Padding(
//                           //                             padding:
//                           //                                 const EdgeInsets.all(
//                           //                                     8.0),
//                           //                             child:
//                           //                                 Text("Customer area"),
//                           //                           ),
//                           //                         ),
//                           //                       ),
//                           //                     ),
//                           //                   ),
//                           //                 ),
//                           //               ],
//                           //             )
//                           //           ],
//                           //         ),
//                           //       ),

//                           // FancyContainer(
//                           //   onTap: () {
//                           //     print("Hello World");
//                           //     Text("hhhhhhhhhh");
//                           //   },
//                           //   color1: Colors.white,
//                           //   color2: Colors.grey[200],
//                           //   title: 'Hello World',
//                           //   textcolor: Colors.white,
//                           //   subtitle: 'This is a new package',
//                           //   subtitlecolor: Colors.white,
//                           // ),
//                           Row(
//                             children: [
//                               filter != "Date"
//                                   ? Container()
//                                   : Expanded(
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Container(
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Container(
//                                                 height: 50,
//                                                 margin: EdgeInsets.all(5),
//                                                 decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       color: Colors
//                                                           .grey, // Set border color
//                                                       width: 1.0),
//                                                   color: HexColor("#F9F9F9"),
//                                                   borderRadius:
//                                                       BorderRadius.circular(5),
//                                                 ),
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           left: 8.0,
//                                                           right: 8.0),
//                                                   child: Align(
//                                                     alignment:
//                                                         Alignment.centerLeft,
//                                                     child: Container(
//                                                       width: Constants(context)
//                                                           .scrnWidth,
//                                                       child: TextButton(
//                                                         onPressed: () {
//                                                           // _keyboardVisible = true;
//                                                           _restorableDatePickerRouteFuture
//                                                               .present();

//                                                           setState(() {
//                                                             a = "${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}";
//                                                             a.toString();
//                                                           });

//                                                           // leaddupliview(
//                                                           //     laclist, a.toString());
//                                                         },
//                                                         child: datelll == null
//                                                             ? Text(
//                                                                 'Filter Date',
//                                                                 style: TextStyle(
//                                                                     fontSize:
//                                                                         11,
//                                                                     color: Colors
//                                                                         .black),
//                                                               )
//                                                             : Text(
//                                                                 datelll
//                                                                     .toString(),
//                                                                 style: TextStyle(
//                                                                     color: Colors
//                                                                         .black),
//                                                               ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                             ],
//                           ),
//                           filter != "Name"
//                               ? Container()
//                               : Padding(
//                                   padding: const EdgeInsets.only(
//                                       bottom: 8.0, left: 16, right: 16),
//                                   child: Container(
//                                     width: Constants(context).scrnWidth,
//                                     height: 52,
//                                     margin: EdgeInsets.all(0),
//                                     decoration: BoxDecoration(
//                                       // border: Border.all(
//                                       //     color: Colors.grey, // Set border color
//                                       //     width: 1.0),
//                                       color: HexColor("#F9F9F9"),
//                                       borderRadius: BorderRadius.circular(5),
//                                     ),
//                                     child: Row(
//                                       children: [
//                                         Expanded(
//                                           child: Container(
//                                             // margin: EdgeInsets.all(2),
//                                             decoration: BoxDecoration(
//                                               color: Colors.grey[100],
//                                               //color: Colors.white,
//                                             ),
//                                             child: CustomSearchableDropDown(
//                                                 suffixIcon: Icon(
//                                                     size: 24, Icons.search),
//                                                 primaryColor: Colors.black,
//                                                 items: productlistsearch,
//                                                 label: 'Lead Search',
//                                                 showLabelInMenu: true,
//                                                 onChanged: (value) async {
//                                                   // markedropdownvalue =
//                                                   //     null;
//                                                   // log(sourcelist
//                                                   //     .toString());
//                                                   // log(value
//                                                   //     .toString());
//                                                   setState(() async {
//                                                     // lshow =
//                                                     //     "show";
//                                                     cusdropdownvalue = null;
//                                                     cusdropdownvalue =
//                                                         value["lead_name"]
//                                                             .toString();
//                                                     await getlac2(
//                                                         cusdropdownvalue);

//                                                     // cleadname =
//                                                     //     value["name"];
//                                                     // custarea =
//                                                     //     value["customer_area"].toString();
//                                                     // log(value
//                                                     //     .toString());
//                                                     // log(custarea.toString() +
//                                                     //     "bnbggggbbfffff");
//                                                     // //   lac = value["lac"]
//                                                     //     .toString();
//                                                     // log("hiiii+" +
//                                                     //     leadname
//                                                     //         .toString());
//                                                     // log(dropdownvaluesource
//                                                     //     .toString());
//                                                   });
//                                                   // log(custarea
//                                                   //     .toString());
//                                                   // marketing(
//                                                   //     custarea,
//                                                   //     cleadname);
//                                                   await getlac();
//                                                   setState(() {});
//                                                 },
//                                                 dropDownMenuItems:
//                                                     custDropDown == []
//                                                         ? ['']
//                                                         : custDropDown
//                                                             .toSet()
//                                                             .toList()),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                           filter != "Mobile"
//                               ? Container()
//                               : Padding(
//                                   padding: const EdgeInsets.only(
//                                       bottom: 8.0, left: 16, right: 16),
//                                   child: Container(
//                                     width: Constants(context).scrnWidth,
//                                     height: 52,
//                                     margin: EdgeInsets.all(0),
//                                     decoration: BoxDecoration(
//                                       // border: Border.all(
//                                       //     color: Colors.grey, // Set border color
//                                       //     width: 1.0),
//                                       color: HexColor("#F9F9F9"),
//                                       borderRadius: BorderRadius.circular(5),
//                                     ),
//                                     child: Row(
//                                       children: [
//                                         Expanded(
//                                           child: Container(
//                                             // margin: EdgeInsets.all(2),
//                                             decoration: BoxDecoration(
//                                               color: Colors.grey[100],
//                                               //color: Colors.white,
//                                             ),
//                                             child: CustomSearchableDropDown(
//                                                 suffixIcon: Icon(
//                                                     size: 24, Icons.search),
//                                                 primaryColor: Colors.black,
//                                                 items: productlistsearch,
//                                                 label: 'Mobile Search',
//                                                 showLabelInMenu: true,
//                                                 onChanged: (value) async {
//                                                   // markedropdownvalue =
//                                                   //     null;
//                                                   // log(sourcelist
//                                                   //     .toString());
//                                                   // log(value
//                                                   //     .toString());
//                                                   setState(() async {
//                                                     // lshow =
//                                                     //     "show";
//                                                     cusdropdownvalu = null;
//                                                     cusdropdownvalu =
//                                                         value["mobile_no"]
//                                                             .toString();
//                                                     await getlac3(
//                                                         cusdropdownvalu);

//                                                     // cleadname =
//                                                     //     value["name"];
//                                                     // custarea =
//                                                     //     value["customer_area"].toString();
//                                                     // log(value
//                                                     //     .toString());
//                                                     // log(custarea.toString() +
//                                                     //     "bnbggggbbfffff");
//                                                     // //   lac = value["lac"]
//                                                     //     .toString();
//                                                     // log("hiiii+" +
//                                                     //     leadname
//                                                     //         .toString());
//                                                     // log(dropdownvaluesource
//                                                     //     .toString());
//                                                   });
//                                                   // log(custarea
//                                                   //     .toString());
//                                                   // marketing(
//                                                   //     custarea,
//                                                   //     cleadname);
//                                                   await getlac();
//                                                   setState(() {});
//                                                 },
//                                                 dropDownMenuItems:
//                                                     custDropDow == []
//                                                         ? ['']
//                                                         : custDropDow
//                                                             .toSet()
//                                                             .toList()),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                           filter != "Lac"
//                               ? Container()
//                               : Padding(
//                                   padding: const EdgeInsets.only(
//                                       bottom: 8.0, left: 16, right: 16),
//                                   child: Container(
//                                     width: Constants(context).scrnWidth,
//                                     height: 52,
//                                     margin: EdgeInsets.all(0),
//                                     decoration: BoxDecoration(
//                                       // border: Border.all(
//                                       //     color: Colors.grey, // Set border color
//                                       //     width: 1.0),
//                                       color: HexColor("#F9F9F9"),
//                                       borderRadius: BorderRadius.circular(5),
//                                     ),
//                                     child: Row(
//                                       children: [
//                                         Expanded(
//                                           child: Container(
//                                             // margin: EdgeInsets.all(2),
//                                             decoration: BoxDecoration(
//                                               color: Colors.grey[100],
//                                               //color: Colors.white,
//                                             ),
//                                             child: CustomSearchableDropDown(
//                                                 suffixIcon: Icon(
//                                                     size: 24, Icons.search),
//                                                 primaryColor: Colors.black,
//                                                 items: productlistsearch,
//                                                 label: 'Customer Area',
//                                                 showLabelInMenu: true,
//                                                 onChanged: (value) async {
//                                                   // markedropdownvalue =
//                                                   //     null;
//                                                   // log(sourcelist
//                                                   //     .toString());
//                                                   // log(value
//                                                   //     .toString());
//                                                   setState(() async {
//                                                     // lshow =
//                                                     //     "show";
//                                                     cusdropdownval = null;
//                                                     cusdropdownval =
//                                                         value["lac"].toString();
//                                                     await getlac4(
//                                                         cusdropdownval);

//                                                     // cleadname =
//                                                     //     value["name"];
//                                                     // custarea =
//                                                     //     value["customer_area"].toString();
//                                                     // log(value
//                                                     //     .toString());
//                                                     // log(custarea.toString() +
//                                                     //     "bnbggggbbfffff");
//                                                     // //   lac = value["lac"]
//                                                     //     .toString();
//                                                     // log("hiiii+" +
//                                                     //     leadname
//                                                     //         .toString());
//                                                     // log(dropdownvaluesource
//                                                     //     .toString());
//                                                   });
//                                                   // log(custarea
//                                                   //     .toString());
//                                                   // marketing(
//                                                   //     custarea,
//                                                   //     cleadname);
//                                                   await getlac();
//                                                   setState(() {});
//                                                 },
//                                                 dropDownMenuItems:
//                                                     custDropDo == []
//                                                         ? ['']
//                                                         : custDropDo
//                                                             .toSet()
//                                                             .toList()),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                           cusdropdownval != null
//                               ? Expanded(
//                                   child: Column(
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Container(
//                                           color: Colors.grey[100],
//                                           child: Row(
//                                             children: [
//                                               IconButton(
//                                                   onPressed: () {
//                                                     setState(() {
//                                                       cusdropdownval = "";
//                                                       cusdropdownval = null;
//                                                     });
//                                                     getlac();
//                                                   },
//                                                   icon: Icon(Icons.clear)),
//                                               Text("Clear Filter"),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Container(
//                                               child: ListView.builder(
//                                                   itemCount:
//                                                       productList5.length,
//                                                   itemBuilder:
//                                                       ((context, index) {
//                                                     return Container(
//                                                       child: Column(
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         children: [
//                                                           Card(
//                                                             // shape: RoundedRectangleBorder(
//                                                             //     borderRadius: BorderRadius.only(
//                                                             //         topLeft: Radius.circular(20),
//                                                             //         topRight: Radius.circular(20),
//                                                             //         bottomLeft:
//                                                             //             Radius.circular(20),
//                                                             //         bottomRight:
//                                                             //             Radius.circular(20))),
//                                                             child: Column(
//                                                               children: [
//                                                                 Padding(
//                                                                   padding:
//                                                                       const EdgeInsets
//                                                                               .all(
//                                                                           8.0),
//                                                                   child:
//                                                                       GestureDetector(
//                                                                     onTap: (() {
//                                                                       Get.to(
//                                                                           LeaddetailsView(
//                                                                         productList5[index]
//                                                                             [
//                                                                             "first_name"],
//                                                                         productList5[index]
//                                                                             [
//                                                                             "status"],
//                                                                         0,
//                                                                         "",
//                                                                         productList5[index]
//                                                                             [
//                                                                             "email"],
//                                                                         productList5[index]
//                                                                             [
//                                                                             "name"],
//                                                                       ));
//                                                                     }),
//                                                                     child: productList5 ==
//                                                                             ""
//                                                                         ? Container()
//                                                                         : Container(
//                                                                             child: productList5[index] == ""
//                                                                                 ? Container()
//                                                                                 : Container(
//                                                                                     // height: 200,
//                                                                                     child: ListTile(
//                                                                                       title: Row(
//                                                                                         children: [
//                                                                                           Column(
//                                                                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                                                                             children: [
//                                                                                               Text(
//                                                                                                 productList5[index]["lead_name"].toString().toUpperCase()
//                                                                                                 // controller
//                                                                                                 //     .productList[index]["name"]
//                                                                                                 //     .value[index],
//                                                                                                 //"hhh"
//                                                                                                 //  controller.productList[index],
//                                                                                                 // "ggg",
//                                                                                                 ,
//                                                                                                 style: TextStyle(fontSize: 11, color: Colors.black, fontWeight: FontWeight.bold),
//                                                                                               ),
//                                                                                               SizedBox(
//                                                                                                 height: 5,
//                                                                                               ),
//                                                                                               Text(
//                                                                                                 productList5[index]["date"] == null ? "No date added" : DateFormat("dd-MM-yyyy").format(DateTime.parse(productList5[index]["date"].toString())),
//                                                                                                 style: TextStyle(fontSize: 11, color: Color.fromARGB(255, 4, 52, 91), fontWeight: FontWeight.bold),
//                                                                                               ),
//                                                                                               SizedBox(
//                                                                                                 height: 5,
//                                                                                               ),
//                                                                                               Text(
//                                                                                                 productList5[index]["status"] == null ? "" : "Status :" + productList5[index]["status"].toString(),
//                                                                                                 style: TextStyle(fontSize: 9, color: Color.fromARGB(255, 4, 52, 91), fontWeight: FontWeight.bold),
//                                                                                               ),
//                                                                                             ],
//                                                                                           ),
//                                                                                           Expanded(child: Container()),
//                                                                                           productList5[index]["latitude"] == null
//                                                                                               ? Container()
//                                                                                               : productList5[index]["latitude"] == null
//                                                                                                   ? Container()
//                                                                                                   : GestureDetector(
//                                                                                                       onTap: (() {
//                                                                                                         MapsLauncher.launchCoordinates(double.parse(productList1[index]["latitude"]), double.parse(productList1[index]["longitude"]), '');
//                                                                                                       }),
//                                                                                                       child: Container(
//                                                                                                         height: 30,
//                                                                                                         width: 30,
//                                                                                                         child: IconButton(
//                                                                                                           onPressed: () {
//                                                                                                             MapsLauncher.launchCoordinates(double.parse(productList5[index]["latitude"]), double.parse(productList5[index]["longitude"]), '');
//                                                                                                           },
//                                                                                                           iconSize: 16,
//                                                                                                           icon: Icon(
//                                                                                                             Icons.location_on,
//                                                                                                           ),
//                                                                                                           color: Colors.grey,
//                                                                                                           //  size: 16,
//                                                                                                         ),
//                                                                                                       ),
//                                                                                                     ),
//                                                                                           GestureDetector(
//                                                                                             onTap: () {
//                                                                                               _makePhoneCall(productlistsearch == "" ? "No number" : productlistsearch[index]["mobile_no"]);
//                                                                                             },
//                                                                                             child: Container(
//                                                                                               height: 30,
//                                                                                               width: 30,
//                                                                                               child: Padding(
//                                                                                                 padding: const EdgeInsets.all(8.0),
//                                                                                                 child: Container(
//                                                                                                   child: IconButton(
//                                                                                                     onPressed: (() {
//                                                                                                       _makePhoneCall(productlistsearch == "" ? "No number" : productlistsearch[index]["mobile_no"]);
//                                                                                                     }),
//                                                                                                     iconSize: 16,
//                                                                                                     icon: Icon(
//                                                                                                       Icons.phone,
//                                                                                                     ),
//                                                                                                     color: Colors.blue,
//                                                                                                   ),
//                                                                                                 ),
//                                                                                               ),
//                                                                                             ),
//                                                                                           ),
//                                                                                           productList5[index]["whatsapp_no"] == ""
//                                                                                               ? Container()
//                                                                                               : Padding(
//                                                                                                   padding: const EdgeInsets.all(8.0),
//                                                                                                   child: Padding(
//                                                                                                     padding: const EdgeInsets.only(top: 8.0),
//                                                                                                     child: GestureDetector(
//                                                                                                       onTap: () {
//                                                                                                         var numb = productList5[index]["whatsapp_no"];
//                                                                                                         launch('whatsapp://send?text=sample text&phone=$numb');
//                                                                                                       },
//                                                                                                       child: Container(
//                                                                                                           height: 20,
//                                                                                                           width: 20,
//                                                                                                           child: Image.asset('assets/55.png',
//                                                                                                               height: 20,
//                                                                                                               scale: 2.5,
//                                                                                                               // color: Color.fromARGB(255, 15, 147, 59),
//                                                                                                               opacity: const AlwaysStoppedAnimation<double>(0.5))),
//                                                                                                     ),
//                                                                                                   ),
//                                                                                                 ),
//                                                                                         ],
//                                                                                       ),

//                                                                                       subtitle: Row(
//                                                                                         children: [
//                                                                                           Expanded(
//                                                                                             child: Container(),
//                                                                                           ),
//                                                                                           Expanded(
//                                                                                             child: Container(),
//                                                                                           ),
//                                                                                           Expanded(
//                                                                                             child: GestureDetector(
//                                                                                               onTap: () {
//                                                                                                 Get.to(LeaddetailsView(
//                                                                                                   productList5[index]["lead_name"],
//                                                                                                   productList5[index]["status"],
//                                                                                                   0,
//                                                                                                   "",
//                                                                                                   productList5[index]["email"],
//                                                                                                   productList5[index]["name"],
//                                                                                                 ));
//                                                                                               },
//                                                                                               child: Container(
//                                                                                                 child: Container(
//                                                                                                     child: Row(
//                                                                                                   children: [
//                                                                                                     Padding(
//                                                                                                       padding: const EdgeInsets.all(8.0),
//                                                                                                       child: Text(
//                                                                                                         "Click detail",
//                                                                                                         style: TextStyle(color: Colors.blue, fontSize: 10),
//                                                                                                       ),
//                                                                                                     ),
//                                                                                                     // Icon(
//                                                                                                     //   Icons.arrow_downward,
//                                                                                                     //   size: 12,
//                                                                                                     // ),
//                                                                                                   ],
//                                                                                                 )),
//                                                                                               ),
//                                                                                             ),
//                                                                                           ),
//                                                                                         ],
//                                                                                       ),

//                                                                                       //   subtitle:
//                                                                                       //       Column(
//                                                                                       //     crossAxisAlignment:
//                                                                                       //         CrossAxisAlignment
//                                                                                       //             .start,
//                                                                                       //     children: [
//                                                                                       //       Row(
//                                                                                       //         children: [
//                                                                                       //           Expanded(
//                                                                                       //             flex: 2,
//                                                                                       //             child: Container(
//                                                                                       //               decoration: BoxDecoration(
//                                                                                       //                   color: Colors.blue[900],
//                                                                                       //                   border: Border.all(

//                                                                                       //                       // color: Colors.red[500],
//                                                                                       //                       ),
//                                                                                       //                   borderRadius: BorderRadius.all(Radius.circular(10))),
//                                                                                       //               height: 40,
//                                                                                       //               // width:
//                                                                                       //               //     100,
//                                                                                       //               child: Container(
//                                                                                       //                 //  width: 50,
//                                                                                       //                 child: Center(
//                                                                                       //                   child: Text(
//                                                                                       //                     productList[index]["source"] == null ? "" : productList[index]["source"],
//                                                                                       //                     style: TextStyle(color: Colors.white, fontSize: 12),
//                                                                                       //                   ),
//                                                                                       //                 ),
//                                                                                       //               ),
//                                                                                       //             ),
//                                                                                       //           ),
//                                                                                       //           Expanded(
//                                                                                       //             flex: 3,
//                                                                                       //             child: Padding(
//                                                                                       //               padding: const EdgeInsets.all(8.0),
//                                                                                       //               child: Container(
//                                                                                       //                 decoration: BoxDecoration(
//                                                                                       //                     color: Colors.green,
//                                                                                       //                     border: Border.all(

//                                                                                       //                         // color: Colors.red[500],
//                                                                                       //                         ),
//                                                                                       //                     borderRadius: BorderRadius.all(Radius.circular(10))),
//                                                                                       //                 height: 40,
//                                                                                       //                 // width:
//                                                                                       //                 //     100,
//                                                                                       //                 child: Container(
//                                                                                       //                   //width: 50,
//                                                                                       //                   child: Center(
//                                                                                       //                     child: Text(
//                                                                                       //                       productList[index]["status"] == "" ? "" : productList[index]["status"],
//                                                                                       //                       style: TextStyle(color: Colors.white),
//                                                                                       //                     ),
//                                                                                       //                   ),
//                                                                                       //                 ),
//                                                                                       //               ),
//                                                                                       //             ),
//                                                                                       //           ),
//                                                                                       //           Expanded(
//                                                                                       //             flex: 2,
//                                                                                       //             child: Container(
//                                                                                       //               decoration: BoxDecoration(
//                                                                                       //                   //color: Colors.blue[900],

//                                                                                       //                   // color: Colors.red[500],

//                                                                                       //                   borderRadius: BorderRadius.all(Radius.circular(20))),
//                                                                                       //               // height:
//                                                                                       //               //     30,
//                                                                                       //               // width:
//                                                                                       //               //     100,
//                                                                                       //               child: Container(
//                                                                                       //                   // width: 50,
//                                                                                       //                   ),
//                                                                                       //             ),
//                                                                                       //           ),
//                                                                                       //         ],
//                                                                                       //       ),
//                                                                                       //       Row(
//                                                                                       //         children: [
//                                                                                       //           Text(productList[index]["location"] == null
//                                                                                       //               ? "Update ur address"
//                                                                                       //               : productList[index]["location"]),
//                                                                                       //           Expanded(child: Container()),
//                                                                                       //           Icon(Icons.delete),
//                                                                                       //         ],
//                                                                                       //       ),
//                                                                                       //       // Container(
//                                                                                       //       //     height:
//                                                                                       //       //         30,
//                                                                                       //       //     width:
//                                                                                       //       //         200,
//                                                                                       //       //     child:
//                                                                                       //       //         Container(
//                                                                                       //       //       decoration: BoxDecoration(
//                                                                                       //       //           color: Colors.red,

//                                                                                       //       //           // border: Border.all(
//                                                                                       //       //           // //  color: Colors.red[500],
//                                                                                       //       //           // ),
//                                                                                       //       //           borderRadius: BorderRadius.all(Radius.circular(10))),
//                                                                                       //       //       child: Center(child: Text("Next meeting :" + productList[index]["next_contact_date"] == "" ? "Not updated" : productList[index]["next_contact_date"].toString())),
//                                                                                       //       //     )),
//                                                                                       //     ],
//                                                                                       //   ),
//                                                                                     ),
//                                                                                   ),
//                                                                           ),
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     );
//                                                   })),
//                                             )),
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               : cusdropdownvalu != null
//                                   ? Expanded(
//                                       child: Column(
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Container(
//                                               color: Colors.grey[100],
//                                               child: Row(
//                                                 children: [
//                                                   IconButton(
//                                                       onPressed: () {
//                                                         setState(() {
//                                                           cusdropdownvalu = "";
//                                                           cusdropdownvalu =
//                                                               null;
//                                                         });
//                                                         getlac();
//                                                       },
//                                                       icon: Icon(Icons.clear)),
//                                                   Text("Clear Filter"),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                           Expanded(
//                                             child: Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(8.0),
//                                                 child: Container(
//                                                   child: ListView.builder(
//                                                       itemCount:
//                                                           productList4.length,
//                                                       itemBuilder:
//                                                           ((context, index) {
//                                                         return Container(
//                                                           child: Column(
//                                                             crossAxisAlignment:
//                                                                 CrossAxisAlignment
//                                                                     .start,
//                                                             children: [
//                                                               Card(
//                                                                 // shape: RoundedRectangleBorder(
//                                                                 //     borderRadius: BorderRadius.only(
//                                                                 //         topLeft: Radius.circular(20),
//                                                                 //         topRight: Radius.circular(20),
//                                                                 //         bottomLeft:
//                                                                 //             Radius.circular(20),
//                                                                 //         bottomRight:
//                                                                 //             Radius.circular(20))),
//                                                                 child: Column(
//                                                                   children: [
//                                                                     Padding(
//                                                                       padding:
//                                                                           const EdgeInsets.all(
//                                                                               8.0),
//                                                                       child:
//                                                                           GestureDetector(
//                                                                         onTap:
//                                                                             (() {
//                                                                           Get.to(
//                                                                               LeaddetailsView(
//                                                                             productList4[index]["first_name"],
//                                                                             productList4[index]["status"],
//                                                                             0,
//                                                                             "",
//                                                                             productList4[index]["email"],
//                                                                             productList4[index]["name"],
//                                                                           ));
//                                                                         }),
//                                                                         child: productList4 ==
//                                                                                 ""
//                                                                             ? Container()
//                                                                             : Container(
//                                                                                 child: productList4[index] == ""
//                                                                                     ? Container()
//                                                                                     : Container(
//                                                                                         // height: 200,
//                                                                                         child: ListTile(
//                                                                                           title: Row(
//                                                                                             children: [
//                                                                                               Column(
//                                                                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                                                                 children: [
//                                                                                                   Text(
//                                                                                                     productList4[index]["lead_name"].toString().toUpperCase()
//                                                                                                     // controller
//                                                                                                     //     .productList[index]["name"]
//                                                                                                     //     .value[index],
//                                                                                                     //"hhh"
//                                                                                                     //  controller.productList[index],
//                                                                                                     // "ggg",
//                                                                                                     ,
//                                                                                                     style: TextStyle(fontSize: 11, color: Colors.black, fontWeight: FontWeight.bold),
//                                                                                                   ),
//                                                                                                   SizedBox(
//                                                                                                     height: 5,
//                                                                                                   ),
//                                                                                                   Text(
//                                                                                                     productList4[index]["date"] == null ? "No date added" : DateFormat("dd-MM-yyyy").format(DateTime.parse(productList4[index]["date"].toString())),
//                                                                                                     style: TextStyle(fontSize: 11, color: Color.fromARGB(255, 4, 52, 91), fontWeight: FontWeight.bold),
//                                                                                                   ),
//                                                                                                   SizedBox(
//                                                                                                     height: 5,
//                                                                                                   ),
//                                                                                                   Text(
//                                                                                                     productList4[index]["status"] == null ? "" : "Status :" + productList4[index]["status"].toString(),
//                                                                                                     style: TextStyle(fontSize: 9, color: Color.fromARGB(255, 4, 52, 91), fontWeight: FontWeight.bold),
//                                                                                                   ),
//                                                                                                 ],
//                                                                                               ),
//                                                                                               Expanded(child: Container()),
//                                                                                               productList4[index]["latitude"] == null
//                                                                                                   ? Container()
//                                                                                                   : productList4[index]["latitude"] == null
//                                                                                                       ? Container()
//                                                                                                       : GestureDetector(
//                                                                                                           onTap: (() {
//                                                                                                             MapsLauncher.launchCoordinates(double.parse(productList1[index]["latitude"]), double.parse(productList1[index]["longitude"]), '');
//                                                                                                           }),
//                                                                                                           child: Container(
//                                                                                                             height: 30,
//                                                                                                             width: 30,
//                                                                                                             child: IconButton(
//                                                                                                               onPressed: () {
//                                                                                                                 MapsLauncher.launchCoordinates(double.parse(productList4[index]["latitude"]), double.parse(productList4[index]["longitude"]), '');
//                                                                                                               },
//                                                                                                               iconSize: 16,
//                                                                                                               icon: Icon(
//                                                                                                                 Icons.location_on,
//                                                                                                               ),
//                                                                                                               color: Colors.grey,
//                                                                                                               //  size: 16,
//                                                                                                             ),
//                                                                                                           ),
//                                                                                                         ),
//                                                                                               GestureDetector(
//                                                                                                 onTap: () {
//                                                                                                   _makePhoneCall(productlistsearch == "" ? "No number" : productlistsearch[index]["mobile_no"]);
//                                                                                                 },
//                                                                                                 child: Container(
//                                                                                                   height: 30,
//                                                                                                   width: 30,
//                                                                                                   child: Padding(
//                                                                                                     padding: const EdgeInsets.all(8.0),
//                                                                                                     child: Container(
//                                                                                                       child: IconButton(
//                                                                                                         onPressed: (() {
//                                                                                                           _makePhoneCall(productlistsearch == "" ? "No number" : productlistsearch[index]["mobile_no"]);
//                                                                                                         }),
//                                                                                                         iconSize: 16,
//                                                                                                         icon: Icon(
//                                                                                                           Icons.phone,
//                                                                                                         ),
//                                                                                                         color: Colors.blue,
//                                                                                                       ),
//                                                                                                     ),
//                                                                                                   ),
//                                                                                                 ),
//                                                                                               ),
//                                                                                               productList4[index]["whatsapp_no"] == ""
//                                                                                                   ? Container()
//                                                                                                   : Padding(
//                                                                                                       padding: const EdgeInsets.all(8.0),
//                                                                                                       child: Padding(
//                                                                                                         padding: const EdgeInsets.only(top: 8.0),
//                                                                                                         child: GestureDetector(
//                                                                                                           onTap: () {
//                                                                                                             var numb = productList4[index]["whatsapp_no"];
//                                                                                                             launch('whatsapp://send?text=sample text&phone=$numb');
//                                                                                                           },
//                                                                                                           child: Container(
//                                                                                                               height: 20,
//                                                                                                               width: 20,
//                                                                                                               child: Image.asset('assets/55.png',
//                                                                                                                   height: 20,
//                                                                                                                   scale: 2.5,
//                                                                                                                   // color: Color.fromARGB(255, 15, 147, 59),
//                                                                                                                   opacity: const AlwaysStoppedAnimation<double>(0.5))),
//                                                                                                         ),
//                                                                                                       ),
//                                                                                                     ),
//                                                                                             ],
//                                                                                           ),

//                                                                                           subtitle: Row(
//                                                                                             children: [
//                                                                                               Expanded(
//                                                                                                 child: Container(),
//                                                                                               ),
//                                                                                               Expanded(
//                                                                                                 child: Container(),
//                                                                                               ),
//                                                                                               Expanded(
//                                                                                                 child: GestureDetector(
//                                                                                                   onTap: () {
//                                                                                                     Get.to(LeaddetailsView(
//                                                                                                       productList4[index]["lead_name"],
//                                                                                                       productList4[index]["status"],
//                                                                                                       0,
//                                                                                                       "",
//                                                                                                       productList4[index]["email"],
//                                                                                                       productList4[index]["name"],
//                                                                                                     ));
//                                                                                                   },
//                                                                                                   child: Container(
//                                                                                                     child: Container(
//                                                                                                         child: Row(
//                                                                                                       children: [
//                                                                                                         Padding(
//                                                                                                           padding: const EdgeInsets.all(8.0),
//                                                                                                           child: Text(
//                                                                                                             "Click detail",
//                                                                                                             style: TextStyle(color: Colors.blue, fontSize: 10),
//                                                                                                           ),
//                                                                                                         ),
//                                                                                                         // Icon(
//                                                                                                         //   Icons.arrow_downward,
//                                                                                                         //   size: 12,
//                                                                                                         // ),
//                                                                                                       ],
//                                                                                                     )),
//                                                                                                   ),
//                                                                                                 ),
//                                                                                               ),
//                                                                                             ],
//                                                                                           ),

//                                                                                           //   subtitle:
//                                                                                           //       Column(
//                                                                                           //     crossAxisAlignment:
//                                                                                           //         CrossAxisAlignment
//                                                                                           //             .start,
//                                                                                           //     children: [
//                                                                                           //       Row(
//                                                                                           //         children: [
//                                                                                           //           Expanded(
//                                                                                           //             flex: 2,
//                                                                                           //             child: Container(
//                                                                                           //               decoration: BoxDecoration(
//                                                                                           //                   color: Colors.blue[900],
//                                                                                           //                   border: Border.all(

//                                                                                           //                       // color: Colors.red[500],
//                                                                                           //                       ),
//                                                                                           //                   borderRadius: BorderRadius.all(Radius.circular(10))),
//                                                                                           //               height: 40,
//                                                                                           //               // width:
//                                                                                           //               //     100,
//                                                                                           //               child: Container(
//                                                                                           //                 //  width: 50,
//                                                                                           //                 child: Center(
//                                                                                           //                   child: Text(
//                                                                                           //                     productList[index]["source"] == null ? "" : productList[index]["source"],
//                                                                                           //                     style: TextStyle(color: Colors.white, fontSize: 12),
//                                                                                           //                   ),
//                                                                                           //                 ),
//                                                                                           //               ),
//                                                                                           //             ),
//                                                                                           //           ),
//                                                                                           //           Expanded(
//                                                                                           //             flex: 3,
//                                                                                           //             child: Padding(
//                                                                                           //               padding: const EdgeInsets.all(8.0),
//                                                                                           //               child: Container(
//                                                                                           //                 decoration: BoxDecoration(
//                                                                                           //                     color: Colors.green,
//                                                                                           //                     border: Border.all(

//                                                                                           //                         // color: Colors.red[500],
//                                                                                           //                         ),
//                                                                                           //                     borderRadius: BorderRadius.all(Radius.circular(10))),
//                                                                                           //                 height: 40,
//                                                                                           //                 // width:
//                                                                                           //                 //     100,
//                                                                                           //                 child: Container(
//                                                                                           //                   //width: 50,
//                                                                                           //                   child: Center(
//                                                                                           //                     child: Text(
//                                                                                           //                       productList[index]["status"] == "" ? "" : productList[index]["status"],
//                                                                                           //                       style: TextStyle(color: Colors.white),
//                                                                                           //                     ),
//                                                                                           //                   ),
//                                                                                           //                 ),
//                                                                                           //               ),
//                                                                                           //             ),
//                                                                                           //           ),
//                                                                                           //           Expanded(
//                                                                                           //             flex: 2,
//                                                                                           //             child: Container(
//                                                                                           //               decoration: BoxDecoration(
//                                                                                           //                   //color: Colors.blue[900],

//                                                                                           //                   // color: Colors.red[500],

//                                                                                           //                   borderRadius: BorderRadius.all(Radius.circular(20))),
//                                                                                           //               // height:
//                                                                                           //               //     30,
//                                                                                           //               // width:
//                                                                                           //               //     100,
//                                                                                           //               child: Container(
//                                                                                           //                   // width: 50,
//                                                                                           //                   ),
//                                                                                           //             ),
//                                                                                           //           ),
//                                                                                           //         ],
//                                                                                           //       ),
//                                                                                           //       Row(
//                                                                                           //         children: [
//                                                                                           //           Text(productList[index]["location"] == null
//                                                                                           //               ? "Update ur address"
//                                                                                           //               : productList[index]["location"]),
//                                                                                           //           Expanded(child: Container()),
//                                                                                           //           Icon(Icons.delete),
//                                                                                           //         ],
//                                                                                           //       ),
//                                                                                           //       // Container(
//                                                                                           //       //     height:
//                                                                                           //       //         30,
//                                                                                           //       //     width:
//                                                                                           //       //         200,
//                                                                                           //       //     child:
//                                                                                           //       //         Container(
//                                                                                           //       //       decoration: BoxDecoration(
//                                                                                           //       //           color: Colors.red,

//                                                                                           //       //           // border: Border.all(
//                                                                                           //       //           // //  color: Colors.red[500],
//                                                                                           //       //           // ),
//                                                                                           //       //           borderRadius: BorderRadius.all(Radius.circular(10))),
//                                                                                           //       //       child: Center(child: Text("Next meeting :" + productList[index]["next_contact_date"] == "" ? "Not updated" : productList[index]["next_contact_date"].toString())),
//                                                                                           //       //     )),
//                                                                                           //     ],
//                                                                                           //   ),
//                                                                                         ),
//                                                                                       ),
//                                                                               ),
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         );
//                                                       })),
//                                                 )),
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                   : cusdropdownvalue != null
//                                       ? Expanded(
//                                           child: Column(
//                                             children: [
//                                               Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(8.0),
//                                                 child: Container(
//                                                   color: Colors.grey[100],
//                                                   child: Row(
//                                                     children: [
//                                                       IconButton(
//                                                           onPressed: () {
//                                                             setState(() {
//                                                               cusdropdownvalue =
//                                                                   "";
//                                                               cusdropdownvalue =
//                                                                   null;
//                                                             });
//                                                             getlac();
//                                                           },
//                                                           icon: Icon(
//                                                               Icons.clear)),
//                                                       Text("Clear Filter"),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             8.0),
//                                                     child: Container(
//                                                       child: ListView.builder(
//                                                           itemCount:
//                                                               productList3
//                                                                   .length,
//                                                           itemBuilder:
//                                                               ((context,
//                                                                   index) {
//                                                             return Container(
//                                                               child: Column(
//                                                                 crossAxisAlignment:
//                                                                     CrossAxisAlignment
//                                                                         .start,
//                                                                 children: [
//                                                                   Card(
//                                                                     // shape: RoundedRectangleBorder(
//                                                                     //     borderRadius: BorderRadius.only(
//                                                                     //         topLeft: Radius.circular(20),
//                                                                     //         topRight: Radius.circular(20),
//                                                                     //         bottomLeft:
//                                                                     //             Radius.circular(20),
//                                                                     //         bottomRight:
//                                                                     //             Radius.circular(20))),
//                                                                     child:
//                                                                         Column(
//                                                                       children: [
//                                                                         Padding(
//                                                                           padding:
//                                                                               const EdgeInsets.all(8.0),
//                                                                           child:
//                                                                               GestureDetector(
//                                                                             onTap:
//                                                                                 (() {
//                                                                               Get.to(LeaddetailsView(
//                                                                                 productList3[index]["first_name"],
//                                                                                 productList3[index]["status"],
//                                                                                 0,
//                                                                                 "",
//                                                                                 productList3[index]["email"],
//                                                                                 productList3[index]["name"],
//                                                                               ));
//                                                                             }),
//                                                                             child: productList3 == ""
//                                                                                 ? Container()
//                                                                                 : Container(
//                                                                                     child: productList3[index] == ""
//                                                                                         ? Container()
//                                                                                         : Container(
//                                                                                             // height: 200,
//                                                                                             child: ListTile(
//                                                                                               title: Row(
//                                                                                                 children: [
//                                                                                                   Column(
//                                                                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                                                                     children: [
//                                                                                                       Text(
//                                                                                                         productList3[index]["lead_name"].toString().toUpperCase()
//                                                                                                         // controller
//                                                                                                         //     .productList[index]["name"]
//                                                                                                         //     .value[index],
//                                                                                                         //"hhh"
//                                                                                                         //  controller.productList[index],
//                                                                                                         // "ggg",
//                                                                                                         ,
//                                                                                                         style: TextStyle(fontSize: 11, color: Colors.black, fontWeight: FontWeight.bold),
//                                                                                                       ),
//                                                                                                       SizedBox(
//                                                                                                         height: 5,
//                                                                                                       ),
//                                                                                                       Text(
//                                                                                                         productList3[index]["date"] == null ? "No date added" : DateFormat("dd-MM-yyyy").format(DateTime.parse(productList3[index]["date"].toString())),
//                                                                                                         style: TextStyle(fontSize: 11, color: Color.fromARGB(255, 4, 52, 91), fontWeight: FontWeight.bold),
//                                                                                                       ),
//                                                                                                       SizedBox(
//                                                                                                         height: 5,
//                                                                                                       ),
//                                                                                                       Text(
//                                                                                                         productList3[index]["status"] == null ? "" : "Status :" + productList3[index]["status"].toString(),
//                                                                                                         style: TextStyle(fontSize: 9, color: Color.fromARGB(255, 4, 52, 91), fontWeight: FontWeight.bold),
//                                                                                                       ),
//                                                                                                     ],
//                                                                                                   ),
//                                                                                                   Expanded(child: Container()),
//                                                                                                   productList3[index]["latitude"] == null
//                                                                                                       ? Container()
//                                                                                                       : productList3[index]["latitude"] == null
//                                                                                                           ? Container()
//                                                                                                           : GestureDetector(
//                                                                                                               onTap: (() {
//                                                                                                                 MapsLauncher.launchCoordinates(double.parse(productList1[index]["latitude"]), double.parse(productList1[index]["longitude"]), '');
//                                                                                                               }),
//                                                                                                               child: Container(
//                                                                                                                 height: 30,
//                                                                                                                 width: 30,
//                                                                                                                 child: IconButton(
//                                                                                                                   onPressed: () {
//                                                                                                                     MapsLauncher.launchCoordinates(double.parse(productList3[index]["latitude"]), double.parse(productList3[index]["longitude"]), '');
//                                                                                                                   },
//                                                                                                                   iconSize: 16,
//                                                                                                                   icon: Icon(
//                                                                                                                     Icons.location_on,
//                                                                                                                   ),
//                                                                                                                   color: Colors.grey,
//                                                                                                                   //  size: 16,
//                                                                                                                 ),
//                                                                                                               ),
//                                                                                                             ),
//                                                                                                   GestureDetector(
//                                                                                                     onTap: () {
//                                                                                                       _makePhoneCall(productlistsearch == "" ? "No number" : productlistsearch[index]["mobile_no"]);
//                                                                                                     },
//                                                                                                     child: Container(
//                                                                                                       height: 30,
//                                                                                                       width: 30,
//                                                                                                       child: Padding(
//                                                                                                         padding: const EdgeInsets.all(8.0),
//                                                                                                         child: Container(
//                                                                                                           child: IconButton(
//                                                                                                             onPressed: (() {
//                                                                                                               _makePhoneCall(productlistsearch == "" ? "No number" : productlistsearch[index]["mobile_no"]);
//                                                                                                             }),
//                                                                                                             iconSize: 16,
//                                                                                                             icon: Icon(
//                                                                                                               Icons.phone,
//                                                                                                             ),
//                                                                                                             color: Colors.blue,
//                                                                                                           ),
//                                                                                                         ),
//                                                                                                       ),
//                                                                                                     ),
//                                                                                                   ),
//                                                                                                   productList3[index]["whatsapp_no"] == ""
//                                                                                                       ? Container()
//                                                                                                       : Padding(
//                                                                                                           padding: const EdgeInsets.all(8.0),
//                                                                                                           child: Padding(
//                                                                                                             padding: const EdgeInsets.only(top: 8.0),
//                                                                                                             child: GestureDetector(
//                                                                                                               onTap: () {
//                                                                                                                 var numb = productList3[index]["whatsapp_no"];
//                                                                                                                 launch('whatsapp://send?text=sample text&phone=$numb');
//                                                                                                               },
//                                                                                                               child: Container(
//                                                                                                                   height: 20,
//                                                                                                                   width: 20,
//                                                                                                                   child: Image.asset('assets/55.png',
//                                                                                                                       height: 20,
//                                                                                                                       scale: 2.5,
//                                                                                                                       // color: Color.fromARGB(255, 15, 147, 59),
//                                                                                                                       opacity: const AlwaysStoppedAnimation<double>(0.5))),
//                                                                                                             ),
//                                                                                                           ),
//                                                                                                         ),
//                                                                                                 ],
//                                                                                               ),

//                                                                                               subtitle: Row(
//                                                                                                 children: [
//                                                                                                   Expanded(
//                                                                                                     child: Container(),
//                                                                                                   ),
//                                                                                                   Expanded(
//                                                                                                     child: Container(),
//                                                                                                   ),
//                                                                                                   Expanded(
//                                                                                                     child: GestureDetector(
//                                                                                                       onTap: () {
//                                                                                                         Get.to(LeaddetailsView(
//                                                                                                           productList3[index]["lead_name"],
//                                                                                                           productList3[index]["status"],
//                                                                                                           0,
//                                                                                                           "",
//                                                                                                           productList3[index]["email"],
//                                                                                                           productList3[index]["name"],
//                                                                                                         ));
//                                                                                                       },
//                                                                                                       child: Container(
//                                                                                                         child: Container(
//                                                                                                             child: Row(
//                                                                                                           children: [
//                                                                                                             Padding(
//                                                                                                               padding: const EdgeInsets.all(8.0),
//                                                                                                               child: Text(
//                                                                                                                 "Click detail",
//                                                                                                                 style: TextStyle(color: Colors.blue, fontSize: 10),
//                                                                                                               ),
//                                                                                                             ),
//                                                                                                             // Icon(
//                                                                                                             //   Icons.arrow_downward,
//                                                                                                             //   size: 12,
//                                                                                                             // ),
//                                                                                                           ],
//                                                                                                         )),
//                                                                                                       ),
//                                                                                                     ),
//                                                                                                   ),
//                                                                                                 ],
//                                                                                               ),

//                                                                                               //   subtitle:
//                                                                                               //       Column(
//                                                                                               //     crossAxisAlignment:
//                                                                                               //         CrossAxisAlignment
//                                                                                               //             .start,
//                                                                                               //     children: [
//                                                                                               //       Row(
//                                                                                               //         children: [
//                                                                                               //           Expanded(
//                                                                                               //             flex: 2,
//                                                                                               //             child: Container(
//                                                                                               //               decoration: BoxDecoration(
//                                                                                               //                   color: Colors.blue[900],
//                                                                                               //                   border: Border.all(

//                                                                                               //                       // color: Colors.red[500],
//                                                                                               //                       ),
//                                                                                               //                   borderRadius: BorderRadius.all(Radius.circular(10))),
//                                                                                               //               height: 40,
//                                                                                               //               // width:
//                                                                                               //               //     100,
//                                                                                               //               child: Container(
//                                                                                               //                 //  width: 50,
//                                                                                               //                 child: Center(
//                                                                                               //                   child: Text(
//                                                                                               //                     productList[index]["source"] == null ? "" : productList[index]["source"],
//                                                                                               //                     style: TextStyle(color: Colors.white, fontSize: 12),
//                                                                                               //                   ),
//                                                                                               //                 ),
//                                                                                               //               ),
//                                                                                               //             ),
//                                                                                               //           ),
//                                                                                               //           Expanded(
//                                                                                               //             flex: 3,
//                                                                                               //             child: Padding(
//                                                                                               //               padding: const EdgeInsets.all(8.0),
//                                                                                               //               child: Container(
//                                                                                               //                 decoration: BoxDecoration(
//                                                                                               //                     color: Colors.green,
//                                                                                               //                     border: Border.all(

//                                                                                               //                         // color: Colors.red[500],
//                                                                                               //                         ),
//                                                                                               //                     borderRadius: BorderRadius.all(Radius.circular(10))),
//                                                                                               //                 height: 40,
//                                                                                               //                 // width:
//                                                                                               //                 //     100,
//                                                                                               //                 child: Container(
//                                                                                               //                   //width: 50,
//                                                                                               //                   child: Center(
//                                                                                               //                     child: Text(
//                                                                                               //                       productList[index]["status"] == "" ? "" : productList[index]["status"],
//                                                                                               //                       style: TextStyle(color: Colors.white),
//                                                                                               //                     ),
//                                                                                               //                   ),
//                                                                                               //                 ),
//                                                                                               //               ),
//                                                                                               //             ),
//                                                                                               //           ),
//                                                                                               //           Expanded(
//                                                                                               //             flex: 2,
//                                                                                               //             child: Container(
//                                                                                               //               decoration: BoxDecoration(
//                                                                                               //                   //color: Colors.blue[900],

//                                                                                               //                   // color: Colors.red[500],

//                                                                                               //                   borderRadius: BorderRadius.all(Radius.circular(20))),
//                                                                                               //               // height:
//                                                                                               //               //     30,
//                                                                                               //               // width:
//                                                                                               //               //     100,
//                                                                                               //               child: Container(
//                                                                                               //                   // width: 50,
//                                                                                               //                   ),
//                                                                                               //             ),
//                                                                                               //           ),
//                                                                                               //         ],
//                                                                                               //       ),
//                                                                                               //       Row(
//                                                                                               //         children: [
//                                                                                               //           Text(productList[index]["location"] == null
//                                                                                               //               ? "Update ur address"
//                                                                                               //               : productList[index]["location"]),
//                                                                                               //           Expanded(child: Container()),
//                                                                                               //           Icon(Icons.delete),
//                                                                                               //         ],
//                                                                                               //       ),
//                                                                                               //       // Container(
//                                                                                               //       //     height:
//                                                                                               //       //         30,
//                                                                                               //       //     width:
//                                                                                               //       //         200,
//                                                                                               //       //     child:
//                                                                                               //       //         Container(
//                                                                                               //       //       decoration: BoxDecoration(
//                                                                                               //       //           color: Colors.red,

//                                                                                               //       //           // border: Border.all(
//                                                                                               //       //           // //  color: Colors.red[500],
//                                                                                               //       //           // ),
//                                                                                               //       //           borderRadius: BorderRadius.all(Radius.circular(10))),
//                                                                                               //       //       child: Center(child: Text("Next meeting :" + productList[index]["next_contact_date"] == "" ? "Not updated" : productList[index]["next_contact_date"].toString())),
//                                                                                               //       //     )),
//                                                                                               //     ],
//                                                                                               //   ),
//                                                                                             ),
//                                                                                           ),
//                                                                                   ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             );
//                                                           })),
//                                                     )),
//                                               ),
//                                             ],
//                                           ),
//                                         )
//                                       : datelll != null
//                                           ? Expanded(
//                                               child: Column(
//                                                 children: [
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             8.0),
//                                                     child: Container(
//                                                       color: Colors.grey[100],
//                                                       child: Row(
//                                                         children: [
//                                                           IconButton(
//                                                               onPressed: () {
//                                                                 getlac();
//                                                                 setState(() {
//                                                                   datelll =
//                                                                       null;
//                                                                 });
//                                                               },
//                                                               icon: Icon(
//                                                                   Icons.clear)),
//                                                           Text("Clear Filter"),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(8.0),
//                                                         child: Container(
//                                                           child:
//                                                               ListView.builder(
//                                                                   itemCount:
//                                                                       productList1
//                                                                           .length,
//                                                                   itemBuilder:
//                                                                       ((context,
//                                                                           index) {
//                                                                     return Container(
//                                                                       child:
//                                                                           Column(
//                                                                         crossAxisAlignment:
//                                                                             CrossAxisAlignment.start,
//                                                                         children: [
//                                                                           Card(
//                                                                             // shape: RoundedRectangleBorder(
//                                                                             //     borderRadius: BorderRadius.only(
//                                                                             //         topLeft: Radius.circular(20),
//                                                                             //         topRight: Radius.circular(20),
//                                                                             //         bottomLeft:
//                                                                             //             Radius.circular(20),
//                                                                             //         bottomRight:
//                                                                             //             Radius.circular(20))),
//                                                                             child:
//                                                                                 Column(
//                                                                               children: [
//                                                                                 Padding(
//                                                                                   padding: const EdgeInsets.all(8.0),
//                                                                                   child: GestureDetector(
//                                                                                     onTap: (() {
//                                                                                       Get.to(LeaddetailsView(
//                                                                                         productList1[index]["first_name"],
//                                                                                         productList1[index]["status"],
//                                                                                         0,
//                                                                                         "",
//                                                                                         productList1[index]["email"],
//                                                                                         productList1[index]["name"],
//                                                                                       ));
//                                                                                     }),
//                                                                                     child: productList1 == ""
//                                                                                         ? Container()
//                                                                                         : Container(
//                                                                                             child: productList1[index] == ""
//                                                                                                 ? Container()
//                                                                                                 : Container(
//                                                                                                     // height: 200,
//                                                                                                     child: ListTile(
//                                                                                                       title: Row(
//                                                                                                         children: [
//                                                                                                           Column(
//                                                                                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                                                                                             children: [
//                                                                                                               Text(
//                                                                                                                 productList1[index]["lead_name"].toString().toUpperCase()
//                                                                                                                 // controller
//                                                                                                                 //     .productList[index]["name"]
//                                                                                                                 //     .value[index],
//                                                                                                                 //"hhh"
//                                                                                                                 //  controller.productList[index],
//                                                                                                                 // "ggg",
//                                                                                                                 ,
//                                                                                                                 style: TextStyle(fontSize: 11, color: Colors.black, fontWeight: FontWeight.bold),
//                                                                                                               ),
//                                                                                                               SizedBox(
//                                                                                                                 height: 5,
//                                                                                                               ),
//                                                                                                               Text(
//                                                                                                                 productList[index]["date"] == null ? "No date added" : DateFormat("dd-MM-yyyy").format(DateTime.parse(productList[index]["date"].toString())),
//                                                                                                                 style: TextStyle(fontSize: 11, color: Color.fromARGB(255, 4, 52, 91), fontWeight: FontWeight.bold),
//                                                                                                               ),
//                                                                                                               SizedBox(
//                                                                                                                 height: 5,
//                                                                                                               ),
//                                                                                                               Text(
//                                                                                                                 productList1[index]["status"] == null ? "" : "Status :" + productList1[index]["status"].toString(),
//                                                                                                                 style: TextStyle(fontSize: 9, color: Color.fromARGB(255, 4, 52, 91), fontWeight: FontWeight.bold),
//                                                                                                               ),
//                                                                                                             ],
//                                                                                                           ),
//                                                                                                           Expanded(child: Container()),
//                                                                                                           productList1[index]["latitude"] == null
//                                                                                                               ? Container()
//                                                                                                               : productList1[index]["latitude"] == null
//                                                                                                                   ? Container()
//                                                                                                                   : GestureDetector(
//                                                                                                                       onTap: (() {
//                                                                                                                         MapsLauncher.launchCoordinates(double.parse(productList1[index]["latitude"]), double.parse(productList1[index]["longitude"]), '');
//                                                                                                                       }),
//                                                                                                                       child: Container(
//                                                                                                                         height: 30,
//                                                                                                                         width: 30,
//                                                                                                                         child: IconButton(
//                                                                                                                           onPressed: () {
//                                                                                                                             MapsLauncher.launchCoordinates(double.parse(productList1[index]["latitude"]), double.parse(productList1[index]["longitude"]), '');
//                                                                                                                           },
//                                                                                                                           iconSize: 16,
//                                                                                                                           icon: Icon(
//                                                                                                                             Icons.location_on,
//                                                                                                                           ),
//                                                                                                                           color: Colors.grey,
//                                                                                                                           //  size: 16,
//                                                                                                                         ),
//                                                                                                                       ),
//                                                                                                                     ),
//                                                                                                           GestureDetector(
//                                                                                                             onTap: () {
//                                                                                                               _makePhoneCall(productList1 == "" ? "No number" : productList1[index]["mobile_no"]);
//                                                                                                             },
//                                                                                                             child: Container(
//                                                                                                               height: 30,
//                                                                                                               width: 30,
//                                                                                                               child: Padding(
//                                                                                                                 padding: const EdgeInsets.all(8.0),
//                                                                                                                 child: Container(
//                                                                                                                   child: IconButton(
//                                                                                                                     onPressed: (() {
//                                                                                                                       _makePhoneCall(productList1 == "" ? "No number" : productList1[index]["mobile_no"]);
//                                                                                                                     }),
//                                                                                                                     iconSize: 16,
//                                                                                                                     icon: Icon(
//                                                                                                                       Icons.phone,
//                                                                                                                     ),
//                                                                                                                     color: Colors.blue,
//                                                                                                                   ),
//                                                                                                                 ),
//                                                                                                               ),
//                                                                                                             ),
//                                                                                                           ),
//                                                                                                           productList1[index]["whatsapp_no"] == ""
//                                                                                                               ? Container()
//                                                                                                               : Padding(
//                                                                                                                   padding: const EdgeInsets.all(8.0),
//                                                                                                                   child: Padding(
//                                                                                                                     padding: const EdgeInsets.only(top: 8.0),
//                                                                                                                     child: GestureDetector(
//                                                                                                                       onTap: () {
//                                                                                                                         var numb = productList1[index]["whatsapp_no"];
//                                                                                                                         launch('whatsapp://send?text=sample text&phone=$numb');
//                                                                                                                       },
//                                                                                                                       child: Container(
//                                                                                                                           height: 20,
//                                                                                                                           width: 20,
//                                                                                                                           child: Image.asset('assets/55.png',
//                                                                                                                               height: 20,
//                                                                                                                               scale: 2.5,
//                                                                                                                               // color: Color.fromARGB(255, 15, 147, 59),
//                                                                                                                               opacity: const AlwaysStoppedAnimation<double>(0.5))),
//                                                                                                                     ),
//                                                                                                                   ),
//                                                                                                                 ),
//                                                                                                         ],
//                                                                                                       ),

//                                                                                                       subtitle: Row(
//                                                                                                         children: [
//                                                                                                           Expanded(
//                                                                                                             child: Container(),
//                                                                                                           ),
//                                                                                                           Expanded(
//                                                                                                             child: Container(),
//                                                                                                           ),
//                                                                                                           Expanded(
//                                                                                                             child: GestureDetector(
//                                                                                                               onTap: () {
//                                                                                                                 Get.to(LeaddetailsView(
//                                                                                                                   productList[index]["lead_name"],
//                                                                                                                   productList[index]["status"],
//                                                                                                                   0,
//                                                                                                                   "",
//                                                                                                                   productList[index]["email"],
//                                                                                                                   productList[index]["name"],
//                                                                                                                 ));
//                                                                                                               },
//                                                                                                               child: Container(
//                                                                                                                 child: Container(
//                                                                                                                     child: Row(
//                                                                                                                   children: [
//                                                                                                                     Padding(
//                                                                                                                       padding: const EdgeInsets.all(8.0),
//                                                                                                                       child: Text(
//                                                                                                                         "Click detail",
//                                                                                                                         style: TextStyle(color: Colors.blue, fontSize: 10),
//                                                                                                                       ),
//                                                                                                                     ),
//                                                                                                                     // Icon(
//                                                                                                                     //   Icons.arrow_downward,
//                                                                                                                     //   size: 12,
//                                                                                                                     // ),
//                                                                                                                   ],
//                                                                                                                 )),
//                                                                                                               ),
//                                                                                                             ),
//                                                                                                           ),
//                                                                                                         ],
//                                                                                                       ),

//                                                                                                       //   subtitle:
//                                                                                                       //       Column(
//                                                                                                       //     crossAxisAlignment:
//                                                                                                       //         CrossAxisAlignment
//                                                                                                       //             .start,
//                                                                                                       //     children: [
//                                                                                                       //       Row(
//                                                                                                       //         children: [
//                                                                                                       //           Expanded(
//                                                                                                       //             flex: 2,
//                                                                                                       //             child: Container(
//                                                                                                       //               decoration: BoxDecoration(
//                                                                                                       //                   color: Colors.blue[900],
//                                                                                                       //                   border: Border.all(

//                                                                                                       //                       // color: Colors.red[500],
//                                                                                                       //                       ),
//                                                                                                       //                   borderRadius: BorderRadius.all(Radius.circular(10))),
//                                                                                                       //               height: 40,
//                                                                                                       //               // width:
//                                                                                                       //               //     100,
//                                                                                                       //               child: Container(
//                                                                                                       //                 //  width: 50,
//                                                                                                       //                 child: Center(
//                                                                                                       //                   child: Text(
//                                                                                                       //                     productList[index]["source"] == null ? "" : productList[index]["source"],
//                                                                                                       //                     style: TextStyle(color: Colors.white, fontSize: 12),
//                                                                                                       //                   ),
//                                                                                                       //                 ),
//                                                                                                       //               ),
//                                                                                                       //             ),
//                                                                                                       //           ),
//                                                                                                       //           Expanded(
//                                                                                                       //             flex: 3,
//                                                                                                       //             child: Padding(
//                                                                                                       //               padding: const EdgeInsets.all(8.0),
//                                                                                                       //               child: Container(
//                                                                                                       //                 decoration: BoxDecoration(
//                                                                                                       //                     color: Colors.green,
//                                                                                                       //                     border: Border.all(

//                                                                                                       //                         // color: Colors.red[500],
//                                                                                                       //                         ),
//                                                                                                       //                     borderRadius: BorderRadius.all(Radius.circular(10))),
//                                                                                                       //                 height: 40,
//                                                                                                       //                 // width:
//                                                                                                       //                 //     100,
//                                                                                                       //                 child: Container(
//                                                                                                       //                   //width: 50,
//                                                                                                       //                   child: Center(
//                                                                                                       //                     child: Text(
//                                                                                                       //                       productList[index]["status"] == "" ? "" : productList[index]["status"],
//                                                                                                       //                       style: TextStyle(color: Colors.white),
//                                                                                                       //                     ),
//                                                                                                       //                   ),
//                                                                                                       //                 ),
//                                                                                                       //               ),
//                                                                                                       //             ),
//                                                                                                       //           ),
//                                                                                                       //           Expanded(
//                                                                                                       //             flex: 2,
//                                                                                                       //             child: Container(
//                                                                                                       //               decoration: BoxDecoration(
//                                                                                                       //                   //color: Colors.blue[900],

//                                                                                                       //                   // color: Colors.red[500],

//                                                                                                       //                   borderRadius: BorderRadius.all(Radius.circular(20))),
//                                                                                                       //               // height:
//                                                                                                       //               //     30,
//                                                                                                       //               // width:
//                                                                                                       //               //     100,
//                                                                                                       //               child: Container(
//                                                                                                       //                   // width: 50,
//                                                                                                       //                   ),
//                                                                                                       //             ),
//                                                                                                       //           ),
//                                                                                                       //         ],
//                                                                                                       //       ),
//                                                                                                       //       Row(
//                                                                                                       //         children: [
//                                                                                                       //           Text(productList[index]["location"] == null
//                                                                                                       //               ? "Update ur address"
//                                                                                                       //               : productList[index]["location"]),
//                                                                                                       //           Expanded(child: Container()),
//                                                                                                       //           Icon(Icons.delete),
//                                                                                                       //         ],
//                                                                                                       //       ),
//                                                                                                       //       // Container(
//                                                                                                       //       //     height:
//                                                                                                       //       //         30,
//                                                                                                       //       //     width:
//                                                                                                       //       //         200,
//                                                                                                       //       //     child:
//                                                                                                       //       //         Container(
//                                                                                                       //       //       decoration: BoxDecoration(
//                                                                                                       //       //           color: Colors.red,

//                                                                                                       //       //           // border: Border.all(
//                                                                                                       //       //           // //  color: Colors.red[500],
//                                                                                                       //       //           // ),
//                                                                                                       //       //           borderRadius: BorderRadius.all(Radius.circular(10))),
//                                                                                                       //       //       child: Center(child: Text("Next meeting :" + productList[index]["next_contact_date"] == "" ? "Not updated" : productList[index]["next_contact_date"].toString())),
//                                                                                                       //       //     )),
//                                                                                                       //     ],
//                                                                                                       //   ),
//                                                                                                     ),
//                                                                                                   ),
//                                                                                           ),
//                                                                                   ),
//                                                                                 ),
//                                                                               ],
//                                                                             ),
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                     );
//                                                                   })),
//                                                         )),
//                                                   ),
//                                                 ],
//                                               ),
//                                             )
//                                           : Expanded(
//                                               child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(8.0),
//                                                   child: Container(
//                                                     child: ListView.builder(
//                                                         itemCount:
//                                                             productList.length,
//                                                         itemBuilder:
//                                                             ((context, index) {
//                                                           return Container(
//                                                             child: Column(
//                                                               crossAxisAlignment:
//                                                                   CrossAxisAlignment
//                                                                       .start,
//                                                               children: [
//                                                                 Card(
//                                                                   // shape: RoundedRectangleBorder(
//                                                                   //     borderRadius: BorderRadius.only(
//                                                                   //         topLeft: Radius.circular(20),
//                                                                   //         topRight: Radius.circular(20),
//                                                                   //         bottomLeft:
//                                                                   //             Radius.circular(20),
//                                                                   //         bottomRight:
//                                                                   //             Radius.circular(20))),
//                                                                   child: Column(
//                                                                     children: [
//                                                                       Padding(
//                                                                         padding:
//                                                                             const EdgeInsets.all(8.0),
//                                                                         child:
//                                                                             GestureDetector(
//                                                                           onTap:
//                                                                               (() {
//                                                                             Get.to(LeaddetailsView(
//                                                                               productList[index]["lead_name"],
//                                                                               productList[index]["status"],
//                                                                               0,
//                                                                               "",
//                                                                               productList[index]["email"],
//                                                                               productList[index]["name"],
//                                                                             ));
//                                                                           }),
//                                                                           child: productList == ""
//                                                                               ? Container()
//                                                                               : Container(
//                                                                                   child: productList[index] == ""
//                                                                                       ? Container()
//                                                                                       : Container(
//                                                                                           // height: 200,
//                                                                                           child: ListTile(
//                                                                                             title: Row(
//                                                                                               children: [
//                                                                                                 Column(
//                                                                                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                                                                                   children: [
//                                                                                                     Text(
//                                                                                                       productList[index]["lead_name"].toString().toUpperCase()
//                                                                                                       // controller
//                                                                                                       //     .productList[index]["name"]
//                                                                                                       //     .value[index],
//                                                                                                       //"hhh"
//                                                                                                       //  controller.productList[index],
//                                                                                                       // "ggg",
//                                                                                                       ,
//                                                                                                       style: TextStyle(fontSize: 11, color: Colors.black, fontWeight: FontWeight.bold),
//                                                                                                     ),
//                                                                                                     SizedBox(
//                                                                                                       height: 5,
//                                                                                                     ),
//                                                                                                     Text(
//                                                                                                       productList[index]["date"] == null ? "No date added" : DateFormat("dd-MM-yyyy").format(DateTime.parse(productList[index]["date"].toString())),
//                                                                                                       style: TextStyle(fontSize: 11, color: Color.fromARGB(255, 4, 52, 91), fontWeight: FontWeight.bold),
//                                                                                                     ),
//                                                                                                     SizedBox(
//                                                                                                       height: 10,
//                                                                                                     ),
//                                                                                                     Text(
//                                                                                                       productList[index]["status"] == null ? "" : "Status :" + productList[index]["status"].toString(),
//                                                                                                       style: TextStyle(fontSize: 9, color: Color.fromARGB(255, 4, 52, 91), fontWeight: FontWeight.bold),
//                                                                                                     ),
//                                                                                                   ],
//                                                                                                 ),
//                                                                                                 Expanded(child: Container()),
//                                                                                                 productList[index]["latitude"] == null
//                                                                                                     ? Container()
//                                                                                                     : productList[index]["latitude"] == null
//                                                                                                         ? Container()
//                                                                                                         : GestureDetector(
//                                                                                                             onTap: (() {
//                                                                                                               MapsLauncher.launchCoordinates(double.parse(productList[index]["latitude"]), double.parse(productList[index]["longitude"]), '');
//                                                                                                             }),
//                                                                                                             child: Container(
//                                                                                                               height: 30,
//                                                                                                               width: 30,
//                                                                                                               child: Icon(
//                                                                                                                 Icons.location_on,
//                                                                                                                 color: Colors.grey,
//                                                                                                                 size: 16,
//                                                                                                               ),
//                                                                                                             ),
//                                                                                                           ),
//                                                                                                 GestureDetector(
//                                                                                                   onTap: () {
//                                                                                                     _makePhoneCall(productList == "" ? "No number" : productList[index]["mobile_no"]);
//                                                                                                   },
//                                                                                                   child: Container(
//                                                                                                     height: 30,
//                                                                                                     width: 30,
//                                                                                                     child: Padding(
//                                                                                                       padding: const EdgeInsets.all(8.0),
//                                                                                                       child: Container(
//                                                                                                         child: Icon(
//                                                                                                           size: 16,
//                                                                                                           Icons.phone,
//                                                                                                           color: Colors.blue,
//                                                                                                         ),
//                                                                                                       ),
//                                                                                                     ),
//                                                                                                   ),
//                                                                                                 ),
//                                                                                                 productList[index]["whatsapp_no"] == ""
//                                                                                                     ? Container()
//                                                                                                     : Padding(
//                                                                                                         padding: const EdgeInsets.all(8.0),
//                                                                                                         child: GestureDetector(
//                                                                                                           onTap: () {
//                                                                                                             var numb = productList[index]["whatsapp_no"];
//                                                                                                             launch('whatsapp://send?text=sample text&phone=$numb');
//                                                                                                           },
//                                                                                                           child: Container(
//                                                                                                               height: 20,
//                                                                                                               width: 20,
//                                                                                                               child: Image.asset('assets/55.png',
//                                                                                                                   height: 20,
//                                                                                                                   scale: 2.5,
//                                                                                                                   // color: Color.fromARGB(255, 15, 147, 59),
//                                                                                                                   opacity: const AlwaysStoppedAnimation<double>(0.5))),
//                                                                                                         ),
//                                                                                                       ),
//                                                                                               ],
//                                                                                             ),

//                                                                                             subtitle: Row(
//                                                                                               children: [
//                                                                                                 Expanded(
//                                                                                                   child: Container(),
//                                                                                                 ),
//                                                                                                 Expanded(
//                                                                                                   child: Container(),
//                                                                                                 ),
//                                                                                                 Expanded(
//                                                                                                   child: GestureDetector(
//                                                                                                     onTap: () {
//                                                                                                       Get.to(LeaddetailsView(
//                                                                                                         productList[index]["lead_name"],
//                                                                                                         productList[index]["status"],
//                                                                                                         0,
//                                                                                                         "",
//                                                                                                         productList[index]["email"],
//                                                                                                         productList[index]["name"],
//                                                                                                       ));
//                                                                                                     },
//                                                                                                     child: Container(
//                                                                                                       child: Container(
//                                                                                                           child: Row(
//                                                                                                         children: [
//                                                                                                           Padding(
//                                                                                                             padding: const EdgeInsets.all(8.0),
//                                                                                                             child: Text(
//                                                                                                               "Click detail",
//                                                                                                               style: TextStyle(color: Colors.blue, fontSize: 10),
//                                                                                                             ),
//                                                                                                           ),
//                                                                                                           // Icon(
//                                                                                                           //   Icons.arrow_downward,
//                                                                                                           //   size: 12,
//                                                                                                           // ),
//                                                                                                         ],
//                                                                                                       )),
//                                                                                                     ),
//                                                                                                   ),
//                                                                                                 ),
//                                                                                               ],
//                                                                                             ),

//                                                                                             //   subtitle:
//                                                                                             //       Column(
//                                                                                             //     crossAxisAlignment:
//                                                                                             //         CrossAxisAlignment
//                                                                                             //             .start,
//                                                                                             //     children: [
//                                                                                             //       Row(
//                                                                                             //         children: [
//                                                                                             //           Expanded(
//                                                                                             //             flex: 2,
//                                                                                             //             child: Container(
//                                                                                             //               decoration: BoxDecoration(
//                                                                                             //                   color: Colors.blue[900],
//                                                                                             //                   border: Border.all(

//                                                                                             //                       // color: Colors.red[500],
//                                                                                             //                       ),
//                                                                                             //                   borderRadius: BorderRadius.all(Radius.circular(10))),
//                                                                                             //               height: 40,
//                                                                                             //               // width:
//                                                                                             //               //     100,
//                                                                                             //               child: Container(
//                                                                                             //                 //  width: 50,
//                                                                                             //                 child: Center(
//                                                                                             //                   child: Text(
//                                                                                             //                     productList[index]["source"] == null ? "" : productList[index]["source"],
//                                                                                             //                     style: TextStyle(color: Colors.white, fontSize: 12),
//                                                                                             //                   ),
//                                                                                             //                 ),
//                                                                                             //               ),
//                                                                                             //             ),
//                                                                                             //           ),
//                                                                                             //           Expanded(
//                                                                                             //             flex: 3,
//                                                                                             //             child: Padding(
//                                                                                             //               padding: const EdgeInsets.all(8.0),
//                                                                                             //               child: Container(
//                                                                                             //                 decoration: BoxDecoration(
//                                                                                             //                     color: Colors.green,
//                                                                                             //                     border: Border.all(

//                                                                                             //                         // color: Colors.red[500],
//                                                                                             //                         ),
//                                                                                             //                     borderRadius: BorderRadius.all(Radius.circular(10))),
//                                                                                             //                 height: 40,
//                                                                                             //                 // width:
//                                                                                             //                 //     100,
//                                                                                             //                 child: Container(
//                                                                                             //                   //width: 50,
//                                                                                             //                   child: Center(
//                                                                                             //                     child: Text(
//                                                                                             //                       productList[index]["status"] == "" ? "" : productList[index]["status"],
//                                                                                             //                       style: TextStyle(color: Colors.white),
//                                                                                             //                     ),
//                                                                                             //                   ),
//                                                                                             //                 ),
//                                                                                             //               ),
//                                                                                             //             ),
//                                                                                             //           ),
//                                                                                             //           Expanded(
//                                                                                             //             flex: 2,
//                                                                                             //             child: Container(
//                                                                                             //               decoration: BoxDecoration(
//                                                                                             //                   //color: Colors.blue[900],

//                                                                                             //                   // color: Colors.red[500],

//                                                                                             //                   borderRadius: BorderRadius.all(Radius.circular(20))),
//                                                                                             //               // height:
//                                                                                             //               //     30,
//                                                                                             //               // width:
//                                                                                             //               //     100,
//                                                                                             //               child: Container(
//                                                                                             //                   // width: 50,
//                                                                                             //                   ),
//                                                                                             //             ),
//                                                                                             //           ),
//                                                                                             //         ],
//                                                                                             //       ),
//                                                                                             //       Row(
//                                                                                             //         children: [
//                                                                                             //           Text(productList[index]["location"] == null
//                                                                                             //               ? "Update ur address"
//                                                                                             //               : productList[index]["location"]),
//                                                                                             //           Expanded(child: Container()),
//                                                                                             //           Icon(Icons.delete),
//                                                                                             //         ],
//                                                                                             //       ),
//                                                                                             //       // Container(
//                                                                                             //       //     height:
//                                                                                             //       //         30,
//                                                                                             //       //     width:
//                                                                                             //       //         200,
//                                                                                             //       //     child:
//                                                                                             //       //         Container(
//                                                                                             //       //       decoration: BoxDecoration(
//                                                                                             //       //           color: Colors.red,

//                                                                                             //       //           // border: Border.all(
//                                                                                             //       //           // //  color: Colors.red[500],
//                                                                                             //       //           // ),
//                                                                                             //       //           borderRadius: BorderRadius.all(Radius.circular(10))),
//                                                                                             //       //       child: Center(child: Text("Next meeting :" + productList[index]["next_contact_date"] == "" ? "Not updated" : productList[index]["next_contact_date"].toString())),
//                                                                                             //       //     )),
//                                                                                             //     ],
//                                                                                             //   ),
//                                                                                           ),
//                                                                                         ),
//                                                                                 ),
//                                                                         ),
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           );
//                                                         })),
//                                                   )),
//                                             )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//         ));
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
//   //   var i;
//   //   for (i = 0; i <= leadArray; i++);
//   //   {
//   //     name = leadArray[i]["name"];
//   //   }
//   // }

//   // login() async {
//   //   SharedPreferences preferences = await SharedPreferences.getInstance();

//   //   var a = preferences.getString("akey");
//   //   var b = preferences.getString("skey");
//   //   // var a = this.akey;
//   //   // var b = this.skey;
//   //   // print(a);
//   //   // print("$b bbzbxb");
//   //   // var email = this.email;
//   //   http.Response response = await http.get(
//   //       Uri.parse(
//   //           'https://lamit.erpeaz.com/api/resource/Lead?filters=[["email","=","adminwebeaz@gmail.com"]]'),
//   //       headers: {
//   //         'Content-type': 'application/json',
//   //         'Accept': 'application/json',
//   //         'Authorization': 'Token $a:$b',
//   //       });
//   //   String data = response.body;
//   //   print(data);

//   //   return null;
//   // }

//   leadview(var lead) async {
//     var l = [];
//     // List<String> customerList = ["KANHANGAD", "MANJESHWAR"];

//     var i;
//     var la = [];
//     var f;
//     for (i = 0; i < lead.length; i++) {
//       l.add({"name": lead[i]["name"]});
//       la.add(l[i]["name"]);
//     }
//     List<String> e = [
//       "",
//       "",
//     ];
//     // e = la;
//     log(la.toString() +
//         "gfdghfgfcgghghggjhjhjjjjhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
//     log(l.toString() + "nbnbbbbbbbbnbbnnbbbnbnbnnbbnbnbnbnnbnbnbnb");
//     print(l.toString() + "b bnbnbbnbnnm");

//     for (var i = 0; i < l.length; i++) {
//       var c = l[i]["name"];
//       e.add("$c,$c");
//       f = lead[i]["name"];
//     }
//     log(e.toString() +
//         "bvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvc");
//     // = l.toString();

//     // var l;
//     // for (var i = 0; i < lead.length; i++) {
//     //   l = lead[i]["name"];
//     // }
//     // log(l.toString() + "nbnbbbbbbbbnbbnnbbbnbnbnnbbnbnbnbnnbnbnbnb");
//     // print(l.toString() + "b bnbnbbnbnnm");
//     // var la = l.toString();

//     // var a = email;
//     // var b = skey;
//     // print(a);
//     // print("$b bbzbxb");
//     //  var email = this.email;
//     //  log(email + "hhhhh");
//     print(skey);
//     http.Response response = await http.get(
//         Uri.parse(urlMain +
//             'api/resource/Lead?filters=[["lac", "in", "$e"],["status", "=", "Hot"]]&fields=["*"]&limit=100000&order_by=creation%20desc'),
//         headers: {
//           'Content-type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': Tocken,
//         });
//     String data = response.body;
//     log(data);
//     setState(() {
//       productList = jsonDecode(data)["data"];
//       productlistsearch = jsonDecode(data)["data"];
//       custDropDo.add(f);

//       for (var i = 0; i < productList.length; i++) {
//         custDropDown.add(productlistsearch[i]['lead_name']);
//         custDropDow.add(productlistsearch[i]['mobile_no']);

//         // offLineCustomersIdDropDown.add(offLineCustomers[i]['id'].toString());
//         // customerDetails.add({
//         //   "address": offLineCustomers[i]['address'],
//         //   "vat": offLineCustomers[i]['vatnum'],
//         //   "ob": offLineCustomers[i]['balance'].toString()
//         // });
//         //  array.add(i.toString());
//       }
//     });

//     print("object");
//     // print(leadArray);

//     // print("laedarray" + leadArray);

//     return null;
//   }

//   void onTabTapped(int index) {
//     setState(() {
//       _index = index;
//     });
//   }

//   Future getlac() async {
//     print("hiiiiiiiii");
//     // https://lamit.erpeaz.com/api/resource/Customer Area?filters=[["allocated_by", "=", "1232435456"]] & limit=100
//     var baseUrl = urlMain +
//         'api/resource/Assign Sale Area?filters=[["sales_officer", "=", "$userId"]]&limit=100000&order_by=creation%20desc';

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
//       //var jsonData;
//       setState(() {
//         // jsonData = json.decode(data)["data"];
//         // laclist = jsonData;
//         laclist = jsonDecode(data)["data"];
//       });
//       leadview(jsonDecode(data)["data"]);
//       // log(jsonData.toString());
//       // setState(() {});
//     }
//   }

//   Future getlac2(name) async {
//     print("hiiiiiiiii");
//     // https://lamit.erpeaz.com/api/resource/Customer Area?filters=[["allocated_by", "=", "1232435456"]] & limit=100
//     var baseUrl = urlMain +
//         'api/resource/Assign Sale Area?filters=[["sales_officer", "=", "$userId"]]&limit=100000&order_by=creation%20desc';

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
//       //var jsonData;
//       setState(() {
//         // jsonData = json.decode(data)["data"];
//         // laclist = jsonData;
//         laclist = jsonDecode(data)["data"];
//       });
//       custview(jsonDecode(data)["data"], name);
//       // log(jsonData.toString());
//       // setState(() {});
//     }
//   }

//   Future getlac3(mobile) async {
//     print("hiiiiiiiii");
//     // https://lamit.erpeaz.com/api/resource/Customer Area?filters=[["allocated_by", "=", "1232435456"]] & limit=100
//     var baseUrl = urlMain +
//         'api/resource/Assign Sale Area?filters=[["sales_officer", "=", "$userId"]]&limit=100000&order_by=creation%20desc';

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
//       //var jsonData;
//       setState(() {
//         // jsonData = json.decode(data)["data"];
//         // laclist = jsonData;
//         laclist = jsonDecode(data)["data"];
//       });
//       mobview(jsonDecode(data)["data"], mobile);
//       // log(jsonData.toString());
//       // setState(() {});
//     }
//   }

//   Future getlac4(cust) async {
//     print("hiiiiiiiii");
//     // https://lamit.erpeaz.com/api/resource/Customer Area?filters=[["allocated_by", "=", "1232435456"]] & limit=100
//     var baseUrl = urlMain +
//         'api/resource/Assign Sale Area?filters=[["sales_officer", "=", "$userId"]]&limit=100000&order_by=creation%20desc';

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
//       //var jsonData;
//       setState(() {
//         // jsonData = json.decode(data)["data"];
//         // laclist = jsonData;
//         laclist = jsonDecode(data)["data"];
//       });
//       custmearea(jsonDecode(data)["data"], cust);
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

//   leaddupliview(var lead, var leaddate) async {
//     var l = [];
//     // List<String> customerList = ["KANHANGAD", "MANJESHWAR"];

//     var i;
//     var la = [];
//     for (i = 0; i < lead.length; i++) {
//       l.add({"name": lead[i]["name"]});
//       la.add(l[i]["name"]);
//     }
//     List<String> e = [
//       "",
//       "",
//     ];
//     // e = la;
//     log(la.toString() +
//         "gfdghfgfcgghghggjhjhjjjjhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
//     log(l.toString() + "nbnbbbbbbbbnbbnnbbbnbnbnnbbnbnbnbnnbnbnbnb");
//     print(l.toString() + "b bnbnbbnbnnm");

//     for (var i = 0; i < l.length; i++) {
//       var c = l[i]["name"];
//       e.add("$c,$c");
//     }
//     log(e.toString() +
//         "bvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvc");
//     // = l.toString();

//     // var l;
//     // for (var i = 0; i < lead.length; i++) {
//     //   l = lead[i]["name"];
//     // }
//     // log(l.toString() + "nbnbbbbbbbbnbbnnbbbnbnbnnbbnbnbnbnnbnbnbnb");
//     // print(l.toString() + "b bnbnbbnbnnm");
//     // var la = l.toString();

//     // var a = email;
//     // var b = skey;
//     // print(a);
//     // print("$b bbzbxb");
//     //  var email = this.email;
//     //  log(email + "hhhhh");
//     print(skey);
//     log(datelll.toString() + "daaaaate");
//     DateTime now = DateTime.now();
//     var v = datelll == null ? "" : datelll;
//     // String formattedDate =
//     //     DateFormat('yyyy-MM-dd').format(DateTime.parse(datelll.toString()));
//     // log(formattedDate.toString() + "fhghgghghjhhjhjjhjh");
//     log(v.toString() + "vvvvvvvvvvvvvvv");
//     http.Response response = await http.get(
//         Uri.parse(urlMain +
//             'api/resource/Lead?fields=["name","lead_name","date","source","mobile_no","email_id","lac"]&filters=[["date", "in", "$v"],["status", "=", "Hot"]]&limit=100000&order_by=creation%20desc'),
//         headers: {
//           'Content-type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': Tocken,
//         });
//     String data = response.body;
//     log(data);
//     setState(() {
//       productList1 = jsonDecode(data)["data"];
//     });
//     setState(() {});

//     print("object");
//     // print(leadArray);

//     // print("laedarray" + leadArray);

//     return null;
//   }

//   mobview(var lac, String name) async {
//     log("hbbb" + lac.toString());
//     //print(skey);

//     var l = [];
//     // List<String> customerList = ["KANHANGAD", "MANJESHWAR"];

//     var i;
//     var la = [];
//     for (i = 0; i < lac.length; i++) {
//       l.add({"name": lac[i]["name"]});
//       la.add(l[i]["name"]);
//     }
//     List<String> e = [
//       "",
//       "",
//     ];
//     // e = la;
//     log(la.toString() +
//         "gfdghfgfcgghghggjhjhjjjjhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
//     log(l.toString() + "nbnbbbbbbbbnbbnnbbbnbnbnnbbnbnbnbnnbnbnbnb");
//     print(l.toString() + "b bnbnbbnbnnm");

//     for (var i = 0; i < l.length; i++) {
//       var c = l[i]["name"];
//       e.add("$c,$c");
//     }
//     log(e.toString() +
//         "bvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvc");
//     // = l.toString();
//     log(name.toString());
//     http.Response response = await http.get(
//         Uri.parse(urlMain +
//             'api/resource/Lead?fields=["name","lead_name","date","source","mobile_no","email_id","lac"]&filters=[["mobile_no", "in", "$name"],["status", "=", "Hot"]]&limit=100000&order_by=creation%20desc'),
//         headers: {
//           'Content-type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': Tocken,
//         });
//     String data = response.body;
//     log("hiiiiiiiiiiiiiiiiiiiiiii");

//     log(data + "nvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv");
//     setState(() {
//       productList4 = jsonDecode(data)["data"];

//       for (var i = 0; i < productList4.length; i++) {
//         //  custDropDown.add(productList4[i]['name']);
//         custDropDow.add(productList4[i]['mobile_no']);
//         // offLineCustomersIdDropDown.add(offLineCustomers[i]['id'].toString());
//         // customerDetails.add({
//         //   "address": offLineCustomers[i]['address'],
//         //   "vat": offLineCustomers[i]['vatnum'],
//         //   "ob": offLineCustomers[i]['balance'].toString()
//         // });
//         //  array.add(i.toString());
//       }
//     });
//     // for (var i = 0; i < productList.length; i++) {
//     // //  ledgers.add({'name': productList[i]['data'], 'id': i});
//     //   searchResults.add({
//     //     "name": productList[i]['first_name'],
//     //   });
//     // }
//     //items.addAll(searchResults);

//     // print(leadArray);

//     // print("laedarray" + leadArray);

//     return null;
//   }

//   custmearea(var lac, String name) async {
//     log("hbbb" + lac.toString());
//     //print(skey);

//     var l = [];
//     // List<String> customerList = ["KANHANGAD", "MANJESHWAR"];

//     var i;
//     var la = [];
//     for (i = 0; i < lac.length; i++) {
//       l.add({"name": lac[i]["name"]});
//       la.add(l[i]["name"]);
//     }
//     List<String> e = [
//       "",
//       "",
//     ];
//     // e = la;
//     log(la.toString() +
//         "gfdghfgfcgghghggjhjhjjjjhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
//     log(l.toString() + "nbnbbbbbbbbnbbnnbbbnbnbnnbbnbnbnbnnbnbnbnb");
//     print(l.toString() + "b bnbnbbnbnnm");

//     for (var i = 0; i < l.length; i++) {
//       var c = l[i]["name"];
//       e.add("$c,$c");
//     }
//     log(e.toString() +
//         "bvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvc");
//     // = l.toString();
//     log(name.toString());
//     http.Response response = await http.get(
//         Uri.parse(urlMain +
//             'api/resource/Lead?fields=["name","lead_name","date","source","mobile_no","email_id","lac"]&filters=[["lac", "in", "$name"],["status", "=", "Hot"]]&limit=100000&order_by=creation%20desc'),
//         headers: {
//           'Content-type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': Tocken,
//         });
//     String data = response.body;
//     log("hiiiiiiiiiiiiiiiiiiiiiii");

//     log(data + "nvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv");
//     setState(() {
//       productList5 = jsonDecode(data)["data"];

//       for (var i = 0; i < productList4.length; i++) {
//         //  custDropDown.add(productList4[i]['name']);
//         custDropDo.add(productList4[i]['lac']);
//         // offLineCustomersIdDropDown.add(offLineCustomers[i]['id'].toString());
//         // customerDetails.add({
//         //   "address": offLineCustomers[i]['address'],
//         //   "vat": offLineCustomers[i]['vatnum'],
//         //   "ob": offLineCustomers[i]['balance'].toString()
//         // });
//         //  array.add(i.toString());
//       }
//     });
//     // for (var i = 0; i < productList.length; i++) {
//     // //  ledgers.add({'name': productList[i]['data'], 'id': i});
//     //   searchResults.add({
//     //     "name": productList[i]['first_name'],
//     //   });
//     // }
//     //items.addAll(searchResults);

//     // print(leadArray);

//     // print("laedarray" + leadArray);

//     return null;
//   }

//   custview(var lac, String name) async {
//     log("hbbb" + lac.toString());
//     //print(skey);

//     var l = [];
//     // List<String> customerList = ["KANHANGAD", "MANJESHWAR"];

//     var i;
//     var la = [];
//     for (i = 0; i < lac.length; i++) {
//       l.add({"name": lac[i]["name"]});
//       la.add(l[i]["name"]);
//     }
//     List<String> e = [
//       "",
//       "",
//     ];
//     // e = la;
//     log(la.toString() +
//         "gfdghfgfcgghghggjhjhjjjjhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
//     log(l.toString() + "nbnbbbbbbbbnbbnnbbbnbnbnnbbnbnbnbnnbnbnbnb");
//     print(l.toString() + "b bnbnbbnbnnm");

//     for (var i = 0; i < l.length; i++) {
//       var c = l[i]["name"];
//       e.add("$c,$c");
//     }
//     log(e.toString() +
//         "bvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvc");
//     // = l.toString();
//     log(name.toString());
//     http.Response response = await http.get(
//         Uri.parse(urlMain +
//             'api/resource/Lead?fields=["name","lead_name","date","source","mobile_no","email_id","lac"]&filters=[["lead_name", "in", "$name"],["status", "=", "Hot"]]&limit=100000&order_by=creation%20desc'),
//         headers: {
//           'Content-type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': Tocken,
//         });
//     String data = response.body;
//     log("hiiiiiiiiiiiiiiiiiiiiiii");

//     log(data + "nvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv");
//     setState(() {
//       productList3 = jsonDecode(data)["data"];

//       for (var i = 0; i < productList3.length; i++) {
//         custDropDown.add(productList3[i]['name']);
//         custDropDow.add(productList3[i]['mobile_no']);
//         // offLineCustomersIdDropDown.add(offLineCustomers[i]['id'].toString());
//         // customerDetails.add({
//         //   "address": offLineCustomers[i]['address'],
//         //   "vat": offLineCustomers[i]['vatnum'],
//         //   "ob": offLineCustomers[i]['balance'].toString()
//         // });
//         //  array.add(i.toString());
//       }
//     });
//     // for (var i = 0; i < productList.length; i++) {
//     // //  ledgers.add({'name': productList[i]['data'], 'id': i});
//     //   searchResults.add({
//     //     "name": productList[i]['first_name'],
//     //   });
//     // }
//     //items.addAll(searchResults);

//     // print(leadArray);

//     // print("laedarray" + leadArray);

//     return null;
//   }

//   // https://lamit.erpeaz.com/api/resource/Lead?fields=["name","lead_name","date","source","mobile_no","email_id","lac"]&filters=[["sale_area", "in",["AZHIKODE"]],["date","=","2022-12-16"]]&limit=100000,
// }

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

class HotleadView extends StatefulWidget {
  const HotleadView({super.key});

  @override
  State<HotleadView> createState() => _HotleadViewState();
}

class _HotleadViewState extends State<HotleadView> {
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
    fetchLacs();
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
              title: 'HOT LEADS',
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
                    popupShape: BeveledRectangleBorder(),
                    // popupProps: PopupProps.dialog(),
                    items: (selectedKey == 'name')
                        ? nameList
                        : (selectedKey == 'lac')
                            ? areaList
                            : (selectedKey == 'mobile')
                                ? mobileList
                                :(selectedKey == 'stage')?globals.stageList:globals.statusList,
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
                      if (snapshot.hasData || areaList.length == 0) {
                        if (snapshot.data.length == 0) {
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
                        } else {
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
                                        1,
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
      api = 'api/resource/Lead?fields=["*"]&filters=[["stage", "=", "Hot"],["sale_area", "in", $lac]]&limit=1000000&order_by=creation%20desc';
      // api =
      //     'api/resource/Lead?fields=["mobile_no","name","lead_name","status","lac","source","lead_category","date","whatsapp_no","longitude","latitude","expected_time_to_purchas","email","stage"]&filters=[["stage", "=", "Hot"],["sale_area", "in",$lac]]&limit=1000000&order_by=creation%20desc';
    } else {
      if (selectedKey == 'name') {
       
        api =
            'api/resource/Lead?fields=["mobile_no","name","lead_name","status","lac","source","lead_category","date","whatsapp_no","longitude","latitude","expected_time_to_purchas","email","stage"]&filters=[["lead_name", "=", "$searchText"],["stage", "=", "Hot"],["lac","in",$lac]]&limit=1000000&order_by=creation%20desc';
      } else if (selectedKey == 'lac') {
        api = 'api/resource/Lead?fields=["mobile_no","name","lead_name","status","lac","source","lead_category","date","whatsapp_no","longitude","latitude","expected_time_to_purchas","email","stage"]&filters=[["stage", "=", "Hot"],["lac", "in", ["$searchText"]]]&limit=1000000&order_by=creation%20desc';
        // api =
        //     'api/resource/Lead?fields=["mobile_no","name","lead_name","status","lac","source","lead_category","date","whatsapp_no","longitude","latitude","expected_time_to_purchas","email","stage"]&filters=[["lac", "=", "$searchText"],["stage", "=", "Hot"],["lac","in",$lac]]&limit=1000000&order_by=creation%20desc';
      } else if (selectedKey == 'mobile') {api ='api/resource/Lead?fields=["mobile_no","name","lead_name","status","lac","source","lead_category","date","whatsapp_no","longitude","latitude","expected_time_to_purchas","email","stage"]&filters=[["mobile_no", "=", "$searchText"],["stage", "=", "Hot"],["lac", "in",$lac]]&limit=1000000&order_by=creation%20desc';
        // api =
        //     'api/resource/Lead?fields=["mobile_no","name","lead_name","status","lac","source","lead_category","date","whatsapp_no","longitude","latitude","expected_time_to_purchas","email","stage"]&filters=[["mobile_no", "=", "$searchText"],["stage", "=", "Hot"],["lac","in",$lac]]&limit=1000000&order_by=creation%20desc';
      } else if (selectedKey == 'status') {
        api =
            'api/resource/Lead?fields=["mobile_no","name","lead_name","status","lac","source","lead_category","date","whatsapp_no","longitude","latitude","expected_time_to_purchas","email","stage"]&filters=[["status", "=", "$searchText"],["stage", "=", "Hot"],["lac","in",$lac]]&limit=1000000&order_by=creation%20desc';
      } else if(selectedKey == 'stage'){
        api = 'api/resource/Lead?fields=["mobile_no","name","lead_name","status","lac","source","lead_category","date","whatsapp_no","longitude","latitude","expected_time_to_purchas","email","stage"]&filters=[["stage", "=", "$searchText"],["stage", "=", "Hot"],["lac","in",$lac]]&limit=1000000&order_by=creation%20desc';
      }else{
        api =
            'api/resource/Lead?fields=["mobile_no","name","lead_name","status","lac","source","lead_category","date","whatsapp_no","longitude","latitude","expected_time_to_purchas","email","stage"]&filters=[["date", "=", "$searchText"],["stage", "=", "Hot"],["lac","in",$lac]]&limit=1000000&order_by=creation%20desc';
      }
    }
log(api+'===');
    // var baseUrl = urlMain +
    //     'api/resource/Lead?fields=["mobile_no","name","lead_name","status","lac","source","lead_category","date"]&filters=[["lead_name", "in", "add das"]]&limit=1000000';
    var baseUrl = urlMain + api;

    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    });
    
    if (response.statusCode == 200) {
      print(response.body);
      String response1 = response.body;
      var data = jsonDecode(response1)["data"];
      if (nameList.length < 1) {
        for (int i = 0; i < data.length; i++) {
          var mobile = data[i]["mobile_no"];
          var name = data[i]["lead_name"];
          nameList.add('$name ($mobile)');
        }
        print(nameList);
      }
      if (mobileList.length < 1) {
        for (int i = 0; i < data.length; i++) {
          mobileList.add(data[i]["mobile_no"]);
        }
        print(mobileList);
      }
    } else {
      log(response.body);
    }

    return jsonDecode(response.body)["data"];
  }

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
       if(areaList.isEmpty){
         for (int i = 0; i < lacList.length; i++) {
          areaList.add(lacList[i]["name"]);
        }
       }
        print(areaList.toString() + 'looo');
      });
      fetchLeads(areaList);
      // custmearea(jsonDecode(data)["data"], cust);
      // log(jsonData.toString());
      // setState(() {});
    }
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
