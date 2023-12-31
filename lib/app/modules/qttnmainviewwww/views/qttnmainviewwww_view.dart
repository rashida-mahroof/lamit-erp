import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:lamit/app/modules/salesdetail/views/salesdetail_view.dart';
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/widget/customeappbar.dart';
import 'package:open_filex/open_filex.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:external_path/external_path.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:lamit/app/modules/home/views/home_view.dart';
import 'package:lamit/app/routes/constants.dart';

import 'package:http/http.dart' as http;
import 'package:lamit/tocken/tockn.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Quotationpdf/pdf.dart';

class QttnmainviewwwwView extends StatefulWidget {
  final String leadtock;
  final String leadid;
  final String name;

  const QttnmainviewwwwView(this.leadtock, this.leadid, this.name);

  @override
  State<QttnmainviewwwwView> createState() => _QttnmainviewwwwViewState();
}

class _QttnmainviewwwwViewState extends State<QttnmainviewwwwView> {
  String? a;
  String? mopprice;
  String? mrp;
  String? brand;
  var pdfData = ["mfmgm"];
  String? dropdownvaluemode;
  String? tax;
  String? check;
  String? userID;
  String? subdealer;
  String? deler;
  var leadlist;
  var pat;
  var plist = [];
  var sourclist = [];
  String? fullname;
  String? modeofpay;
  var sourcelist = [];
  var sourceDropDown = [];
  var path;
  String? dropdownvaluesource;
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
  // void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
  //   registerForRestoration(_selectedDate, 'selected_date');
  //   registerForRestoration(
  //       _restorableDatePickerRouteFuture, 'date_picker_route_future');
  // }

