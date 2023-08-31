import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:lamit/app/modules/addbaisicdetail/controllers/addbaisicdetail_controller.dart';
import 'package:lamit/app/routes/constants.dart';
import 'package:lamit/widget/customeappbar.dart';

class AddbaisicdetailView extends StatefulWidget {
  final String? status1;
  final String? status;
  final String? leadtok;
  final String? baisicsocialgroup;
  final String? bisicmaterial;
  final String? graduate;
  final String? nofkids;
  final String? companyname;
  final String? Designation;
  final String? mname;
  final String? education;
  final String? gender;
  final String? relation;
  final String? dateofbirth;
  final String? maritalstatus2;
  final String? age;
  final int idx;
  final String? occupation;
  final String? rowid;

  const AddbaisicdetailView(
      this.status1,
      this.status,
      this.leadtok,
      this.baisicsocialgroup,
      this.bisicmaterial,
      this.graduate,
      this.nofkids,
      this.companyname,
      this.Designation,
      this.mname,
      this.education,
      this.gender,
      this.relation,
      this.dateofbirth,
      this.maritalstatus2,
      this.age,
      this.idx,
      this.occupation,
      this.rowid);

  @override
  State<AddbaisicdetailView> createState() => _AddbaisicdetailViewState();
}

class _AddbaisicdetailViewState extends State<AddbaisicdetailView> {
  // Initial Selected Value
  // String dropdownvalue = 'Middle';
  // String dropdownvalue = 'middle';
  String? a;
  String? socialdropdownvalue;
  String? educationdropdownvalue;
  String? educationdropdownvalue2;
  String? matrialdropdownvalue;
  String? matrialdropdownvalue2;
  TextEditingController textEditingController = new TextEditingController();

  String? genderdropdownvalue;
  TextEditingController dateinput = new TextEditingController();
  TextEditingController? noOf;
  TextEditingController? companyname;
  TextEditingController? designation;
  TextEditingController? nameController;
  TextEditingController? age;
  TextEditingController? designation2;

  // List of items in our dropdown menu

  String? relationshipdropdownvalue;
  var genderItem = ["Male", "Female"];
  var relationitems = [
    'Father',
    "Mother",
    "Grand Mother",
    'Husband',
    'Wife',
    'High',
    'Son',
    'Daughter',
    'Grand Father',
    'Brother',
    'Sister',
    'Other',
  ];
  var gendertems = [
    'Male',
    'Female',
  ];
  var sociaitems = [
    'Upper Class',
    'Middle Class',
    'Below Class',
  ];
  var edusociaitems = [
    'Graduate',
    'Post Graduate',
    'Under Graduate',
  ];
  var edusociaitems2 = [
    'Graduate',
    'Post Graduate',
    'Under Graduate',
  ];
  var matriaitems = ['Married', 'Single', 'Divorced', 'Widowed'];
  var matriaitems2 = ['Married', 'Single', 'Divorced', 'Widowed'];

