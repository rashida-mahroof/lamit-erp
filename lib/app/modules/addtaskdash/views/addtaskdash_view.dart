import 'dart:convert';
import 'dart:developer';

import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fancy_containers/fancy_containers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:lamit/app/modules/home/views/home_view.dart';
import 'package:lamit/app/modules/taskmainview/views/taskmainview_view.dart';

import 'package:lamit/app/routes/constants.dart';
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/widget/customeappbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../tocken/tockn.dart';

class AddtaskdashView extends StatefulWidget {
  final String ladcust;
  final String status;
  final String name;

  final String leadid;
  final String contact_date;
  final String taktype;
  final String fromtime;
  final String subject;
  final String restorationId = "main";

  const AddtaskdashView(this.ladcust, this.status, this.name, this.leadid,
      this.contact_date, this.taktype, this.fromtime, this.subject);
  @override
  State<AddtaskdashView> createState() => _AddtaskdashViewState();
}

class _AddtaskdashViewState extends State<AddtaskdashView>
    with RestorationMixin {
  String? get restorationId => widget.restorationId;
  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2021),
          lastDate: DateTime(2122),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  var a;
  String? datelll;
  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        datelll =
            '${_selectedDate.value.year}-${_selectedDate.value.month}-${_selectedDate.value.day}';
        setState(() {
          a = "${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}";

          //  a.toString();
        });
      });
    }
  }

  String? refdropdownvalue;
  String? hourdropdownvalue;
  String? mindropdownvalue;
  String? hour2dropdownvalue;
  String? min2dropdownvalue;
  String? refdropdownvalue2;
  String? markedropdownvalue;
  String? statusDropdownvalue;
  String? perdium;
  String? dropValue;
  String? cleadname;
  String? lshow;
  var productList3;
  var customerlist;
  String? custnumber;
  String? leadmobile;
  var callitems = ["Calling", "Visit"];
  var refitems = ["AM", "PM"];
  var marketingoffice = [];
  String? marketingofficename;
  String? marketingofficeemail;
  String? salesofficername;
  String? salesofficeremail;
  var items = ["Open", "Closed"];
  var items3 = ["Customer", "Lead"];
  var custDropDown = [];
  String? custLead;
  String? marketingofficerid;
  var houritems = [
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12"
  ];

  TextEditingController textEditingController = new TextEditingController();
  var miitems = [
    "00",
    "05",
    "10",
    "15",
    "20",
    "25",
    "30",
    "35",
    "40",
    "45",
    "50",
    "55"
  ];

  TextEditingController timeinput = TextEditingController();
  TextEditingController notes = TextEditingController();
  TextEditingController subject = TextEditingController();

  DateTime? nextmeetingDate;
  //DateTime? datelll;
  String? userId;
  DateTime? time;
  String? intimehr1;
  String? totimemin1;
  String? intimehr2;
  String? totimemin2;
  String? lac;
  String? custarea;
  String? calldropdownvalue;

  var referencelist;
  String? dropdownvaluesource;
  var sourcelist = [];
  var productlist = [];
  var sourceDropDown = [];
  var cusdropdownvalue;
  String? selectedValue;
  final List<String> items1 = ["Marketing Officer", "Me"];

  String? leadname;
  TextEditingController endtime = TextEditingController();
  @override
  void initState() {
    log(markedropdownvalue.toString());
    getsf();
    if (widget.status == "Closed") {
      statusDropdownvalue = widget.status;
      dropdownvaluesource = widget.name;
    }

    log(statusDropdownvalue.toString());
    log(dropdownvaluesource.toString());
    log(widget.leadid.toString());
    //getAllarea();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize:
              Size(MediaQuery.of(context).size.width, kToolbarHeight),
          child: CustomAppBar(
            title: widget.status != "Closed"
                ? "ADD DAILY TASK"
                : "CLOSE DAILY TASK",
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: Constants(context).scrnHeight + 200,
              // color: Colors.blue[100],
              // color: HexColor("#EEf3f9"),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Container(
                        child: Row(
                          children: [],
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(16.0),
                    //   child: Row(
                    //     children: [
                    //       GestureDetector(
                    //         onTap: () {
                    //           Get.back();
                    //         },
                    //         child: Container(
                    //           height: 30,
                    //           child: Icon(
                    //             Icons.arrow_back,
                    //             size: 18,
                    //           ),
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Text(
                    //           widget.status != "Closed"
                    //               ? "ADD DAILY TASK"
                    //               : "CLOSED DAILY TASK",
                    //           style: TextStyle(
                    //               color: Color.fromARGB(255, 4, 46, 80),
                    //               fontSize: 12,
                    //               fontWeight: FontWeight.bold),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),

                    //////////
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Column(
                          children: [
                            widget.status == "Closed"
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Container(
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton2(
                                                isExpanded: true,
                                                hint: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Lead / Customer",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Theme.of(context)
                                                          .hintColor,
                                                    ),
                                                  ),
                                                ),
                                                items: items3
                                                    .map((item) =>
                                                        DropdownMenuItem<
                                                            String>(
                                                          value: item,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              item.toString(),
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ),
                                                        ))
                                                    .toList(),
                                                value: custLead,
                                                onChanged: (value) {
                                                  setState(() {
                                                    log(productList3
                                                        .toString());

                                                    custLead = value == ""
                                                        ? ""
                                                        : value.toString();
                                                    log(custLead.toString());
                                                  });
                                                },
                                                searchInnerWidgetHeight: 20,
                                                buttonHeight: 40,
                                                buttonWidth: Constants(context)
                                                    .scrnWidth,
                                                itemHeight: 40,
                                                dropdownMaxHeight: 200,
                                                searchController:
                                                    textEditingController,
                                                searchInnerWidget: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 8,
                                                    bottom: 4,
                                                    right: 8,
                                                    left: 8,
                                                  ),
                                                  child: Container(),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            widget.status == "Closed"
                                ? Container()
                                : custLead == "Customer"
                                    ? Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8.0),
                                                  child: Container(
                                                    width: Constants(context)
                                                        .scrnWidth,
                                                    height: 52,
                                                    margin: EdgeInsets.all(0),
                                                    decoration: BoxDecoration(
                                                      // border: Border.all(
                                                      //     color: Colors.grey, // Set border color
                                                      //     width: 1.0),
                                                      color:
                                                          HexColor("#F9F9F9"),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            // margin: EdgeInsets.all(2),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .grey[100],
                                                              //color: Colors.white,
                                                            ),
                                                            child:
                                                                CustomSearchableDropDown(
                                                                    primaryColor:
                                                                        Colors
                                                                            .black,
                                                                    items:
                                                                        productList3,
                                                                    label:
                                                                        'Customer',
                                                                    showLabelInMenu:
                                                                        true,
                                                                    onChanged:
                                                                        (value) async {
                                                                      markedropdownvalue =
                                                                          null;
                                                                      // log(sourcelist
                                                                      //     .toString());
                                                                      // log(value
                                                                      //     .toString());
                                                                      setState(
                                                                          () {
                                                                        custnumber =
                                                                            value["mobile_number"].toString();
                                                                        lshow =
                                                                            "show";
                                                                        cusdropdownvalue =
                                                                            null;
                                                                        cusdropdownvalue =
                                                                            value["name"].toString();
                                                                        cleadname =
                                                                            value["name"];
                                                                        custarea =
                                                                            value["customer_area"].toString();
                                                                        log(value
                                                                            .toString());
                                                                        log(custarea.toString() +
                                                                            "bnbggggbbfffff");
                                                                        //   lac = value["lac"]
                                                                        //     .toString();
                                                                        // log("hiiii+" +
                                                                        //     leadname
                                                                        //         .toString());
                                                                        // log(dropdownvaluesource
                                                                        //     .toString());
                                                                      });
                                                                      log(custarea
                                                                          .toString());
                                                                      marketing(
                                                                          custarea,
                                                                          cleadname);
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                    dropDownMenuItems:
                                                                        custDropDown ==
                                                                                []
                                                                            ? [
                                                                                ''
                                                                              ]
                                                                            : custDropDown),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container(),
                            custLead != "Lead"
                                ? Container()
                                : Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Container(
                                                height: 52,
                                                width: Constants(context)
                                                    .scrnWidth,
                                                margin: EdgeInsets.all(0),
                                                decoration: BoxDecoration(
                                                  // border: Border.all(
                                                  //     color: Colors.grey, // Set border color
                                                  //     width: 1.0),
                                                  color: HexColor("#F9F9F9"),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        // margin: EdgeInsets.all(2),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.grey[100],
                                                          //color: Colors.white,
                                                        ),
                                                        child:
                                                            CustomSearchableDropDown(
                                                                primaryColor:
                                                                    Colors
                                                                        .black,
                                                                items:
                                                                    sourcelist,
                                                                label: 'Lead',
                                                                showLabelInMenu:
                                                                    true,
                                                                onChanged:
                                                                    (value) async {
                                                                  // markedropdownvalue =
                                                                  //     null;
                                                                  log(sourcelist
                                                                      .toString());
                                                                  log(value
                                                                      .toString());
                                                                  setState(() {
                                                                    leadmobile =
                                                                        value["mobile"]
                                                                            .toString();
                                                                    lshow =
                                                                        "show";
                                                                    dropdownvaluesource =
                                                                        value["lead_name"]
                                                                            .toString();
                                                                    leadname =
                                                                        value[
                                                                            "name"];
                                                                    lac = value[
                                                                            "lac"]
                                                                        .toString();
                                                                    log("hiiii+" +
                                                                        leadname
                                                                            .toString());
                                                                    log(dropdownvaluesource
                                                                        .toString());
                                                                  });
                                                                  log(lac
                                                                      .toString());
                                                                  marketing(lac,
                                                                      leadname);
                                                                  setState(
                                                                      () {});
                                                                },
                                                                dropDownMenuItems:
                                                                    sourceDropDown ==
                                                                            []
                                                                        ? ['']
                                                                        : sourceDropDown),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                            if (widget.status == "Open")
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Container(
                                  color: Colors.grey[100],
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          isExpanded: true,
                                          hint: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Assign",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color:
                                                    Theme.of(context).hintColor,
                                              ),
                                            ),
                                          ),
                                          items: items1
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        item.toString(),
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                          value: dropValue,
                                          onChanged: (value) {
                                            setState(() {
                                              dropValue = value == ""
                                                  ? ""
                                                  : value.toString();
                                              log(dropValue.toString());
                                              log(salesofficername.toString());
                                            });
                                          },
                                          searchInnerWidgetHeight: 20,
                                          buttonHeight: 40,
                                          buttonWidth:
                                              Constants(context).scrnWidth,
                                          itemHeight: 40,
                                          dropdownMaxHeight: 200,
                                          searchController:
                                              textEditingController,
                                          searchInnerWidget: Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8,
                                                bottom: 4,
                                                right: 8,
                                                left: 8,
                                              ),
                                              child:
                                                  Container() //This to clear the search value when you close the menu
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            dropValue == "Marketing Officer"
//mark
                                ? Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Container(
                                      height: 50,
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton2(
                                                isExpanded: true,
                                                hint: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Marketing officer',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Theme.of(context)
                                                          .hintColor,
                                                    ),
                                                  ),
                                                ),
                                                items: marketingoffice
                                                    .map((item) =>
                                                        DropdownMenuItem<
                                                            String>(
                                                          value: item["index"]
                                                              .toString(),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              item == null
                                                                  ? item
                                                                      .toString()
                                                                  : item["marketing_officer_name"]
                                                                      .toString(),
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ),
                                                        ))
                                                    .toList(),
                                                value: markedropdownvalue,
                                                onChanged: (value) {
                                                  setState(() {
                                                    markedropdownvalue =
                                                        value.toString();
                                                    log(markedropdownvalue
                                                        .toString());
                                                    log(markedropdownvalue
                                                        .toString());
                                                    markedropdownvalue =
                                                        value.toString();
                                                    marketingofficename =
                                                        marketingoffice[
                                                                int.parse(value
                                                                    .toString())]
                                                            [
                                                            "marketing_officer_name"];

                                                    marketingofficerid =
                                                        marketingoffice[
                                                                int.parse(value
                                                                    .toString())]
                                                            [
                                                            "marketing_officer"];
                                                    marketingofficeemail =
                                                        marketingoffice[
                                                                int.parse(value
                                                                    .toString())]
                                                            [
                                                            "marketing_officer_email"];
                                                    log(value.toString());
                                                    log("bbbbbbbbbbbbbbbb" +
                                                        value.toString());
                                                  });
                                                },
                                                searchInnerWidgetHeight: 20,
                                                buttonHeight: 20,
                                                buttonWidth: Constants(context)
                                                    .scrnWidth,
                                                itemHeight: 40,
                                                dropdownMaxHeight: 200,
                                                searchController:
                                                    textEditingController,
                                                searchInnerWidget: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 8,
                                                      bottom: 4,
                                                      right: 8,
                                                      left: 8,
                                                    ),
                                                    child: Container())
                                                //This to clear the search value when you close the menu

                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                            widget.status == "Closed"
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Container(
                                        height: 50,
                                        color: Colors.grey[100],
                                        width: Constants(context).scrnWidth,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextField(
                                                  controller: subject,
                                                  decoration:
                                                      new InputDecoration
                                                              .collapsed(
                                                          hintText: 'Subject'),
                                                  keyboardType:
                                                      TextInputType.name,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )),
                                  ),
                            widget.status == "Closed"
                                ? Container()
                                : Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 50,
                                                  margin: EdgeInsets.all(0),
                                                  decoration: BoxDecoration(
                                                    // border: Border.all(
                                                    //     color: Colors
                                                    //         .grey, // Set border color
                                                    //     width: 1.0),
                                                    color: HexColor("#F9F9F9"),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            right: 8.0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Container(
                                                        width:
                                                            Constants(context)
                                                                .scrnWidth,
                                                        child: TextButton(
                                                            onPressed: () {
                                                              _restorableDatePickerRouteFuture
                                                                  .present();
                                                              //  a = "${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}";
                                                            },
                                                            child:
                                                                datelll == null
                                                                    ? Text(
                                                                        'Pick  Date ',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                11,
                                                                            color:
                                                                                Colors.black),
                                                                      )
                                                                    : datelll ==
                                                                            ""
                                                                        ? Text(
                                                                            'Pick Expected Date ',
                                                                            style:
                                                                                TextStyle(fontSize: 11, color: Colors.black),
                                                                          )
                                                                        : Text(
                                                                            datelll.toString(),
                                                                            style:
                                                                                TextStyle(color: Colors.black),
                                                                          )),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                if (datelll != null)
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        datelll = null;
                                                      });
                                                    },
                                                    child: Row(
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                datelll = null;
                                                              });
                                                            },
                                                            icon: Icon(
                                                              Icons.clear,
                                                              color: Colors.red,
                                                            )),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16.0),
                                                          child: Text(
                                                            'Picked Date Clear ',
                                                            style: TextStyle(
                                                                fontSize: 11,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                            widget.status == "Closed"
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Container(
                                      height: 50,
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton2(
                                              isExpanded: true,
                                              hint: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Task Type',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  ),
                                                ),
                                              ),
                                              items: callitems
                                                  .map((item) =>
                                                      DropdownMenuItem<String>(
                                                        value: item,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            item,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      ))
                                                  .toList(),
                                              value: calldropdownvalue,
                                              onChanged: (value) {
                                                setState(() {
                                                  calldropdownvalue =
                                                      value.toString();
                                                  log("bbbbbbbbbbbbbbbb" +
                                                      value.toString());
                                                });
                                              },
                                              searchInnerWidgetHeight: 20,
                                              buttonHeight: 20,
                                              buttonWidth:
                                                  Constants(context).scrnWidth,
                                              itemHeight: 40,
                                              dropdownMaxHeight: 200,
                                              searchController:
                                                  textEditingController,
                                              searchInnerWidget: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 8,
                                                    bottom: 4,
                                                    right: 8,
                                                    left: 8,
                                                  ),
                                                  child: Container()),

                                              //This to clear the search value when you close the menu
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            // widget.status == "Closed"
                            //     ? Container()
                            //     : Row(
                            //         children: [
                            //           Expanded(
                            //             flex: 2,
                            //             child: Column(
                            //               crossAxisAlignment:
                            //                   CrossAxisAlignment.start,
                            //               children: [
                            //                 Container(
                            //                   decoration: BoxDecoration(
                            //                     color: Colors.grey[100],
                            //                     // border: Border.all(
                            //                     //     color: Colors.grey, // Set border color
                            //                     //     width: 1.0),
                            //                     //   color: HexColor("#F9F9F9"),
                            //                     borderRadius:
                            //                         BorderRadius.circular(5),
                            //                   ),
                            //                   height: 50,
                            //                   width:
                            //                       Constants(context).scrnWidth +
                            //                           ,
                            //                   child: DropdownButton(
                            //                     menuMaxHeight: 200,
                            //                     // hint: "Reference",
                            //                     hint: Padding(
                            //                       padding:
                            //                           const EdgeInsets.all(8.0),
                            //                       child: Container(
                            //                           child: Padding(
                            //                         padding:
                            //                             const EdgeInsets.all(
                            //                                 8.0),
                            //                         child: Text("Status"),
                            //                       )),
                            //                     ),
                            //                     underline: Container(),
                            //                     // Initial Value
                            //                     value: statusDropdownvalue,

                            //                     // Down Arrow Icon
                            //                     // icon: const Icon(
                            //                     //     Icons.keyboard_arrow_down),

                            //                     // Array list of items
                            //                     items:
                            //                         items.map((String items) {
                            //                       return DropdownMenuItem(
                            //                         value: items,
                            //                         child: Row(
                            //                           children: [
                            //                             Row(
                            //                               children: [
                            //                                 Text(items),
                            //                               ],
                            //                             ),
                            //                             Container(
                            //                                 width: Constants(
                            //                                             context)
                            //                                         .scrnWidth *
                            //                                     0.56)
                            //                           ],
                            //                         ),
                            //                       );
                            //                     }).toList(),
                            //                     // After selecting the desired option,it will
                            //                     // change button value to selected value
                            //                     onChanged: (String? newValue) {
                            //                       setState(() {
                            //                         statusDropdownvalue =
                            //                             newValue!;
                            //                       });
                            //                     },
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //           )
                            //         ],
                            //       ),
                          ],
                        ),
                      ),
                    ),

                    if (statusDropdownvalue != "Closed")
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, bottom: 8),
                                    child: Text(
                                      "Start Time",
                                      style: TextStyle(color: Colors.grey[900]),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Container(
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Container(
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton2(
                                              isExpanded: true,
                                              hint: Text(
                                                'Hour',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Theme.of(context)
                                                      .hintColor,
                                                ),
                                              ),
                                              items: houritems
                                                  .map((item) =>
                                                      DropdownMenuItem<String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ))
                                                  .toList(),
                                              value: hourdropdownvalue,
                                              onChanged: (value) {
                                                setState(() {
                                                  hourdropdownvalue =
                                                      value as String;
                                                });
                                              },
                                              searchInnerWidgetHeight: 20,
                                              buttonHeight: 20,
                                              buttonWidth:
                                                  Constants(context).scrnWidth,
                                              itemHeight: 40,
                                              dropdownMaxHeight: 200,
                                              searchController:
                                                  textEditingController,
                                              searchInnerWidget: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 8,
                                                    bottom: 4,
                                                    right: 8,
                                                    left: 8,
                                                  ),
                                                  child: Container()),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Padding(
                                  //   padding:
                                  //       const EdgeInsets.only(right: 8, left: 6),
                                  //   child: Container(
                                  //     decoration: BoxDecoration(
                                  //       color: Colors.grey[100],
                                  //       // border: Border.all(
                                  //       //     color: Colors.grey, // Set border color
                                  //       //     width: 1.0),
                                  //       //   color: HexColor("#F9F9F9"),
                                  //       borderRadius: BorderRadius.circular(5),
                                  //     ),
                                  //     height: 50,
                                  //     width: Constants(context).scrnWidth,
                                  //     child: DropdownButton(
                                  //       menuMaxHeight: 200,
                                  //       // hint: "Reference",
                                  //       hint: Padding(
                                  //         padding: const EdgeInsets.all(8.0),
                                  //         child: Text("Hour"),
                                  //       ),
                                  //       underline: Container(),
                                  //       // Initial Value
                                  //       value: hourdropdownvalue,

                                  //       // Down Arrow Icon
                                  //       // icon: const Icon(
                                  //       //     Icons.keyboard_arrow_down),

                                  //       // Array list of items
                                  //       items: houritems.map((String items) {
                                  //         return DropdownMenuItem(
                                  //           value: items,
                                  //           child: Row(
                                  //             children: [
                                  //               Padding(
                                  //                 padding:
                                  //                     const EdgeInsets.all(16.0),
                                  //                 child: Row(
                                  //                   children: [
                                  //                     Text(items),
                                  //                   ],
                                  //                 ),
                                  //               ),
                                  //               Container(
                                  //                 width: Constants(context)
                                  //                         .scrnWidth *
                                  //                     0.0,
                                  //               )
                                  //             ],
                                  //           ),
                                  //         );
                                  //       }).toList(),
                                  //       // After selecting the desired option,it will
                                  //       // change button value to selected value
                                  //       onChanged: (String? newValue) {
                                  //         setState(() {
                                  //           hourdropdownvalue = newValue!;
                                  //         });
                                  //       },
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "",
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 14,
                                          //fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Container(
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Container(
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton2(
                                              isExpanded: true,
                                              hint: Text(
                                                'Min',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Theme.of(context)
                                                      .hintColor,
                                                ),
                                              ),
                                              items: miitems
                                                  .map((item) =>
                                                      DropdownMenuItem<String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ))
                                                  .toList(),
                                              value: mindropdownvalue,
                                              onChanged: (value) {
                                                setState(() {
                                                  mindropdownvalue =
                                                      value as String;
                                                });
                                              },
                                              searchInnerWidgetHeight: 20,
                                              buttonHeight: 20,
                                              buttonWidth:
                                                  Constants(context).scrnWidth,
                                              itemHeight: 40,
                                              dropdownMaxHeight: 200,
                                              searchController:
                                                  textEditingController,
                                              searchInnerWidget: Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 8,
                                                  bottom: 4,
                                                  right: 8,
                                                  left: 8,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Padding(
                                  //   padding:
                                  //       const EdgeInsets.only(right: 8, left: 6),
                                  //   child: Container(
                                  //     decoration: BoxDecoration(
                                  //       color: Colors.grey[100],
                                  //       // border: Border.all(
                                  //       //     color: Colors.grey, // Set border color
                                  //       //     width: 1.0),
                                  //       //   color: HexColor("#F9F9F9"),
                                  //       borderRadius: BorderRadius.circular(5),
                                  //     ),
                                  //     height: 50,
                                  //     width: Constants(context).scrnWidth,
                                  //     child: DropdownButton(
                                  //       menuMaxHeight: 200,
                                  //       // hint: "Reference",
                                  //       hint: Padding(
                                  //         padding: const EdgeInsets.all(8.0),
                                  //         child: Text("Min"),
                                  //       ),
                                  //       underline: Container(),
                                  //       // Initial Value
                                  //       value: mindropdownvalue,

                                  //       // Down Arrow Icon
                                  //       // icon: const Icon(
                                  //       //     Icons.keyboard_arrow_down),

                                  //       // Array list of items
                                  //       items: miitems.map((String items) {
                                  //         return DropdownMenuItem(
                                  //           value: items,
                                  //           child: Row(
                                  //             children: [
                                  //               Padding(
                                  //                 padding:
                                  //                     const EdgeInsets.all(16.0),
                                  //                 child: Row(
                                  //                   children: [
                                  //                     Text(items),
                                  //                   ],
                                  //                 ),
                                  //               ),
                                  //               Container(
                                  //                 width: Constants(context)
                                  //                         .scrnWidth *
                                  //                     0.0,
                                  //               )
                                  //             ],
                                  //           ),
                                  //         );
                                  //       }).toList(),
                                  //       // After selecting the desired option,it will
                                  //       // change button value to selected value
                                  //       onChanged: (String? newValue) {
                                  //         setState(() {
                                  //           mindropdownvalue = newValue!;
                                  //         });
                                  //       },
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "",
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 14,
                                        //fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                                if (statusDropdownvalue != "Closed")
                                  // Padding(
                                  //   padding:
                                  //       const EdgeInsets.only(right: 8, left: 6),
                                  //   child: Container(
                                  //     decoration: BoxDecoration(
                                  //       color: Colors.grey[100],
                                  //       // border: Border.all(
                                  //       //     color: Colors.grey, // Set border color
                                  //       //     width: 1.0),
                                  //       //   color: HexColor("#F9F9F9"),
                                  //       borderRadius: BorderRadius.circular(5),
                                  //     ),
                                  //     height: 50,
                                  //     // width: 30,
                                  //     child: DropdownButton(
                                  //       menuMaxHeight: 200,
                                  //       // hint: "Reference",
                                  //       hint: Padding(
                                  //         padding: const EdgeInsets.all(8.0),
                                  //         child: Text("Meridiem"),
                                  //       ),
                                  //       underline: Container(),
                                  //       // Initial Value
                                  //       value: refdropdownvalue,

                                  //       // Down Arrow Icon
                                  //       // icon: const Icon(
                                  //       //     Icons.keyboard_arrow_down),

                                  //       // Array list of items
                                  //       items: refitems.map((String items) {
                                  //         return DropdownMenuItem(
                                  //           value: items,
                                  //           child: Row(
                                  //             children: [
                                  //               Padding(
                                  //                 padding:
                                  //                     const EdgeInsets.all(16.0),
                                  //                 child: Row(
                                  //                   children: [
                                  //                     Text(items),
                                  //                   ],
                                  //                 ),
                                  //               ),
                                  //               Container(
                                  //                   // width:
                                  //                   // Constants(context).scrnWidth *
                                  //                   //     0.0,
                                  //                   )
                                  //             ],
                                  //           ),
                                  //         );
                                  //       }).toList(),
                                  //       // After selecting the desired option,it will
                                  //       // change button value to selected value
                                  //       onChanged: (String? newValue) {
                                  //         setState(() {
                                  //           refdropdownvalue = newValue!;
                                  //         });
                                  //       },
                                  //     ),
                                  //   ),
                                  // ),

                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16, left: 16),
                                    child: Container(
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Container(
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton2(
                                              isExpanded: true,
                                              hint: Text(
                                                'Meridiem',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Theme.of(context)
                                                      .hintColor,
                                                ),
                                              ),
                                              items: refitems
                                                  .map((item) =>
                                                      DropdownMenuItem<String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ))
                                                  .toList(),
                                              value: refdropdownvalue,
                                              onChanged: (value) {
                                                setState(() {
                                                  refdropdownvalue =
                                                      value as String;
                                                });
                                              },
                                              searchInnerWidgetHeight: 20,
                                              buttonHeight: 20,
                                              buttonWidth: 100,
                                              itemHeight: 40,
                                              dropdownMaxHeight: 200,
                                              searchController:
                                                  textEditingController,
                                              searchInnerWidget: Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 8,
                                                  bottom: 4,
                                                  right: 8,
                                                  left: 8,
                                                ),
                                                // child: TextFormField(
                                                //   controller:
                                                //       textEditingController,
                                                //   decoration: InputDecoration(
                                                //     isDense: true,
                                                //     contentPadding:
                                                //         const EdgeInsets
                                                //             .symmetric(
                                                //       horizontal: 10,
                                                //       vertical: 8,
                                                //     ),
                                                //     hintText:
                                                //         'Search for an item...',
                                                //     hintStyle: const TextStyle(
                                                //         fontSize: 12),
                                                //     border: OutlineInputBorder(
                                                //       borderRadius:
                                                //           BorderRadius.circular(
                                                //               8),
                                                //     ),
                                                //   ),
                                                // ),
                                              ),
                                              // searchMatchFn:
                                              //     (item, searchValue) {
                                              //   return (item.value
                                              //       .toString()
                                              //       .contains(searchValue));
                                              // },
                                              //This to clear the search value when you close the menu
                                              // onMenuStateChange: (isOpen) {
                                              //   if (!isOpen) {
                                              //     textEditingController.clear();
                                              //   }
                                              // },
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
                      ],
                    ),
                    if (statusDropdownvalue == "Closed")
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child:
                                Text("Subject", style: TextStyle(fontSize: 16)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 100,
                              width: double.infinity,
                              color: Colors.grey[50],
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, bottom: 0, right: 8, top: 8),
                                child: Text(
                                  widget.subject.toString() == "null"
                                      ? ""
                                      : " " + widget.subject.toString(),
                                  style: TextStyle(color: Colors.grey[900]),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                    if (statusDropdownvalue == "Closed")
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 19.0, bottom: 0, top: 8),
                        child: Text(
                          "End Time",
                          style: TextStyle(color: Colors.grey[900]),
                        ),
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    if (statusDropdownvalue == "Closed")
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Padding(
                                //     padding: const EdgeInsets.only(left: 8.0),
                                //     child: Text(
                                //       "",
                                //       style: TextStyle(
                                //         color: Colors.grey[700],
                                //         fontSize: 14,
                                //         //fontWeight: FontWeight.bold
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Container(
                                    color: Colors.grey[100],
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Container(
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton2(
                                            isExpanded: true,
                                            hint: Text(
                                              'Hour',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color:
                                                    Theme.of(context).hintColor,
                                              ),
                                            ),
                                            items: houritems
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
                                            value: hour2dropdownvalue,
                                            onChanged: (value) {
                                              setState(() {
                                                hour2dropdownvalue =
                                                    value as String;
                                              });
                                            },
                                            searchInnerWidgetHeight: 20,
                                            buttonHeight: 20,
                                            buttonWidth:
                                                Constants(context).scrnWidth,
                                            itemHeight: 40,
                                            dropdownMaxHeight: 200,
                                            searchController:
                                                textEditingController,
                                            searchInnerWidget: Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8,
                                                bottom: 4,
                                                right: 8,
                                                left: 8,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // Padding(
                                //   padding:
                                //       const EdgeInsets.only(right: 8, left: 6),
                                //   child: Container(
                                //     decoration: BoxDecoration(
                                //       color: Colors.grey[100],
                                //       // border: Border.all(
                                //       //     color: Colors.grey, // Set border color
                                //       //     width: 1.0),
                                //       //   color: HexColor("#F9F9F9"),
                                //       borderRadius: BorderRadius.circular(5),
                                //     ),
                                //     height: 50,
                                //     width: Constants(context).scrnWidth,
                                //     child: DropdownButton(
                                //       menuMaxHeight: 200,
                                //       // hint: "Reference",
                                //       hint: Padding(
                                //         padding: const EdgeInsets.all(8.0),
                                //         child: Text("Hour"),
                                //       ),
                                //       underline: Container(),
                                //       // Initial Value
                                //       value: hour2dropdownvalue,

                                //       // Down Arrow Icon
                                //       // icon: const Icon(
                                //       //     Icons.keyboard_arrow_down),

                                //       // Array list of items
                                //       items: houritems.map((String items) {
                                //         return DropdownMenuItem(
                                //           value: items,
                                //           child: Row(
                                //             children: [
                                //               Padding(
                                //                 padding:
                                //                     const EdgeInsets.all(16.0),
                                //                 child: Row(
                                //                   children: [
                                //                     Text(items),
                                //                   ],
                                //                 ),
                                //               ),
                                //               Container(
                                //                 width: Constants(context)
                                //                         .scrnWidth *
                                //                     0.0,
                                //               )
                                //             ],
                                //           ),
                                //         );
                                //       }).toList(),
                                //       // After selecting the desired option,it will
                                //       // change button value to selected value
                                //       onChanged: (String? newValue) {
                                //         setState(() {
                                //           hour2dropdownvalue = newValue!;
                                //         });
                                //       },
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Padding(
                                //     padding: const EdgeInsets.only(left: 8.0),
                                //     child: Text(
                                //       "",
                                //       style: TextStyle(
                                //         color: Colors.grey[700],
                                //         fontSize: 14,
                                //         //fontWeight: FontWeight.bold
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Container(
                                    color: Colors.grey[100],
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Container(
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton2(
                                            isExpanded: true,
                                            hint: Text(
                                              'Min',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color:
                                                    Theme.of(context).hintColor,
                                              ),
                                            ),
                                            items: miitems
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
                                            value: min2dropdownvalue,
                                            onChanged: (value) {
                                              setState(() {
                                                min2dropdownvalue =
                                                    value as String;
                                              });
                                              print(min2dropdownvalue);
                                            },
                                            searchInnerWidgetHeight: 20,
                                            buttonHeight: 20,
                                            buttonWidth:
                                                Constants(context).scrnWidth,
                                            itemHeight: 40,
                                            dropdownMaxHeight: 200,
                                            searchController:
                                                textEditingController,
                                            searchInnerWidget: Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8,
                                                bottom: 4,
                                                right: 8,
                                                left: 8,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // Padding(
                                //   padding:
                                //       const EdgeInsets.only(right: 8, left: 6),
                                //   child: Container(
                                //     decoration: BoxDecoration(
                                //       color: Colors.grey[100],
                                //       // border: Border.all(
                                //       //     color: Colors.grey, // Set border color
                                //       //     width: 1.0),
                                //       //   color: HexColor("#F9F9F9"),
                                //       borderRadius: BorderRadius.circular(5),
                                //     ),
                                //     height: 50,
                                //     width: Constants(context).scrnWidth,
                                //     child: DropdownButton(
                                //       menuMaxHeight: 200,
                                //       // hint: "Reference",
                                //       hint: Padding(
                                //         padding: const EdgeInsets.all(8.0),
                                //         child: Text("Min"),
                                //       ),
                                //       underline: Container(),
                                //       // Initial Value
                                //       value: min2dropdownvalue,

                                //       // Down Arrow Icon
                                //       // icon: const Icon(
                                //       //     Icons.keyboard_arrow_down),

                                //       // Array list of items
                                //       items: miitems.map((String items) {
                                //         return DropdownMenuItem(
                                //           value: items,
                                //           child: Row(
                                //             children: [
                                //               Padding(
                                //                 padding:
                                //                     const EdgeInsets.all(16.0),
                                //                 child: Row(
                                //                   children: [
                                //                     Text(items),
                                //                   ],
                                //                 ),
                                //               ),
                                //               Container(
                                //                 width: Constants(context)
                                //                         .scrnWidth *
                                //                     0.0,
                                //               )
                                //             ],
                                //           ),
                                //         );
                                //       }).toList(),
                                //       // After selecting the desired option,it will
                                //       // change button value to selected value
                                //       onChanged: (String? newValue) {
                                //         setState(() {
                                //           min2dropdownvalue = newValue!;
                                //         });
                                //       },
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    if (statusDropdownvalue == "Closed")
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Container(
                                  color: Colors.grey[100],
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Container(
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          isExpanded: true,
                                          hint: Text(
                                            'Meridiem',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  Theme.of(context).hintColor,
                                            ),
                                          ),
                                          items: refitems
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
                                          value: perdium,
                                          onChanged: (value) {
                                            setState(() {
                                              perdium = value as String;
                                            });
                                          },
                                          searchInnerWidgetHeight: 20,
                                          buttonHeight: 20,
                                          buttonWidth: 100,
                                          itemHeight: 40,
                                          dropdownMaxHeight: 200,
                                          searchController:
                                              textEditingController,
                                          searchInnerWidget: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8,
                                              bottom: 4,
                                              right: 8,
                                              left: 8,
                                            ),
                                          ),
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
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                  // color: Colors.grey[100],
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Container(),
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

                    //  if (statusDropdownvalue == "Closed")

                    if (statusDropdownvalue == "Closed")
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0, top: 16),
                        child: Text(
                          "Notes",
                          style: TextStyle(color: Colors.grey[900]),
                        ),
                      ),
                    if (statusDropdownvalue == "Closed")
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                            height: 160,
                            color: Colors.grey[100],
                            width: Constants(context).scrnWidth,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 300,
                                  child: TextField(
                                    controller: notes,
                                    maxLines: null,
                                    decoration: new InputDecoration.collapsed(
                                        hintText: 'Notes'),
                                    // keyboardType: TextInputType.text,
                                  ),
                                ),
                              ),
                            )),
                      ),

                    // SizedBox(
                    //   height: 200,
                    // ),
                      
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: Constants(context).scrnWidth,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 2, 73, 131),
                                ),
                                onPressed: () {
                                  log(notes.text.toString());
                                  log("jjjjjjjjjjjjjj" +
                                      refdropdownvalue.toString());

                                  if (widget.status != "Closed") {
                                    if (custLead == null) {
                                     
                                      Fluttertoast.showToast(
                                          msg: "Lead / Customer required",
                                          textColor: Colors.black,
                                          backgroundColor: Colors.blue[100]);
                                    }else if(custLead == "Customer" && cusdropdownvalue == null){
                                      Fluttertoast.showToast(
                                          msg: "Customer Name required",
                                           textColor: Colors.black,
                                          backgroundColor: Colors.blue[100]);
                                    }else if(custLead == "Lead" && dropdownvaluesource == null){
                                      Fluttertoast.showToast(
                                          msg: "Lead Name required",
                                           textColor: Colors.black,
                                          backgroundColor: Colors.blue[100]);
                                    }  else if (subject.text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: "Subject Required",
                                          textColor: Colors.black,
                                          backgroundColor: Colors.blue[100]);
                                    } else if (datelll == null) {
                                      Fluttertoast.showToast(
                                          msg: "Dates Required",
                                          textColor: Colors.black,
                                          backgroundColor: Colors.blue[100]);
                                    } else if (hourdropdownvalue == null) {
                                      Fluttertoast.showToast(
                                          msg: "Hour Required",
                                          textColor: Colors.black,
                                          backgroundColor: Colors.blue[100]);
                                    } else if (mindropdownvalue == null) {
                                      Fluttertoast.showToast(
                                          msg: "Min Required",
                                          textColor: Colors.black,
                                          backgroundColor: Colors.blue[100]);
                                    } else if (dropValue != "Me" &&
                                        markedropdownvalue == null) {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Please Assign task",
                                          textColor: Colors.black,
                                          backgroundColor: Colors.blue[100]);
                                    } else {
                                      widget.status != "Closed"
                                          ? addTask()
                                          : addclosedsTask();
                                    }
                                  } else {
                                    if (hour2dropdownvalue == "") {
                                      Fluttertoast.showToast(
                                          msg: "Hour is Required",
                                          textColor: Colors.white,
                                          backgroundColor: Colors.red);
                                    } else if (min2dropdownvalue == "") {
                                      Fluttertoast.showToast(
                                          msg: "MinutRequired",
                                          textColor: Colors.white,
                                          backgroundColor: Colors.red);
                                    } else if (perdium == "") {
                                      Fluttertoast.showToast(
                                          msg: "Merridiem Required",
                                          textColor: Colors.white,
                                          backgroundColor: Colors.red);
                                    } else if (notes.text == "") {
                                      Fluttertoast.showToast(
                                          msg: "Notes is Required",
                                          textColor: Colors.white,
                                          backgroundColor: Colors.red);
                                    }
                                     else {
                                      widget.status != "Closed"
                                          ? addTask()
                                          : addclosedsTask();
                                    }
                                  }

                                  //  log(nextmeetingDate.toString());
                                  // MeetingupdatesaddController().meetingupdates(
                                  //     "widget.name",
                                  //     "",
                                  //     [],
                                  //     "widget.leadtocken.toString()",
                                  //     DateFormat('yyyy-MM-dd')
                                  //         .format(DateTime.parse(datel.toString())),
                                  //     timeinput.text,
                                  //     endtime.text,
                                  //     nextmeetingDate == null
                                  //         ? ""
                                  //         : DateFormat('yyyy-MM-dd').format(
                                  //             DateTime.parse(
                                  //                 nextmeetingDate.toString())));
                                  // // if (ledgernameCon
                                  // //troller!.text == "") {
                                  // //   Fluttertoast.showToast(
                                  // //       msg: "Name Required",
                                  // //       textColor: Colors.white,
                                  // //       backgroundColor: Colors.red);
                                  // // } else if (dropdownValue == "") {
                                  // //   Fluttertoast.showToast(
                                  // //       msg: "Group Required",
                                  // //       textColor: Colors.white,
                                  // //       backgroundColor: Colors.red);
                                  // // } else if (obController!.text == "") {
                                  // //   Fluttertoast.showToast(
                                  // //       msg: "Ob Required",
                                  // //       textColor: Colors.white,
                                  // //       backgroundColor: Colors.red);
                                  // // } else if (desController!.text == "") {
                                  // //   Fluttertoast.showToast(
                                  // //       msg: "Description Required",
                                  // //       textColor: Colors.white,
                                  // //       backgroundColor: Colors.red);
                                  // // } else {
                                  // //   if (widget.isEDIT == "isEDIT") {
                                  // //     update();
                                  // //     print("kkjjjjjjjjjjj" + widget.isEDIT);
                                  // //   } else {
                                  // //     insertCollectionOffline();
                                  // //   }
                                  // // }
                                },
                                child: Text(
                                  'SUBMIT',
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        ),
                      ),
                    ),
                    
                    // DropdownButton<DateTime>(
                    //     hint: Text('Choose A Date'),
                    //     items: ['Choose A Date']
                    //         .map((e) => DropdownMenuItem<DateTime>(child: Text(e)))
                    //         .toList(),
                    //     onChanged: (DateTime? value) {
                    //       setState(() {
                    //         showDatePicker(
                    //                 context: context,
                    //                 initialDate: DateTime.now(),
                    //                 firstDate: DateTime(2001),
                    //                 lastDate: DateTime(2099))
                    //             .then((date) {
                    //           setState(() {
                    //             datel = date;
                    //           });
                    //         });
                    //       });
                    //     }),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future getlac() async {
    print("hiiiiiiiii");
    String u = userId.toString();
    // https://lamit.erpeaz.com/api/resource/Customer Area?filters=[["allocated_by", "=", "1232435456"]] & limit=100
    var baseUrl = urlMain +
        'api/resource/Assign Sale Area?filters=[["sales_officer", "=", "$u"]]&limit=100000"';

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
        productlist = jsonDecode(data)["data"];
      });
      getAllarea(jsonDecode(data)["data"]);
      custview(productlist);
      //  listLedgers((jsonDecode(data)["data"]));
      // log(jsonData.toString());
      // setState(() {});
    }
  }

  Future marketing(laci, leadname) async {
    marketingoffice.clear();
    print("hiiiiiiiii");
    log(laci.toString() + "hhhhhhhhhhhhhhhhh");
    // String u = lac.toString();
    // https://lamit.erpeaz.com/api/resource/Customer Area?filters=[["allocated_by", "=", "1232435456"]] & limit=100
    var baseUrl = urlMain +
        'api/resource/Assign Sale Area?fields=["marketing_officer_name","marketing_officer","marketing_officer_email","sales_officer_email","sales_officer_name"]&filters=[["name","=","$laci"]]';

    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    });
    print(response.body);
    print(response.statusCode);
    log(response.body);
    print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
    if (response.statusCode == 200) {
      print(response.body);
      print("haaaaaaaaaaaaaaaaaaaaaaaaa");
      String data = response.body;
      //  var jsonData;
      setState(() {
        // jsonData = json.decode(data)["data"];
        // laclist = jsonData;

        marketingoffice = jsonDecode(data)["data"];

        for (var i = 0; i < marketingoffice.length; i++) {
          marketingoffice[i]["index"] = i;
          salesofficername = marketingoffice[i]["sales_officer_name"];
          salesofficeremail = marketingoffice[i]["sales_officer_email"];
        }
      });
      //  getAllarea(jsonDecode(data)["data"]);
      //  listLedgers((jsonDecode(data)["data"]));
      // log(jsonData.toString());
      // setState(() {});
    }
  }

  Future getAllarea(var lac) async {
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
    // e 1= la;
    // log(la.toString() +
    //     "gfdghfgfcgghghggjhjhjjjjhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
    // log(l.toString() + "nbnbbbbbbbbnbbnnbbbnbnbnnbbnbnbnbnnbnbnbnb");
    // print(l.toString() + "b bnbnbbnbnnm");

    for (var i = 0; i < l.length; i++) {
      var c = l[i]["name"];
      e.add("$c,$c");
    }
    // log(e.toString() +
    //     "bvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvc");
    // // = l.toString();
    // print("hiiiiiiiii");
    var baseUrl = urlMain +
        'api/resource/Lead?fields=["name","lead_name","lac"]&filters=[["lac", "in", "$e"]]&limit=100000000';
    //'https://lamit.erpeaz.com/api/resource/Lead?fields=["name","lead_name"]&filters=[["lac", "in",["$e"]]]';

    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    });
    // print(response.body);
    // print(response.statusCode);
    // print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
    if (response.statusCode == 200) {
      print(response.body);
      print("haaaaaaaaaaaaaaaaaaaaaaaaa");
      String data = response.body;
      var jsonData;
      setState(() {
        jsonData = json.decode(data)["data"];
        sourcelist = jsonData;
        log(sourcelist.toString() + "jjmhvgnbfdsadsfghj");
        for (var i = 0; i < sourcelist.length; i++) {
          sourceDropDown.add(sourcelist[i]['lead_name']);
          // offLineCustomersIdDropDown.add(offLineCustomers[i]['id'].toString());
          // customerDetails.add({
          //   "address": offLineCustomers[i]['address'],
          //   "vat": offLineCustomers[i]['vatnum'],
          //   "ob": offLineCustomers[i]['balance'].toString()
          // });
          //  array.add(i.toString());
        }
      });

      // log(jsonData.toString());
      //setState(() {});
    }
  }

  // getsf() async {
  getsf() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString("userid");
    getlac();
    // em = preferences.getString("fullname");
    // email = preferences.getString("email");

    // skey = preferences.getString("name");
    // print(skey.toString() + "hhhhhhh");
    // print(userId.toString() +
    //     "hhhhhhhhhhhhhhhdddddddddddddddddddddddddddddddddddddddddd");

    print("haai");
    //leadview("");
    // LeadAPI(akey, skey).login();
    // email = preferences.getString("emailid");
  }

  addTask() async {
    // DateFormat('HH').format(DateTime.parse(time.toString())).toString();
    // log(widget.leadid + "jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj");
    // log(intimehr1.toString());
    // log(min2dropdownvalue.toString());
    // log(intimehr2.toString());
    // log(datelll.toString());
    // log(subject.toString());
    // log(marketingofficename.toString());
    // log(hour2dropdownvalue.toString());
    log('mynote: ' +
        notes.text.toString() +
        hour2dropdownvalue.toString() +
        min2dropdownvalue.toString() +
        perdium.toString());

    final msg = jsonEncode({
      "subject": subject.text,
      "due_date": datelll == null ? "" : datelll.toString(),
      "assign": marketingofficename.toString() == "null"
          ? salesofficername.toString()
          : marketingofficename.toString(),
      "marketing_officer": marketingofficename.toString() == "null"
          ? ""
          : marketingofficename.toString(),
      "assigned_to":
          marketingofficeemail == null ? "" : marketingofficeemail.toString(),
      "sales_officer": dropValue == "Me" ? salesofficername.toString() : "",
      "status": widget.status == "Closed" ? "Closed" : "Open",
      "task_type": "Visit",
      "select_lead": custLead == "Customer" ? "Customer" : "Lead",
      "note": notes.text == "null" ? "" : notes.text.toString(),
      "lead_names":
          dropdownvaluesource == null ? "" : dropdownvaluesource.toString(),
      "select_lead_name": widget.status == "Closed"
          ? widget.leadid.toString()
          : leadname.toString(),
      "assigned_to1": marketingofficeemail == null
          ? salesofficeremail
          : marketingofficeemail.toString(),
      "from_time": hourdropdownvalue.toString() +
          ":" +
          mindropdownvalue.toString() +
          " " +
          refdropdownvalue.toString(),
      "marketing_officer1":
          marketingofficerid == null ? "" : marketingofficerid,
      "sales_officer2": dropValue == "Me" ? userId : "",
      "contact_time_in_hour":
          hourdropdownvalue == null ? "" : hourdropdownvalue.toString(),
      "contact_time_in_min":
          mindropdownvalue == null ? "" : mindropdownvalue.toString(),
      "time2": refdropdownvalue == null ? "" : refdropdownvalue.toString(),
      "contact_to_time_in_hour":
          hour2dropdownvalue == null ? "" : hour2dropdownvalue.toString(),
      "contact_to_time_in_min":
          min2dropdownvalue == null ? "" : min2dropdownvalue.toString(),
      "time1": perdium == null ? "" : perdium.toString(),
      "title": "",
      "lead_location": dropdownvaluesource == null ? "" : lac,
      "customer_location": custarea == null ? "" : custarea,
      "customer_locations": custarea == null ? "" : custarea,
      "select_customer": cleadname == null ? "" : cleadname.toString(),
      "mobile": custnumber == "" ? leadmobile : custnumber,
      "leadorcustomer": custLead == "Customer"
          ? cusdropdownvalue.toString()
          : dropdownvaluesource.toString(),
      "lead_id": dropdownvaluesource == null ? "" : dropdownvaluesource,
    });

    http.Response response = await http.post(
      Uri.parse(urlMain + "api/resource/Task"),
      body: msg,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Tocken,
      },
    );
    log(response.body);
    if (response.statusCode == 200) {
      log(response.body);
      Get.to(HomeView(""));
    }
  }

  addclosedsTask() async {
    // log(widget.leadid.toString().toString() + "bhhjjjjjjjjjjjjj");
    var taskid = widget.leadid;
    // DateFormat('HH').format(DateTime.parse(time.toString())).toString();
    // log(taskid.toString());
    // log(widget.leadid);
    // //log(intimehr1.toString());
    // log(hour2dropdownvalue.toString());
    // log(min2dropdownvalue.toString());
    // //log(intimehr2.toString());
    // log(datelll.toString());
    // log(subject.toString());
    // log(hour2dropdownvalue.toString());
    // log(notes.text);
    // log(perdium.toString());
    // log(leadname.toString());
    // log(statusDropdownvalue.toString());
    // log(widget.leadid.toString() + "ffffffffffffffffffffff");
    // log(widget.ladcust.toString() + "gfffffffffffffffffffffffffff");
    log('mynote: ' +
        notes.text.toString() +
        hour2dropdownvalue.toString() +
        min2dropdownvalue.toString() +
        perdium.toString());
    final msg = jsonEncode({
      "doc_type": widget.ladcust.toString(),

      "reference_doc": taskid.toString(),

      "table_name":
          (widget.ladcust == 'Customer') ? "follow_up" : "meeting_updates2",
// follow_up
      "contact_date": widget.contact_date.toString(),
      //  "status": statusDropdownvalue == "" ? "" : statusDropdownvalue.toString(),

      "notes": notes.text == "null" ? "" : notes.text.toString(),
      "contact_to_time_in_hour":
          hour2dropdownvalue == null ? "" : hour2dropdownvalue.toString(),
      "contact_to_time_in_min":
          min2dropdownvalue == null ? "" : min2dropdownvalue.toString(),
      "time1": perdium == null ? "" : perdium.toString(),
      "task_type": widget.taktype.toString() == "null" ? "" : widget.taktype,
      "from_time": widget.fromtime.toString() == "null" ? "" : widget.fromtime,
      "emp_id": userId.toString(),
      "to_time": hour2dropdownvalue.toString() +
          ":" +
          min2dropdownvalue.toString() +
          " " +
          perdium.toString()
      // "title": "",
    });
    log(taskid);
    http.Response response = await http.post(
      Uri.parse(urlMain + "api/resource/UpdateTable"),
      body: msg,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Tocken,
      },
    );
    log(response.body);
    if (response.statusCode == 200) {
      log(response.body);
      closedsTask();
      Get.to(HomeView(""));
    }
  }

  closedsTask() async {
    // log(widget.name.toString().toString() + "bhhjjjjjjjjjjjjj");
    var taskid = widget.name;
    // DateFormat('HH').format(DateTime.parse(time.toString())).toString();
    // log(taskid.toString());
    // log(widget.leadid);
    //log(intimehr1.toString());
    // log(hour2dropdownvalue.toString());
    // log(min2dropdownvalue.toString());
    //log(intimehr2.toString());
    // log(datelll.toString());
    // log(subject.toString());
    // log(hour2dropdownvalue.toString());
    // log(notes.text);
    // log(perdium.toString());
    // log(leadname.toString());
    // log(statusDropdownvalue.toString());
    // log(widget.leadid.toString() + "ffffffffffffffffffffff");
    // log(widget.ladcust.toString() + "gfffffffffffffffffffffffffff");
    log('mynote: ' +
        notes.text.toString() +
        hour2dropdownvalue.toString() +
        min2dropdownvalue.toString() +
        perdium.toString());
    final msg = jsonEncode({
      "contact_date": widget.contact_date.toString(),
      "status": "Closed",

      "note": notes.text == "null" ? "" : notes.text.toString(),
      "contact_to_time_in_hour":
          hour2dropdownvalue == null ? "" : hour2dropdownvalue.toString(),
      "contact_to_time_in_min":
          min2dropdownvalue == null ? "" : min2dropdownvalue.toString(),
      "time1": perdium == null ? "" : perdium.toString(),
      // "task_type": widget.taktype.toString() == "null" ? "" : widget.taktype,
      // "from_time": widget.fromtime.toString() == "null" ? "" : widget.fromtime,
      // "emp_id": userId.toString(),
      "to_time": hour2dropdownvalue.toString() +
          ":" +
          min2dropdownvalue.toString() +
          " " +
          perdium.toString()
      // "title": "",
    });
    log(taskid);
    http.Response response = await http.put(
      Uri.parse(urlMain + "api/resource/Task/$taskid"),
      body: msg,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Tocken,
      },
    );
    log('rashidaresponse: ' + response.body);
    if (response.statusCode == 200) {
      log(response.body);
      // Get.to(TaskmainviewView());
    }
  }

  custview(var lac) async {
    log("hbbb" + lac.toString());
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
            'api/resource/Customer?fields=["name","lead_name","customer_area"]&filters=[["customer_area", "in","$e"]]&limit=100000&order_by=creation%20desc'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': Tocken,
        });
    String data = response.body;
    log("hiiiiiiiiiiiiiiiiiiiiiii");

    log(data + "nvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv");
    setState(() {
      productList3 = jsonDecode(data)["data"];

      for (var i = 0; i < productList3.length; i++) {
        custDropDown.add(productList3[i]['name']);
        // offLineCustomersIdDropDown.add(offLineCustomers[i]['id'].toString());
        // customerDetails.add({
        //   "address": offLineCustomers[i]['address'],
        //   "vat": offLineCustomers[i]['vatnum'],
        //   "ob": offLineCustomers[i]['balance'].toString()
        // });
        //  array.add(i.toString());
      }
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
}
