import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:lamit/app/modules/customerdetail/views/customerdetail_view.dart';
import 'package:lamit/app/modules/home/views/home_view.dart';

import 'package:lamit/app/routes/constants.dart';
import 'package:lamit/app/widget./title.dart';
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/tocken/tockn.dart';
import 'package:lamit/widget/customeappbar.dart';

class SalesinvoicereportView extends StatefulWidget {
  var array;
  final String restorationId = "main";
  final String custid;
  final String series;
  final String name;
  final String payStatus;
  final String customer;
  final int indexValue;
  String? modeofpay;

  SalesinvoicereportView(this.custid, this.series, this.name, this.customer,
      this.payStatus, this.indexValue);

  @override
  State<SalesinvoicereportView> createState() => _SalesinvoicereportViewState();
}

class _SalesinvoicereportViewState extends State<SalesinvoicereportView>
    with RestorationMixin {
  String? get restorationId => widget.restorationId;
  String? a;
  String? dropdownvaluemode;
  String? userID;

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

  String? datelll;
  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        datelll =
            '${_selectedDate.value.year}-${_selectedDate.value.month}-${_selectedDate.value.day}';
      });
      print(datelll);
    }
  }

  var sourcDropDown = [];
  var distlist = [];
  var arealist = [];
  var jsonData = [];
  var sourcelist = [];
  var jdata = [];

  dynamic taxincamount;
  dynamic totAmount;
  dynamic totAmount2;
  String? modeofpay;
  String nos = "";
  String box = "";
  String? name;
  String startDate = 'Pick Start Date';
  String endDate = 'Pick End Date';
  List<Map<String, dynamic>> offlineSalesReport = [];
  String? productseries;
  String? dropdownvalueArea;
  var sourclist = [];

  var productlist;

  double totalAmount = 0.0;
  double totalReceived = 0.0;
  double totalBAlance = 0.0;
  double height = 0;
  bool visibility = false;
  int pos = 0;
  var items = [];
  String qrData = 'afpc';
  File? qrFile;
  String ticka = "ticked";
  final GlobalKey globalKey = GlobalKey();
  List<Map<String, String>> itemList = [];

  Future<List<int>> _readFontData() async {
    final ByteData bytes = await rootBundle.load('assets/fonts/Arial.ttf');
    return bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
  }

  var settings = [];
  var productitem = [];
  pickDate(String from) async {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        if (from == 'start') {
          startDate = DateFormat('y-MM-dd').format(pickedDate);
        } else {
          endDate = DateFormat('y-MM-dd').format(pickedDate);
        }
      });
    });
  }

  bool isRotated = false;
  bool isChecked = true;

  TextEditingController qtdQntity = TextEditingController();
  TextEditingController qtdPrice = TextEditingController();
  TextEditingController selledquantity = TextEditingController();
  TextEditingController selledPrice = TextEditingController();
  TextEditingController? dmgeQntity;
  TextEditingController? dmgCont;
  TextEditingController? collectedam;
  String? dmg;
  String? collectedamount;
  var array;
  // getA4() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (prefs.getBool('isA4') == null || prefs.getBool('isA4')!) {
  //     setState(() {
  //       isChecked = true;
  //     });
  //   } else {
  //     setState(() {
  //       isChecked = false;
  //     });
  //   }
  // }

  double vatPercent = 0;

  // getSP() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final db = await database;
  //   var settings = await db.query('Setting');
  //   if (prefs.getBool('isVAT') == true) {
  //     vatPercent = double.parse(settings[0]['vat']) / 100;
  //   } else {
  //     vatPercent = 0;
  //   }
  //   getA4();
  // }
  bool value = false;
  bool values = false;
  String? dmgeqntityy;
  var sourceDropDown = [];

  @override
  void initState() {
    getAllArea();
    modeofpayment();

    detailinvoceView();

    //dmgeQntity = new TextEditingController(text: dmgeqntityy);
    log(widget.custid);
    log(widget.customer);
    log(widget.name);
    log(widget.series);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                  builder: (builder) => CustomerdetailView(
                      widget.series, widget.customer, "", widget.indexValue)));
          return true;
        },
        child: Scaffold(
            backgroundColor: Colors.blueGrey[50],
            appBar: PreferredSize(
              preferredSize:
                  Size(MediaQuery.of(context).size.width, kToolbarHeight),
              child: CustomAppBar(
                title: 'DELIVERY NOTE',
              ),
            ),
            body: productlist == null
                ? Container()
                : Stack(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          // height: Constants(context).scrnHeight + 500,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                      child: Text(
                                    'Customer name:   ' + widget.name,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Container(
                                      child: Text(
                                    'Customer area:   ' +
                                        productlist["sale_area"].toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Table(
                                    border: TableBorder.all(),
                                    children: [
                                      TableRow(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text('Product Name'),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text('Qty'),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text('Amount'),
                                        )
                                      ]),
                                      for (int index = 0;
                                          index < productitem.length;index++)
                                        TableRow(children: [
                                          
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Text(productitem[index]
                                                ["item_name"]),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Text(productitem[index]["qty"]
                                                .toString()),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Text(productitem[index]
                                                    ["amount"]
                                                .toString()),
                                          )
                                        ])
                                    ],
                                  ),
                                ),

                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                height: 15,
                                                child: Text("Total amount")),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                height: 15,
                                                child: Text("Tax Inc Amount")),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                height: 15,
                                                child: Text("Grand Total")),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                height: 15, child: Text(":")),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                height: 15, child: Text(":")),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                height: 15, child: Text(":")),
                                          ),
                                        ],
                                      ),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 15,
                                                child:
                                                    Text(totAmount.toString()),
                                              ),
                                            ),
                                            // total_taxes_and_charges
                                            // total
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 15,
                                                child:
                                                    Text(totAmount2.toString()),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 15,
                                                child: Text(
                                                    taxincamount.toString()),
                                              ),
                                            ),
                                          ])
                                    ],
                                  ),
                                ),

                                // Text('Tax incl Amount : $taxincamount'),
                                values == true
                                    ? Container()
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16.0, right: 8),
                                        child: Container(
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 10,
                                              ), //SizedBox
                                              Text(
                                                'Quantity and item  price are different:       ',
                                                style:
                                                    TextStyle(fontSize: 14.0),
                                              ), //Text
                                              SizedBox(width: 10), //SizedBox
                                              /** Checkbox Widget **/
                                              Checkbox(
                                                value: this.value,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    this.value = value!;
                                                    ticka = value.toString();
                                                    log(ticka.toString());
                                                  });
                                                },
                                              ), //Checkbox
                                            ], //<Widget>[]
                                          ),
                                        ),
                                      ),
                                //  if (ticka == "true"&&values)
                                if (value == true)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 00, left: 16, right: 16),
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0.0),
                                                child: Text(
                                                  "Enter quoted quantity",
                                                  style: TextStyle(
                                                    color: Colors.grey[700],
                                                    fontSize: 14,
                                                    // fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 40,
                                              margin: EdgeInsets.all(0),
                                              decoration: BoxDecoration(
                                                // border: Border.all(
                                                //     color: Colors.blue, // Set border color
                                                //     width: 1.0),
                                                color: Colors.white,
                                                //    borderRadius: BorderRadius.circular(20)
                                              ),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextField(
                                                    controller: qtdQntity,
                                                    // controller: ledgernameController,
                                                    textAlign: TextAlign.left,
                                                    keyboardType:
                                                        TextInputType.name,
                                                    decoration: InputDecoration(
                                                      hintText: "",
                                                      // hintStyle: TextStyle(
                                                      //     fontWeight:
                                                      //         FontWeight.bold,
                                                      //     color: Colors.black),
                                                      border: InputBorder.none,
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
                                if (value == true)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 00, left: 16, right: 16),
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0.0),
                                                child: Text(
                                                  "Enter quoted price",
                                                  style: TextStyle(
                                                    color: Colors.grey[700],
                                                    fontSize: 14,
                                                    // fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 40,
                                              margin: EdgeInsets.all(0),
                                              decoration: BoxDecoration(
                                                // border: Border.all(
                                                //     color: Colors.blue, // Set border color
                                                //     width: 1.0),
                                                color: Colors.white,
                                                //    borderRadius: BorderRadius.circular(20)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0, right: 8.0),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: TextField(
                                                    controller: qtdPrice,
                                                    // controller: ledgernameController,
                                                    textAlign: TextAlign.left,
                                                    keyboardType:
                                                        TextInputType.name,
                                                    decoration: InputDecoration(
                                                      hintText: "",
                                                      // hintStyle: TextStyle(
                                                      //     fontWeight:
                                                      //         FontWeight.bold,
                                                      //     color: Colors.black),
                                                      border: InputBorder.none,
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
                                //  if (ticka == "true")
                                if (value == true)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 00, left: 16, right: 16),
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0.0),
                                                child: Text(
                                                  "Sold quantity",
                                                  style: TextStyle(
                                                    color: Colors.grey[700],
                                                    fontSize: 14,
                                                    // fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 40,
                                              margin: EdgeInsets.all(0),
                                              decoration: BoxDecoration(
                                                // border: Border.all(
                                                //     color: Colors.blue, // Set border color
                                                //     width: 1.0),
                                                color: Colors.white,
                                                //    borderRadius: BorderRadius.circular(20)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0, right: 8.0),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: TextField(
                                                    controller: selledquantity,
                                                    // controller: ledgernameController,
                                                    textAlign: TextAlign.left,
                                                    keyboardType:
                                                        TextInputType.name,
                                                    decoration: InputDecoration(
                                                      hintText: "",
                                                      // hintStyle: TextStyle(
                                                      //     fontWeight:
                                                      //         FontWeight.bold,
                                                      //     color: Colors.black),
                                                      border: InputBorder.none,
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
                                if (value == true)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 00, left: 16, right: 16),
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0.0),
                                                child: Text(
                                                  "Sold price",
                                                  style: TextStyle(
                                                    color: Colors.grey[700],
                                                    fontSize: 14,
                                                    // fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 40,
                                              margin: EdgeInsets.all(0),
                                              decoration: BoxDecoration(
                                                // border: Border.all(
                                                //     color: Colors.blue, // Set border color
                                                //     width: 1.0),
                                                color: Colors.white,
                                                //    borderRadius: BorderRadius.circular(20)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0, right: 8.0),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: TextField(
                                                    controller: selledPrice,
                                                    // controller: ledgernameController,
                                                    textAlign: TextAlign.left,
                                                    keyboardType:
                                                        TextInputType.name,
                                                    decoration: InputDecoration(
                                                      hintText: "",
                                                      // hintStyle: TextStyle(
                                                      //     fontWeight:
                                                      //         FontWeight.bold,
                                                      //     color: Colors.black),
                                                      border: InputBorder.none,
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
                                value != false
                                    ? Container()
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16.0, right: 10),
                                        child: Container(
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 10,
                                              ), //SizedBox
                                              Text(
                                                'Quantity and item quoted price are same:',
                                                style:
                                                    TextStyle(fontSize: 14.0),
                                              ), //Text
                                              SizedBox(width: 10), //SizedBox
                                              /** Checkbox Widget **/
                                              Checkbox(
                                                value: this.values,
                                                onChanged: (bool? values) {
                                                  setState(() {
                                                    this.values = values!;
                                                  });
                                                },
                                              ), //Checkbox
                                            ], //<Widget>[]
                                          ),
                                        ),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 00, left: 16, right: 16),
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0.0),
                                              child: Text(
                                                "Damage quantity",
                                                style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize: 14,
                                                  // fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            margin: EdgeInsets.all(0),
                                            decoration: BoxDecoration(
                                              // border: Border.all(
                                              //     color: Colors.blue, // Set border color
                                              //     width: 1.0),
                                              color: Colors.white,
                                              //    borderRadius: BorderRadius.circular(20)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: TextField(
                                                  //controller: qtycontroller,
                                                  controller: dmgeQntity,
                                                  textAlign: TextAlign.left,
                                                  keyboardType:
                                                      TextInputType.name,
                                                  decoration: InputDecoration(
                                                    hintText: ""
                                                    // productlist[
                                                    //     "damage_quantity"],
                                                    ,
                                                    hintStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                    border: InputBorder.none,
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
                                //Row
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 00, left: 16, right: 16),
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10.0),
                                              child: Text(
                                                "Damage percentage (%)",
                                                style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize: 14,
                                                  // fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            margin: EdgeInsets.all(0),
                                            decoration: BoxDecoration(
                                              // border: Border.all(
                                              //     color: Colors.blue, // Set border color
                                              //     width: 1.0),
                                              color: Colors.white,
                                              //    borderRadius: BorderRadius.circular(20)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: TextField(
                                                  controller: dmgCont,
                                                  textAlign: TextAlign.left,
                                                  keyboardType:
                                                      TextInputType.name,
                                                  decoration: InputDecoration(
                                                    hintText: "",
                                                    hintStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                    border: InputBorder.none,
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

                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 00, left: 16, right: 16),
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                "Collected date",
                                                style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize: 14,
                                                  // fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0.0),
                                                      child: Container(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              height: 40,
                                                              margin: EdgeInsets
                                                                  .all(5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                // border: Border.all(
                                                                //     color: Colors
                                                                //         ., // Set border color
                                                                //     width: 1.0),
                                                                //color: HexColor("#F9F9F9"),
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            8.0,
                                                                        right:
                                                                            8.0),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child:
                                                                      Container(
                                                                    width: Constants(
                                                                            context)
                                                                        .scrnWidth,
                                                                    child:
                                                                        TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        //_keyboardVisible = true;
                                                                        _restorableDatePickerRouteFuture
                                                                            .present();
                                                                        a = "${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}";

                                                                        setState(
                                                                            () {
                                                                          a.toString();
                                                                        });
                                                                      },
                                                                      child: datelll ==
                                                                              null
                                                                          ? Text(
                                                                              productlist["collected_date"] == null ? "" : productlist["collected_date"].toString(),
                                                                              style: TextStyle(fontSize: 11, color: Colors.black),
                                                                            )
                                                                          : Text(
                                                                              datelll.toString()),
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
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 00, left: 16, right: 16),
                                    child: Container(
                                      // height: Constants(context).scrnHeight,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0.0),
                                              child: Text(
                                                "Collected amount",
                                                style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize: 14,
                                                  // fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            margin: EdgeInsets.all(0),
                                            decoration: BoxDecoration(
                                              // border: Border.all(
                                              //     color: Colors.blue, // Set border color
                                              //     width: 1.0),
                                              color: Colors.white,
                                              //    borderRadius: BorderRadius.circular(20)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: TextField(
                                                  //controller: qtycontroller,
                                                  controller: collectedam,
                                                  textAlign: TextAlign.left,
                                                  keyboardType:
                                                      TextInputType.name,
                                                  decoration: InputDecoration(
                                                    hintText: "",
                                                    hintStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                    border: InputBorder.none,
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
                                // Padding(
                                //   padding: const EdgeInsets.only(
                                //       left: 16, right: 16),
                                //   child: Container(
                                //     child: Row(
                                //       children: [
                                //         Expanded(
                                //           flex: 2,
                                //           child: Padding(
                                //             padding: const EdgeInsets.all(8.0),
                                //             child: Column(
                                //               crossAxisAlignment:
                                //                   CrossAxisAlignment.start,
                                //               children: [
                                //                 Padding(
                                //                   padding:
                                //                       const EdgeInsets.all(8.0),
                                //                   child: Padding(
                                //                     padding:
                                //                         const EdgeInsets.only(
                                //                             left: 8.0),
                                //                     child: Text(
                                //                       "mode_of_payment",
                                //                       style: TextStyle(
                                //                         color: Colors.grey[700],
                                //                         fontSize: 14,
                                //                         //fontWeight: FontWeight.bold
                                //                       ),
                                //                     ),
                                //                   ),
                                //                 ),
                                //                 Container(
                                //                   height: 33,
                                //                   margin: EdgeInsets.all(5),
                                //                   decoration: BoxDecoration(
                                //                     // border: Border.all(
                                //                     //     color: Colors.blue, // Set border color
                                //                     //     width: 1.0),
                                //                     color: Colors.white,
                                //                     // borderRadius:
                                //                     //     BorderRadius.circular(20)
                                //                   ),
                                //                   child: Padding(
                                //                     padding:
                                //                         const EdgeInsets.all(
                                //                             8.0),
                                //                     child: Row(
                                //                       children: [
                                //                         DropdownButton(
                                //                           //   icon: Icon(Icons.arrow_drop_down),
                                //                           underline:
                                //                               Container(),
                                //                           // itemHeight: 60,
                                //                           hint: Row(
                                //                             children: [
                                //                               Text(
                                //                                   productlist["mode_of_payment3"] ==
                                //                                           "null"
                                //                                       ? ""
                                //                                       : productlist[
                                //                                           "mode_of_payment3"],
                                //                                   style: TextStyle(
                                //                                       fontWeight:
                                //                                           FontWeight
                                //                                               .bold,
                                //                                       color: Colors
                                //                                           .black)),
                                //                               SizedBox(
                                //                                 width: MediaQuery.of(
                                //                                             context)
                                //                                         .size
                                //                                         .width *
                                //                                     0.45,
                                //                               )
                                //                             ],
                                //                           ),

                                //                           items: jsonData
                                //                               .map((item) {
                                //                             // setState(() {
                                //                             //   i = item;
                                //                             // });
                                //                             print(item
                                //                                 .toString());
                                //                             return DropdownMenuItem(
                                //                               value:
                                //                                   item["index"],
                                //                               child: Row(
                                //                                 children: [
                                //                                   Text(item[
                                //                                           "name"]
                                //                                       .toString()),
                                //                                 ],
                                //                               ),
                                //                             );
                                //                           }).toList(),
                                //                           onChanged: (newVal) {
                                //                             setState(() {
                                //                               dropdownvalueArea =
                                //                                   value
                                //                                       .toString();

                                //                               print(newVal
                                //                                   .toString());
                                //                               print(newVal
                                //                                   .toString());
                                //                               name = jsonData[
                                //                                       int.parse(
                                //                                           newVal
                                //                                               .toString())]
                                //                                   ["name"];
                                //                               productseries = jsonData[
                                //                                       int.parse(
                                //                                           newVal
                                //                                               .toString())]
                                //                                   [
                                //                                   "product_series"];

                                //                               //  productdetail(name.toString());

                                //                               // var i;
                                //                               // var a;
                                //                               // for (i = 0;
                                //                               //     i <= arealist.length;
                                //                               //     i++) {
                                //                               //   a = arealist;
                                //                               // }
                                //                               // print(a);

                                //                               // filterproduct(
                                //                               //     dropdownvalueArea.toString());
                                //                             });
                                //                           },
                                //                           value:
                                //                               dropdownvalueArea,
                                //                           icon: const Icon(Icons
                                //                               .keyboard_arrow_down),
                                //                         ),
                                //                       ],
                                //                     ),
                                //                   ),
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),

                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0),
                                                child: Text(
                                                  "Mode of pay",
                                                  style: TextStyle(
                                                    color: Colors.grey[700],
                                                    fontSize: 14,
                                                    // fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height: 52,
                                                          margin:
                                                              EdgeInsets.all(8),
                                                          decoration:
                                                              BoxDecoration(
                                                            // border: Border.all(
                                                            //     color: Colors
                                                            //         .grey, // Set border color
                                                            //     width: 1.0),
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  // margin: EdgeInsets.all(2),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          //color: Colors.white,
                                                                          ),
                                                                  child: CustomSearchableDropDown(
                                                                      primaryColor: Colors.black,
                                                                      items: sourclist,
                                                                      label: modeofpay.toString() == "null" ? "Select Mode of pay" : modeofpay.toString(),
                                                                      labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                                                      showLabelInMenu: true,
                                                                      onChanged: (value) async {
                                                                        setState(
                                                                            () {
                                                                          dropdownvaluemode =
                                                                              value["name"].toString();
                                                                          log(dropdownvaluemode
                                                                              .toString());
                                                                        });
                                                                      },
                                                                      dropDownMenuItems: sourcDropDown == [] ? [''] : sourcDropDown),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // SizedBox(
                                        //   height: 30,
                                        // ),
                                        Container(
                                          height: 50,
                                          width: Constants(context).scrnWidth,
                                          child: ElevatedButton(
                                            child: Text(
                                              (productlist["check"] == 0)
                                                  ? 'SAVE'
                                                  : 'Update',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              primary: Color.fromARGB(
                                                  255, 15, 46, 148),
                                              // side: BorderSide(color: Colors.yellow, width: 5),
                                              textStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontStyle: FontStyle.normal),
                                            ),
                                            onPressed: () {
                                              var i;
                                              // for (i = 0; i <= mapList.length; i++) {
                                              //   finalList.add({
                                              //     "name": mapList[i]["name"],
                                              //     "qty": mapList[i]["qty"],
                                              //     "color": mapList[i]["color"],
                                              //   });
                                              // }
                                              addRequirement(widget.series);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Container(
                                //     child: Expanded(
                                //       child: Container(
                                //         child: Padding(
                                //           padding: const EdgeInsets.all(8.0),
                                //           child: Padding(
                                //             padding: const EdgeInsets.only(top: 100),
                                //             child: Container(
                                //               child: Column(
                                //                 crossAxisAlignment:
                                //                     CrossAxisAlignment.start,
                                //                 children: [
                                //                   // SizedBox(
                                //                   //   height: 30,
                                //                   // ),
                                //                   Center(
                                //                     child: Container(
                                //                       height: 40,
                                //                       width: Constants(context)
                                //                           .scrnWidth,
                                //                       child: ElevatedButton(
                                //                           child: Text(
                                //                             'ADD AS CUSTOMER',
                                //                             style: TextStyle(
                                //                               color: Colors.black,
                                //                               fontSize: 12,
                                //                               //fontStyle: FontStyle.normal
                                //                             ),
                                //                           ),
                                //                           style: ElevatedButton
                                //                               .styleFrom(
                                //                             primary: Colors.blue[50],
                                //                             // side: BorderSide(color: Colors.yellow, width: 5),
                                //                             textStyle: TextStyle(
                                //                                 color: Colors.black,
                                //                                 fontSize: 18,
                                //                                 fontStyle:
                                //                                     FontStyle.normal),
                                //                           ),
                                //                           onPressed: () {}),
                                //                     ),
                                //                   ),
                                //                 ],
                                //               ),
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),

                                // //   Expanded(
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: Padding(
                                //         padding: const EdgeInsets.only(
                                //             top: 00, left: 16, right: 16),
                                //         child: Container(
                                //           child: Column(
                                //             crossAxisAlignment: CrossAxisAlignment.start,
                                //             children: [
                                //               Padding(
                                //                 padding: const EdgeInsets.all(8.0),
                                //                 child: Padding(
                                //                   padding: const EdgeInsets.only(left: 8.0),
                                //                   child: Text(
                                //                     "payment_status",
                                //                     style: TextStyle(
                                //                       color: Colors.grey[700],
                                //                       fontSize: 14,
                                //                       // fontWeight: FontWeight.bold
                                //                     ),
                                //                   ),
                                //                 ),
                                //               ),
                                //               Container(
                                //                 height: 40,
                                //                 margin: EdgeInsets.all(0),
                                //                 decoration: BoxDecoration(
                                //                   // border: Border.all(
                                //                   //     color: Colors.blue, // Set border color
                                //                   //     width: 1.0),
                                //                   color: Colors.white,
                                //                   //    borderRadius: BorderRadius.circular(20)
                                //                 ),
                                //                 child: Padding(
                                //                   padding: const EdgeInsets.only(
                                //                       left: 8.0, right: 8.0),
                                //                   child: Align(
                                //                     alignment: Alignment.centerLeft,
                                //                     child: TextField(
                                //                       //controller: qtycontroller,
                                //                       // controller: ledgernameController,
                                //                       textAlign: TextAlign.left,
                                //                       keyboardType: TextInputType.name,
                                //                       decoration: InputDecoration(
                                //                         hintText:
                                //                             productlist["payment_status"],
                                //                         border: InputBorder.none,
                                //                       ),
                                //                     ),
                                //                   ),
                                //                 ),
                                //               ),
                                //             ],
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ],
                              ]),
                        ),
                      ),
                    ],
                  )));
  }

  detailinvoceView() async {
    print("object");
    var s = widget.custid;
    // var Tocken;
    http.Response response = await http.get(
      Uri.parse(urlMain + "api/resource/Sales Invoice/$s"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Tocken,
      },
    );
    log(response.body + 'rasresponse');
    print(response.statusCode);
    if (response.statusCode == 200) {
      String data = response.body;
      setState(() {
        //baisicDetail = jsonDecode(data)["data"];
        productlist = jsonDecode(data)["data"];
        modeofpay = jsonDecode(data)["data"]["mode_of_payment3"];
        value = jsonDecode(data)["data"]
                    ["quantity_and_item_quoted_price_are_different"] ==
                0
            ? false
            : true;
        values = jsonDecode(data)["data"]
                    ["quantity_and_item_quoted_price_are_same"] ==
                0
            ? false
            : true;
        taxincamount = jsonDecode(data)["data"]["grand_total"];
        totAmount = jsonDecode(data)["data"]["total"];
        print('rasttal: $totAmount');
        totAmount2 = jsonDecode(data)["data"]["total_taxes_and_charges"];
        print('rmtax: $taxincamount');
        productitem = jsonDecode(data)["data"]["items"];
        log('plistt' + productitem.length.toString());
        dmgeqntityy = jsonDecode(data)["data"]["damage_quantity"];
        dmgeQntity = new TextEditingController(text: dmgeqntityy);
        dmg = jsonDecode(data)["data"]["damage"];
        dmgCont = new TextEditingController(text: dmg);
        collectedamount = jsonDecode(data)["data"]["collected_amount"] == null
            ? ""
            : jsonDecode(data)["data"]["collected_amount"];

        dmgCont = new TextEditingController(text: dmg);
        datelll =
            datelll == "" ? "" : jsonDecode(data)["data"]["collected_date"];
        collectedam = new TextEditingController(text: collectedamount);
        dropdownvalueArea = jsonDecode(data)["data"]["mode_of_payment3"] == null
            ? ""
            : jsonDecode(data)["data"]["mode_of_payment3"];
        qtdQntity.text = jsonDecode(data)["data"]["quoted_quantity"] == null
            ? ""
            : jsonDecode(data)["data"]["quoted_quantity"];
        qtdPrice.text = jsonDecode(data)["data"]["quoted_price"] == null
            ? ""
            : jsonDecode(data)["data"]["quoted_price"];
        selledquantity.text =
            jsonDecode(data)["data"]["selled_quantity"] == null
                ? ""
                : jsonDecode(data)["data"]["selled_quantity"];
        selledPrice.text = jsonDecode(data)["data"]["selled_price"] == null
            ? ""
            : jsonDecode(data)["data"]["selled_price"];

        //    "quoted_quantity": qtdQntity.text == "" ? "" : qtdQntity.text,
        // "quoted_price": qtdPrice.text == "" ? "" : qtdPrice.text,
        // "selled_quantity": selledquantity.text == "" ? "" : selledquantity.text,
        // "selled_price": selledPrice.text == "" ? "" : selledPrice.text
      });
      print(productitem.toString() + 'mkmk');
      log(productlist + ': daata');
      log(dmgeQntity.toString() + "bnnmhmhmhmmhm");
      print(data);

      //  baisicDetailView2();
    } else {}
  }

  Future getAllArea() async {
    print("hiiiiiiiii");
    var baseUrl = urlMain + "api/resource/Mode of Payment";

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
      var jsonData;
      setState(() {
        jsonData = json.decode(data)["data"];
        arealist = jsonData;
      });

      // log(jsonData.toString());
      // setState(() {});
    }
  }

  // Future getAllArea() async {
  //   print("hiiiiiiiii");
  //   var baseUrl = 'https://lamit.erpeaz.com/api/resource/Mode of Payment';

  //   http.Response response = await http.get(Uri.parse(baseUrl), headers: {
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': Tocken,
  //   });
  //   print(response.body);
  //   print(response.statusCode);
  //   print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
  //   if (response.statusCode == 200) {
  //     print(response.body);
  //     print("haaaaaaaaaaaaaaaaaaaaaaaaa");
  //     String data = response.body;

  //     setState(() {
  //       jsonData = json.decode(data)["data"];
  //       arealist = jsonData;
  //       for (var i = 0; i <= jsonData.length; i++) {
  //         setState(() {
  //           jsonData[i]["index"] = i;
  //         });

  //         ;
  //       }
  //     });
  //     ;

  //     // log(jsonData.toString());
  //     // setState(() {});
  //   }
  // }

  filterproduct(String productseries) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    var a = productseries.toString();
    var baseUrl = urlMain + 'api/resource/Mode of Payment';

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
        jdata = json.decode(data)["data"];

        arealist = jsonData;
      });

      // log(jsonData.toString());
      // setState(() {});
    }
  }

  Future addRequirement(
    String lead,
  ) async {
    // log(datelll.toString());
    // log("hiiiiiiii" +
    //     DateFormat('yyyy-MM-dd')
    //         .format(DateTime.parse(datelll.toString()))
    //         .toString());
    // log(productlist["collected_date"].toString());
    // log(widget.custid);
    // log(dropdownvaluemode.toString());

    // log(DateFormat('yyyy-MM-dd').format(DateTime.parse(datelll.toString())));
    // print(array[d]["name"]);
    // print(d.toString() + "hbmbhmbmbmnnmnmnm");

    // log(array[d]["qty"].toString() + "mnhbbcfbbbbbbbbbgvgvhbjhjkljiikk");
    var s = widget.custid;
    DateTime now = DateTime.now();
    var baseUrl = urlMain + 'api/resource/Sales Invoice/$s';
    final msg = jsonEncode({
      "quantity_and_item_quoted_price_are_same": values == false ? 0 : 1,
      "quantity_and_item_quoted_price_are_different": value == false ? 0 : 1,
      "damage": dmgCont == "" ? "" : dmgCont!.text,
      "damage_quantity": dmgeQntity!.text == "" ? "" : dmgeQntity!.text,
      "collected_date": datelll == null ? "" : datelll.toString(),
      "collected_amount": collectedam!.text,
      "mode_of_payment3": dropdownvaluemode == "" ? "" : dropdownvaluemode,
      "payment_status": "Collected",
      "quoted_quantity": qtdQntity.text == "" ? "" : qtdQntity.text,
      "quoted_price": qtdPrice.text == "" ? "" : qtdPrice.text,
      "selled_quantity": selledquantity.text == "" ? "" : selledquantity.text,
      "selled_price": selledPrice.text == "" ? "" : selledPrice.text,
      "check": "1"
    });

    http.Response response =
        await http.put(Uri.parse(baseUrl), body: msg, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    });

    print('rashidaresponse' + response.body);
    // print(response.statusCode);
    // print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
    if (response.statusCode == 200) {
      // print(response.body);
      // print("haaaaaaaaaaaaaaaaaaaaaaaaa");
      // String data = response.body;
      if (productlist["check"] == 0) {
        Fluttertoast.showToast(msg: "Delivery note added");
      } else {
        Fluttertoast.showToast(msg: "Delivery note Updated");
      }

      Get.to(CustomerdetailView(
              widget.series, widget.customer, "verify", widget.indexValue))
          // setState(() {
          //   jsonData = json.decode(data)["data"];
          //   arealist = jsonData;
          //   for (var i = 0; i <= jsonData.length; i++) {
          //     setState(() {
          //       jsonData[i]["index"] = i;
          //     });

          //     ;
          //   }
          // });
          ;

      // log(jsonData.toString());
      // setState(() {});
    }
  }

  Future modeofpayment() async {
    print("hiiiiiiiii");
    var baseUrl = urlMain + "api/resource/Mode of Payment";

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
      var jsonData;
      setState(() {
        jsonData = json.decode(data)["data"];
        sourclist = jsonData;

        for (var i = 0; i < sourclist.length; i++) {
          sourcDropDown.add(sourclist[i]['name']);
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
}