  @override
  void initState() {
    log(widget.education.toString() + "nnnnnnnnnn");
    log(widget.status.toString());
    log(widget.baisicsocialgroup.toString() + "hlooo");
    dateinput.text = ""; //se
    a = "";
    noOf = new TextEditingController(text: widget.nofkids);
    designation = new TextEditingController(text: widget.Designation);
    designation2 = new TextEditingController(text: widget.Designation);
    companyname = new TextEditingController(text: widget.companyname);
    age = new TextEditingController(text: widget.age);
    nameController = new TextEditingController(text: widget.mname);
    dateinput = new TextEditingController(text: widget.dateofbirth);

    if (widget.status == "add") {
      socialdropdownvalue = widget.baisicsocialgroup == "----Select----"
          ? null
          : widget.baisicsocialgroup;
      educationdropdownvalue =
          widget.graduate == "----Select----" ? null : widget.graduate;
      matrialdropdownvalue = widget.bisicmaterial == "----Select----"
          ? null
          : widget.bisicmaterial;
    }
    if (widget.status == "member") {
      educationdropdownvalue2 = widget.education;
      matrialdropdownvalue2 = widget.maritalstatus2;
      genderdropdownvalue = widget.gender;
      relationshipdropdownvalue = widget.relation;
    }
    if (widget.status == "memb") {
      educationdropdownvalue2 =
          widget.education == "----Select----" ? null : widget.education;
      matrialdropdownvalue2 = widget.maritalstatus2 == "----Select----"
          ? null
          : widget.maritalstatus2;
      genderdropdownvalue = widget.gender == "" ? null : widget.gender;
      relationshipdropdownvalue =
          widget.relation == "----Select----" ? null : widget.relation;
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#F9F9F9"),
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize:
              Size(MediaQuery.of(context).size.width, kToolbarHeight),
          child: CustomAppBar(
            title: widget.status == "mem"
                ? "ADD MEMBER DETAILS"
                : "ADD BASIC UPDATES",
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(16.0),
                    //   child: Row(
                    //     children: [
                    //       GestureDetector(
                    //           onTap: () {
                    //             Get.back();
                    //           },
                    //           child: Container(
                    //               height: 30, child: Icon(Icons.arrow_back))),
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Text(
                    //           widget.status == "mem"
                    //               ? "ADD MEMBER DETAILS"
                    //               : "ADD BASIC UPDATES",
                    //           style: TextStyle(
                    //               color: Color.fromARGB(255, 4, 46, 80),
                    //               fontSize: 14,
                    //               fontWeight: FontWeight.bold),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),

                    widget.status == "add"
                        ? Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                                child: Container(
                                    //   width: Constants(context).scrnWidth,
                                    color: HexColor("#F9F9F9"),
                                    height: Constants(context).scrnHeight,
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      child: Container(
                                                        color: Colors.grey[100],
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16.0),
                                                          child: Container(
                                                            child:
                                                                DropdownButtonHideUnderline(
                                                              child:
                                                                  DropdownButton2(
                                                                isExpanded:
                                                                    true,
                                                                hint: Text(
                                                                  'Social Group',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .hintColor,
                                                                  ),
                                                                ),
                                                                items: sociaitems
                                                                    .map((item) => DropdownMenuItem<String>(
                                                                          value:
                                                                              item,
                                                                          child:
                                                                              Text(
                                                                            item,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontSize: 14,
                                                                            ),
                                                                          ),
                                                                        ))
                                                                    .toList(),
                                                                value:
                                                                    socialdropdownvalue,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    socialdropdownvalue =
                                                                        value
                                                                            as String;
                                                                  });
                                                                },
                                                                searchInnerWidgetHeight:
                                                                    20,
                                                                buttonHeight:
                                                                    20,
                                                                buttonWidth:
                                                                    100,
                                                                itemHeight: 40,

                                                                dropdownMaxHeight:
                                                                    200,

                                                                searchController:
                                                                    textEditingController,
                                                                searchInnerWidget:
                                                                    Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                    top: 8,
                                                                    bottom: 4,
                                                                    right: 8,
                                                                    left: 8,
                                                                  ),
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        textEditingController,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      isDense:
                                                                          true,
                                                                      contentPadding:
                                                                          const EdgeInsets
                                                                              .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            8,
                                                                      ),
                                                                      hintText:
                                                                          'Search for an item...',
                                                                      hintStyle:
                                                                          const TextStyle(
                                                                              fontSize: 12),
                                                                      border:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                searchMatchFn:
                                                                    (item,
                                                                        searchValue) {
                                                                  return (item
                                                                      .value
                                                                      .toString()
                                                                      .toLowerCase()
                                                                      .contains(
                                                                          searchValue
                                                                              .toLowerCase()));
                                                                },
                                                                //This to clear the search value when you close the menu
                                                                onMenuStateChange:
                                                                    (isOpen) {
                                                                  if (!isOpen) {
                                                                    textEditingController
                                                                        .clear();
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                    // Padding(
                                                    //   padding: const EdgeInsets.all(8.0),
                                                    //   child: Padding(
                                                    //     padding: const EdgeInsets.all(8.0),
                                                    //     child: Container(
                                                    //       child: Column(
                                                    //         crossAxisAlignment: CrossAxisAlignment.start,
                                                    //         children: [
                                                    //           Padding(
                                                    //             padding: const EdgeInsets.only(
                                                    //                 right: 8, left: 6),
                                                    //             child: Container(
                                                    //               decoration: BoxDecoration(
                                                    //                 color: Colors.grey[100],
                                                    //                 // border: Border.all(
                                                    //                 //     color: Colors.grey, // Set border color
                                                    //                 //     width: 1.0),
                                                    //                 //   color: HexColor("#F9F9F9"),
                                                    //                 borderRadius:
                                                    //                     BorderRadius.circular(5),
                                                    //               ),
                                                    //               height: 40,
                                                    //               // width: 200,
                                                    //               child: SingleChildScrollView(
                                                    //                 child: Container(
                                                    //                   child: DropdownButton(
                                                    //                     menuMaxHeight: 200,
                                                    //                     // hint: "Reference",
                                                    //                     hint: Padding(
                                                    //                       padding:
                                                    //                           const EdgeInsets.all(8.0),
                                                    //                       child: Text("Meridiem"),
                                                    //                     ),
                                                    //                     underline: Container(),
                                                    //                     // Initial Value
                                                    //                     value: perdium,

                                                    //                     // Down Arrow Icon
                                                    //                     // icon: const Icon(
                                                    //                     //     Icons.keyboard_arrow_down),

                                                    //                     // Array list of items
                                                    //                     items:
                                                    //                         refitems.map((String items) {
                                                    //                       return DropdownMenuItem(
                                                    //                         value: items,
                                                    //                         child: Row(
                                                    //                           children: [
                                                    //                             Row(
                                                    //                               children: [
                                                    //                                 Padding(
                                                    //                                   padding:
                                                    //                                       const EdgeInsets
                                                    //                                           .all(8.0),
                                                    //                                   child: Container(
                                                    //                                       child: Text(
                                                    //                                           items)),
                                                    //                                 ),
                                                    //                               ],
                                                    //                             ),
                                                    //                             Container()
                                                    //                           ],
                                                    //                         ),
                                                    //                       );
                                                    //                     }).toList(),
                                                    //                     // After selecting the desired option,it will
                                                    //                     // change button value to selected value
                                                    //                     onChanged: (String? newValue) {
                                                    //                       setState(() {
                                                    //                         perdium = newValue!;
                                                    //                       });
                                                    //                     },
                                                    //                   ),
                                                    //                 ),
                                                    //               ),
                                                    //             ),
                                                    //           ),
                                                    //         ],
                                                    //       ),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          // Container(
                                          //   color: Colors.grey[50],
                                          //   height: 50,
                                          //   width: Constants(context).scrnWidth,
                                          //   child: DropdownButton(
                                          //     hint: Padding(
                                          //       padding:
                                          //           const EdgeInsets.all(8.0),
                                          //       child: Text("Social group"),
                                          //     ),
                                          //     underline: Container(),
                                          //     // Initial Value
                                          //     value: socialdropdownvalue,

                                          //     // Down Arrow Icon
                                          //     icon: const Icon(
                                          //         Icons.keyboard_arrow_down),

                                          //     // Array list of items
                                          //     items: sociaitems
                                          //         .map((String items) {
                                          //       return DropdownMenuItem(
                                          //         value: items,
                                          //         child: Row(
                                          //           children: [
                                          //             Padding(
                                          //               padding:
                                          //                   const EdgeInsets
                                          //                       .all(16.0),
                                          //               child: Text(items),
                                          //             ),
                                          //             Container(
                                          //               width:
                                          //                   Constants(context)
                                          //                           .scrnWidth *
                                          //                       0.40,
                                          //             )
                                          //           ],
                                          //         ),
                                          //       );
                                          //     }).toList(),
                                          //     // After selecting the desired option,it will
                                          //     // change button value to selected value
                                          //     onChanged: (String? newValue) {
                                          //       setState(() {
                                          //         socialdropdownvalue =
                                          //             newValue!;
                                          //       });
                                          //     },
                                          //   ),
                                          // ),

                                          SizedBox(
                                            height: 8,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      child: Container(
                                                        color: Colors.grey[100],
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16.0),
                                                          child: Container(
                                                            child:
                                                                DropdownButtonHideUnderline(
                                                              child:
                                                                  DropdownButton2(
                                                                isExpanded:
                                                                    true,
                                                                hint: Text(
                                                                  'Education',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .hintColor,
                                                                  ),
                                                                ),
                                                                items:
                                                                    edusociaitems
                                                                        .map((item) =>
                                                                            DropdownMenuItem<String>(
                                                                              value: item,
                                                                              child: Text(
                                                                                item,
                                                                                style: const TextStyle(
                                                                                  fontSize: 14,
                                                                                ),
                                                                              ),
                                                                            ))
                                                                        .toList(),
                                                                value:
                                                                    educationdropdownvalue,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    educationdropdownvalue =
                                                                        value
                                                                            as String;
                                                                  });
                                                                },
                                                                searchInnerWidgetHeight:
                                                                    20,
                                                                buttonHeight:
                                                                    20,
                                                                buttonWidth:
                                                                    100,
                                                                itemHeight: 40,

                                                                dropdownMaxHeight:
                                                                    200,

                                                                searchController:
                                                                    textEditingController,
                                                                searchInnerWidget:
                                                                    Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                    top: 8,
                                                                    bottom: 4,
                                                                    right: 8,
                                                                    left: 8,
                                                                  ),
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        textEditingController,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      isDense:
                                                                          true,
                                                                      contentPadding:
                                                                          const EdgeInsets
                                                                              .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            8,
                                                                      ),
                                                                      hintText:
                                                                          'Search for an item...',
                                                                      hintStyle:
                                                                          const TextStyle(
                                                                              fontSize: 12),
                                                                      border:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                searchMatchFn:
                                                                    (item,
                                                                        searchValue) {
                                                                  return (item
                                                                      .value
                                                                      .toString()
                                                                      .toLowerCase()
                                                                      .contains(
                                                                          searchValue
                                                                              .toLowerCase()));
                                                                },
                                                                //This to clear the search value when you close the menu
                                                                onMenuStateChange:
                                                                    (isOpen) {
                                                                  if (!isOpen) {
                                                                    textEditingController
                                                                        .clear();
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                    // Padding(
                                                    //   padding: const EdgeInsets.all(8.0),
                                                    //   child: Padding(
                                                    //     padding: const EdgeInsets.all(8.0),
                                                    //     child: Container(
                                                    //       child: Column(
                                                    //         crossAxisAlignment: CrossAxisAlignment.start,
                                                    //         children: [
                                                    //           Padding(
                                                    //             padding: const EdgeInsets.only(
                                                    //                 right: 8, left: 6),
                                                    //             child: Container(
                                                    //               decoration: BoxDecoration(
                                                    //                 color: Colors.grey[100],
                                                    //                 // border: Border.all(
                                                    //                 //     color: Colors.grey, // Set border color
                                                    //                 //     width: 1.0),
                                                    //                 //   color: HexColor("#F9F9F9"),
                                                    //                 borderRadius:
                                                    //                     BorderRadius.circular(5),
                                                    //               ),
                                                    //               height: 40,
                                                    //               // width: 200,
                                                    //               child: SingleChildScrollView(
                                                    //                 child: Container(
                                                    //                   child: DropdownButton(
                                                    //                     menuMaxHeight: 200,
                                                    //                     // hint: "Reference",
                                                    //                     hint: Padding(
                                                    //                       padding:
                                                    //                           const EdgeInsets.all(8.0),
                                                    //                       child: Text("Meridiem"),
                                                    //                     ),
                                                    //                     underline: Container(),
                                                    //                     // Initial Value
                                                    //                     value: perdium,

                                                    //                     // Down Arrow Icon
                                                    //                     // icon: const Icon(
                                                    //                     //     Icons.keyboard_arrow_down),

                                                    //                     // Array list of items
                                                    //                     items:
                                                    //                         refitems.map((String items) {
                                                    //                       return DropdownMenuItem(
                                                    //                         value: items,
                                                    //                         child: Row(
                                                    //                           children: [
                                                    //                             Row(
                                                    //                               children: [
                                                    //                                 Padding(
                                                    //                                   padding:
                                                    //                                       const EdgeInsets
                                                    //                                           .all(8.0),
                                                    //                                   child: Container(
                                                    //                                       child: Text(
                                                    //                                           items)),
                                                    //                                 ),
                                                    //                               ],
                                                    //                             ),
                                                    //                             Container()
                                                    //                           ],
                                                    //                         ),
                                                    //                       );
                                                    //                     }).toList(),
                                                    //                     // After selecting the desired option,it will
                                                    //                     // change button value to selected value
                                                    //                     onChanged: (String? newValue) {
                                                    //                       setState(() {
                                                    //                         perdium = newValue!;
                                                    //                       });
                                                    //                     },
                                                    //                   ),
                                                    //                 ),
                                                    //               ),
                                                    //             ),
                                                    //           ),
                                                    //         ],
                                                    //       ),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          // Container(
                                          //   color: Colors.grey[50],
                                          //   height: 50,
                                          //   width: Constants(context).scrnWidth,
                                          //   child: DropdownButton(
                                          //     hint: Padding(
                                          //       padding:
                                          //           const EdgeInsets.all(8.0),
                                          //       child: Padding(
                                          //         padding:
                                          //             const EdgeInsets.all(8.0),
                                          //         child: Text("Education"),
                                          //       ),
                                          //     ),
                                          //     underline: Container(),
                                          //     // Initial Value
                                          //     value: educationdropdownvalue,

                                          //     // Down Arrow Icon
                                          //     icon: const Icon(
                                          //         Icons.keyboard_arrow_down),

                                          //     // Array list of items
                                          //     items: edusociaitems
                                          //         .map((String items) {
                                          //       return DropdownMenuItem(
                                          //         value: items,
                                          //         child: Row(
                                          //           children: [
                                          //             Padding(
                                          //               padding:
                                          //                   const EdgeInsets
                                          //                       .all(16.0),
                                          //               child: Text(items),
                                          //             ),
                                          //             Container(
                                          //               width:
                                          //                   Constants(context)
                                          //                           .scrnWidth *
                                          //                       0.34,
                                          //             )
                                          //           ],
                                          //         ),
                                          //       );
                                          //     }).toList(),
                                          //     // After selecting the desired option,it will
                                          //     // change button value to selected value
                                          //     onChanged: (String? newValue) {
                                          //       setState(() {
                                          //         educationdropdownvalue =
                                          //             newValue!;
                                          //       });
                                          //     },
                                          //   ),
                                          // ),

                                          SizedBox(
                                            height: 8,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      child: Container(
                                                        color: Colors.grey[100],
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16.0),
                                                          child: Container(
                                                            child:
                                                                DropdownButtonHideUnderline(
                                                              child:
                                                                  DropdownButton2(
                                                                isExpanded:
                                                                    true,
                                                                hint: Text(
                                                                  'Maritial Status',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .hintColor,
                                                                  ),
                                                                ),
                                                                items:
                                                                    matriaitems
                                                                        .map((item) =>
                                                                            DropdownMenuItem<String>(
                                                                              value: item,
                                                                              child: Text(
                                                                                item,
                                                                                style: const TextStyle(
                                                                                  fontSize: 14,
                                                                                ),
                                                                              ),
                                                                            ))
                                                                        .toList(),
                                                                value:
                                                                    matrialdropdownvalue,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    matrialdropdownvalue =
                                                                        value
                                                                            as String;
                                                                  });
                                                                },
                                                                searchInnerWidgetHeight:
                                                                    20,
                                                                buttonHeight:
                                                                    20,
                                                                buttonWidth:
                                                                    100,
                                                                itemHeight: 40,

                                                                dropdownMaxHeight:
                                                                    200,

                                                                searchController:
                                                                    textEditingController,
                                                                searchInnerWidget:
                                                                    Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                    top: 8,
                                                                    bottom: 4,
                                                                    right: 8,
                                                                    left: 8,
                                                                  ),
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        textEditingController,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      isDense:
                                                                          true,
                                                                      contentPadding:
                                                                          const EdgeInsets
                                                                              .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            8,
                                                                      ),
                                                                      hintText:
                                                                          'Search for an item...',
                                                                      hintStyle:
                                                                          const TextStyle(
                                                                              fontSize: 12),
                                                                      border:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                searchMatchFn:
                                                                    (item,
                                                                        searchValue) {
                                                                  return (item
                                                                      .value
                                                                      .toString()
                                                                      .toLowerCase()
                                                                      .contains(
                                                                          searchValue
                                                                              .toLowerCase()));
                                                                },
                                                                //This to clear the search value when you close the menu
                                                                onMenuStateChange:
                                                                    (isOpen) {
                                                                  if (!isOpen) {
                                                                    textEditingController
                                                                        .clear();
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                    // Padding(
                                                    //   padding: const EdgeInsets.all(8.0),
                                                    //   child: Padding(
                                                    //     padding: const EdgeInsets.all(8.0),
                                                    //     child: Container(
                                                    //       child: Column(
                                                    //         crossAxisAlignment: CrossAxisAlignment.start,
                                                    //         children: [
                                                    //           Padding(
                                                    //             padding: const EdgeInsets.only(
                                                    //                 right: 8, left: 6),
                                                    //             child: Container(
                                                    //               decoration: BoxDecoration(
                                                    //                 color: Colors.grey[100],
                                                    //                 // border: Border.all(
                                                    //                 //     color: Colors.grey, // Set border color
                                                    //                 //     width: 1.0),
                                                    //                 //   color: HexColor("#F9F9F9"),
                                                    //                 borderRadius:
                                                    //                     BorderRadius.circular(5),
                                                    //               ),
                                                    //               height: 40,
                                                    //               // width: 200,
                                                    //               child: SingleChildScrollView(
                                                    //                 child: Container(
                                                    //                   child: DropdownButton(
                                                    //                     menuMaxHeight: 200,
                                                    //                     // hint: "Reference",
                                                    //                     hint: Padding(
                                                    //                       padding:
                                                    //                           const EdgeInsets.all(8.0),
                                                    //                       child: Text("Meridiem"),
                                                    //                     ),
                                                    //                     underline: Container(),
                                                    //                     // Initial Value
                                                    //                     value: perdium,

                                                    //                     // Down Arrow Icon
                                                    //                     // icon: const Icon(
                                                    //                     //     Icons.keyboard_arrow_down),

                                                    //                     // Array list of items
                                                    //                     items:
                                                    //                         refitems.map((String items) {
                                                    //                       return DropdownMenuItem(
                                                    //                         value: items,
                                                    //                         child: Row(
                                                    //                           children: [
                                                    //                             Row(
                                                    //                               children: [
                                                    //                                 Padding(
                                                    //                                   padding:
                                                    //                                       const EdgeInsets
                                                    //                                           .all(8.0),
                                                    //                                   child: Container(
                                                    //                                       child: Text(
                                                    //                                           items)),
                                                    //                                 ),
                                                    //                               ],
                                                    //                             ),
                                                    //                             Container()
                                                    //                           ],
                                                    //                         ),
                                                    //                       );
                                                    //                     }).toList(),
                                                    //                     // After selecting the desired option,it will
                                                    //                     // change button value to selected value
                                                    //                     onChanged: (String? newValue) {
                                                    //                       setState(() {
                                                    //                         perdium = newValue!;
                                                    //                       });
                                                    //                     },
                                                    //                   ),
                                                    //                 ),
                                                    //               ),
                                                    //             ),
                                                    //           ),
                                                    //         ],
                                                    //       ),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  // Container(
                                                  //   width: 10,
                                                  // ),
                                                  //  Expanded(child: Container()),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      color: Colors.grey[100],
                                                      height: 52,
                                                      child: Container(
                                                        color:
                                                            HexColor("#F9F9F9"),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                                width: Constants(
                                                                        context)
                                                                    .scrnWidth,
                                                                color: Colors
                                                                    .grey[100],
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          16.0),
                                                                  child:
                                                                      TextField(
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            13),
                                                                    decoration:
                                                                        InputDecoration(
                                                                      hintText:
                                                                          'No Of kids',
                                                                      hintStyle: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              13),
                                                                      border: InputBorder
                                                                          .none,
                                                                    ),
                                                                    controller:
                                                                        noOf,
                                                                  ),
                                                                )
                                                                //     DropdownButton(
                                                                //   hint: Text(
                                                                //       "select one"),
                                                                //   underline:
                                                                //       Container(),
                                                                //   // Initial Value
                                                                //   value:
                                                                //       dropdownvalue,