  String? datelll;
  DateTime? datel;
  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        datel = newSelectedDate;
        datelll =
            'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}';
      });
    }
  }

  DateTime now = DateTime.now();

  var distlist = [];
  var arealist = [];
  var jsonData = [];
  var complist;
  var jdata = [];
  String nos = "";
  String box = "";
  String? name;
  var productlist;
  //var i;
  String? productseries;
  List<Map<String, dynamic>> mapList = [];
  List<Map<String, dynamic>> finalList = [];
  TextEditingController qtycontroller = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController veh = TextEditingController();
  var sourcDropDown = [];
  String? dropdownvalueArea;
  String? dropdownvalueselectne;
  String? vehicledrop;
  var vehtems = [
    'All vehicle permissible',
    'Limited vehicle permissible',
  ];

  @override
  // Future getAllArea() async {
  //   print("hiiiiiiiii");
  //   var baseUrl =
  //       'https://lamit.erpeaz.com/api/resource/Item?limit=1000&filters=[["has_variants", "=", "0"]] &fields=["name","product_series"]';

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
    var a = productseries.toString();
    var baseUrl =
        urlMain + 'api/resource/Item?fields=["name","product_series"]';

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

  productdetail(String productseries) async {
    log(productseries.toString());

    var a = productseries;
    var baseUrl = urlMain + 'api/resource/Item/$a';

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
      log(data);
      setState(() {
        // jsonData = jsonDecode(data)["data"];

        mopprice = jsonDecode(data)["data"]["mop"].toString();
        mrp = jsonDecode(data)["data"]["mrp"].toString();
        brand = jsonDecode(data)["data"]["item_group"].toString();
        tax = jsonDecode(data)["data"]["tax_percentage"].toString();
        subdealer = jsonDecode(data)["data"]["sub_dealer"].toString();
        deler = jsonDecode(data)["data"]["dealer_delivery"].toString();

        //arealist = jsonData;
      });
      log(mopprice.toString() + "bnbb nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");

      // log(jsonData.toString());
      // setState(() {});
    }
  }

  var array;

  Future getlac() async {
    print("hiiiiiiiii");
    // https://lamit.erpeaz.com/api/resource/Customer Area?filters=[["allocated_by", "=", "1232435456"]] & limit=100
    var baseUrl = urlMain +
        'api/resource/Assign Sale Area?filters=[["sales_officer", "=", "$userID"]]&limit=100000"';

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
      log(data + "nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
      var jsonData;
      setState(() {
        array = json.decode(data)["data"];

        // for (var i = 0; i < laclist.length; i++) {
        //   lacDropDown.add(laclist[i]['name']);
        //   // offLineCustomersIdDropDown.add(offLineCustomers[i]['id'].toString());
        //   // customerDetails.add({
        //   //   "address": offLineCustomers[i]['address'],
        //   //   "vat": offLineCustomers[i]['vatnum'],
        //   //   "ob": offLineCustomers[i]['balance'].toString()
        //   // });
        //   array.add(i.toString());
        // }
      });

      // log(jsonData.toString());
      // setState(() {});
    }
  }

  var array2;
  getfullarea(String area) async {
    var baseUrl = urlMain +
        'api/resource/Assign Sale Area?filters=[["sales_officer", "=", "$userID"]]&limit=100000"';

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
      log(data + "nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
      var jsonData;
      setState(() {
        array2 = json.decode(data)["data"];

        // for (var i = 0; i < laclist.length; i++) {
        //   lacDropDown.add(laclist[i]['name']);
        //   // offLineCustomersIdDropDown.add(offLineCustomers[i]['id'].toString());
        //   // customerDetails.add({
        //   //   "address": offLineCustomers[i]['address'],
        //   //   "vat": offLineCustomers[i]['vatnum'],
        //   //   "ob": offLineCustomers[i]['balance'].toString()
        //   // });
        //   array.add(i.toString());
        // }
      });

      // log(jsonData.toString());
      // setState(() {});
    }
  }

  String? email;
  getsf() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    email = preferences.getString("emailid");
    fullname = preferences.getString("fullname");
    userID = preferences.getString("userid");
    log(email.toString() + "bjcffzsxdfghjkl");
    getlac();
    detailinvoceView();
    getPath_1();
    getPath_2();

    //modeofpayment();

    // getAllsource();

    //  getAllArea();
    //  gettaxcharge();

    name = preferences.getString("name");
    //getlac();
    // sales();

    //print(id.toString());
    //print(name.toString());

    // newleadView(id.toString());
  }

  var taxarr;
  @override
  void initState() {
    getsf();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F9F9F9"),
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight),
        child: CustomAppBar(
          title: 'QUOTATION VIEW',
        ),
      ),
      body: productlist == null
          ? Container()
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.only(top: 00),
                child: Container(
                  //color: Colors.blue[50],
                  color: HexColor("#F9F9F9"),
                  child: Container(
                    child: Container(
                        child: Column(
                      //  mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        // SizedBox(
                        //   height: 10,
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  // GestureDetector(
                                  //     onTap: () {
                                  //       Get.to(SalesdetailView(widget.name,
                                  //           "qt", "0", "", "", widget.leadid));
                                  //     },
                                  //     child: Container(
                                  //         child: Icon(Icons.arrow_back))),

                                  // Padding(
                                  //   padding: const EdgeInsets.only(left: 8.0),
                                  //   child: Text(
                                  //     "Quotation View",
                                  //     style: TextStyle(
                                  //         color:
                                  //             Color.fromARGB(255, 5, 70, 123),
                                  //         fontSize: 18,
                                  //         fontWeight: FontWeight.bold),
                                  //   ),
                                  // )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                width: 80,
                                                height: 20,
                                                child: Text("Net total")),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                width: 5,
                                                height: 20,
                                                child: Text(":")),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 100,
                                              height: 20,
                                              child: Text(
                                                  productlist["net_total"]
                                                      .toString()),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                width: 80,
                                                height: 20,
                                                child: Text("Tax Amount")),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                width: 5,
                                                height: 20,
                                                child: Text(":")),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 100,
                                              height: 20,
                                              child: Text(productlist[
                                                      "total_taxes_and_charges"]
                                                  .toString()),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                width: 80,
                                                height: 20,
                                                child: Text("Grand Total")),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                width: 5,
                                                height: 20,
                                                child: Text(":")),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Container(
                                              width: 80,
                                              height: 20,
                                              child: Text(
                                                  productlist["grand_total"]
                                                      .toString()),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // Text('notes: ' + productlist["notes"].toString()),
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
                                          Container(
                                            height: 52,
                                            margin: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              // border: Border.all(
                                              //     color:
                                              //         Colors.grey, // Set border color
                                              //     width: 1.0),
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                      // margin: EdgeInsets.all(2),
                                                      decoration: BoxDecoration(
                                                          //color: Colors.white,
                                                          ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text("Company : " +
                                                                    productlist[
                                                                        "company"] ==
                                                                "null"
                                                            ? ""
                                                            : productlist[
                                                                    "company"]
                                                                .toString()),
                                                      )),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 50,
                                              margin: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                // border: Border.all(
                                                //     color: Colors.blue, // Set border color
                                                //     width: 1.0),
                                                color: Colors.white,
                                                // borderRadius:
                                                //     BorderRadius.circular(20)
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Text(DateFormat(
                                                            "dd-MM-yyyy")
                                                        .format(DateTime.parse(
                                                            productlist[
                                                                "transaction_date"])))
                                                  ],
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
                              productlist["valid_till"].toString() == "null"
                                  ? Container()
                                  : Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    margin: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      // border: Border.all(
                                                      //     color:
                                                      //         Colors.grey, // Set border color
                                                      //     width: 1.0),
                                                      //  color: HexColor("#F9F9F9"),
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Container(
                                                        width:
                                                            Constants(context)
                                                                .scrnWidth,
                                                        child: TextButton(
                                                          onPressed: () {},
                                                          child: datelll == null
                                                              ? Text(
                                                                  "Valid Till : " +
                                                                      DateFormat(
                                                                              "dd-MM-yyyy")
                                                                          .format(
                                                                              DateTime.parse(productlist["valid_till"])),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          11,
                                                                      color: Colors
                                                                          .black),
                                                                )
                                                              : Text(
                                                                  "",
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

                              // productlist["note"].toString() == "null"
                              //     ? Container()
                              //     : Row(
                              //         children: [
                              //           Expanded(
                              //             child: Padding(
                              //               padding: const EdgeInsets.all(8.0),
                              //               child: Container(
                              //                 child: Column(
                              //                   crossAxisAlignment:
                              //                       CrossAxisAlignment.start,
                              //                   children: [
                              //                     Container(
                              //                       height: 90,
                              //                       margin: EdgeInsets.all(5),
                              //                       decoration: BoxDecoration(
                              //                         // border: Border.all(
                              //                         //     color:
                              //                         //         Colors.grey, // Set border color
                              //                         //     width: 1.0),
                              //                         //  color: HexColor("#F9F9F9"),
                              //                         color: Colors.white,
                              //                         borderRadius:
                              //                             BorderRadius.circular(
                              //                                 5),
                              //                       ),
                              //                       child: Align(
                              //                         alignment:
                              //                             Alignment.centerLeft,
                              //                         child: Container(
                              //                           width:
                              //                               Constants(context)
                              //                                   .scrnWidth,
                              //                           child: TextButton(
                              //                             onPressed: () {},
                              //                             child: datelll == null
                              //                                 ? Container(
                              //                                     width: 200,
                              //                                     child: Text(
                              //                                       maxLines: 6,
                              //                                       "Note : " +
                              //                                           productlist[
                              //                                               "note"],
                              //                                       style: TextStyle(
                              //                                           fontSize:
                              //                                               11,
                              //                                           color: Colors
                              //                                               .black),
                              //                                     ),
                              //                                   )
                              //                                 : Text(
                              //                                     "",
                              //                                   ),
                              //                           ),
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       ),

                              // // Padding(
                              //   padding: const EdgeInsets.only(
                              //       left: 10.0, right: 14),
                              //   child: Container(
                              //       color: Colors.white,
                              //       height: 50,
                              //       width: Constants(context).scrnWidth,
                              //       child: Padding(
                              //         padding: const EdgeInsets.all(8.0),
                              //         child: Text(
                              //             productlist["all_vehicle_permissible"]
                              //                         .toString() ==
                              //                     "0"
                              //                 ? "Limited vehicle permissible"
                              //                 : "All vehicle permissible"),
                              //       )),
                              // ),
                              // if ((productlist["all_vehicle_permissible"]
                              //         .toString() ==
                              //     "0"))
                              Row(
                                children: [
                                  // Icon(
                                  //   Icons.person_add,
                                  //   color: Colors.black,
                                  //   size: 17,
                                  // ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 00),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0, bottom: 8),
                                                  child: Text(
                                                    "Possible Vehicle Service ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            productlist["all"].toString() == "0"
                                                ? Container()
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                        productlist["all"] == 1
                                                            ? "All"
                                                            : "".toString()),
                                                  ),
                                            productlist["goods_ape"]
                                                        .toString() ==
                                                    "0"
                                                ? Container()
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(productlist[
                                                                "goods_ape"] ==
                                                            1
                                                        ? "Goods ape"
                                                        : "".toString()),
                                                  ),
                                            plist[0]["sml_isuzu"].toString() ==
                                                    "0"
                                                ? Container()
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(productlist[
                                                                "sml_isuzu"] ==
                                                            1
                                                        ? "Sml isuzu"
                                                        : "".toString()),
                                                  ),
                                            productlist["mahindra_mini_truck"]
                                                        .toString() ==
                                                    "0"
                                                ? Container()
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(productlist[
                                                                "mahindra_mini_truck"] ==
                                                            1
                                                        ? "Mahindra mini truck"
                                                        : "".toString()),
                                                  ),
                                            productlist["mahindra_jeeto_plus"]
                                                        .toString() ==
                                                    "0"
                                                ? Container()
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(productlist[
                                                                "mahindra_jeeto_plus"] ==
                                                            1
                                                        ? "Mahindra jeeto plus"
                                                        : "".toString()),
                                                  ),
                                            productlist["tata_ace"]
                                                        .toString() ==
                                                    "0"
                                                ? Container()
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(productlist[
                                                                "tata_ace"] ==
                                                            1
                                                        ? "Tata ace"
                                                        : "".toString()),
                                                  ),
                                            productlist["mahindra_bolero_pickups"]
                                                        .toString() ==
                                                    "0"
                                                ? Container()
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(productlist[
                                                                "mahindra_bolero_pickups"] ==
                                                            1
                                                        ? "Mahindra bolero pickups"
                                                        : "".toString()),
                                                  ),
                                            productlist["tata_407"]
                                                        .toString() ==
                                                    "0"
                                                ? Container()
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(productlist[
                                                                "tata_407"] ==
                                                            1
                                                        ? "Tata 407"
                                                        : "".toString()),
                                                  ),
                                            productlist["eicher"].toString() ==
                                                    "0"
                                                ? Container()
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                        productlist["eicher"] ==
                                                                1
                                                            ? "Eicher"
                                                            : "".toString()),
                                                  ),
                                            productlist["bharat_benz"]
                                                        .toString() ==
                                                    "0"
                                                ? Container()
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(productlist[
                                                                "bharat_benz"] ==
                                                            1
                                                        ? "Bharat benz"
                                                        : "".toString()),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  // // Expanded(
                                  //   child: Container(
                                  //       // child: Center(
                                  //       // child:
                                  //       ),
                                  // ),

                                  //   Expanded(
                                  //     child: Padding(
                                  //       padding: const EdgeInsets.all(8.0),
                                  //       child: Padding(
                                  //         padding: const EdgeInsets.only(top: 20),
                                  //         child: Column(
                                  //           crossAxisAlignment: CrossAxisAlignment.start,
                                  //           children: [
                                  //             Padding(
                                  //               padding: const EdgeInsets.all(8.0),
                                  //               child: Padding(
                                  //                 padding:
                                  //                     const EdgeInsets.only(left: 8.0),
                                  //                 child: Text(
                                  //                   "",
                                  //                   style: TextStyle(
                                  //                     color: Colors.grey[700],
                                  //                     fontSize: 14,
                                  //                     // fontWeight: FontWeight.bold
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //             GestureDetector(
                                  //               onTap: () {},
                                  //               child: Container(
                                  //                 height: 50,
                                  //                 width: 200,
                                  //                 // margin: EdgeInsets.all(5),
                                  //                 decoration: BoxDecoration(
                                  //                     // border: Border.all(
                                  //                     //     color: Colors.blue, // Set border color
                                  //                     //     width: 1.0),
                                  //                     //    color: Colors.grey[50],
                                  //                     //    borderRadius: BorderRadius.circular(20)
                                  //                     ),
                                  //                 child: Padding(
                                  //                   padding: const EdgeInsets.only(),
                                  //                   child: Align(
                                  //                     //alignment: Alignment.centerLeft,
                                  //                     child: Row(
                                  //                       children: [
                                  //                         // SizedBox(
                                  //                         //   height: 10,
                                  //                         // ),
                                  //                         //Icon(Icons.add_rounded),

                                  //                         productseries == null
                                  //                             ? Container()
                                  //                             : Expanded(
                                  //                                 child: Card(
                                  //                                     child: Container(
                                  //                                         height: 70,
                                  //                                         //  width: 150,
                                  //                                         color: Colors
                                  //                                             .white,
                                  //                                         child: Padding(
                                  //                                           padding:
                                  //                                               const EdgeInsets
                                  //                                                       .all(
                                  //                                                   8.0),
                                  //                                           child: Text(
                                  //                                               productseries
                                  //                                                   .toString()),
                                  //                                         ))),
                                  //                               )
                                  //                       ],
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                ],
                              ),
                              productlist["note"].toString() == "null"
                                  ? Container()
                                  : Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 90,
                                                    margin: EdgeInsets.all(0),
                                                    decoration: BoxDecoration(
                                                      // border: Border.all(
                                                      //     color:
                                                      //         Colors.grey, // Set border color
                                                      //     width: 1.0),
                                                      //  color: HexColor("#F9F9F9"),
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Container(
                                                        width:
                                                            Constants(context)
                                                                .scrnWidth,
                                                        child: TextButton(
                                                          onPressed: () {},
                                                          child: datelll == null
                                                              ? Container(
                                                                  width: 200,
                                                                  child: Text(
                                                                    maxLines: 6,
                                                                    "Note : " +
                                                                        productlist[
                                                                            "note"],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            11,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                )
                                                              : Text(
                                                                  "",
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

                              plist.length == 0
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16.0, right: 40),
                                      child: Container(
                                        child: ExpansionTile(
                                          title: Text(
                                            "Billing Details",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          children: <Widget>[
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    plist.length == 0
                                                        ? Container()
                                                        : Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 16,
                                                                    right: 16),
                                                            child: Container(
                                                              color: Colors
                                                                  .grey[100],
                                                              height: 50,
                                                              width: Constants(
                                                                      context)
                                                                  .scrnWidth,
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Container(
                                                                    width: 100,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              14),
                                                                      child: Container(
                                                                          child: Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(
                                                                            "ITEM",
                                                                            style:
                                                                                TextStyle(fontSize: 10),
                                                                          ),
                                                                        ),
                                                                      )),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                      width: 70,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(10.0),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child: Text(
                                                                              "QTY",
                                                                              style: TextStyle(color: Colors.black, fontSize: 10)),
                                                                        ),
                                                                      )),
                                                                  Container(
                                                                      width: 70,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(16.0),
                                                                        child: Text(
                                                                            "SERIES",
                                                                            style:
                                                                                TextStyle(fontSize: 10)),
                                                                      )),
                                                                  Container(
                                                                      width: 70,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(16.0),
                                                                        child: Text(
                                                                            "PRICE",
                                                                            style:
                                                                                TextStyle(fontSize: 10)),
                                                                      )),
                                                                  Container(
                                                                      width: 70,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child: Text(
                                                                            "Subtotal",
                                                                            style:
                                                                                TextStyle(fontSize: 10)),
                                                                      )),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                    plist.length == 0
                                                        ? Container(
                                                            // color: Colors.red,

                                                            )
                                                        : Container(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 12,
                                                                      right:
                                                                          12),
                                                              child: Container(
                                                                height: 100,
                                                                width: Constants(
                                                                        context)
                                                                    .scrnWidth,
                                                                child: ListView
                                                                    .builder(
                                                                        // physics:
                                                                        //     NeverScrollableScrollPhysics(),
                                                                        itemCount:
                                                                            plist
                                                                                .length,
                                                                        itemBuilder:
                                                                            ((context,
                                                                                index) {
                                                                          return Card(
                                                                            child:
                                                                                Container(
                                                                              //  color: Colors.blue[100],
                                                                              height: 140,
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Container(
                                                                                      child: Row(
                                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                                        children: [
                                                                                          Container(
                                                                                              width: 100,
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsets.all(8.0),
                                                                                                child: Text(plist[index]["item_name"] == "" ? "" : plist[index]["item_name"], style: TextStyle(fontSize: 10)),
                                                                                              )),

                                                                                          Container(
                                                                                              width: 70,
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsets.all(4.0),
                                                                                                child: Text(plist[index]["qty"] == "" ? "" : plist[index]["qty"].toString(), style: TextStyle(fontSize: 10)),
                                                                                              )),
                                                                                          Container(width: 70, child: Text(plist[index]["item_series"] == "null" ? "" : plist[index]["item_series"].toString(), style: TextStyle(fontSize: 10))),
                                                                                          Expanded(
                                                                                              flex: 1,
                                                                                              child: Container(
                                                                                                  child: Padding(
                                                                                                padding: const EdgeInsets.all(8.0),
                                                                                                child: Text(plist[index]["rate"] == "null" ? "" : plist[index]["rate"].toString(), style: TextStyle(fontSize: 9)),
                                                                                              ))),
                                                                                          Expanded(
                                                                                              flex: 1,
                                                                                              child: Container(
                                                                                                  child: Padding(
                                                                                                padding: const EdgeInsets.all(8.0),
                                                                                                child: Text(plist[index]["amount"] == "null" ? "" : plist[index]["amount"].toString(), style: TextStyle(fontSize: 9)),
                                                                                              ))),

                                                                                          //     flex: 3,
                                                                                          //     child: Container(
                                                                                          //         child:
                                                                                          //             Padding(
                                                                                          //       padding:
                                                                                          //           const EdgeInsets
                                                                                          //                   .all(
                                                                                          //               8.0),
                                                                                          //       child: Text(
                                                                                          //           mapList[index]["brand"] ==
                                                                                          //                   null
                                                                                          //               ? ""
                                                                                          //               : mapList[index]
                                                                                          //                   [
                                                                                          //                   "brand"],
                                                                                          //           style: TextStyle(
                                                                                          //               fontSize:
                                                                                          //                   9)),
                                                                                          //     ))),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Column(
                                                                                    children: [],
                                                                                  ),
                                                                                  // Expanded(
                                                                                  //     child: Container(
                                                                                  //         child: Padding(
                                                                                  //   padding:
                                                                                  //       const EdgeInsets
                                                                                  //               .all(
                                                                                  //           8.0),
                                                                                  //   child: Row(
                                                                                  //     children: [
                                                                                  //       Text(
                                                                                  //         "SUB DELEAR PRICE :",
                                                                                  //         style:
                                                                                  //             TextStyle(
                                                                                  //           fontSize:
                                                                                  //               9,
                                                                                  //         ),
                                                                                  //       ),
                                                                                  //       Text(
                                                                                  //         mapList[index]["sub_dealer"] ==
                                                                                  //                 "null"
                                                                                  //             ? "PRICE NOT ADDED"
                                                                                  //             : mapList[index]["sub_dealer"].toString(),
                                                                                  //         style: TextStyle(
                                                                                  //             fontSize:
                                                                                  //                 9,
                                                                                  //             fontWeight:
                                                                                  //                 FontWeight.bold),
                                                                                  //       ),
                                                                                  //     ],
                                                                                  //   ),
                                                                                  // ))),
                                                                                  // Expanded(
                                                                                  //     child: Container(
                                                                                  //         child: Row(
                                                                                  //   children: [
                                                                                  //     Padding(
                                                                                  //       padding: const EdgeInsets
                                                                                  //               .only(
                                                                                  //           left:
                                                                                  //               8),
                                                                                  //       child:
                                                                                  //           Text(
                                                                                  //         "DELEAR PRICE :",
                                                                                  //         style:
                                                                                  //             TextStyle(
                                                                                  //           fontSize:
                                                                                  //               9,
                                                                                  //         ),
                                                                                  //       ),
                                                                                  //     ),
                                                                                  //     Text(
                                                                                  //       mapList[index]["dealer_delivery"] ==
                                                                                  //               "null"
                                                                                  //           ? "PRICE NOT ADDED"
                                                                                  //           : mapList[index]
                                                                                  //               [
                                                                                  //               "dealer_delivery"],
                                                                                  //       style: TextStyle(
                                                                                  //           fontSize:
                                                                                  //               9,
                                                                                  //           fontWeight:
                                                                                  //               FontWeight.bold),
                                                                                  //     ),
                                                                                  //   ],
                                                                                  // )))
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        })),
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

                              // plist.length == 0
                              //     ? Container()
                              //     : Padding(
                              //         padding: const EdgeInsets.all(8.0),
                              //         child: Padding(
                              //           padding:
                              //               const EdgeInsets.only(right: 8.0),
                              //           child: Container(
                              //             child: SingleChildScrollView(
                              //               scrollDirection: Axis.horizontal,
                              //               child: Container(
                              //                 child: Column(
                              //                   children: [
                              //                     Padding(
                              //                       padding:
                              //                           const EdgeInsets.only(
                              //                               left: 16,
                              //                               right: 16),
                              //                       child: Container(
                              //                         color: Colors.grey[100],
                              //                         height: 50,
                              //                         width: Constants(context)
                              //                                 .scrnWidth +
                              //                             300,
                              //                         child: Row(
                              //                           crossAxisAlignment:
                              //                               CrossAxisAlignment
                              //                                   .center,
                              //                           children: [
                              //                             Container(
                              //                                 width: 70,
                              //                                 child: Padding(
                              //                                   padding:
                              //                                       const EdgeInsets
                              //                                               .all(
                              //                                           8.0),
                              //                                   child: Padding(
                              //                                     padding:
                              //                                         const EdgeInsets
                              //                                                 .all(
                              //                                             8.0),
                              //                                     child: Text(
                              //                                         "Name",
                              //                                         style: TextStyle(
                              //                                             fontSize:
                              //                                                 10)),
                              //                                   ),
                              //                                 )),
                              //                             Container(
                              //                                 width: 70,
                              //                                 child: Padding(
                              //                                   padding:
                              //                                       const EdgeInsets
                              //                                               .all(
                              //                                           8.0),
                              //                                   child: Padding(
                              //                                     padding:
                              //                                         const EdgeInsets
                              //                                                 .all(
                              //                                             8.0),
                              //                                     child: Text(
                              //                                         "MOP",
                              //                                         style: TextStyle(
                              //                                             fontSize:
                              //                                                 10)),
                              //                                   ),
                              //                                 )),
                              //                             Container(
                              //                                 width: 70,
                              //                                 child: Padding(
                              //                                   padding:
                              //                                       const EdgeInsets
                              //                                               .all(
                              //                                           8.0),
                              //                                   child: Text(
                              //                                       "MRP",
                              //                                       style: TextStyle(
                              //                                           fontSize:
                              //                                               10)),
                              //                                 )),
                              //                             Padding(
                              //                               padding:
                              //                                   const EdgeInsets
                              //                                       .all(8.0),
                              //                               child: Container(
                              //                                   width: 70,
                              //                                   child: Padding(
                              //                                     padding:
                              //                                         const EdgeInsets
                              //                                                 .all(
                              //                                             8.0),
                              //                                     child: Text(
                              //                                       "QTY",
                              //                                       style: TextStyle(
                              //                                           fontSize:
                              //                                               10),
                              //                                     ),
                              //                                   )),
                              //                             ),

                              //                             Container(
                              //                                 width: 70,
                              //                                 child: Text(
                              //                                   "PRICE",
                              //                                   style: TextStyle(
                              //                                       fontSize:
                              //                                           10),
                              //                                 )),
                              //                             Container(
                              //                                 width: 70,
                              //                                 child: Padding(
                              //                                   padding:
                              //                                       const EdgeInsets
                              //                                               .all(
                              //                                           8.0),
                              //                                   child: Text(
                              //                                       "SUB DELEAR PRICE",
                              //                                       style: TextStyle(
                              //                                           fontSize:
                              //                                               10)),
                              //                                 )),
                              //                             Container(
                              //                                 width: 70,
                              //                                 child: Padding(
                              //                                   padding:
                              //                                       const EdgeInsets
                              //                                               .all(
                              //                                           8.0),
                              //                                   child: Text(
                              //                                       "DELEAR PRICE",
                              //                                       style: TextStyle(
                              //                                           fontSize:
                              //                                               10)),
                              //                                 )),
                              //                             // Expanded(
                              //                             //     child: Container(
                              //                             //         child: Padding(
                              //                             //   padding: const EdgeInsets.all(8.0),
                              //                             //   child: Text("BRAND",
                              //                             //       style: TextStyle(fontSize: 10)),
                              //                             // ))),
                              //                             Container(
                              //                                 width: 70,
                              //                                 child: Padding(
                              //                                   padding:
                              //                                       const EdgeInsets
                              //                                               .all(
                              //                                           8.0),
                              //                                   child: Text(
                              //                                     "TAX",
                              //                                     style: TextStyle(
                              //                                         fontSize:
                              //                                             10),
                              //                                   ),
                              //                                 )),
                              //                           ],
                              //                         ),
                              //                       ),
                              //                     ),
                              //                     Padding(
                              //                       padding:
                              //                           const EdgeInsets.all(
                              //                               3.0),
                              //                       child: Container(
                              //                         child: Padding(
                              //                           padding:
                              //                               const EdgeInsets
                              //                                       .only(
                              //                                   left: 12,
                              //                                   right: 12),
                              //                           child: Container(
                              //                             height: 160,
                              //                             width: Constants(
                              //                                         context)
                              //                                     .scrnWidth +
                              //                                 300,
                              //                             child:
                              //                                 ListView.builder(
                              //                                     // physics:
                              //                                     //     NeverScrollableScrollPhysics(),
                              //                                     itemCount: plist
                              //                                         .length,
                              //                                     itemBuilder:
                              //                                         ((context,
                              //                                             index) {
                              //                                       return Padding(
                              //                                         padding:
                              //                                             const EdgeInsets.all(
                              //                                                 2.0),
                              //                                         child:
                              //                                             Container(
                              //                                           decoration:
                              //                                               BoxDecoration(border: Border.all(color: Colors.black)),
                              //                                           // color: Colors.blue[50],
                              //                                           height:
                              //                                               120,
                              //                                           child:
                              //                                               Column(
                              //                                             crossAxisAlignment:
                              //                                                 CrossAxisAlignment.start,
                              //                                             children: [
                              //                                               Padding(
                              //                                                 padding: const EdgeInsets.all(8.0),
                              //                                                 child: Container(
                              //                                                   child: Row(
                              //                                                     crossAxisAlignment: CrossAxisAlignment.center,
                              //                                                     children: [
                              //                                                       Container(width: 70, child: Container(child: Text(plist[index]["product"] == null ? "" : plist[index]["product"].toString(), style: TextStyle(fontSize: 9)))),
                              //                                                       Container(
                              //                                                           width: 70,
                              //                                                           child: Padding(
                              //                                                             padding: const EdgeInsets.all(8.0),
                              //                                                             child: Text(plist[index]["mop"] == null ? "" : plist[index]["mop"].toString(), style: TextStyle(fontSize: 9)),
                              //                                                           )),
                              //                                                       Container(width: 70, child: Text(plist[index]["mrp"] == null ? "" : plist[index]["mrp"].toString(), style: TextStyle(fontSize: 9))),

                              //                                                       Container(
                              //                                                         child: Column(
                              //                                                           crossAxisAlignment: CrossAxisAlignment.start,
                              //                                                           children: [
                              //                                                             Container(
                              //                                                               width: 70,
                              //                                                               height: 50,
                              //                                                               margin: EdgeInsets.all(0),
                              //                                                               decoration: BoxDecoration(
                              //                                                                   // border: Border.all(
                              //                                                                   //     color: Colors.blue, // Set border color
                              //                                                                   //     width: 1.0),
                              //                                                                   // color: Colors.white,
                              //                                                                   //    borderRadius: BorderRadius.circular(20)
                              //                                                                   ),
                              //                                                               child: Align(
                              //                                                                 alignment: Alignment.centerLeft,
                              //                                                                 child: TextField(
                              //                                                                   style: TextStyle(fontSize: 12),
                              //                                                                   controller: qtycontroller,
                              //                                                                   // controller: ledgernameController,
                              //                                                                   textAlign: TextAlign.left,

                              //                                                                   keyboardType: TextInputType.name,
                              //                                                                   decoration: InputDecoration(
                              //                                                                     hintText: "Enter quantity",
                              //                                                                     border: InputBorder.none,
                              //                                                                   ),
                              //                                                                 ),
                              //                                                               ),
                              //                                                             ),
                              //                                                           ],
                              //                                                         ),
                              //                                                       ),
                              //                                                       Container(
                              //                                                         //  width: 70,
                              //                                                         child: Column(
                              //                                                           crossAxisAlignment: CrossAxisAlignment.start,
                              //                                                           children: [
                              //                                                             Container(
                              //                                                               height: 50,
                              //                                                               width: 70,
                              //                                                               margin: EdgeInsets.all(0),
                              //                                                               decoration: BoxDecoration(
                              //                                                                   // border: Border.all(
                              //                                                                   //     color: Colors.blue, // Set border color
                              //                                                                   //     width: 1.0),
                              //                                                                   // color: Colors.white,
                              //                                                                   //    borderRadius: BorderRadius.circular(20)
                              //                                                                   ),
                              //                                                               child: Align(
                              //                                                                 alignment: Alignment.centerLeft,
                              //                                                                 child: TextField(
                              //                                                                   style: TextStyle(fontSize: 11),
                              //                                                                   controller: price,
                              //                                                                   // controller: ledgernameController,
                              //                                                                   textAlign: TextAlign.left,
                              //                                                                   keyboardType: TextInputType.name,
                              //                                                                   decoration: InputDecoration(
                              //                                                                     hintText: "Enter.. ",
                              //                                                                     border: InputBorder.none,
                              //                                                                   ),
                              //                                                                 ),
                              //                                                               ),
                              //                                                             ),
                              //                                                           ],
                              //                                                         ),
                              //                                                       ),

                              //                                                       // Expanded(
                              //                                                       //     flex: 3,
                              //                                                       //     child: Container(
                              //                                                       //         child:
                              //                                                       //             Padding(
                              //                                                       //       padding:
                              //                                                       //           const EdgeInsets
                              //                                                       //                   .all(
                              //                                                       //               8.0),
                              //                                                       //       child: Text(
                              //                                                       //           mapList[index]["brand"] ==
                              //                                                       //                   null
                              //                                                       //               ? ""
                              //                                                       //               : mapList[index]
                              //                                                       //                   [
                              //                                                       //                   "brand"],
                              //                                                       //           style: TextStyle(
                              //                                                       //               fontSize:
                              //                                                       //                   9)),
                              //                                                       //     ))),

                              //                                                       Container(
                              //                                                           width: 70,
                              //                                                           child: Padding(
                              //                                                             padding: const EdgeInsets.all(16.0),
                              //                                                             child: Text(plist[index]["subdealer_price"] == null ? "" : plist[index]["subdealer_price"].toString(), style: TextStyle(fontSize: 10)),
                              //                                                           )),

                              //                                                       Container(
                              //                                                           width: 70,
                              //                                                           child: Padding(
                              //                                                             padding: const EdgeInsets.all(16.0),
                              //                                                             child: Text(plist[index]["dealer_price"] == null ? "" : plist[index]["dealer_price"].toString(), style: TextStyle(fontSize: 10)),
                              //                                                           )),

                              //                                                       Container(
                              //                                                           width: 70,
                              //                                                           child: Padding(
                              //                                                             padding: const EdgeInsets.all(8.0),
                              //                                                             child: Padding(
                              //                                                               padding: const EdgeInsets.all(8.0),
                              //                                                               child: Text(plist[index]["tax"] == null ? "" : plist[index]["tax"].toString(), style: TextStyle(fontSize: 10)),
                              //                                                             ),
                              //                                                           )),
                              //                                                       Container(
                              //                                                           width: 70,
                              //                                                           child: Padding(
                              //                                                             padding: const EdgeInsets.all(8.0),
                              //                                                             child: Padding(
                              //                                                               padding: const EdgeInsets.all(8.0),
                              //                                                               child: IconButton(
                              //                                                                 icon: Icon(
                              //                                                                   size: 18,
                              //                                                                   Icons.add,
                              //                                                                   color: Colors.green,
                              //                                                                 ),
                              //                                                                 onPressed: () {
                              //                                                                   if (dropdownvalueArea == "") {
                              //                                                                     Fluttertoast.showToast(msg: "Select Product");
                              //                                                                   } else if (qtycontroller.text.isEmpty) {
                              //                                                                     Fluttertoast.showToast(msg: "Enter Quantity");
                              //                                                                   } else if (price.text.isEmpty) {
                              //                                                                     Fluttertoast.showToast(msg: "Enter Price");
                              //                                                                   } else {
                              //                                                                     setState(() {
                              //                                                                       // ta = 12;
                              //                                                                       // subtotal = double.parse(qtycontroller.text) * double.parse(price.text);
                              //                                                                       // log(subtotal.toString());

                              //                                                                       // total = double.parse(qtycontroller.text) *
                              //                                                                       //     double.parse(price.text);
                              //                                                                       // log(subtotal.toString());
                              //                                                                       // totals = double.parse(qtycontroller.text) * double.parse(price.text);
                              //                                                                       // total = subtotal == null
                              //                                                                       //     ? 0
                              //                                                                       //     : subtotal! +
                              //                                                                       //         (double.parse(
                              //                                                                       //                 qtycontroller.text) *
                              //                                                                       //             double.parse(price.text));

                              //                                                                       // salestax =
                              //                                                                       //  total * 18.toDouble()!;
                              //                                                                       // taxamount = total - salestax;
                              //                                                                       mapList.add({
                              //                                                                         "item_code": plist[index]["product"] == null ? "" : plist[index]["product"],
                              //                                                                         "item_name": plist[index]["product"] == null ? "" : plist[index]["product"],

                              //                                                                         "item_series": plist[index]["color"] == null ? "" : plist[index]["color"],

                              //                                                                         "description": plist[index]["product"] == null ? "" : plist[index]["product"],
                              //                                                                         "item_group": plist[index]["product_group"] == null ? "" : plist[index]["product_group"].toString(),
                              //                                                                         "image": "",
                              //                                                                         "qty": qtycontroller == "" ? "1" : qtycontroller.text,
                              //                                                                         "dealer_delivery": plist[index]["dealer_price"] == null ? "" : plist[index]["subdealer_price"],
                              //                                                                         "sub_dealer_": plist[index]["subdealer_price"] == null ? "" : plist[index]["subdealer_price"],
                              //                                                                         "mop": plist[index]["mop"] == null ? "" : plist[index]["mop"],
                              //                                                                         "mrp": plist[index]["mrp"] == null ? "" : plist[index]["mop"],
                              //                                                                         "tax_percentage": "12",
                              //                                                                         "uom": "Nos",
                              //                                                                         "price_list_rate": price.text.toString(),
                              //                                                                         "rate": price.text.toString(),

                              //                                                                         "amount": double.parse(qtycontroller.text) * double.parse(price.text)

                              //                                                                         // "name":
                              //                                                                         //     name == null ? "" : name.toString(),
                              //                                                                         // "qty": qtycontroller == ""
                              //                                                                         //     ? "1"
                              //                                                                         //     : qtycontroller.text.toString(),
                              //                                                                         // "color": productseries.toString(),
                              //                                                                         // "mopprice": mopprice.toString(),
                              //                                                                         // "mrp": mrp.toString(),
                              //                                                                         // "brand": brand.toString(),
                              //                                                                         // "tax": tax.toString(),
                              //                                                                         // "subdeler": subdealer.toString(),
                              //                                                                         // "deler": deler.toString(),
                              //                                                                         // "price": price.text.toString(),
                              //                                                                       });
                              //                                                                     });

                              //                                                                     qtycontroller.clear();
                              //                                                                     price.clear();
                              //                                                                   }

                              //                                                                   for (var i = 0; i < mapList.length; i++) {
                              //                                                                     log(mapList[i]["qty"]);
                              //                                                                     log(mapList[i]["price_list_rate"]);

                              //                                                                     setState(() {
                              //                                                                       log(mapList[i]["amount"].toString() + "amount");
                              //                                                                       // totaltd = mapList[i]["amount"];
                              //                                                                       // subto = mapList[i]["amount"];

                              //                                                                       // (double.parse(mapList[i]["qty"])) *
                              //                                                                       //     (double.parse(mapList[i]
                              //                                                                       //         ["price_list_rate"]))
                              //                                                                       // );
                              //                                                                     });

                              //                                                                     //  log(total.toString());

                              //                                                                     ;
                              //                                                                   }
                              //                                                                   // log(totaltd.toString() + "totaltdddddddddddddddddddddd");
                              //                                                                   // log(totaltd.toString());
                              //                                                                   // total = total! + subtotal!;
                              //                                                                   // net = total == null ? 0 * 12 : total! * 0.12 + total!;
                              //                                                                 },
                              //                                                               ),
                              //                                                             ),
                              //                                                           )),
                              //                                                     ],
                              //                                                   ),
                              //                                                 ),
                              //                                               ),
                              //                                               Column(
                              //                                                 children: [],
                              //                                               ),
                              //                                             ],
                              //                                           ),
                              //                                         ),
                              //                                       );
                              //                                     })),

                              //                           ),
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       ),

                              dropdownvalueArea == null
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Container(
                                          child: SingleChildScrollView(
                                            //  scrollDirection: Axis.horizontal,
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 16,
                                                            right: 16),
                                                    child: Container(
                                                      color: Colors.grey[100],
                                                      height: 50,
                                                      width: Constants(context)
                                                          .scrnWidth,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                              child: Container(
                                                                  child:
                                                                      Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text("MOP",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          10)),
                                                            ),
                                                          ))),
                                                          Expanded(
                                                              child: Container(
                                                                  child:
                                                                      Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text("MRP",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10)),
                                                          ))),
                                                          Expanded(
                                                              child: Container(
                                                                  child:
                                                                      Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                                "SUB DELEAR PRICE",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10)),
                                                          ))),
                                                          Expanded(
                                                              child: Container(
                                                                  child:
                                                                      Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                                "DELEAR PRICE",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10)),
                                                          ))),
                                                          // Expanded(
                                                          //     child: Container(
                                                          //         child: Padding(
                                                          //   padding: const EdgeInsets.all(8.0),
                                                          //   child: Text("BRAND",
                                                          //       style: TextStyle(fontSize: 10)),
                                                          // ))),
                                                          Expanded(
                                                              child: Container(
                                                                  child:
                                                                      Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(16.0),
                                                            child: Text(
                                                              "                   TAX",
                                                              style: TextStyle(
                                                                  fontSize: 10),
                                                            ),
                                                          ))),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: Container(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 12,
                                                                right: 12),
                                                        child: Container(
                                                          height: 100,
                                                          width:
                                                              Constants(context)
                                                                  .scrnWidth,
                                                          child:
                                                              ListView.builder(
                                                                  physics:
                                                                      NeverScrollableScrollPhysics(),
                                                                  itemCount: 1,
                                                                  itemBuilder:
                                                                      ((context,
                                                                          index) {
                                                                    return Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              2.0),
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(border: Border.all(color: Colors.black)),
                                                                        // color: Colors.blue[50],
                                                                        height:
                                                                            70,
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Container(
                                                                                child: Row(
                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                  children: [
                                                                                    Expanded(
                                                                                        flex: 3,
                                                                                        child: Container(
                                                                                            child: Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: Text(mopprice == null ? "" : mopprice.toString(), style: TextStyle(fontSize: 9)),
                                                                                        ))),
                                                                                    Expanded(
                                                                                        flex: 3,
                                                                                        child: Container(
                                                                                            child: Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: Text(mrp == null ? "" : mrp.toString(), style: TextStyle(fontSize: 9)),
                                                                                        ))),
                                                                                    // Expanded(
                                                                                    //     flex: 3,
                                                                                    //     child: Container(
                                                                                    //         child:
                                                                                    //             Padding(
                                                                                    //       padding:
                                                                                    //           const EdgeInsets
                                                                                    //                   .all(
                                                                                    //               8.0),
                                                                                    //       child: Text(
                                                                                    //           mapList[index]["brand"] ==
                                                                                    //                   null
                                                                                    //               ? ""
                                                                                    //               : mapList[index]
                                                                                    //                   [
                                                                                    //                   "brand"],
                                                                                    //           style: TextStyle(
                                                                                    //               fontSize:
                                                                                    //                   9)),
                                                                                    //     ))),

                                                                                    Expanded(
                                                                                        flex: 3,
                                                                                        child: Container(
                                                                                            child: Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: Text(subdealer == null ? "not added" : subdealer.toString(), style: TextStyle(fontSize: 10)),
                                                                                        ))),

                                                                                    Expanded(
                                                                                        flex: 3,
                                                                                        child: Container(
                                                                                            child: Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: Text(deler == null ? "not added" : deler.toString(), style: TextStyle(fontSize: 10)),
                                                                                        ))),

                                                                                    Container(
                                                                                        width: 70,
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.all(8.0),
                                                                                            child: Text(tax == null ? "" : tax.toString(), style: TextStyle(fontSize: 10)),
                                                                                          ),
                                                                                        )),

                                                                                    Container(
                                                                                        width: 70,
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.all(8.0),
                                                                                            child: IconButton(
                                                                                              icon: Icon(
                                                                                                Icons.abc,
                                                                                                color: Colors.green,
                                                                                              ),
                                                                                              onPressed: () {},
                                                                                            ),
                                                                                          ),
                                                                                        )),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Column(
                                                                              children: [],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  })),
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

                              Row(
                                children: [
                                  // Icon(
                                  //   Icons.person_add,
                                  //   color: Colors.black,
                                  //   size: 17,
                                  // ),

                                  // dropdownvalueArea == null
                                  //     ? Container()
                                  //     : Expanded(
                                  //         child: Padding(
                                  //           padding: const EdgeInsets.all(8.0),
                                  //           child: Padding(
                                  //             padding: const EdgeInsets.only(
                                  //                 top: 00, left: 6, right: 6),
                                  //             child: Container(
                                  //               child: Column(
                                  //                 crossAxisAlignment:
                                  //                     CrossAxisAlignment.start,
                                  //                 children: [
                                  //                   Container(
                                  //                     height: 50,
                                  //                     margin: EdgeInsets.all(0),
                                  //                     decoration: BoxDecoration(
                                  //                       // border: Border.all(
                                  //                       //     color: Colors.blue, // Set border color
                                  //                       //     width: 1.0),
                                  //                       color: Colors.white,
                                  //                       //    borderRadius: BorderRadius.circular(20)
                                  //                     ),
                                  //                     child: Padding(
                                  //                       padding: const EdgeInsets.only(
                                  //                           left: 8.0, right: 8.0),
                                  //                       child: Align(
                                  //                         alignment:
                                  //                             Alignment.centerLeft,
                                  //                         child: TextField(
                                  //                           controller: qtycontroller,
                                  //                           // controller: ledgernameController,
                                  //                           textAlign: TextAlign.left,
                                  //                           keyboardType:
                                  //                               TextInputType.name,
                                  //                           decoration: InputDecoration(
                                  //                             hintText: "Qty",
                                  //                             border: InputBorder.none,
                                  //                           ),
                                  //                         ),
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                 ],
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),

                                  // Expanded(
                                  //   child: Container(
                                  //       // child: Center(
                                  //       // child:
                                  //       ),
                                  // ),
                                ],
                              ),

                              // Padding(
                              //   padding: const EdgeInsets.all(16.0),
                              //   child: Container(
                              //     color: Colors.grey[300],
                              //     child: Row(
                              //       children: [
                              //         Expanded(
                              //             child: Container(
                              //                 child: Padding(
                              //           padding: const EdgeInsets.all(8.0),
                              //           child: Text("ITEM"),
                              //         ))),
                              //         Expanded(
                              //           child: Container(
                              //               child: Padding(
                              //             padding: const EdgeInsets.all(8.0),
                              //             child: Container(
                              //                 child: Padding(
                              //               padding: const EdgeInsets.all(8.0),
                              //               child: Text("RATE"),
                              //             )),
                              //           )),
                              //         ),
                              //         Expanded(
                              //             child: Container(
                              //                 child: Padding(
                              //           padding: const EdgeInsets.all(8.0),
                              //           child: Text("QTY"),
                              //         ))),
                              //         Expanded(
                              //             child: Container(
                              //                 child: Padding(
                              //           padding: const EdgeInsets.all(8.0),
                              //           child: Text("MOP"),
                              //         ))),
                              //         Expanded(
                              //             child: Container(
                              //                 child: Padding(
                              //           padding: const EdgeInsets.all(8.0),
                              //           child: Text("MRP"),
                              //         ))),
                              //         Expanded(
                              //             child: Container(
                              //                 child: Padding(
                              //           padding: const EdgeInsets.all(8.0),
                              //           child: Text("TAX"),
                              //         )))
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Container(
                              //     height: 120,
                              //     child: ListView.builder(
                              //         itemCount: plist.length,
                              //         itemBuilder: ((context, index) {
                              //           return Card(
                              //             child: Column(
                              //               children: [
                              //                 Row(
                              //                   children: [
                              //                     Expanded(
                              //                         child: Container(
                              //                       child: Padding(
                              //                         padding:
                              //                             const EdgeInsets.all(
                              //                                 8.0),
                              //                         child: Text(plist[index]
                              //                                 ["item_name"]
                              //                             .toString()),
                              //                       ),
                              //                     )),
                              //                     Expanded(
                              //                         child: Container(
                              //                       child: Padding(
                              //                         padding:
                              //                             const EdgeInsets.all(
                              //                                 8.0),
                              //                         child: Text(plist[index][
                              //                                 "price_list_rate"]
                              //                             .toString()),
                              //                       ),
                              //                     )),
                              //                     Expanded(
                              //                         child: Container(
                              //                       child: Padding(
                              //                         padding:
                              //                             const EdgeInsets.all(
                              //                                 8.0),
                              //                         child: Text(plist[index]
                              //                                 ["qty"]
                              //                             .toString()),
                              //                       ),
                              //                     )),
                              //                     Expanded(
                              //                         child: Container(
                              //                       child: Padding(
                              //                         padding:
                              //                             const EdgeInsets.all(
                              //                                 8.0),
                              //                         child: Text(plist[index]
                              //                                 ["mop"]
                              //                             .toString()),
                              //                       ),
                              //                     )),
                              //                     Expanded(
                              //                         child: Container(
                              //                       child: Padding(
                              //                         padding:
                              //                             const EdgeInsets.all(
                              //                                 8.0),
                              //                         child: Text(plist[index]
                              //                                 ["mrp"]
                              //                             .toString()),
                              //                       ),
                              //                     )),
                              //                     Expanded(
                              //                         child: Container(
                              //                       child: Padding(
                              //                         padding:
                              //                             const EdgeInsets.all(
                              //                                 8.0),
                              //                         child: Text(plist[index]
                              //                                     ["tax"] ==
                              //                                 null
                              //                             ? "nill"
                              //                             : tax.toString()),
                              //                       ),
                              //                     ))
                              //                   ],
                              //                 )
                              //               ],
                              //             ),
                              //           );
                              //         })),
                              //   ),
                              // ),
                              productlist["status"] == "Draft"
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Container(
                                        width: Constants(context).scrnWidth,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // getPath_1();
                                            // getPath_2();
                                            // exportPdf("n", "nhn");
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        QuotationPDFView(
                                                            Complist: complist,
                                                            Productlist:
                                                                productlist,
                                                            Leadlist: leadlist,
                                                            Plist: plist)));
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors
                                                .grey[700], // Background color
                                          ),
                                          child: const Text(
                                            'Generate Pdf',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        ),
                                      )),
                              // if (check == "true")
                              //   Row(
                              //     children: [
                              //       Expanded(
                              //         flex: 2,
                              //         child: Padding(
                              //           padding: const EdgeInsets.all(8.0),
                              //           child: Column(
                              //             crossAxisAlignment:
                              //                 CrossAxisAlignment.start,
                              //             children: [
                              //               Container(
                              //                 height: 52,
                              //                 margin: EdgeInsets.all(8),
                              //                 decoration: BoxDecoration(
                              //                   // border: Border.all(
                              //                   //     color: Colors
                              //                   //         .grey, // Set border color
                              //                   //     width: 1.0),
                              //                   color: Colors.white,
                              //                   borderRadius:
                              //                       BorderRadius.circular(5),
                              //                 ),
                              //                 child: Row(
                              //                   children: [
                              //                     Expanded(
                              //                       child: Container(
                              //                         // margin: EdgeInsets.all(2),
                              //                         decoration: BoxDecoration(
                              //                             //color: Colors.white,
                              //                             ),
                              //                         child:
                              //                             CustomSearchableDropDown(
                              //                                 primaryColor:
                              //                                     Colors.black,
                              //                                 items: sourclist,
                              //                                 label: modeofpay.toString() == "null"
                              //                                     ? "Select Mode of pay"
                              //                                     : modeofpay
                              //                                         .toString(),
                              //                                 labelStyle: TextStyle(
                              //                                     fontWeight:
                              //                                         FontWeight
                              //                                             .bold,
                              //                                     color: Colors
                              //                                         .black),
                              //                                 showLabelInMenu:
                              //                                     true,
                              //                                 onChanged:
                              //                                     (value) async {
                              //                                   setState(() {
                              //                                     dropdownvaluemode =
                              //                                         value["name"]
                              //                                             .toString();
                              //                                     log(dropdownvaluemode
                              //                                         .toString());
                              //                                   });
                              //                                 },
                              //                                 dropDownMenuItems:
                              //                                     sourcDropDown ==
                              //                                             []
                              //                                         ? ['']
                              //                                         : sourcDropDown),
                              //                       ),
                              //                     )
                              //                   ],
                              //                 ),
                              //               )
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // if (check == "true")
                              //   Row(
                              //     children: [
                              //       // Icon(
                              //       //   Icons.person_add,
                              //       //   color: Colors.black,
                              //       //   size: 17,
                              //       // ),
                              //       Expanded(
                              //         child: Padding(
                              //           padding: const EdgeInsets.all(8.0),
                              //           child: Padding(
                              //             padding: const EdgeInsets.only(
                              //                 top: 00, left: 6, right: 6),
                              //             child: Container(
                              //               child: Column(
                              //                 crossAxisAlignment:
                              //                     CrossAxisAlignment.start,
                              //                 children: [
                              //                   Container(
                              //                     height: 50,
                              //                     margin: EdgeInsets.all(0),
                              //                     decoration: BoxDecoration(
                              //                       // border: Border.all(
                              //                       //     color: Colors.blue, // Set border color
                              //                       //     width: 1.0),
                              //                       color: Colors.white,
                              //                       //    borderRadius: BorderRadius.circular(20)
                              //                     ),
                              //                     child: Padding(
                              //                       padding:
                              //                           const EdgeInsets.only(
                              //                               left: 8.0,
                              //                               right: 8.0),
                              //                       child: Align(
                              //                         alignment:
                              //                             Alignment.centerLeft,
                              //                         child: TextField(
                              //                           controller:
                              //                               qtycontroller,
                              //                           // controller: ledgernameController,
                              //                           textAlign:
                              //                               TextAlign.left,
                              //                           keyboardType:
                              //                               TextInputType.name,
                              //                           decoration:
                              //                               InputDecoration(
                              //                             hintText:
                              //                                 "Colleted Amount",
                              //                             border:
                              //                                 InputBorder.none,
                              //                           ),
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       ),

                              //       // Expanded(
                              //       //   child: Container(
                              //       //       // child: Center(
                              //       //       // child:
                              //       //       ),
                              //       // ),
                              //     ],
                              //   ),
                              // if (check == "true")
                              //   Row(
                              //     children: [
                              //       // Icon(
                              //       //   Icons.person_add,
                              //       //   color: Colors.black,
                              //       //   size: 17,
                              //       // ),
                              //     ],
                              //   ),
                            ],
                          ),
                        ),
                        if (check == "true")
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 0, left: 20, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // SizedBox(
                                  //   height: 30,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        if (check == "true")
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // SizedBox(
                                  //   height: 30,
                                  // ),
                                  Container(
                                    height: 50,
                                    width: Constants(context).scrnWidth,
                                    child: ElevatedButton(
                                      child: Text('SAVE '),
                                      style: ElevatedButton.styleFrom(
                                        primary:
                                            Color.fromARGB(255, 15, 46, 148),
                                        // side: BorderSide(color: Colors.yellow, width: 5),
                                        textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontStyle: FontStyle.normal),
                                      ),
                                      onPressed: () {
                                        print("hii");
                                        var i;
                                        // for (i = 0; i <= mapList.length; i++) {
                                        //   finalList.add({
                                        //     "name": mapList[i]["name"],
                                        //     "qty": mapList[i]["qty"],
                                        //     "color": mapList[i]["color"],
                                        //   });
                                        // }
                                        // addRequirement(
                                        //     0, mapList, widget.leadtok);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    )),
                  ),
                ),
              ),
            ),
    );
  }

  AddressviewView() async {
    print("object");
    var s = productlist["company"];
    log(s + ",nsbhwvc");
    // var Tocken;
    http.Response response = await http.get(
      Uri.parse(urlMain + 'api/resource/Address/$s-billing'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Tocken,
      },
    );
    log(response.body + "hello biggi problem");
    print(response.statusCode);
    if (response.statusCode == 200) {
      String data = response.body;
      setState(() {
        //baisicDetail = jsonDecode(data)["data"];
        complist = jsonDecode(data)["data"];
      });
      log(complist.toString() + "company123");
      // log(productList[0]["note"]);
      print(data);
      //  baisicDetailView2();
    } else {}
  }

  leadView() async {
    print("object");
    var s = widget.leadid;
    log(s + ",nsbhwvcxyz");
    // var Tocken;
    http.Response response = await http.get(
      Uri.parse(urlMain + 'api/resource/Lead/$s'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Tocken,
      },
    );
    log(response.body + "hello biggi problem");
    print(response.statusCode);
    if (response.statusCode == 200) {
      String data = response.body;
      setState(() {
        //baisicDetail = jsonDecode(data)["data"];
        leadlist = jsonDecode(data)["data"];
      });
      log(leadlist.toString() + "lead");
      // log(productList[0]["note"]);
      print(data);
      //  baisicDetailView2();
    } else {}
  }

  detailinvoceView() async {
    print("object");
    var s = widget.leadtock;
    log(s + ",nsbhwvcxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    // var Tocken;
    http.Response response = await http.get(
      Uri.parse(urlMain + 'api/resource/Quotation/$s'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Tocken,
      },
    );
    log(response.body + "hello biggi problem");
    print(response.statusCode);
    if (response.statusCode == 200) {
      String data = response.body;
      setState(() {
        //baisicDetail = jsonDecode(data)["data"];
        productlist = jsonDecode(data)["data"];
        plist = jsonDecode(data)["data"]["items"];
      });
      log(plist.toString() + 'plisttttttt');
      AddressviewView();
      leadView();
      log(productlist.toString() + "bvgvgbbgvgvvbvvv");
      // log(productList[0]["note"]);
      print(data);
      //  baisicDetailView2();
    } else {}
  }

  // Future<void> exportpdf() async {
  //   final pdf = pw.Document();
  //   final font = await PdfGoogleFonts.nunitoExtraLight();

  //   pdf.addPage(
  //     pw.Page(
  //       build: (pw.Context context) => pw.Center(
  //         child: pw.Text('Hello World!', style: pw.TextStyle(font: font)),
  //       ),
  //     ),
  //   );

  //   var path = '/storage/emulated/0/Documents/lamitsss.pdf';
  //   final file = File(path);
  //   var pdffile = await file.writeAsBytes(await pdf.save());

  //   if (Permission.manageExternalStorage.status ==
  //           PermissionStatus.permanentlyDenied ||
  //       Permission.manageExternalStorage.status == PermissionStatus.denied) {
  //     await Permission.manageExternalStorage.request();
  //   } else {
  //     if (pdfData.length > 0) {
  //       OpenFilex.open(pdffile.path);
  //     } else {
  //       Get.snackbar('No data', 'There is no data found to export',
  //           backgroundColor: Colors.black45, colorText: Colors.white);
  //       HapticFeedback.vibrate();
  //     }
  //   }

  // exportPdf(var data, String heading) async {
  //    final file = File('lamitss.pdf');
  // await file.writeAsBytes(await pdf.save());
  //   final pdf = pw.Document();
  //   final font = await PdfGoogleFonts.nunitoExtraLight();
  //   final ByteData bytes = await rootBundle.load('assets/33.png');
  //   final Uint8List byteList = bytes.buffer.asUint8List();

  //   pdf.addPage(
  //     pw.MultiPage(
  //       crossAxisAlignment: pw.CrossAxisAlignment.center,
  //       maxPages: 50,
  //       build: ((context) => [
  //             pw.Image(
  //                 pw.MemoryImage(
  //                   byteList,
  //                 ),
  //                 //  fit: pw.BoxFit.fitHeight
  //                 height: 80,
  //                 width: 80),
  //             pw.Padding(
  //               padding: pw.EdgeInsets.only(top: 2),
  //               child: pw.Container(
  //                   width: 500,
  //                   height: 40,
  //                   color: PdfColors.grey,
  //                   child: pw.Padding(
  //                       padding: pw.EdgeInsets.only(left: 210, top: 20),
  //                       child: pw.Container(
  //                           // width: 500,
  //                           // height: 40,
  //                           color: PdfColors.grey,
  //                           child: pw.Text("PROFORMA",
  //                               style: pw.TextStyle(
  //                                   font: font,
  //                                   fontWeight: pw.FontWeight.bold,
  //                                   color: PdfColors.white))))),
  //             ),
  //             pw.Container(
  //                 height: 400,
  //                 //width: 500,
  //                 color: PdfColors.black,
  //                 child: pw.Container(
  //                   height: 298,
  //                   color: PdfColors.white,
  //                   child: pw.Row(
  //                       crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                       children: [
  //                         pw.Container(
  //                             width: 1, color: PdfColors.black, height: 369),
  //                         pw.Container(
  //                             width: 240,
  //                             color: PdfColors.white,
  //                             child: pw.Column(
  //                                 crossAxisAlignment:
  //                                     pw.CrossAxisAlignment.start,
  //                                 children: [
  //                                   pw.Container(
  //                                       width: 500,
  //                                       color: PdfColors.white,
  //                                       child: pw.Column(
  //                                           crossAxisAlignment:
  //                                               pw.CrossAxisAlignment.start,
  //                                           children: [
  //                                             pw.Container(
  //                                                 height: 1,
  //                                                 color: PdfColors.black,
  //                                                 width: 480),

  //                                             pw.SizedBox(height: 5),
  //                                             // pw.Container(
  //                                             //     height: 1,
  //                                             //     color: PdfColors.black),
  //                                             pw.SizedBox(height: 5),
  //                                             pw.SizedBox(
  //                                                 width: 190,
  //                                                 child: pw.Container(
  //                                                     child: pw.Paragraph(
  //                                                   //margin: EdgeInsets.only(bottom: 20),
  //                                                   text:
  //                                                       ' Super Stockist 1 : ',
  //                                                   style: pw.TextStyle(
  //                                                       font: font,
  //                                                       fontWeight:
  //                                                           pw.FontWeight.bold,
  //                                                       fontSize: 19),
  //                                                 ))),
  //                                             pw.SizedBox(height: 20),
  //                                             pw.SizedBox(
  //                                                 width: 190,
  //                                                 child: pw.Container(
  //                                                     child: pw.Paragraph(
  //                                                   //margin: EdgeInsets.only(bottom: 20),
  //                                                   text: ' Thayyil',
  //                                                   style: pw.TextStyle(
  //                                                       font: font,
  //                                                       fontSize: 12),
  //                                                 ))),
  //                                             pw.SizedBox(height: 2),
  //                                             pw.SizedBox(
  //                                                 width: 190,
  //                                                 child: pw.Container(
  //                                                     child: pw.Paragraph(
  //                                                   //margin: EdgeInsets.only(bottom: 20),
  //                                                   text: ' chembra',
  //                                                   style: pw.TextStyle(
  //                                                       font: font,
  //                                                       fontSize: 12),
  //                                                 ))),
  //                                             pw.SizedBox(height: 2),
  //                                             pw.SizedBox(
  //                                                 width: 190,
  //                                                 child: pw.Container(
  //                                                     child: pw.Paragraph(
  //                                                   //margin: EdgeInsets.only(bottom: 20),
  //                                                   text: ' kerala',
  //                                                   style: pw.TextStyle(
  //                                                       font: font,
  //                                                       fontSize: 12),
  //                                                 ))),
  //                                             pw.SizedBox(height: 2),
  //                                             pw.SizedBox(
  //                                                 width: 190,
  //                                                 child: pw.Container(
  //                                                     child: pw.Paragraph(
  //                                                   //margin: EdgeInsets.only(bottom: 20),
  //                                                   text: ' India',
  //                                                   style: pw.TextStyle(
  //                                                     fontSize: 12,
  //                                                     font: font,
  //                                                   ),
  //                                                 ))),
  //                                           ])),
  //                                   pw.SizedBox(height: 5),
  //                                   pw.SizedBox(
  //                                       width: 190,
  //                                       child: pw.Container(
  //                                           child: pw.Paragraph(
  //                                         //margin: EdgeInsets.only(bottom: 20),
  //                                         text: ' Quotation For',
  //                                         style: pw.TextStyle(
  //                                             font: font,
  //                                             fontWeight: pw.FontWeight.bold,
  //                                             fontSize: 19),
  //                                       ))),
  //                                   pw.SizedBox(height: 20),
  //                                   pw.SizedBox(
  //                                       width: 190,
  //                                       child: pw.Container(
  //                                           child: pw.Paragraph(
  //                                         //margin: EdgeInsets.only(bottom: 20),
  //                                         text: ' Super Stockist calicut',
  //                                         style: pw.TextStyle(
  //                                           fontSize: 12,
  //                                           font: font,
  //                                         ),
  //                                       ))),
  //                                   pw.SizedBox(height: 2),
  //                                   pw.SizedBox(
  //                                       width: 190,
  //                                       child: pw.Container(
  //                                           child: pw.Paragraph(
  //                                         //margin: EdgeInsets.only(bottom: 20),
  //                                         text: ' kozhikod',
  //                                         style: pw.TextStyle(
  //                                           fontSize: 12,
  //                                           font: font,
  //                                         ),
  //                                       ))),
  //                                   pw.SizedBox(height: 2),
  //                                   pw.SizedBox(
  //                                       width: 190,
  //                                       child: pw.Container(
  //                                           child: pw.Paragraph(
  //                                         //margin: EdgeInsets.only(bottom: 20),
  //                                         text: ' kerala',
  //                                         style: pw.TextStyle(
  //                                           fontSize: 12,
  //                                           font: font,
  //                                         ),
  //                                       ))),
  //                                   pw.SizedBox(height: 2),
  //                                   pw.SizedBox(
  //                                       width: 190,
  //                                       child: pw.Container(
  //                                           child: pw.Paragraph(
  //                                         //margin: EdgeInsets.only(bottom: 20),
  //                                         text: ' India',
  //                                         style: pw.TextStyle(
  //                                           fontSize: 12,
  //                                           font: font,
  //                                         ),
  //                                       ))),
  //                                   pw.Container(
  //                                       height: 1,
  //                                       color: PdfColors.black,
  //                                       width: 480),
  //                                 ])),
  //                         pw.Container(
  //                             width: 1, color: PdfColors.black, height: 369),
  //                         pw.Container(
  //                             width: 240,
  //                             color: PdfColors.white,
  //                             child: pw.Column(
  //                                 crossAxisAlignment:
  //                                     pw.CrossAxisAlignment.start,
  //                                 children: [
  //                                   pw.Container(
  //                                       width: 500,
  //                                       color: PdfColors.white,
  //                                       child: pw.Column(
  //                                           crossAxisAlignment:
  //                                               pw.CrossAxisAlignment.start,
  //                                           children: [
  //                                             pw.Container(
  //                                                 height: 1,
  //                                                 color: PdfColors.black,
  //                                                 width: 480),

  //                                             pw.SizedBox(height: 5),
  //                                             // pw.Container(
  //                                             //     height: 1,
  //                                             //     color: PdfColors.black),
  //                                             pw.SizedBox(height: 5),
  //                                             pw.SizedBox(
  //                                                 width: 190,
  //                                                 child: pw.Container(
  //                                                     child: pw.Paragraph(
  //                                                   //margin: EdgeInsets.only(bottom: 20),
  //                                                   text: ' Date :3/7/2022',
  //                                                   style: pw.TextStyle(
  //                                                     fontSize: 12,
  //                                                     font: font,
  //                                                   ),
  //                                                 ))),
  //                                             pw.SizedBox(height: 2),
  //                                             pw.SizedBox(
  //                                                 width: 190,
  //                                                 child: pw.Container(
  //                                                     child: pw.Paragraph(
  //                                                   //margin: EdgeInsets.only(bottom: 20),
  //                                                   text: ' No of lead:66789',
  //                                                   style: pw.TextStyle(
  //                                                     fontSize: 12,
  //                                                     font: font,
  //                                                   ),
  //                                                 ))),
  //                                             pw.SizedBox(height: 2),

  //                                             pw.Container(
  //                                                 height: 1,
  //                                                 color: PdfColors.black,
  //                                                 width: 480),

  //                                             pw.SizedBox(
  //                                                 width: 190,
  //                                                 child: pw.Container(
  //                                                     height: 90,
  //                                                     child: pw.Row(children: [
  //                                                       pw.Paragraph(
  //                                                         //margin: EdgeInsets.only(bottom: 20),
  //                                                         text:
  //                                                             ' QOUTATION MADE BY :',
  //                                                         style: pw.TextStyle(
  //                                                             font: font,
  //                                                             fontSize: 10,
  //                                                             fontWeight: pw
  //                                                                 .FontWeight
  //                                                                 .bold),
  //                                                       ),
  //                                                       pw.Expanded(
  //                                                           child: pw.Paragraph(
  //                                                         //margin: EdgeInsets.only(bottom: 20),
  //                                                         text: 'Arun',
  //                                                         style: pw.TextStyle(
  //                                                             font: font,
  //                                                             fontSize: 10),
  //                                                       ))
  //                                                     ]))),
  //                                           ])),
  //                                   pw.Container(
  //                                       height: 1,
  //                                       color: PdfColors.black,
  //                                       width: 480),
  //                                   pw.Container(height: 202.5),
  //                                   pw.Container(
  //                                       height: 1,
  //                                       color: PdfColors.black,
  //                                       width: 480),
  //                                 ])),
  //                         pw.Container(
  //                             width: 1, color: PdfColors.black, height: 369),
  //                       ]),
  //                 )),
  //             pw.Container(
  //               color: PdfColors.blue,
  //               child: pw.Row(children: [
  //                 pw.Expanded(
  //                   child: pw.Text('sl No',
  //                       style: pw.TextStyle(
  //                         font: font,
  //                       )),
  //                 ),
  //                 pw.Expanded(
  //                   child: pw.Text('Product',
  //                       style: pw.TextStyle(
  //                         font: font,
  //                       )),
  //                 ),
  //                 pw.Expanded(
  //                   child: pw.Text('Series',
  //                       style: pw.TextStyle(
  //                         font: font,
  //                       )),
  //                 ),
  //                 pw.Expanded(
  //                   child: pw.Text('Qty',
  //                       style: pw.TextStyle(
  //                         font: font,
  //                       )),
  //                 ),
  //                 pw.Expanded(
  //                   child: pw.Text('Total',
  //                       style: pw.TextStyle(
  //                         font: font,
  //                       )),
  //                 ),
  //                 // pw.SizedBox(
  //                 //     width: 75, child: pw.Column(children: [pw.Text("Arundas")]))
  //               ]),
  //             ),
  //             pw.ListView.builder(
  //                 itemBuilder: ((context, i) => pw.Column(children: [
  //                       pw.Row(children: [
  //                         pw.Expanded(
  //                           child: pw.Text('sl No',
  //                               style: pw.TextStyle(
  //                                 font: font,
  //                               )),
  //                         ),
  //                         pw.Expanded(
  //                           child: pw.Text('Product',
  //                               style: pw.TextStyle(
  //                                 font: font,
  //                               )),
  //                         ),
  //                         pw.Expanded(
  //                           child: pw.Text('Series',
  //                               style: pw.TextStyle(
  //                                 font: font,
  //                               )),
  //                         ),
  //                         pw.Expanded(
  //                           child: pw.Text('Qty',
  //                               style: pw.TextStyle(
  //                                 font: font,
  //                               )),
  //                         ),
  //                         pw.Expanded(
  //                           child: pw.Text('Total',
  //                               style: pw.TextStyle(
  //                                 font: font,
  //                               )),
  //                         ),
  //                       ]),
  //                     ])),
  //                 itemCount: 2),
  //             pw.Container(
  //               color: PdfColors.grey,
  //               child: pw.Row(children: [
  //                 pw.Expanded(child: pw.Container()),
  //                 pw.Expanded(child: pw.Container()),
  //                 pw.Expanded(child: pw.Container()),
  //                 pw.Expanded(
  //                   child: pw.Text('Total',
  //                       style: pw.TextStyle(
  //                         font: font,
  //                       )),
  //                 ),
  //                 pw.Expanded(
  //                   child: pw.Text('500',
  //                       style: pw.TextStyle(
  //                         font: font,
  //                       )),
  //                 ),
  //                 // pw.SizedBox(
  //                 //     width: 75, child: pw.Column(children: [pw.Text("Arundas")]))
  //               ]),
  //             ),
  //             pw.Container(
  //                 height: 350,
  //                 //width: 500,
  //                 color: PdfColors.black,
  //                 child: pw.Container(
  //                   height: 298,
  //                   color: PdfColors.white,
  //                   child: pw.Row(
  //                       crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                       children: [
  //                         pw.Container(
  //                             width: 1, color: PdfColors.black, height: 327),
  //                         pw.Container(
  //                             width: 480,
  //                             color: PdfColors.white,
  //                             child: pw.Column(
  //                                 crossAxisAlignment:
  //                                     pw.CrossAxisAlignment.start,
  //                                 children: [
  //                                   pw.Container(
  //                                       width: 500,
  //                                       color: PdfColors.white,
  //                                       child: pw.Column(
  //                                           crossAxisAlignment:
  //                                               pw.CrossAxisAlignment.start,
  //                                           children: [
  //                                             pw.Container(
  //                                                 height: 1,
  //                                                 color: PdfColors.black,
  //                                                 width: 480),

  //                                             //  pw.SizedBox(height: 5),
  //                                             // pw.Container(
  //                                             //     height: 1,
  //                                             //     color: PdfColors.black),
  //                                             // pw.SizedBox(height: 5),
  //                                             pw.SizedBox(
  //                                                 width: 500,
  //                                                 child: pw.Container(
  //                                                     height: 40,
  //                                                     color: PdfColors.blue,
  //                                                     child: pw.Paragraph(
  //                                                       //margin: EdgeInsets.only(bottom: 20),
  //                                                       text:
  //                                                           ' TERMS AND CONDITION :',
  //                                                       style: pw.TextStyle(
  //                                                           font: font,
  //                                                           fontWeight: pw
  //                                                               .FontWeight
  //                                                               .bold,
  //                                                           fontSize: 19),
  //                                                     ))),
  //                                             pw.SizedBox(height: 20),
  //                                             pw.SizedBox(
  //                                                 width: 480,
  //                                                 child: pw.Container(
  //                                                     child: pw.Paragraph(
  //                                                   //margin: EdgeInsets.only(bottom: 20),
  //                                                   text:
  //                                                       '* 30 of total amount should be aid in advance',
  //                                                   style: pw.TextStyle(
  //                                                       fontSize: 12,
  //                                                       font: font),
  //                                                 ))),
  //                                             pw.SizedBox(height: 2),
  //                                             pw.SizedBox(
  //                                                 width: 480,
  //                                                 child: pw.Container(
  //                                                     child: pw.Paragraph(
  //                                                   //margin: EdgeInsets.only(bottom: 20),
  //                                                   text:
  //                                                       '* Balance amount should be paid before container arrival port',
  //                                                   style: pw.TextStyle(
  //                                                       fontSize: 12,
  //                                                       font: font),
  //                                                 ))),
  //                                             pw.SizedBox(height: 2),
  //                                             pw.SizedBox(
  //                                                 width: 480,
  //                                                 child: pw.Container(
  //                                                     child: pw.Paragraph(
  //                                                   //margin: EdgeInsets.only(bottom: 20),
  //                                                   text:
  //                                                       '* Any increase in shipping or purchase charges will result increases in material price',
  //                                                   style: pw.TextStyle(
  //                                                       fontSize: 12,
  //                                                       font: font),
  //                                                 ))),
  //                                             pw.SizedBox(height: 2),
  //                                             pw.SizedBox(
  //                                                 width: 480,
  //                                                 child: pw.Container(
  //                                                     child: pw.Paragraph(
  //                                                   //margin: EdgeInsets.only(bottom: 20),
  //                                                   text:
  //                                                       '* This Qutation is valid for 15 days',
  //                                                   style: pw.TextStyle(
  //                                                       fontSize: 12,
  //                                                       font: font),
  //                                                 ))),
  //                                           ])),
  //                                   pw.SizedBox(height: 5),
  //                                   pw.SizedBox(
  //                                       width: 480,
  //                                       child: pw.Container(
  //                                           child: pw.Paragraph(
  //                                         //margin: EdgeInsets.only(bottom: 20),
  //                                         text:
  //                                             '* Quoted price inclusive of gst and tax',
  //                                         style: pw.TextStyle(
  //                                             font: font,

  //                                             /// fontWeight: pw.FontWeight.bold,
  //                                             fontSize: 12),
  //                                       ))),
  //                                   pw.SizedBox(height: 20),
  //                                   pw.SizedBox(
  //                                       width: 480,
  //                                       child: pw.Container(
  //                                           child: pw.Paragraph(
  //                                         //margin: EdgeInsets.only(bottom: 20),
  //                                         text:
  //                                             '* Transportation is free for delivery',
  //                                         style: pw.TextStyle(
  //                                             fontSize: 12, font: font),
  //                                       ))),
  //                                   pw.SizedBox(height: 2),
  //                                   pw.SizedBox(
  //                                       width: 480,
  //                                       child: pw.Container(
  //                                           child: pw.Paragraph(
  //                                         //margin: EdgeInsets.only(bottom: 20),
  //                                         text:
  //                                             '* unloading is parties responsibility',
  //                                         style: pw.TextStyle(
  //                                             fontSize: 12, font: font),
  //                                       ))),
  //                                   pw.SizedBox(height: 2),
  //                                   pw.SizedBox(
  //                                       width: 480,
  //                                       child: pw.Container(
  //                                           child: pw.Paragraph(
  //                                         //margin: EdgeInsets.only(bottom: 20),
  //                                         text: '* 1% breaking normal',
  //                                         style: pw.TextStyle(
  //                                             fontSize: 12, font: font),
  //                                       ))),
  //                                   pw.SizedBox(height: 2),
  //                                   pw.Container(
  //                                       height: 1,
  //                                       color: PdfColors.black,
  //                                       width: 480),
  //                                 ])),
  //                         pw.Container(
  //                             width: 1, color: PdfColors.black, height: 329),
  //                       ]),
  //                 )),
  //           ]),
  //     ),
  //   );

  //   var path = '/storage/emulated/0/Documents/lamit.pdf';
  //   final file = File(path);
  //   var pdffile = await file.writeAsBytes(await pdf.save());

  //   if (Permission.manageExternalStorage.status ==
  //           PermissionStatus.permanentlyDenied ||
  //       Permission.manageExternalStorage.status == PermissionStatus.denied) {
  //     await Permission.manageExternalStorage.request();
  //   } else {
  //     if (pdfData.length > 0) {
  //       OpenFilex.open(pdffile.path);
  //     } else {
  //       Get.snackbar('No data', 'There is no data found to export',
  //           backgroundColor: Colors.black45, colorText: Colors.white);
  //       HapticFeedback.vibrate();
  //     }
  //   }
  // }
  exportPdf(var data, String heading) async {
    final pdf = pw.Document();
    final ByteData bytes = await rootBundle.load('assets/33.png');
    final Uint8List byteList = bytes.buffer.asUint8List();
    final font = await PdfGoogleFonts.nunitoExtraLight();
    pdf.addPage(
      pw.MultiPage(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        maxPages: 50,
        build: ((context) => [
              pw.Image(
                  pw.MemoryImage(
                    byteList,
                  ),
                  //  fit: pw.BoxFit.fitHeight
                  height: 80,
                  width: 80),
              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                  color: PdfColors.white,
                ),
                child: pw.ListView.builder(
                  itemCount: 1,
                  itemBuilder: ((context, i) => pw.Column(children: [
                        //  pw.SizedBox(height: 2, width: 2),
                        pw.Row(children: [
                          pw.Expanded(
                            child: pw.Container(

                                // margin: pw.EdgeInsets.all(3),
                                // decoration: pw.BoxDecoration(
                                //   border: pw.Border.all(),
                                //   color: PdfColors.white,
                                // ),

                                // color: PdfColor.fromInt(0xFFEEEEEE),
                                // pw.BoxBorder(color: PdfColors.black, width: 5.0, left: true, top: true, right: true, bottom: true),
                                child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                  pw.SizedBox(
                                    height: 4,
                                  ),
                                  pw.Container(
                                      child: pw.Paragraph(
                                    //margin: EdgeInsets.only(bottom: 20),
                                    text: ' Quotation from :         ',
                                    style: pw.TextStyle(
                                        font: font,
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 14),
                                  )),
                                  pw.Container(
                                      child: pw.Paragraph(
                                    //margin: EdgeInsets.only(bottom: 20),
                                    text: complist["name"] == "null"
                                        ? ""
                                        : " " + complist["name"],
                                    style: pw.TextStyle(
                                        font: font,
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 13),
                                  )),
                                  pw.Container(
                                      child: pw.Paragraph(
                                    //margin: EdgeInsets.only(bottom: 20),
                                    text: complist["address_line1"] == null
                                        ? ""
                                        : " " + complist["address_line1"],
                                    style:
                                        pw.TextStyle(font: font, fontSize: 11),
                                  )),
                                  pw.Container(
                                      child: pw.Paragraph(
                                    //margin: EdgeInsets.only(bottom: 20),
                                    text: complist["address_line2"] == null
                                        ? ""
                                        : " " + complist["address_line2"],
                                    style:
                                        pw.TextStyle(font: font, fontSize: 11),
                                  )),
                                  pw.Container(
                                      child: pw.Paragraph(
                                    //margin: EdgeInsets.only(bottom: 20),
                                    text: complist["city"] == null
                                        ? ""
                                        : " " + complist["city"],
                                    style:
                                        pw.TextStyle(font: font, fontSize: 11),
                                  )),
                                  pw.Container(
                                      child: pw.Paragraph(
                                    //margin: EdgeInsets.only(bottom: 20),
                                    text: complist["pincode"] == null
                                        ? ""
                                        : "  " + complist["pincode"],
                                    style:
                                        pw.TextStyle(font: font, fontSize: 12),
                                  ))
                                ])),
                          ),
                          pw.Expanded(
                            child: pw.Text(
                                plist[i]["item_series"] == null ? "" : "",
                                style: pw.TextStyle(
                                  font: font,
                                )),
                          ),
                          pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.SizedBox(
                                  height: 4,
                                ),
                                pw.Container(
                                    child: pw.Paragraph(
                                  //margin: EdgeInsets.only(bottom: 20),
                                  text: ' Quotation ID : \n' +
                                      productlist["name"],
                                  style: pw.TextStyle(
                                      font: font,
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 11),
                                )),
                                pw.Container(
                                    child: pw.Paragraph(
                                  //margin: EdgeInsets.only(bottom: 20),
                                  text: ' Quotation Made by : \n' +
                                      productlist["sales_officer_name"],
                                  style: pw.TextStyle(
                                      font: font,
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 11),
                                )),
                                pw.Container(
                                    child: pw.Paragraph(
                                  //margin: EdgeInsets.only(bottom: 20),
                                  text: 'Concerned Staff : \n' +
                                      productlist["area_sales_manager"],
                                  style: pw.TextStyle(
                                      font: font,
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 11),
                                )),
                                pw.Container(
                                    child: pw.Paragraph(
                                  //margin: EdgeInsets.only(bottom: 20),
                                  text: 'Date : \n' +
                                      productlist["transaction_date"],
                                  style: pw.TextStyle(
                                      font: font,
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 11),
                                )),
                              ]),
                          pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.SizedBox(
                                  height: 4,
                                ),
                                pw.Container(
                                    child: pw.Paragraph(
                                  //margin: EdgeInsets.only(bottom: 20),
                                  text: '  : \n' + "",
                                  style: pw.TextStyle(
                                      font: font,
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 11),
                                )),
                              ]),
                          pw.Expanded(
                            child: pw.Container(
                                margin: pw.EdgeInsets.all(3),
                                color: PdfColors.white,
                                //  color: PdfColor.fromInt(0xFFEEEEEE),
                                child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.SizedBox(
                                        height: 4,
                                      ),
                                      pw.Container(
                                          child: pw.Paragraph(
                                        //margin: EdgeInsets.only(bottom: 20),
                                        text: ' Quotation to :         ',
                                        style: pw.TextStyle(
                                            font: font,
                                            fontWeight: pw.FontWeight.bold,
                                            fontSize: 14),
                                      )),
                                      pw.Container(
                                          child: pw.Paragraph(
                                        //margin: EdgeInsets.only(bottom: 20),
                                        text: leadlist["lead_name"] == null
                                            ? ""
                                            : " " + leadlist["lead_name"],
                                        style: pw.TextStyle(
                                            font: font,
                                            fontWeight: pw.FontWeight.bold,
                                            fontSize: 12),
                                      )),
                                      pw.Container(
                                          child: pw.Paragraph(
                                        //margin: EdgeInsets.only(bottom: 20),
                                        text: leadlist["address_line1"]
                                                    .toString() ==
                                                "null"
                                            ? ""
                                            : leadlist["address_line1"],
                                        style: pw.TextStyle(
                                            font: font, fontSize: 11),
                                      )),
                                      pw.Container(
                                          child: pw.Paragraph(
                                        //margin: EdgeInsets.only(bottom: 20),
                                        text: leadlist["address_line2"] == null
                                            ? ""
                                            : " " + leadlist["address_line2"],
                                        style: pw.TextStyle(
                                            font: font, fontSize: 11),
                                      )),
                                      pw.Container(
                                          child: pw.Paragraph(
                                        //margin: EdgeInsets.only(bottom: 20),
                                        text: leadlist["city"] == null
                                            ? ""
                                            : " " + leadlist["city"],
                                        style: pw.TextStyle(
                                            font: font, fontSize: 11),
                                      )),
                                      pw.Container(
                                          child: pw.Paragraph(
                                        //margin: EdgeInsets.only(bottom: 20),
                                        text: leadlist["pincode"] == null
                                            ? ""
                                            : "  " + leadlist["pincode"],
                                        style: pw.TextStyle(
                                            font: font, fontSize: 12),
                                      ))
                                    ])),
                          ),
                        ]),
                      ])),
                  // itemCount: 2
                ),
              ),

              // pw.Padding(
              //   padding: pw.EdgeInsets.only(top: 2),
              //   child: pw.Container(
              //       width: 500,
              //       height: 40,
              //       color: PdfColors.grey,
              //       child: pw.Padding(
              //           padding: pw.EdgeInsets.only(left: 210, top: 20),
              //           child: pw.Container(
              //               // width: 500,
              //               // height: 40,
              //               color: PdfColors.grey,
              //               child: pw.Text("PROFORMA",
              //                   style: pw.TextStyle(
              //                       font: font,
              //                       fontWeight: pw.FontWeight.bold,
              //                       color: PdfColors.white))))),
              // ),

              // pw.SizedBox(height: 5),
              // pw.Container(
              //     height: 300,
              //     //width: 500,
              //     decoration: pw.BoxDecoration(
              //         color: PdfColors.black,
              //         border: pw.Border.all(color: PdfColors.black, width: 2)),
              //     child: pw.Container(
              //       height: 298,
              //       color: PdfColors.white,
              //       child: pw.Row(
              //           crossAxisAlignment: pw.CrossAxisAlignment.start,
              //           children: [
              //             // pw.Container(
              //             //     width: 1, color: PdfColors.black, height: 342),
              //             pw.Container(
              //                 width: 240,
              //                 color: PdfColors.white,
              //                 child: pw.Column(
              //                     crossAxisAlignment:
              //                         pw.CrossAxisAlignment.start,
              //                     children: [
              //                       pw.Container(
              //                           width: 500,
              //                           color: PdfColors.white,
              //                           child: pw.Column(
              //                               crossAxisAlignment:
              //                                   pw.CrossAxisAlignment.start,
              //                               children: [
              //                                 // pw.Container(
              //                                 //     height: 1,
              //                                 //     color: PdfColors.black,
              //                                 //     width: 480),

              //                                 pw.SizedBox(height: 2),
              //                                 // pw.Container(
              //                                 //     height: 1,
              //                                 //     color: PdfColors.black),
              //                                 // pw.SizedBox(height: 5),
              //                                 pw.Container(
              //                                     child: pw.Paragraph(
              //                                   //margin: EdgeInsets.only(bottom: 20),
              //                                   text: complist["name"] == null
              //                                       ? ""
              //                                       : " " +
              //                                           complist["name"]
              //                                               .toString(),
              //                                   style: pw.TextStyle(
              //                                       font: font,
              //                                       fontWeight:
              //                                           pw.FontWeight.bold,
              //                                       fontSize: 19),
              //                                 )),
              //                                 pw.SizedBox(height: 2),
              //                                 pw.Container(
              //                                     child: pw.Paragraph(
              //                                   //margin: EdgeInsets.only(bottom: 20),
              //                                   text: complist[
              //                                               "address_line1"] ==
              //                                           null
              //                                       ? ""
              //                                       : " " +
              //                                           complist[
              //                                               "address_line1"],
              //                                   style: pw.TextStyle(
              //                                       font: font, fontSize: 12),
              //                                 )),
              //                                 //  pw.SizedBox(height: 2),
              //                                 pw.SizedBox(
              //                                     width: 190,
              //                                     child: pw.Container(
              //                                         child: pw.Paragraph(
              //                                       //margin: EdgeInsets.only(bottom: 20),
              //                                       text: complist[
              //                                                   "address_line2"] ==
              //                                               null
              //                                           ? ""
              //                                           : " " +
              //                                               complist[
              //                                                   "address_line2"],
              //                                       style: pw.TextStyle(
              //                                           font: font,
              //                                           fontSize: 12),
              //                                     ))),
              //                                 //pw.SizedBox(height: 2),
              //                                 pw.SizedBox(
              //                                     width: 190,
              //                                     child: pw.Container(
              //                                         child: pw.Paragraph(
              //                                       //margin: EdgeInsets.only(bottom: 20),
              //                                       text: complist["city"] ==
              //                                               null
              //                                           ? ""
              //                                           : " " +
              //                                               complist["city"],
              //                                       style: pw.TextStyle(
              //                                           font: font,
              //                                           fontSize: 12),
              //                                     ))),
              //                                 pw.SizedBox(height: 2),
              //                                 pw.SizedBox(
              //                                     width: 190,
              //                                     child: pw.Container(
              //                                         child: pw.Paragraph(
              //                                       //margin: EdgeInsets.only(bottom: 20),
              //                                       text: complist["pincode"] ==
              //                                               null
              //                                           ? ""
              //                                           : "  " +
              //                                               complist["pincode"],
              //                                       style: pw.TextStyle(
              //                                           font: font,
              //                                           fontSize: 12),
              //                                     ))),
              //                               ])),
              //                       //   pw.SizedBox(height: 5),
              //                       pw.Container(
              //                           child: pw.Paragraph(
              //                         //margin: EdgeInsets.only(bottom: 20),
              //                         text: ' Quotation To',
              //                         style: pw.TextStyle(
              //                             font: font,
              //                             fontWeight: pw.FontWeight.bold,
              //                             fontSize: 19),
              //                       )),
              //                       // pw.SizedBox(height: 20),
              //                       pw.Container(
              //                           child: pw.Paragraph(
              //                         //margin: EdgeInsets.only(bottom: 20),
              //                         text: productlist["customer_name"] == null
              //                             ? ""
              //                             : " " + productlist["customer_name"],
              //                         style: pw.TextStyle(
              //                           fontSize: 12,
              //                           font: font,
              //                         ),
              //                       )),
              //                       pw.SizedBox(height: 2),
              //                       pw.SizedBox(
              //                           width: 190,
              //                           child: pw.Container(
              //                               child: pw.Paragraph(
              //                             //margin: EdgeInsets.only(bottom: 20),
              //                             text: leadlist["address_line1"] ==
              //                                     null
              //                                 ? ""
              //                                 : " " + leadlist["address_line1"],
              //                             style: pw.TextStyle(
              //                               fontSize: 12,
              //                               font: font,
              //                             ),
              //                           ))),
              //                       pw.SizedBox(height: 2),
              //                       pw.SizedBox(
              //                           width: 190,
              //                           child: pw.Container(
              //                               child: pw.Paragraph(
              //                             //margin: EdgeInsets.only(bottom: 20),
              //                             text: leadlist["address_line2"] ==
              //                                     null
              //                                 ? ""
              //                                 : "" + leadlist["address_line2"],
              //                             style: pw.TextStyle(
              //                               fontSize: 12,
              //                               font: font,
              //                             ),
              //                           ))),
              //                       pw.SizedBox(height: 2),
              //                       pw.SizedBox(
              //                           width: 190,
              //                           child: pw.Container(
              //                               child: pw.Paragraph(
              //                             //margin: EdgeInsets.only(bottom: 20),
              //                             text: leadlist["city"] == null
              //                                 ? ""
              //                                 : leadlist["city"],
              //                             style: pw.TextStyle(
              //                                 font: font, fontSize: 12),
              //                           ))),
              //                       pw.SizedBox(
              //                           width: 190,
              //                           child: pw.Container(
              //                               child: pw.Paragraph(
              //                             //margin: EdgeInsets.only(bottom: 20),
              //                             text: leadlist["pincode"] == null
              //                                 ? ""
              //                                 : leadlist["pincode"],
              //                             style: pw.TextStyle(
              //                                 font: font, fontSize: 12),
              //                           ))),
              //                       // pw.Container(
              //                       //     height: 1,
              //                       //     color: PdfColors.black,
              //                       //     width: 340),
              //                     ])),
              //             // pw.Container(
              //             //     width: 1, color: PdfColors.black, height: 342),
              //             pw.Container(
              //                 width: 240,
              //                 color: PdfColors.white,
              //                 child: pw.Column(
              //                     crossAxisAlignment:
              //                         pw.CrossAxisAlignment.start,
              //                     children: [
              //                       pw.Container(
              //                           width: 500,
              //                           color: PdfColors.white,
              //                           child: pw.Column(
              //                               crossAxisAlignment:
              //                                   pw.CrossAxisAlignment.start,
              //                               children: [
              //                                 // pw.Container(
              //                                 //     height: 1,
              //                                 //     color: PdfColors.black,
              //                                 //     width: 300),

              //                                 pw.SizedBox(height: 5),
              //                                 // pw.Container(
              //                                 //     height: 1,
              //                                 //     color: PdfColors.black),
              //                                 pw.SizedBox(height: 5),
              //                                 pw.SizedBox(
              //                                     width: 190,
              //                                     child: pw.Container(
              //                                         child: pw.Paragraph(
              //                                       //margin: EdgeInsets.only(bottom: 20),
              //                                       text: productlist["date"] ==
              //                                               null
              //                                           ? ""
              //                                           : productlist["date"]
              //                                               .toString(),
              //                                       style: pw.TextStyle(
              //                                           font: font,
              //                                           fontSize: 12),
              //                                     ))),
              //                                 pw.SizedBox(height: 2),
              //                                 pw.SizedBox(
              //                                     width: 190,
              //                                     child: pw.Container(
              //                                         child: pw.Paragraph(
              //                                       //margin: EdgeInsets.only(bottom: 20),
              //                                       text: productlist["name"]
              //                                                   .toString() ==
              //                                               "null"
              //                                           ? ""
              //                                           : ' No : ' +
              //                                               productlist["name"]
              //                                                   .toString(),
              //                                       style: pw.TextStyle(
              //                                           font: font,
              //                                           fontSize: 12),
              //                                     ))),
              //                                 pw.SizedBox(height: 2),

              //                                 // pw.Container(
              //                                 //     height: 1,
              //                                 //     color: PdfColors.black,
              //                                 //     width: 480),

              //                                 pw.SizedBox(
              //                                     width: 190,
              //                                     child: pw.Container(
              //                                         height: 90,
              //                                         child: pw.Row(children: [
              //                                           pw.Paragraph(
              //                                             //margin: EdgeInsets.only(bottom: 20),
              //                                             text:
              //                                                 ' QOUTATION MADE BY :',
              //                                             style: pw.TextStyle(
              //                                                 font: font,
              //                                                 fontSize: 10,
              //                                                 fontWeight: pw
              //                                                     .FontWeight
              //                                                     .bold),
              //                                           ),
              //                                           pw.Expanded(
              //                                               child: pw.Paragraph(
              //                                             //margin: EdgeInsets.only(bottom: 20),
              //                                             text: fullname == null
              //                                                 ? ""
              //                                                 : fullname,
              //                                             style: pw.TextStyle(
              //                                                 font: font,
              //                                                 fontSize: 10),
              //                                           ))
              //                                         ]))),
              //                               ])),
              //                       // pw.Container(
              //                       //     height: 1,
              //                       //     color: PdfColors.black,
              //                       //     width: 480),
              //                       pw.Container(height: 172.5),
              //                       // pw.Container(
              //                       //     height: 1,
              //                       //     color: PdfColors.black,
              //                       //     width: 480),
              //                     ])),
              //             // pw.Container(
              //             //     width: 1, color: PdfColors.black, height: 342),
              //           ]),
              //     )),

              pw.Container(
                color: PdfColor.fromInt(0xFF1A237E),
                child: pw.Row(children: [
                  // pw.Expanded(
                  //   child: pw.Text('sl No',
                  //       style: pw.TextStyle(
                  //         color: PdfColors.white,
                  //         font: font,
                  //       )),
                  // ),
                  // pw.Expanded(
                  //   child: pw.Text('Product',
                  //       style: pw.TextStyle(
                  //         color: PdfColors.white,
                  //         font: font,
                  //       )),
                  // ),
                  // pw.Expanded(
                  //   child: pw.Text('Series',
                  //       style: pw.TextStyle(
                  //         color: PdfColors.white,
                  //         font: font,
                  //       )),
                  // ),
                  // pw.Expanded(
                  //   child: pw.Text('Qty',
                  //       style: pw.TextStyle(
                  //         color: PdfColors.white,
                  //         font: font,
                  //       )),
                  // ),
                  // pw.Expanded(
                  //   child: pw.Text('Total',
                  //       style: pw.TextStyle(
                  //         color: PdfColors.white,
                  //         font: font,
                  //       )),
                  // ),
                  // pw.SizedBox(
                  //     width: 75, child: pw.Column(children: [pw.Text("Arundas")]))
                ]),
              ),
              pw.ListView.builder(
                itemCount: plist.length,
                itemBuilder: ((context, i) => pw.Column(children: [
                      // pw.Row(children: [
                      //   pw.Expanded(
                      //     child: pw.Text(plist[i]["idx"].toString(),
                      //         style: pw.TextStyle(
                      //           font: font,
                      //         )),
                      //   ),
                      //   pw.Expanded(
                      //     child: pw.Text(
                      //         plist[i]["item_name"] == null
                      //             ? ""
                      //             : plist[i]["item_name"],
                      //         style: pw.TextStyle(
                      //           font: font,
                      //         )),
                      //   ),
                      //   pw.Expanded(
                      //     child: pw.Text(
                      //         plist[i]["item_series"] == null
                      //             ? ""
                      //             : plist[i]["item_series"],
                      //         style: pw.TextStyle(
                      //           font: font,
                      //         )),
                      //   ),
                      //   pw.Expanded(
                      //     child: pw.Text(
                      //         plist[i]["qty"] == null
                      //             ? ""
                      //             : plist[i]["qty"].toString(),
                      //         style: pw.TextStyle(
                      //           font: font,
                      //         )),
                      //   ),
                      //   pw.Expanded(
                      //     child: pw.Text(
                      //         plist[i]["amount"] == null
                      //             ? ""
                      //             : plist[i]["amount"].toString(),
                      //         style: pw.TextStyle(
                      //           font: font,
                      //         )),
                      //   ),
                      //]),
                    ])),
                // itemCount: 2
              ),

              pw.Container(
                decoration: pw.BoxDecoration(
                  color: PdfColor.fromInt(0xFF1A237E),
                  border: pw.Border.all(),
                  //  color: PdfColors.white,
                ),
                child: pw.Row(children: [
                  pw.Container(
                    width: 20,
                    child: pw.Text('sl No',
                        style: pw.TextStyle(
                          color: PdfColors.white,
                          font: font,
                        )),
                  ),
                  pw.Expanded(
                    child: pw.Text('Product',
                        style: pw.TextStyle(
                          color: PdfColors.white,
                          font: font,
                        )),
                  ),
                  pw.Expanded(
                    child: pw.Text('Series',
                        style: pw.TextStyle(
                          color: PdfColors.white,
                          font: font,
                        )),
                  ),
                  pw.Expanded(
                    child: pw.Text('Qty',
                        style: pw.TextStyle(
                          color: PdfColors.white,
                          font: font,
                        )),
                  ),
                  pw.Expanded(
                    child: pw.Text('Total',
                        style: pw.TextStyle(
                          color: PdfColors.white,
                          font: font,
                        )),
                  ),
                  // pw.SizedBox(
                  //     width: 75, child: pw.Column(children: [pw.Text("Arundas")]))
                ]),
              ),
              pw.ListView.builder(
                itemCount: plist.length,
                itemBuilder: ((context, i) => pw.Container(
                    decoration: pw.BoxDecoration(
                      // color: PdfColor.fromInt(0xFF1A237E),
                      border: pw.Border.all(),
                    ),
                    child: pw.Column(children: [
                      pw.Row(children: [
                        pw.Container(
                          width: 20,
                          child: pw.Text(plist[i]["idx"].toString(),
                              style: pw.TextStyle(
                                font: font,
                              )),
                        ),
                        pw.Expanded(
                          child: pw.Text(
                              plist[i]["item_name"] == null
                                  ? ""
                                  : plist[i]["item_name"],
                              style: pw.TextStyle(
                                font: font,
                              )),
                        ),
                        pw.Expanded(
                          child: pw.Text(
                              plist[i]["item_series"] == null
                                  ? ""
                                  : plist[i]["item_series"],
                              style: pw.TextStyle(
                                font: font,
                              )),
                        ),
                        pw.Expanded(
                          child: pw.Text(
                              plist[i]["qty"] == null
                                  ? ""
                                  : plist[i]["qty"].toString(),
                              style: pw.TextStyle(
                                font: font,
                              )),
                        ),
                        pw.Expanded(
                          child: pw.Text(
                              plist[i]["amount"] == null
                                  ? ""
                                  : plist[i]["amount"].toString(),
                              style: pw.TextStyle(
                                font: font,
                              )),
                        ),
                      ]),
                    ]))),
                // itemCount: 2
              ),
              pw.Container(
                color: PdfColors.grey,
                child: pw.Row(children: [
                  pw.Expanded(child: pw.Container()),
                  pw.Expanded(child: pw.Container()),

                  pw.Expanded(
                    child: pw.Text("",
                        style: pw.TextStyle(
                          font: font,
                        )),
                  ),
                  pw.Expanded(
                    child: pw.Text("Total : " + productlist["total"].toString(),
                        style: pw.TextStyle(
                          font: font,
                        )),
                  ),
                  // pw.Expanded(
                  //   child: pw.Text("",
                  //       style: pw.TextStyle(
                  //         font: font,
                  //       )),
                  // ),
                  pw.Expanded(
                    child: pw.Text(
                        "Grand Total :" + productlist["grand_total"].toString(),
                        style: pw.TextStyle(
                          font: font,
                        )),
                  ),
                  // pw.SizedBox(
                  //     width: 75, child: pw.Column(children: [pw.Text("Arundas")]))
                ]),
              ),
              pw.Container(height: 10),
              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                  color: PdfColors.white,
                ),
                child: pw.Container(
                    height: 350,
                    //width: 500,
                    color: PdfColors.black,
                    child: pw.Container(
                      height: 298,
                      color: PdfColors.white,
                      child: pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            // pw.Container(
                            //     width: 1, color: PdfColors.black, height: 327),
                            pw.Container(
                                width: 480,
                                color: PdfColors.white,
                                child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                          width: 500,
                                          color: PdfColors.white,
                                          child: pw.Column(
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.start,
                                              children: [
                                                pw.Container(
                                                    height: 1,
                                                    color: PdfColors.black,
                                                    width: 480),

                                                //  pw.SizedBox(height: 5),
                                                // pw.Container(
                                                //     height: 1,
                                                //     color: PdfColors.black),
                                                // pw.SizedBox(height: 5),
                                                pw.SizedBox(
                                                  width: 500,
                                                  child: pw.Container(
                                                      height: 40,
                                                      color: PdfColor.fromInt(
                                                          0xFF1A237E),
                                                      child: pw.SizedBox(
                                                          height: 20,
                                                          child: pw.Paragraph(
                                                            //margin: EdgeInsets.only(bottom: 20),
                                                            text:
                                                                ' TERMS AND CONDITION :',
                                                            style: pw.TextStyle(
                                                                color: PdfColors
                                                                    .white,
                                                                font: font,
                                                                fontWeight: pw
                                                                    .FontWeight
                                                                    .bold,
                                                                fontSize: 14),
                                                          ))),
                                                ),

                                                pw.SizedBox(height: 20),
                                                pw.SizedBox(
                                                    width: 480,
                                                    child: pw.Container(
                                                        child: pw.Paragraph(
                                                      //margin: EdgeInsets.only(bottom: 20),
                                                      text:
                                                          '* 30 of total amount should be aid in advance',
                                                      style: pw.TextStyle(
                                                          font: font,
                                                          fontSize: 12),
                                                    ))),
                                                pw.SizedBox(height: 2),
                                                pw.SizedBox(
                                                    width: 480,
                                                    child: pw.Container(
                                                        child: pw.Paragraph(
                                                      //margin: EdgeInsets.only(bottom: 20),
                                                      text:
                                                          '* Balance amount should be paid before container arrival port',
                                                      style: pw.TextStyle(
                                                          font: font,
                                                          fontSize: 12),
                                                    ))),
                                                pw.SizedBox(height: 2),
                                                pw.SizedBox(
                                                    width: 480,
                                                    child: pw.Container(
                                                        child: pw.Paragraph(
                                                      //margin: EdgeInsets.only(bottom: 20),
                                                      text:
                                                          '* Any increase in shipping or purchase charges will result increases in material price',
                                                      style: pw.TextStyle(
                                                          font: font,
                                                          fontSize: 12),
                                                    ))),
                                                pw.SizedBox(height: 2),
                                                pw.SizedBox(
                                                    width: 480,
                                                    child: pw.Container(
                                                        child: pw.Paragraph(
                                                      //margin: EdgeInsets.only(bottom: 20),
                                                      text:
                                                          '* This Qutation is valid for 15 days',
                                                      style: pw.TextStyle(
                                                          font: font,
                                                          fontSize: 12),
                                                    ))),
                                              ])),
                                      pw.SizedBox(height: 5),
                                      pw.SizedBox(
                                          width: 480,
                                          child: pw.Container(
                                              child: pw.Paragraph(
                                            //margin: EdgeInsets.only(bottom: 20),
                                            text:
                                                '* Quoted price inclusive of gst and tax',
                                            style: pw.TextStyle(
                                                font: font,

                                                /// fontWeight: pw.FontWeight.bold,
                                                fontSize: 12),
                                          ))),
                                      pw.SizedBox(height: 5),
                                      pw.SizedBox(
                                          width: 480,
                                          child: pw.Container(
                                              child: pw.Paragraph(
                                            //margin: EdgeInsets.only(bottom: 20),
                                            text:
                                                '* Transportation is free for delivery',
                                            style: pw.TextStyle(
                                              fontSize: 12,
                                              font: font,
                                            ),
                                          ))),
                                      pw.SizedBox(height: 2),
                                      pw.SizedBox(
                                          width: 480,
                                          child: pw.Container(
                                              child: pw.Paragraph(
                                            //margin: EdgeInsets.only(bottom: 20),
                                            text:
                                                '* unloading is parties responsibility',
                                            style: pw.TextStyle(
                                              fontSize: 12,
                                              font: font,
                                            ),
                                          ))),
                                      pw.SizedBox(height: 2),
                                      pw.SizedBox(
                                          width: 480,
                                          child: pw.Container(
                                              child: pw.Paragraph(
                                            //margin: EdgeInsets.only(bottom: 20),
                                            text: '* 1% breaking normal',
                                            style: pw.TextStyle(
                                              fontSize: 12,
                                              font: font,
                                            ),
                                          ))),
                                      pw.SizedBox(height: 2),
                                      // pw.Container(
                                      //     height: 1,
                                      //     color: PdfColors.black,
                                      //     width: 400),
                                    ])),
                            // pw.Container(
                            //     width: 1, color: PdfColors.black, height: 329),
                          ]),
                    )),
              )
            ]),
      ),
    );
    var pathi = pat.toString();
    log(pat);
    final file = File(
        '$pat/filessssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss.pdf');

    File(file.toString()).create(recursive: true);
    var pdffile = await file.writeAsBytes(await pdf.save());

    if (Permission.manageExternalStorage.status ==
            PermissionStatus.permanentlyDenied ||
        Permission.manageExternalStorage.status == PermissionStatus.denied) {
      await Permission.manageExternalStorage.request();
    } else {
      if (pdfData.length > 0) {
        OpenFilex.open(pdffile.path);
      } else {
        Get.snackbar('No data', 'There is no data found to export',
            backgroundColor: Colors.black45, colorText: Colors.white);
        HapticFeedback.vibrate();
      }
    }

//final font = await PdfGoogleFonts.nunitoExtraLight();
  }

  // Get storage directory paths

  Future<void> getPath_1() async {
    var path = await ExternalPath.getExternalStorageDirectories();
    log(path.toString()); // [/storage/emulated/0, /storage/B3AE-4D28]

    // please note: B3AE-4D28 is external storage (SD card) folder name it can be any.
  }

  Future<void> getPath_2() async {
    pat = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    setState(() {
      log(pat);
    });
    // /storage/emulated/0/Download
  }

  // To get public storage directory path
}
