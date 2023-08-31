// import 'dart:convert';
// import 'dart:developer';

// import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
// import 'package:fancy_containers/fancy_containers.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:intl/intl.dart';
// import 'package:lamit/app/modules/home/views/home_view.dart';

// import 'package:lamit/app/modules/lead/controllers/lead_controller.dart';
// import 'package:lamit/app/modules/leaddetails/views/leaddetails_view.dart';
// import 'package:lamit/app/routes/constants.dart';
// import 'package:lamit/tocken/config/url.dart';
// import 'package:lamit/tocken/tockn.dart';
// import 'package:lamit/widget/customeappbar.dart';
// import 'package:maps_launcher/maps_launcher.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';

// import 'lead-view-new.dart';

// class LeadView extends StatefulWidget {
//   final String restorationId = "";
//   @override
//   State<LeadView> createState() => _LeadViewState();
// }

// class _LeadViewState extends State<LeadView> with RestorationMixin {
//   String? get restorationId => widget.restorationId;
//   // final List<Widget> _children = [
//   //   // DashView(),
//   //   LeadView(),
//   //   LeadView(),
//   //   //ToolsView(),
//   // ];
//   String? filter;
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
//   String? em;
//   String? userId;
//   bool _canPop = false;
//   String? ceatd;
//   String? named;
//   String? mobiled;
//   String lls = "";
//   //StringproductList;
//   LeadController controller = Get.put(LeadController(""));
//   String? a;
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
//     log(a.toString() + "aaaaaaaaaaaaaaaaaaaaaaaaaaa");
//     // setState(() {
//     //   akey;
//     //   skey;
//     // });

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
//             title: 'LEAD LIST',
//             actions: [
//               IconButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => LeadListView()));
//                   },
//                   icon: Icon(Icons.new_label))
//             ],
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
//                           // lls != "true"
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
//                                                   setState(() {
//                                                     // lshow =
//                                                     //     "show";
//                                                     cusdropdownvalue = null;
//                                                     cusdropdownvalue =
//                                                         value["lead_name"]
//                                                             .toString();
//                                                     getlac2(cusdropdownvalue);

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
//                                                   getlac();
//                                                   setState(() {});
//                                                 },
//                                                 dropDownMenuItems:
//                                                     custDropDown == []
//                                                         ? ['']
//                                                         : custDropDown),
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
//                                                   setState(() {
//                                                     // lshow =
//                                                     //     "show";
//                                                     cusdropdownvalu = null;
//                                                     cusdropdownvalu =
//                                                         value["mobile_no"]
//                                                             .toString();
//                                                     getlac3(cusdropdownvalu);

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
//                                                   getlac();
//                                                   setState(() {});
//                                                 },
//                                                 dropDownMenuItems:
//                                                     custDropDow == []
//                                                         ? ['']
//                                                         : custDropDow),
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
//                                                   setState(() {
//                                                     // lshow =
//                                                     //     "show";
//                                                     cusdropdownval = null;
//                                                     cusdropdownval =
//                                                         value["lac"].toString();
//                                                     getlac4(cusdropdownval);

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
//                                                   getlac();
//                                                   setState(() {});
//                                                 },
//                                                 dropDownMenuItems:
//                                                     custDropDo == []
//                                                         ? ['']
//                                                         : custDropDo),
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
//                                                                                                                   height: 30,
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
//             'api/resource/Lead?filters=[["lac", "in", "$e"]]&fields=["*"]&limit=100000&order_by=creation%20desc'),
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
//             'api/resource/Lead?fields=["name","lead_name","date","source","mobile_no","email_id","lac"]&filters=[["lac", "in", "$e"],["date","=","$v"]]&limit=100000&order_by=creation%20desc'),
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
//             'api/resource/Lead?fields=["name","lead_name","date","source","mobile_no","email_id","lac"]&filters=[["lac", "in", "$e"],["mobile_no","=","$name"]]&limit=100000&order_by=creation%20desc'),
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
//             'api/resource/Lead?fields=["name","lead_name","date","source","mobile_no","email_id","lac"]&filters=[["lac", "in", "$e"],["lac","=","$name"]]&limit=100000&order_by=creation%20desc'),
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
//             'api/resource/Lead?fields=["name","lead_name","date","source","mobile_no","email_id","lac"]&filters=[["lac", "in", "$e"],["lead_name","=","$name"]]&limit=100000&order_by=creation%20desc'),
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