                                                                //   // Down Arrow Icon
                                                                //   icon: const Icon(
                                                                //     Icons
                                                                //         .keyboard_arrow_down,
                                                                //     // color: Colors.white,
                                                                //   ),

                                                                //   // Array list of items
                                                                //   items: items.map(
                                                                //       (String
                                                                //           items) {
                                                                //     return DropdownMenuItem(
                                                                //       value: items,
                                                                //       child:
                                                                //           Padding(
                                                                //         padding: const EdgeInsets
                                                                //                 .all(
                                                                //             16.0),
                                                                //         child: Text(
                                                                //             items),
                                                                //       ),
                                                                //     );
                                                                //   }).toList(),
                                                                //   // After selecting the desired option,it will
                                                                //   // change button value to selected value
                                                                //   onChanged: (String?
                                                                //       newValue) {
                                                                //     setState(() {
                                                                //       dropdownvalue =
                                                                //           newValue!;
                                                                //     });
                                                                //   },
                                                                // ),
                                                                ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.all(16.0),
                                          //   child: Text(
                                          //     "Employment Type",
                                          //     style: TextStyle(
                                          //         color: Colors.grey[900]),
                                          //   ),
                                          // ),
                                          // Container(
                                          //   color: Colors.white,
                                          //   height: 50,
                                          //   width: Constants(context).scrnWidth,
                                          //   child: DropdownButton(
                                          //     hint: Text("select one"),
                                          //     underline: Container(),
                                          //     // Initial Value
                                          //     value: dropdownvalue,

                                          //     // Down Arrow Icon
                                          //     icon: const Icon(
                                          //         Icons.keyboard_arrow_down),

                                          //     // Array list of items
                                          //     items: items.map((String items) {
                                          //       return DropdownMenuItem(
                                          //         value: items,
                                          //         child: Row(
                                          //           children: [
                                          //             Padding(
                                          //               padding:
                                          //                   const EdgeInsets.all(
                                          //                       16.0),
                                          //               child: Text(items),
                                          //             ),
                                          //             Container(
                                          //               width: Constants(context)
                                          //                       .scrnWidth *
                                          //                   0.60,
                                          //             )
                                          //           ],
                                          //         ),
                                          //       );
                                          //     }).toList(),
                                          //     // After selecting the desired option,it will
                                          //     // change button value to selected value
                                          //     onChanged: (String? newValue) {
                                          //       setState(() {
                                          //         dropdownvalue = newValue!;
                                          //       });
                                          //     },
                                          //   ),
                                          // ),
                                          // Padding(
                                          //   padding:
                                          //       const EdgeInsets.all(16.0),
                                          //   child: Text(
                                          //     "Company Name",
                                          //     style: TextStyle(
                                          //         color: Colors.grey[900]),
                                          //   ),
                                          // ),

                                          // Container(
                                          //     color: Colors.white,
                                          //     height: 50,
                                          //     width: Constants(context)
                                          //         .scrnWidth,
                                          //     child: Padding(
                                          //       padding:
                                          //           const EdgeInsets.all(8.0),
                                          //       child: TextField(
                                          //         controller: companyname,
                                          //       ),
                                          //     )),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                color: Colors.grey[100],
                                                height: 50,
                                                width: Constants(context)
                                                    .scrnWidth,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: TextField(
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                    decoration: InputDecoration(
                                                      hintText: 'Occupation',
                                                      hintStyle: TextStyle(
                                                          fontSize: 13),
                                                      border: InputBorder.none,
                                                    ),
                                                    controller: designation,
                                                  ),
                                                )),
                                          ),

                                          Container(
                                            width: Constants(context).scrnWidth,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                log("kk");
                                                if (widget.status == "add") {
                                                  // AddbaisicdetailController().addbaisicDetail(
                                                  //     widget.leadtok.toString(),
                                                  //     socialdropdownvalue == ""
                                                  //         ? ""
                                                  //         : socialdropdownvalue
                                                  //             .toString(),
                                                  //     matrialdropdownvalue == ""
                                                  //         ? ""
                                                  //         : matrialdropdownvalue
                                                  //             .toString(),
                                                  //     educationdropdownvalue ==
                                                  //             ""
                                                  //         ? ""
                                                  //         : educationdropdownvalue
                                                  //             .toString(),
                                                  //     noOf!.text,
                                                  //     companyname!.text,
                                                  //     designation!.text,
                                                  //     widget.leadtok
                                                  //         .toString());

                                                  AddbaisicdetailController().updatedd(
                                                      widget.status1.toString(),
                                                      nameController!.text ==
                                                              "----Select----"
                                                          ? ""
                                                          : nameController!.text
                                                              .toString(),
                                                      widget.leadtok.toString(),
                                                      socialdropdownvalue == ""
                                                          ? ""
                                                          : socialdropdownvalue
                                                              .toString(),
                                                      matrialdropdownvalue == ""
                                                          ? ""
                                                          : matrialdropdownvalue
                                                              .toString(),
                                                      educationdropdownvalue ==
                                                              ""
                                                          ? ""
                                                          : educationdropdownvalue
                                                              .toString(),
                                                      noOf!.text,
                                                      companyname!.text,
                                                      designation!.text,
                                                      widget.leadtok
                                                          .toString());
                                                }
                                                // else {
                                                //  // AddbaisicdetailController().updatedd(
                                                //       nameController!.text,
                                                //       widget.leadtok.toString(),
                                                //       socialdropdownvalue == ""
                                                //           ? ""
                                                //           : socialdropdownvalue
                                                //               .toString(),
                                                //       matrialdropdownvalue == ""
                                                //           ? ""
                                                //           : matrialdropdownvalue
                                                //               .toString(),
                                                //       educationdropdownvalue ==
                                                //               ""
                                                //           ? ""
                                                //           : educationdropdownvalue
                                                //               .toString(),
                                                //       noOf!.text,
                                                //       companyname!.text,
                                                //       designation!.text,
                                                //       widget.leadtok
                                                //           .toString());
                                                // }
                                                // Get.to(AddbaisicdetailView());

                                                setState(() {});
                                              },
                                              child: Text("Save"),
                                              style: ElevatedButton.styleFrom(
                                                primary: Color.fromARGB(255, 2,
                                                    45, 79), // background
                                                onPrimary: Colors
                                                    .grey[50], // foreground
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))))
                        : Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Container(
                                child: Card(
                                    color: Colors.grey[50],
                                    child: Container(
                                        //   width: Constants(context).scrnWidth,
                                        color: HexColor("#F9F9F9"),
                                        height: Constants(context).scrnHeight,
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 8,
                                              ),

                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                    color: Colors.grey[100],
                                                    height: 50,
                                                    width: Constants(context)
                                                        .scrnWidth,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 8.0,
                                                                left: 8),
                                                        child: TextField(
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                'Member Name',
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                          controller:
                                                              nameController,
                                                        ),
                                                      ),
                                                    )),
                                              ),

                                              // Container(
                                              //   color: Colors.grey[50],
                                              //   height: 50,
                                              //   width: Constants(context)
                                              //       .scrnWidth,
                                              //   child: DropdownButton(
                                              //     hint: Padding(
                                              //       padding:
                                              //           const EdgeInsets.all(
                                              //               8.0),
                                              //       child: Text("Education"),
                                              //     ),
                                              //     underline: Container(),
                                              //     // Initial Value
                                              //     value:
                                              //         educationdropdownvalue2,

                                              //     // Down Arrow Icon
                                              //     icon: const Icon(Icons
                                              //         .keyboard_arrow_down),

                                              //     // Array list of items
                                              //     items: edusociaitems2
                                              //         .map((String items) {
                                              //       return DropdownMenuItem(
                                              //         value: items,
                                              //         child: Row(
                                              //           children: [
                                              //             Padding(
                                              //               padding:
                                              //                   const EdgeInsets
                                              //                       .all(8.0),
                                              //               child: Text(items),
                                              //             ),
                                              //             Container(
                                              //               width: Constants(
                                              //                           context)
                                              //                       .scrnWidth *
                                              //                   0.35,
                                              //             )
                                              //           ],
                                              //         ),
                                              //       );
                                              //     }).toList(),
                                              //     // After selecting the desired option,it will
                                              //     // change button value to selected value
                                              //     onChanged:
                                              //         (String? newValue) {
                                              //       setState(() {
                                              //         educationdropdownvalue2 =
                                              //             newValue!;
                                              //       });
                                              //     },
                                              //   ),
                                              // ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                child: Container(
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          child: Container(
                                                            color: Colors
                                                                .grey[100],
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      16.0),
                                                              child: Container(
                                                                child:
                                                                    DropdownButtonHideUnderline(
                                                                  child:
                                                                      DropdownButton2(
                                                                    isExpanded:
                                                                        true,
                                                                    hint: Text(
                                                                      'Education',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Theme.of(context)
                                                                            .hintColor,
                                                                      ),
                                                                    ),
                                                                    items: edusociaitems2
                                                                        .map((item) => DropdownMenuItem<String>(
                                                                              value: item,
                                                                              child: Text(
                                                                                item,
                                                                                style: const TextStyle(
                                                                                  fontSize: 14,
                                                                                ),
                                                                              ),
                                                                            ))
                                                                        .toList(),
                                                                    value:
                                                                        educationdropdownvalue2,
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        educationdropdownvalue2 =
                                                                            value
                                                                                as String;
                                                                      });
                                                                    },
                                                                    searchInnerWidgetHeight:
                                                                        20,
                                                                    buttonHeight:
                                                                        20,
                                                                    buttonWidth:
                                                                        100,
                                                                    itemHeight:
                                                                        40,

                                                                    dropdownMaxHeight:
                                                                        200,

                                                                    searchController:
                                                                        textEditingController,
                                                                    searchInnerWidget:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                        top: 8,
                                                                        bottom:
                                                                            4,
                                                                        right:
                                                                            8,
                                                                        left: 8,
                                                                      ),
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            textEditingController,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          isDense:
                                                                              true,
                                                                          contentPadding:
                                                                              const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                10,
                                                                            vertical:
                                                                                8,
                                                                          ),
                                                                          hintText:
                                                                              'Search for an item...',
                                                                          hintStyle:
                                                                              const TextStyle(fontSize: 12),
                                                                          border:
                                                                              OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    searchMatchFn:
                                                                        (item,
                                                                            searchValue) {
                                                                      return (item
                                                                          .value
                                                                          .toString()
                                                                          .toLowerCase()
                                                                          .contains(
                                                                              searchValue.toLowerCase()));
                                                                    },
                                                                    //This to clear the search value when you close the menu
                                                                    onMenuStateChange:
                                                                        (isOpen) {
                                                                      if (!isOpen) {
                                                                        textEditingController
                                                                            .clear();
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        // Padding(
                                                        //   padding: const EdgeInsets.all(8.0),
                                                        //   child: Padding(
                                                        //     padding: const EdgeInsets.all(8.0),
                                                        //     child: Container(
                                                        //       child: Column(
                                                        //         crossAxisAlignment: CrossAxisAlignment.start,
                                                        //         children: [
                                                        //           Padding(
                                                        //             padding: const EdgeInsets.only(
                                                        //                 right: 8, left: 6),
                                                        //             child: Container(
                                                        //               decoration: BoxDecoration(
                                                        //                 color: Colors.grey[100],
                                                        //                 // border: Border.all(
                                                        //                 //     color: Colors.grey, // Set border color
                                                        //                 //     width: 1.0),
                                                        //                 //   color: HexColor("#F9F9F9"),
                                                        //                 borderRadius:
                                                        //                     BorderRadius.circular(5),
                                                        //               ),
                                                        //               height: 40,
                                                        //               // width: 200,
                                                        //               child: SingleChildScrollView(
                                                        //                 child: Container(
                                                        //                   child: DropdownButton(
                                                        //                     menuMaxHeight: 200,
                                                        //                     // hint: "Reference",
                                                        //                     hint: Padding(
                                                        //                       padding:
                                                        //                           const EdgeInsets.all(8.0),
                                                        //                       child: Text("Meridiem"),
                                                        //                     ),
                                                        //                     underline: Container(),
                                                        //                     // Initial Value
                                                        //                     value: perdium,

                                                        //                     // Down Arrow Icon
                                                        //                     // icon: const Icon(
                                                        //                     //     Icons.keyboard_arrow_down),

                                                        //                     // Array list of items
                                                        //                     items:
                                                        //                         refitems.map((String items) {
                                                        //                       return DropdownMenuItem(
                                                        //                         value: items,
                                                        //                         child: Row(
                                                        //                           children: [
                                                        //                             Row(
                                                        //                               children: [
                                                        //                                 Padding(
                                                        //                                   padding:
                                                        //                                       const EdgeInsets
                                                        //                                           .all(8.0),
                                                        //                                   child: Container(
                                                        //                                       child: Text(
                                                        //                                           items)),
                                                        //                                 ),
                                                        //                               ],
                                                        //                             ),
                                                        //                             Container()
                                                        //                           ],
                                                        //                         ),
                                                        //                       );
                                                        //                     }).toList(),
                                                        //                     // After selecting the desired option,it will
                                                        //                     // change button value to selected value
                                                        //                     onChanged: (String? newValue) {
                                                        //                       setState(() {
                                                        //                         perdium = newValue!;
                                                        //                       });
                                                        //                     },
                                                        //                   ),
                                                        //                 ),
                                                        //               ),
                                                        //             ),
                                                        //           ),
                                                        //         ],
                                                        //       ),
                                                        //     ),
                                                        //   ),
                                                        // ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          child: Container(
                                                            color: Colors
                                                                .grey[100],
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      16.0),
                                                              child: Container(
                                                                child:
                                                                    DropdownButtonHideUnderline(
                                                                  child:
                                                                      DropdownButton2(
                                                                    isExpanded:
                                                                        true,
                                                                    hint: Text(
                                                                      'Maritial Status',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Theme.of(context)
                                                                            .hintColor,
                                                                      ),
                                                                    ),
                                                                    items: matriaitems2
                                                                        .map((item) => DropdownMenuItem<String>(
                                                                              value: item,
                                                                              child: Text(
                                                                                item,
                                                                                style: const TextStyle(
                                                                                  fontSize: 14,
                                                                                ),
                                                                              ),
                                                                            ))
                                                                        .toList(),
                                                                    value:
                                                                        matrialdropdownvalue2,
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        matrialdropdownvalue2 =
                                                                            value
                                                                                as String;
                                                                      });
                                                                    },
                                                                    searchInnerWidgetHeight:
                                                                        20,
                                                                    buttonHeight:
                                                                        20,
                                                                    buttonWidth:
                                                                        100,
                                                                    itemHeight:
                                                                        40,

                                                                    dropdownMaxHeight:
                                                                        200,

                                                                    searchController:
                                                                        textEditingController,
                                                                    searchInnerWidget:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                        top: 8,
                                                                        bottom:
                                                                            4,
                                                                        right:
                                                                            8,
                                                                        left: 8,
                                                                      ),
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            textEditingController,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          isDense:
                                                                              true,
                                                                          contentPadding:
                                                                              const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                10,
                                                                            vertical:
                                                                                8,
                                                                          ),
                                                                          hintText:
                                                                              'Search for an item...',
                                                                          hintStyle:
                                                                              const TextStyle(fontSize: 12),
                                                                          border:
                                                                              OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    searchMatchFn:
                                                                        (item,
                                                                            searchValue) {
                                                                      return (item
                                                                          .value
                                                                          .toString()
                                                                          .toLowerCase()
                                                                          .contains(
                                                                              searchValue.toString()));
                                                                    },
                                                                    //This to clear the search value when you close the menu
                                                                    onMenuStateChange:
                                                                        (isOpen) {
                                                                      if (!isOpen) {
                                                                        textEditingController
                                                                            .clear();
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        // Padding(
                                                        //   padding: const EdgeInsets.all(8.0),
                                                        //   child: Padding(
                                                        //     padding: const EdgeInsets.all(8.0),
                                                        //     child: Container(
                                                        //       child: Column(
                                                        //         crossAxisAlignment: CrossAxisAlignment.start,
                                                        //         children: [
                                                        //           Padding(
                                                        //             padding: const EdgeInsets.only(
                                                        //                 right: 8, left: 6),
                                                        //             child: Container(
                                                        //               decoration: BoxDecoration(
                                                        //                 color: Colors.grey[100],
                                                        //                 // border: Border.all(
                                                        //                 //     color: Colors.grey, // Set border color
                                                        //                 //     width: 1.0),
                                                        //                 //   color: HexColor("#F9F9F9"),
                                                        //                 borderRadius:
                                                        //                     BorderRadius.circular(5),
                                                        //               ),
                                                        //               height: 40,
                                                        //               // width: 200,
                                                        //               child: SingleChildScrollView(
                                                        //                 child: Container(
                                                        //                   child: DropdownButton(
                                                        //                     menuMaxHeight: 200,
                                                        //                     // hint: "Reference",
                                                        //                     hint: Padding(
                                                        //                       padding:
                                                        //                           const EdgeInsets.all(8.0),
                                                        //                       child: Text("Meridiem"),
                                                        //                     ),
                                                        //                     underline: Container(),
                                                        //                     // Initial Value
                                                        //                     value: perdium,

                                                        //                     // Down Arrow Icon
                                                        //                     // icon: const Icon(
                                                        //                     //     Icons.keyboard_arrow_down),

                                                        //                     // Array list of items
                                                        //                     items:
                                                        //                         refitems.map((String items) {
                                                        //                       return DropdownMenuItem(
                                                        //                         value: items,
                                                        //                         child: Row(
                                                        //                           children: [
                                                        //                             Row(
                                                        //                               children: [
                                                        //                                 Padding(
                                                        //                                   padding:
                                                        //                                       const EdgeInsets
                                                        //                                           .all(8.0),
                                                        //                                   child: Container(
                                                        //                                       child: Text(
                                                        //                                           items)),
                                                        //                                 ),
                                                        //                               ],
                                                        //                             ),
                                                        //                             Container()
                                                        //                           ],
                                                        //                         ),
                                                        //                       );
                                                        //                     }).toList(),
                                                        //                     // After selecting the desired option,it will
                                                        //                     // change button value to selected value
                                                        //                     onChanged: (String? newValue) {
                                                        //                       setState(() {
                                                        //                         perdium = newValue!;
                                                        //                       });
                                                        //                     },
                                                        //                   ),
                                                        //                 ),
                                                        //               ),
                                                        //             ),
                                                        //           ),
                                                        //         ],
                                                        //       ),
                                                        //     ),
                                                        //   ),
                                                        // ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              // Padding(
                                              //   padding: const EdgeInsets.only(
                                              //       top: 8.0),
                                              //   child: Container(
                                              //     child: Row(
                                              //       children: [
                                              //         Expanded(
                                              //           flex: 2,
                                              //           child: Container(
                                              //             child: Container(
                                              //               color: HexColor(
                                              //                   "#F9F9F9"),
                                              //               child: Column(
                                              //                 crossAxisAlignment:
                                              //                     CrossAxisAlignment
                                              //                         .start,
                                              //                 children: [
                                              //                   Container(
                                              //                     width: Constants(
                                              //                             context)
                                              //                         .scrnWidth,
                                              //                     color: Colors
                                              //                         .grey[50],
                                              //                     child:
                                              //                         DropdownButton(
                                              //                       hint:
                                              //                           Padding(
                                              //                         padding:
                                              //                             const EdgeInsets.all(
                                              //                                 8.0),
                                              //                         child: Text(
                                              //                             "Maritial Status"),
                                              //                       ),
                                              //                       underline:
                                              //                           Container(),
                                              //                       // Initial Value
                                              //                       value:
                                              //                           matrialdropdownvalue2,

                                              //                       // Down Arrow Icon
                                              //                       icon: Row(
                                              //                         children: [
                                              //                           Container(
                                              //                             width:
                                              //                                 Constants(context).scrnWidth - 227,
                                              //                           ),
                                              //                           Icon(
                                              //                             Icons
                                              //                                 .keyboard_arrow_down,
                                              //                             // color: Colors.white,
                                              //                           ),
                                              //                         ],
                                              //                       ),

                                              //                       // Array list of items
                                              //                       items: matriaitems2
                                              //                           .map((String
                                              //                               items) {
                                              //                         return DropdownMenuItem(
                                              //                           value:
                                              //                               items,
                                              //                           child:
                                              //                               Padding(
                                              //                             padding:
                                              //                                 const EdgeInsets.all(8.0),
                                              //                             child:
                                              //                                 Text(items),
                                              //                           ),
                                              //                         );
                                              //                       }).toList(),
                                              //                       // After selecting the desired option,it will
                                              //                       // change button value to selected value
                                              //                       onChanged:
                                              //                           (String?
                                              //                               newValue) {
                                              //                         setState(
                                              //                             () {
                                              //                           matrialdropdownvalue2 =
                                              //                               newValue!;
                                              //                         });
                                              //                       },
                                              //                     ),
                                              //                   ),
                                              //                 ],
                                              //               ),
                                              //             ),
                                              //           ),
                                              //         ),
                                              //         Container(
                                              //           width: 10,
                                              //         ),
                                              //         //  Expanded(child: Container()),
                                              //       ],
                                              //     ),
                                              //   ),
                                              // ),
                                              // // Padding(
                                              //   padding: const EdgeInsets.all(16.0),
                                              //   child: Text(
                                              //     "Employment Type",
                                              //     style: TextStyle(
                                              //         color: Colors.grey[900]),
                                              //   ),
                                              // ),
                                              // Container(
                                              //   color: Colors.white,
                                              //   height: 50,
                                              //   width: Constants(context).scrnWidth,
                                              //   child: DropdownButton(
                                              //     hint: Text("select one"),
                                              //     underline: Container(),
                                              //     // Initial Value
                                              //     value: dropdownvalue,

                                              //     // Down Arrow Icon
                                              //     icon: const Icon(
                                              //         Icons.keyboard_arrow_down),

                                              //     // Array list of items
                                              //     items: items.map((String items) {
                                              //       return DropdownMenuItem(
                                              //         value: items,
                                              //         child: Row(
                                              //           children: [
                                              //             Padding(
                                              //               padding:
                                              //                   const EdgeInsets.all(
                                              //                       16.0),
                                              //               child: Text(items),
                                              //             ),
                                              //             Container(
                                              //               width: Constants(context)
                                              //                       .scrnWidth *
                                              //                   0.60,
                                              //             )
                                              //           ],
                                              //         ),
                                              //       );
                                              //     }).toList(),
                                              //     // After selecting the desired option,it will
                                              //     // change button value to selected value
                                              //     onChanged: (String? newValue) {
                                              //       setState(() {
                                              //         dropdownvalue = newValue!;
                                              //       });
                                              //     },
                                              //   ),
                                              // ),

                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                    color: Colors.grey[100],
                                                    padding: EdgeInsets.all(8),
                                                    height: 60,
                                                    child: Center(
                                                        child: Container(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextField(
                                                          style: TextStyle(
                                                              fontSize: 13),
                                                          controller:
                                                              dateinput, //editing controller of this TextField
                                                          decoration:
                                                              InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  // icon: Icon(Icons
                                                                  //     .calendar_today), //icon of text field
                                                                  hintText:
                                                                      "Enter Date of birth",
                                                                  hintStyle: TextStyle(
                                                                      color: Colors
                                                                          .black) //label text of field
                                                                  ),
                                                          readOnly:
                                                              true, //set it true, so that user will not able to edit text
                                                          onTap: () async {
                                                            DateTime?
                                                                pickedDate =
                                                                await showDatePicker(
                                                                    context:
                                                                        context,
                                                                    initialDate:
                                                                        DateTime
                                                                            .now(),
                                                                    firstDate:
                                                                        DateTime(
                                                                            1943), //DateTime.now() - not to allow to choose before today.
                                                                    lastDate:
                                                                        DateTime(
                                                                            2101));

                                                            if (pickedDate !=
                                                                null) {
                                                              print(
                                                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                              String
                                                                  formattedDate =
                                                                  DateFormat(
                                                                          'yyyy-MM-dd')
                                                                      .format(
                                                                          pickedDate);
                                                              print(
                                                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                                                              //you can implement different kind of Date Format here according to your requirement

                                                              setState(() {
                                                                dateinput.text =
                                                                    formattedDate; //set output date to TextField value.
                                                              });
                                                            } else {
                                                              print(
                                                                  "Date is not selected");
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ))),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          child: Container(
                                                            color: Colors
                                                                .grey[100],
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      16.0),
                                                              child: Container(
                                                                child:
                                                                    DropdownButtonHideUnderline(
                                                                  child:
                                                                      DropdownButton2(
                                                                    isExpanded:
                                                                        true,
                                                                    hint: Text(
                                                                      'Gender',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Theme.of(context)
                                                                            .hintColor,
                                                                      ),
                                                                    ),
                                                                    items: genderItem
                                                                        .map((item) => DropdownMenuItem<String>(
                                                                              value: item,
                                                                              child: Text(
                                                                                item,
                                                                                style: const TextStyle(
                                                                                  fontSize: 14,
                                                                                ),
                                                                              ),
                                                                            ))
                                                                        .toList(),
                                                                    value:
                                                                        genderdropdownvalue,
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        genderdropdownvalue =
                                                                            value
                                                                                as String;
                                                                      });
                                                                    },
                                                                    searchInnerWidgetHeight:
                                                                        20,
                                                                    buttonHeight:
                                                                        20,
                                                                    buttonWidth:
                                                                        100,
                                                                    itemHeight:
                                                                        40,

                                                                    dropdownMaxHeight:
                                                                        200,

                                                                    searchController:
                                                                        textEditingController,
                                                                    searchInnerWidget:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                        top: 8,
                                                                        bottom:
                                                                            4,
                                                                        right:
                                                                            8,
                                                                        left: 8,
                                                                      ),
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            textEditingController,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          isDense:
                                                                              true,
                                                                          contentPadding:
                                                                              const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                10,
                                                                            vertical:
                                                                                8,
                                                                          ),
                                                                          hintText:
                                                                              'Search for an item...',
                                                                          hintStyle:
                                                                              const TextStyle(fontSize: 12),
                                                                          border:
                                                                              OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    searchMatchFn:
                                                                        (item,
                                                                            searchValue) {
                                                                      return (item
                                                                          .value
                                                                          .toString()
                                                                          .toLowerCase()
                                                                          .contains(
                                                                              searchValue.toLowerCase()));
                                                                    },
                                                                    //This to clear the search value when you close the menu
                                                                    onMenuStateChange:
                                                                        (isOpen) {
                                                                      if (!isOpen) {
                                                                        textEditingController
                                                                            .clear();
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        // Padding(
                                                        //   padding: const EdgeInsets.all(8.0),
                                                        //   child: Padding(
                                                        //     padding: const EdgeInsets.all(8.0),
                                                        //     child: Container(
                                                        //       child: Column(
                                                        //         crossAxisAlignment: CrossAxisAlignment.start,
                                                        //         children: [
                                                        //           Padding(
                                                        //             padding: const EdgeInsets.only(
                                                        //                 right: 8, left: 6),
                                                        //             child: Container(
                                                        //               decoration: BoxDecoration(
                                                        //                 color: Colors.grey[100],
                                                        //                 // border: Border.all(
                                                        //                 //     color: Colors.grey, // Set border color
                                                        //                 //     width: 1.0),
                                                        //                 //   color: HexColor("#F9F9F9"),
                                                        //                 borderRadius:
                                                        //                     BorderRadius.circular(5),
                                                        //               ),
                                                        //               height: 40,
                                                        //               // width: 200,
                                                        //               child: SingleChildScrollView(
                                                        //                 child: Container(
                                                        //                   child: DropdownButton(
                                                        //                     menuMaxHeight: 200,
                                                        //                     // hint: "Reference",
                                                        //                     hint: Padding(
                                                        //                       padding:
                                                        //                           const EdgeInsets.all(8.0),
                                                        //                       child: Text("Meridiem"),
                                                        //                     ),
                                                        //                     underline: Container(),
                                                        //                     // Initial Value
                                                        //                     value: perdium,

                                                        //                     // Down Arrow Icon
                                                        //                     // icon: const Icon(
                                                        //                     //     Icons.keyboard_arrow_down),

                                                        //                     // Array list of items
                                                        //                     items:
                                                        //                         refitems.map((String items) {
                                                        //                       return DropdownMenuItem(
                                                        //                         value: items,
                                                        //                         child: Row(
                                                        //                           children: [
                                                        //                             Row(
                                                        //                               children: [
                                                        //                                 Padding(
                                                        //                                   padding:
                                                        //                                       const EdgeInsets
                                                        //                                           .all(8.0),
                                                        //                                   child: Container(
                                                        //                                       child: Text(
                                                        //                                           items)),
                                                        //                                 ),
                                                        //                               ],
                                                        //                             ),
                                                        //                             Container()
                                                        //                           ],
                                                        //                         ),
                                                        //                       );
                                                        //                     }).toList(),
                                                        //                     // After selecting the desired option,it will
                                                        //                     // change button value to selected value
                                                        //                     onChanged: (String? newValue) {
                                                        //                       setState(() {
                                                        //                         perdium = newValue!;
                                                        //                       });
                                                        //                     },
                                                        //                   ),
                                                        //                 ),
                                                        //               ),
                                                        //             ),
                                                        //           ),
                                                        //         ],
                                                        //       ),
                                                        //     ),
                                                        //   ),
                                                        // ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              // Container(
                                              //   color: Colors.grey[50],
                                              //   height: 50,
                                              //   width: Constants(context)
                                              //       .scrnWidth,
                                              //   child: DropdownButton(
                                              //     hint: Padding(
                                              //       padding:
                                              //           const EdgeInsets.all(
                                              //               8.0),
                                              //       child: Text(" Gender"),
                                              //     ),
                                              //     underline: Container(),
                                              //     // Initial Value
                                              //     value: genderdropdownvalue,

                                              //     // Down Arrow Icon
                                              //     icon: const Icon(Icons
                                              //         .keyboard_arrow_down),

                                              //     // Array list of items
                                              //     items: genderItem
                                              //         .map((String items) {
                                              //       return DropdownMenuItem(
                                              //         value: items,
                                              //         child: Row(
                                              //           children: [
                                              //             Padding(
                                              //               padding:
                                              //                   const EdgeInsets
                                              //                       .all(8.0),
                                              //               child: Text(items),
                                              //             ),
                                              //             Container(
                                              //               width: Constants(
                                              //                           context)
                                              //                       .scrnWidth *
                                              //                   0.49,
                                              //             )
                                              //           ],
                                              //         ),
                                              //       );
                                              //     }).toList(),
                                              //     // After selecting the desired option,it will
                                              //     // change button value to selected value
                                              //     onChanged:
                                              //         (String? newValue) {
                                              //       setState(() {
                                              //         genderdropdownvalue =
                                              //             newValue!;
                                              //       });
                                              //     },
                                              //   ),
                                              // ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          child: Container(
                                                            color: Colors
                                                                .grey[100],
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      16.0),
                                                              child: Container(
                                                                child:
                                                                    DropdownButtonHideUnderline(
                                                                  child:
                                                                      DropdownButton2(
                                                                    isExpanded:
                                                                        true,
                                                                    hint: Text(
                                                                      'Relationship With Lead',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Theme.of(context)
                                                                            .hintColor,
                                                                      ),
                                                                    ),
                                                                    items: relationitems
                                                                        .map((item) => DropdownMenuItem<String>(
                                                                              value: item,
                                                                              child: Text(
                                                                                item,
                                                                                style: const TextStyle(
                                                                                  fontSize: 14,
                                                                                ),
                                                                              ),
                                                                            ))
                                                                        .toList(),
                                                                    value:
                                                                        relationshipdropdownvalue,
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        relationshipdropdownvalue =
                                                                            value
                                                                                as String;
                                                                      });
                                                                    },
                                                                    searchInnerWidgetHeight:
                                                                        20,
                                                                    buttonHeight:
                                                                        20,
                                                                    buttonWidth:
                                                                        100,
                                                                    itemHeight:
                                                                        40,

                                                                    dropdownMaxHeight:
                                                                        200,

                                                                    searchController:
                                                                        textEditingController,
                                                                    searchInnerWidget:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                        top: 8,
                                                                        bottom:
                                                                            4,
                                                                        right:
                                                                            8,
                                                                        left: 8,
                                                                      ),
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            textEditingController,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          isDense:
                                                                              true,
                                                                          contentPadding:
                                                                              const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                10,
                                                                            vertical:
                                                                                8,
                                                                          ),
                                                                          hintText:
                                                                              'Search for an item...',
                                                                          hintStyle:
                                                                              const TextStyle(fontSize: 12),
                                                                          border:
                                                                              OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    searchMatchFn:
                                                                        (item,
                                                                            searchValue) {
                                                                      return (item
                                                                          .value
                                                                          .toString()
                                                                          .toLowerCase()
                                                                          .contains(
                                                                              searchValue.toLowerCase()));
                                                                    },
                                                                    //This to clear the search value when you close the menu
                                                                    onMenuStateChange:
                                                                        (isOpen) {
                                                                      if (!isOpen) {
                                                                        textEditingController
                                                                            .clear();
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        // Padding(
                                                        //   padding: const EdgeInsets.all(8.0),
                                                        //   child: Padding(
                                                        //     padding: const EdgeInsets.all(8.0),
                                                        //     child: Container(
                                                        //       child: Column(
                                                        //         crossAxisAlignment: CrossAxisAlignment.start,
                                                        //         children: [
                                                        //           Padding(
                                                        //             padding: const EdgeInsets.only(
                                                        //                 right: 8, left: 6),
                                                        //             child: Container(
                                                        //               decoration: BoxDecoration(
                                                        //                 color: Colors.grey[100],
                                                        //                 // border: Border.all(
                                                        //                 //     color: Colors.grey, // Set border color
                                                        //                 //     width: 1.0),
                                                        //                 //   color: HexColor("#F9F9F9"),
                                                        //                 borderRadius:
                                                        //                     BorderRadius.circular(5),
                                                        //               ),
                                                        //               height: 40,
                                                        //               // width: 200,
                                                        //               child: SingleChildScrollView(
                                                        //                 child: Container(
                                                        //                   child: DropdownButton(
                                                        //                     menuMaxHeight: 200,
                                                        //                     // hint: "Reference",
                                                        //                     hint: Padding(
                                                        //                       padding:
                                                        //                           const EdgeInsets.all(8.0),
                                                        //                       child: Text("Meridiem"),
                                                        //                     ),
                                                        //                     underline: Container(),
                                                        //                     // Initial Value
                                                        //                     value: perdium,

                                                        //                     // Down Arrow Icon
                                                        //                     // icon: const Icon(
                                                        //                     //     Icons.keyboard_arrow_down),

                                                        //                     // Array list of items
                                                        //                     items:
                                                        //                         refitems.map((String items) {
                                                        //                       return DropdownMenuItem(
                                                        //                         value: items,
                                                        //                         child: Row(
                                                        //                           children: [
                                                        //                             Row(
                                                        //                               children: [
                                                        //                                 Padding(
                                                        //                                   padding:
                                                        //                                       const EdgeInsets
                                                        //                                           .all(8.0),
                                                        //                                   child: Container(
                                                        //                                       child: Text(
                                                        //                                           items)),
                                                        //                                 ),
                                                        //                               ],
                                                        //                             ),
                                                        //                             Container()
                                                        //                           ],
                                                        //                         ),
                                                        //                       );
                                                        //                     }).toList(),
                                                        //                     // After selecting the desired option,it will
                                                        //                     // change button value to selected value
                                                        //                     onChanged: (String? newValue) {
                                                        //                       setState(() {
                                                        //                         perdium = newValue!;
                                                        //                       });
                                                        //                     },
                                                        //                   ),
                                                        //                 ),
                                                        //               ),
                                                        //             ),
                                                        //           ),
                                                        //         ],
                                                        //       ),
                                                        //     ),
                                                        //   ),
                                                        // ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                    color: Colors.grey[100],
                                                    height: 50,
                                                    width: Constants(context)
                                                        .scrnWidth,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16.0),
                                                      child: TextField(
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              'Occupation',
                                                          hintStyle: TextStyle(
                                                              fontSize: 13),
                                                          border:
                                                              InputBorder.none,
                                                        ),
                                                        controller:
                                                            designation2,
                                                      ),
                                                    )),
                                              ),

                                              // Container(
                                              //     color: Colors.grey[50],
                                              //     //  height: 50,
                                              //     width: Constants(context)
                                              //         .scrnWidth,
                                              //     child: Container(
                                              //         color: Colors.grey[50],
                                              //         height: 50,
                                              //         width: Constants(context)
                                              //             .scrnWidth,
                                              //         child: Container(
                                              //           color: Colors.grey[50],
                                              //           height: 50,
                                              //           width:
                                              //               Constants(context)
                                              //                   .scrnWidth,
                                              //           child: DropdownButton(
                                              //             hint: Padding(
                                              //               padding:
                                              //                   const EdgeInsets
                                              //                       .all(16.0),
                                              //               child: Text(
                                              //                   "Relationship with lead"),
                                              //             ),
                                              //             underline:
                                              //                 Container(),
                                              //             // Initial Value
                                              //             value:
                                              //                 relationshipdropdownvalue,

                                              //             // Down Arrow Icon
                                              //             icon: const Icon(Icons
                                              //                 .keyboard_arrow_down),

                                              //             // Array list of items
                                              //             items: relationitems
                                              //                 .map((String
                                              //                     items) {
                                              //               return DropdownMenuItem(
                                              //                 value: items,
                                              //                 child: Row(
                                              //                   children: [
                                              //                     Padding(
                                              //                       padding:
                                              //                           const EdgeInsets.all(
                                              //                               8.0),
                                              //                       child: Text(
                                              //                           items),
                                              //                     ),
                                              //                     Container(
                                              //                       width: Constants(context)
                                              //                               .scrnWidth *
                                              //                           0.36,
                                              //                     )
                                              //                   ],
                                              //                 ),
                                              //               );
                                              //             }).toList(),
                                              //             // After selecting the desired option,it will
                                              //             // change button value to selected value
                                              //             onChanged: (String?
                                              //                 newValue) {
                                              //               setState(() {
                                              //                 relationshipdropdownvalue =
                                              //                     newValue!;
                                              //               });
                                              //             },
                                              //           ),
                                              //         ))),

                                              if (widget.status != "memb")
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Container(
                                                    width: Constants(context)
                                                        .scrnWidth,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        if (nameController!
                                                            .text.isEmpty) {
                                                          Fluttertoast.showToast(
                                                              backgroundColor:
                                                                  Colors.blue[
                                                                      200],
                                                              textColor:
                                                                  Colors.black,
                                                              msg:
                                                                  "Add member name");
                                                        } else {
                                                          widget.status == "mem"
                                                              ? AddbaisicdetailController().addmemberDetail(
                                                                  nameController!
                                                                      .text,
                                                                  genderdropdownvalue
                                                                      .toString(),
                                                                  relationshipdropdownvalue
                                                                      .toString(),
                                                                  age!.text,
                                                                  dateinput
                                                                      .text,
                                                                  matrialdropdownvalue2
                                                                      .toString(),
                                                                  educationdropdownvalue2
                                                                      .toString(),
                                                                  widget.leadtok
                                                                      .toString(),
                                                                  designation2!
                                                                      .text
                                                                      .toString())
                                                              : widget.status ==
                                                                      "memb"
                                                                  ? AddbaisicdetailController().updatememberDetail(
                                                                      nameController!
                                                                          .text,
                                                                      genderdropdownvalue
                                                                          .toString(),
                                                                      relationshipdropdownvalue
                                                                          .toString(),
                                                                      age!.text,
                                                                      dateinput
                                                                          .text,
                                                                      matrialdropdownvalue2
                                                                          .toString(),
                                                                      educationdropdownvalue2
                                                                          .toString(),
                                                                      widget.leadtok
                                                                          .toString(),
                                                                      widget
                                                                          .idx,
                                                                      designation2!
                                                                          .text
                                                                          .toString(),
                                                                      widget.rowid
                                                                          .toString(),
                                                                      widget.leadtok
                                                                          .toString())
                                                                  : AddbaisicdetailController().addmemberDetail(
                                                                      nameController!
                                                                          .text,
                                                                      genderdropdownvalue
                                                                          .toString(),
                                                                      relationshipdropdownvalue
                                                                          .toString(),
                                                                      age!.text,
                                                                      dateinput
                                                                          .text,
                                                                      matrialdropdownvalue2
                                                                          .toString(),
                                                                      educationdropdownvalue2
                                                                          .toString(),
                                                                      widget
                                                                          .leadtok
                                                                          .toString(),
                                                                      designation2!
                                                                          .text
                                                                          .toString());

                                                          setState(() {
                                                            // Get.to(LeaddetailsView(
                                                            //     "",
                                                            //     "",
                                                            //     0,
                                                            //     "",
                                                            //     "",
                                                            //     widget.leadtok));
                                                          });
                                                        }
                                                      },
                                                      child: Text(
                                                        "Save",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      3,
                                                                      66,
                                                                      114)),
                                                    ),
                                                  ),
                                                ),
                                              if (widget.status == "memb")
                                                // Text(
                                                //   "jjj",
                                                //   style: TextStyle(
                                                //       color: Colors.black),
                                                // ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Container(
                                                    width: Constants(context)
                                                        .scrnWidth,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        if (nameController!
                                                            .text.isEmpty) {
                                                          Fluttertoast.showToast(
                                                              backgroundColor:
                                                                  Colors.blue[
                                                                      200],
                                                              textColor:
                                                                  Colors.black,
                                                              msg:
                                                                  "Add member name");
                                                        } else {
                                                          widget
                                                                      .status ==
                                                                  "memb"
                                                              ? AddbaisicdetailController().updatememberDetail(
                                                                  nameController!
                                                                      .text,
                                                                  genderdropdownvalue
                                                                      .toString(),
                                                                  relationshipdropdownvalue
                                                                      .toString(),
                                                                  age!.text,
                                                                  dateinput
                                                                      .text,
                                                                  matrialdropdownvalue2
                                                                      .toString(),
                                                                  educationdropdownvalue2
                                                                      .toString(),
                                                                  widget.leadtok
                                                                      .toString(),
                                                                  widget.idx,
                                                                  designation2!
                                                                      .text
                                                                      .toString(),
                                                                  widget
                                                                      .rowid
                                                                      .toString(),
                                                                  widget
                                                                      .leadtok
                                                                      .toString())
                                                              : AddbaisicdetailController().addmemberDetail(
                                                                  nameController!
                                                                      .text,
                                                                  genderdropdownvalue
                                                                      .toString(),
                                                                  relationshipdropdownvalue
                                                                      .toString(),
                                                                  age!.text,
                                                                  dateinput
                                                                      .text,
                                                                  matrialdropdownvalue2
                                                                      .toString(),
                                                                  educationdropdownvalue2
                                                                      .toString(),
                                                                  widget.leadtok
                                                                      .toString(),
                                                                  designation2!
                                                                      .text
                                                                      .toString());

                                                          setState(() {
                                                            // Get.to(LeaddetailsView(
                                                            //     "",
                                                            //     "",
                                                            //     0,
                                                            //     "",
                                                            //     "",
                                                            //     widget.leadtok));
                                                          });
                                                        }
                                                      },
                                                      child: Text(
                                                        "Update",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      3,
                                                                      66,
                                                                      114)),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        )))),
                          ),
                    Row(
                      children: [],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
