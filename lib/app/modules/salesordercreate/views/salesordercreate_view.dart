import 'dart:convert';
import 'dart:developer';

import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:lamit/app/modules/customerdetail/views/customerdetail_view.dart';
import 'package:lamit/app/modules/home/views/home_view.dart';
import 'package:lamit/app/modules/salesdetail/views/salesdetail_view.dart';
import 'package:lamit/app/routes/constants.dart';
import 'package:lamit/tocken/tockn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../testtttt.dart';
import '../../../../tocken/config/url.dart';
import '../../addqoutationadd/views/addqoutationadd_view.dart';
import '../../collectionreport/views/custom_divider_horizontal.dart';
import '../../collectionreport/views/custom_divider_vertical.dart';

class SalesordercreateView extends StatefulWidget {
  final String leadtok;
  final String name;
  final String qtname;

  final String restorationId = "main";

  const SalesordercreateView(this.leadtok, this.name, this.qtname);

  @override
  State<SalesordercreateView> createState() => _SalesordercreateViewState();
}

class _SalesordercreateViewState extends State<SalesordercreateView>
    with RestorationMixin {
  String? get restorationId => widget.restorationId;
  String? a;
  String? mopprice;
  String? mrp;
  String? brand;
  String? dropdownvaluemode;
  String? tax;
  String? check;
  String? userID;
  String? subdealer;
  String? deler;
  var plist = [];
  var sourclist = [];
  String? modeofpay;
  var sourcelist = [];
  var sourceDropDown = [];
  var maplist;
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
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

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
  var jdata = [];
  String? x;
  String? y;
  String? w;
  double? z;
  String nos = "";
  String box = "";
  String? name;
  var productlist;
  var taxes;
  var selectedNote;

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
  List<Map<String, dynamic>> taxeasarrray = [];
  var taxe;
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

  bool isLoading = false;
  String? email;
  getsf() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    email = preferences.getString("emailid");
    log(email.toString() + "bjcffzsxdfghjkl");
    detailinvoceView();
    modeofpayment();

    getAllsource();

    //  getAllArea();
    gettaxcharge();

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
    // log(plist.where((element) => element["item_code"]).toString() + "hhhhhh");
    getsf();

    super.initState();
  }

  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yy').format(now);
    return Scaffold(
      backgroundColor: HexColor("#F9F9F9"),
      resizeToAvoidBottomInset: false,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : productlist == null
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Stack(
                    //  mainAxisAlignment: MainAxisAlignment.start,
                    //crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: Container(
                            height: Constants(context).scrnHeight + 500,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          Get.to(SalesdetailView(widget.leadtok,
                                              "qt", "0", "", "", widget.name));
                                        },
                                        child: Container(
                                            child: Icon(Icons.arrow_back))),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "SALES ORDER",
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 5, 70, 123),
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                  width: 80,
                                                  height: 20,
                                                  child: Text("Net total")),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                  width: 5,
                                                  height: 20,
                                                  child: Text(":")),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                  width: 80,
                                                  height: 20,
                                                  child: Text("Tax Amount")),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                  width: 5,
                                                  height: 20,
                                                  child: Text(":")),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                  width: 80,
                                                  height: 20,
                                                  child: Text("Grand Total")),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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

                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Card(
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(16.0),
                                //       child: Container(
                                //         child: Column(
                                //           children: [
                                //             Row(
                                //               children: [
                                //                 Padding(
                                //                   padding:
                                //                       const EdgeInsets.all(8.0),
                                //                   child: Container(

                                //                     child: Text("Net total")),
                                //                 ),
                                //                 Padding(
                                //                   padding:
                                //                       const EdgeInsets.all(8.0),
                                //                   child: Text(":"),
                                //                 ),
                                //                 Padding(
                                //                   padding:
                                //                       const EdgeInsets.all(8.0),
                                //                   child: Text(
                                //                       productlist["net_total"]
                                //                           .toString()),
                                //                 ),
                                //               ],
                                //             ),
                                //             Row(
                                //               children: [
                                //                 Padding(
                                //                   padding:
                                //                       const EdgeInsets.all(8.0),
                                //                   child: Text("Tax Amount"),
                                //                 ),
                                //                 Padding(
                                //                   padding:
                                //                       const EdgeInsets.all(8.0),
                                //                   child: Text(":"),
                                //                 ),
                                //                 Padding(
                                //                   padding:
                                //                       const EdgeInsets.all(8.0),
                                //                   child: Text(productlist[
                                //                           "total_taxes_and_charges"]
                                //                       .toString()),
                                //                 ),
                                //               ],
                                //             ),
                                //             Row(
                                //               children: [
                                //                 Padding(
                                //                   padding:
                                //                       const EdgeInsets.all(8.0),
                                //                   child: Text("Grand Total"),
                                //                 ),
                                //                 Padding(
                                //                   padding:
                                //                       const EdgeInsets.all(8.0),
                                //                   child: Text(":"),
                                //                 ),
                                //                 Text(productlist["grand_total"]
                                //                     .toString()),
                                //               ],
                                //             )
                                //           ],
                                //         ),
                                //       ),
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
                                                      Text(formattedDate
                                                          .toString())
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

                                // Row(
                                //   children: [
                                //     Expanded(
                                //       flex: 2,
                                //       child: Padding(
                                //         padding: const EdgeInsets.all(8.0),
                                //         child: Column(
                                //           crossAxisAlignment:
                                //               CrossAxisAlignment.start,
                                //           children: [
                                //             Container(
                                //               height: 82,
                                //               margin: EdgeInsets.all(5),
                                //               decoration: BoxDecoration(
                                //                 // border: Border.all(
                                //                 //     color:
                                //                 //         Colors.grey, // Set border color
                                //                 //     width: 1.0),
                                //                 color: Colors.white,
                                //                 borderRadius:
                                //                     BorderRadius.circular(5),
                                //               ),
                                //               child: Row(
                                //                 children: [
                                //                   Expanded(
                                //                     child: Container(
                                //                         // margin: EdgeInsets.all(2),
                                //                         decoration: BoxDecoration(
                                //                             //color: Colors.white,
                                //                             ),
                                //                         child: Padding(
                                //                           padding:
                                //                               const EdgeInsets
                                //                                   .all(8.0),
                                //                           child: Container(
                                //                             width: 200,
                                //                             height: 80,
                                //                             child: Text(productlist[
                                //                                         "note"] ==
                                //                                     "null"
                                //                                 ? ""
                                //                                 : "Note : " +
                                //                                     productlist[
                                //                                             "note"]
                                //                                         .toString()),
                                //                           ),
                                //                         )),
                                //                   )
                                //                 ],
                                //               ),
                                //             )
                                //           ],
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),

                                Row(
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
                                                      BorderRadius.circular(5),
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
                                                      width: Constants(context)
                                                          .scrnWidth,
                                                      child: TextButton(
                                                        onPressed: () {
                                                          // _keyboardVisible = true;
                                                          _restorableDatePickerRouteFuture
                                                              .present();
                                                          a = "${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}";

                                                          setState(() {
                                                            a.toString();
                                                          });
                                                        },
                                                        child: datelll == null
                                                            ? Text(
                                                                'Delivery date',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        11,
                                                                    color: Colors
                                                                        .black),
                                                              )
                                                            : Text(
                                                                datelll
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
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
                                  ],
                                ),
                                // Padding(
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
                                          padding:
                                              const EdgeInsets.only(top: 00),
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
                                                    //    borderRadius: BorderRadius.circular(20)
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            right: 8.0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          "Type of vehicle  "),
                                                    ),
                                                  )),
                                              productlist["all"].toString() ==
                                                      "0"
                                                  ? Container()
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                          productlist["all"] ==
                                                                  1
                                                              ? "All"
                                                              : "".toString()),
                                                    ),
                                              productlist["all"].toString() ==
                                                      "1"
                                                  ? Container()
                                                  : Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        productlist["goods_ape"]
                                                                    .toString() ==
                                                                "0"
                                                            ? Container()
                                                            : Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Text(productlist[
                                                                            "goods_ape"] ==
                                                                        1
                                                                    ? "Goods ape"
                                                                    : "".toString()),
                                                              ),
                                                        productlist["goods_ape"]
                                                                    .toString() ==
                                                                "0"
                                                            ? Container()
                                                            : Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
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
                                                                    const EdgeInsets
                                                                            .all(
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
                                                                    const EdgeInsets
                                                                            .all(
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
                                                                    const EdgeInsets
                                                                            .all(
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
                                                                    const EdgeInsets
                                                                            .all(
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
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Text(productlist[
                                                                            "tata_407"] ==
                                                                        1
                                                                    ? "Tata 407"
                                                                    : "".toString()),
                                                              ),
                                                        productlist.toString() ==
                                                                "0"
                                                            ? Container()
                                                            : Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Text(productlist[
                                                                            "eicher"] ==
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
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Text(productlist[
                                                                            "bharat_benz"] ==
                                                                        1
                                                                    ? "Bharat benz"
                                                                    : "".toString()),
                                                              ),
                                                      ],
                                                    ),
                                              productlist["note"].toString() ==
                                                      "null"
                                                  ? Container()
                                                  : Row(
                                                      children: [
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    height: 90,
                                                                    margin: EdgeInsets
                                                                        .all(5),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      // border: Border.all(
                                                                      //     color:
                                                                      //         Colors.grey, // Set border color
                                                                      //     width: 1.0),
                                                                      //  color: HexColor("#F9F9F9"),
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                    ),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Container(
                                                                        width: Constants(context)
                                                                            .scrnWidth,
                                                                        child: TextButton(
                                                                            onPressed: () {},
                                                                            child:
                                                                                // datelll == null?
                                                                                Container(
                                                                              width: 200,
                                                                              child: Text(
                                                                                maxLines: 6,
                                                                                "Note : " + selectedNote,
                                                                                style: TextStyle(fontSize: 11, color: Colors.black),
                                                                              ),
                                                                            )
                                                                            // : Text(
                                                                            //     "",
                                                                            //   ),
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
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Expanded(
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
                                if (productlist.length > 0)
                                  CustomDividerHorizontal(),
                                Container(
                                  height: 200,
                                  child: SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    child: Container(
                                      width: 750,
                                      child: Column(
                                        children: [
                                          CustomDividerVertical(),
                                          Container(
                                            height: 50,
                                            color: Colors.grey[200],
                                            child: Row(
                                              children: [
                                                CustomDividerVertical(),
                                                Container(
                                                  width: 50,
                                                  child: Center(
                                                    child:
                                                        HeadingText('Sl.No.'),
                                                  ),
                                                ),
                                                CustomDividerVertical(),
                                                Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                        child: Center(
                                                            child: HeadingText(
                                                                'Item')))),
                                                CustomDividerVertical(),
                                                Expanded(
                                                    child: Container(
                                                        child: Center(
                                                            child: HeadingText(
                                                                'Price')))),
                                                // if (vatPercent != 0)
                                                //   CustomDividerVertical(),
                                                // if (vatPercent != 0)
                                                Expanded(
                                                    child: Container(
                                                        child: Center(
                                                            child: HeadingText(
                                                                '')))),
                                                CustomDividerVertical(),
                                                Container(
                                                  width: 50,
                                                  child: Center(
                                                    child: HeadingText('Qty.'),
                                                  ),
                                                ),
                                                CustomDividerVertical(),
                                                Container(
                                                  width: 60,
                                                  child: Center(
                                                    child: HeadingText('mop'),
                                                  ),
                                                ),
                                                CustomDividerVertical(),
                                                Container(
                                                  width: 60,
                                                  child: Center(
                                                    child: HeadingText('mrp'),
                                                  ),
                                                ),

                                                CustomDividerVertical(),
                                                Container(
                                                  width: 60,
                                                  child: Center(
                                                    child: HeadingText('Tax'),
                                                  ),
                                                ),

                                                CustomDividerVertical(),
                                                Expanded(
                                                    child: Container(
                                                        child: Center(
                                                            child: HeadingText(
                                                                'Total')))),
                                                CustomDividerVertical(),
                                              ],
                                            ),
                                          ),
                                          CustomDividerHorizontal(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: Container(
                                              color: Colors.grey[100],
                                              height: 100,
                                              child: ListView.builder(

                                                  //  controller: controller,
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  itemCount: plist.length,
                                                  itemBuilder: (ctx, index) {
                                                    // controllers
                                                    //     .add(new TextEditingController());
                                                    return Container(
                                                      height: 60,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            height: 0.3,
                                                            width: Constants(
                                                                        context)
                                                                    .scrnWidth +
                                                                400,
                                                            color: Colors.black,
                                                          ),
                                                          Container(
                                                            color:
                                                                Colors.grey[50],
                                                            height: 50,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                CustomDividerVertical(),
                                                                Container(
                                                                  width: 50,
                                                                  child: Center(
                                                                    child: ListText(
                                                                        (index +
                                                                                1)
                                                                            .toString()),
                                                                  ),
                                                                ),
                                                                CustomDividerVertical(),
                                                                Expanded(
                                                                    flex: 2,
                                                                    child: Container(
                                                                        child: Center(
                                                                            child:
                                                                                ListText(plist[index]['item_name'].toString())))),
                                                                CustomDividerVertical(),
                                                                Expanded(
                                                                    flex: 2,
                                                                    child: Container(
                                                                        child: Center(
                                                                            child:
                                                                                ListText(plist[index]['rate'].toString())))),
                                                                // Expanded(
                                                                //     child: Container(
                                                                //         child: Center(
                                                                //             child:
                                                                //                 TextField(
                                                                //   controller:
                                                                //       controllers[index],
                                                                //   decoration:
                                                                //       InputDecoration(
                                                                //           hintText: items[
                                                                //                   index]
                                                                //               ['price']!),
                                                                //   keyboardType:
                                                                //       TextInputType.number,
                                                                //   onTap: () {
                                                                //     controllers[index]
                                                                //             .selection =
                                                                //         TextSelection(
                                                                //             baseOffset: 0,
                                                                //             extentOffset:
                                                                //                 controllers[
                                                                //                         index]
                                                                //                     .value
                                                                //                     .text
                                                                //                     .length);
                                                                //   },
                                                                //   onChanged: (value) {
                                                                //     if (value.isEmpty) {
                                                                //       // controllers[index].text =
                                                                //       //     offlineProducts[int.parse(
                                                                //       //             selectedItem!)]
                                                                //       //         ['saleprice'];
                                                                //     } else {
                                                                //       setState(() {
                                                                //         subTotal = '0.0';
                                                                //         vatAmount = 0.0;
                                                                //         totalAmount = 0.0;
                                                                //         items[index][
                                                                //             'vprice'] = (double
                                                                //                     .parse(
                                                                //                         value) +
                                                                //                 double.parse(
                                                                //                         value) *
                                                                //                     vatPercent)
                                                                //             .toStringAsFixed(
                                                                //                 2);
                                                                //         items[index]
                                                                //                 ['price'] =
                                                                //             controllers[
                                                                //                     index]
                                                                //                 .text;

                                                                //         suTotal = items[
                                                                //                 index][
                                                                //             'total'] = (double
                                                                //                     .parse(
                                                                //                         value) *
                                                                //                 double.parse(
                                                                //                     items[index]
                                                                //                         [
                                                                //                         'qty']!))
                                                                //             .toStringAsFixed(
                                                                //                 2);
                                                                //         items[index][
                                                                //             'total'] = (double
                                                                //                     .parse(
                                                                //                         value) *
                                                                //                 double.parse(
                                                                //                     items[index]
                                                                //                         [
                                                                //                         'qty']!))
                                                                //             .toStringAsFixed(
                                                                //                 2);
                                                                //         for (var i = 0;
                                                                //             i <
                                                                //                 items
                                                                //                     .length;
                                                                //             i++) {
                                                                //           if (controllers[i]
                                                                //               .text
                                                                //               .isEmpty) {
                                                                //             subTotal = suTotal
                                                                //                 .toString();
                                                                //           } else {
                                                                //             subTotal = (double.parse(
                                                                //                         subTotal) +
                                                                //                     double.parse(controllers[i].text) *
                                                                //                         double.parse(items[i][
                                                                //                             'qty']!))
                                                                //                 .toStringAsFixed(
                                                                //                     2);
                                                                //           }
                                                                //           vatAmount = totalAmount +
                                                                //               double.parse(
                                                                //                   subTotal);

                                                                //           totAmount = subTotal ==
                                                                //                   "0"
                                                                //               ? 0 * 12
                                                                //               : double.parse(
                                                                //                           subTotal) *
                                                                //                       0.12 +
                                                                //                   totalAmount;
                                                                //           (double.parse(
                                                                //                   subTotal) +
                                                                //               vatAmount);
                                                                //           balance = double
                                                                //                   .parse(
                                                                //                       subTotal) +
                                                                //               totAmount!;
                                                                //         }
                                                                //       });
                                                                //     }
                                                                //   },
                                                                // )))),
                                                                // if (vatPercent != 0)
                                                                //   CustomDividerVertical(),
                                                                // if (vatPercent != 0)
                                                                // Expanded(
                                                                //     child: Container(
                                                                //         child: Center(
                                                                //             child: ListText(vatPercent >
                                                                //                     0
                                                                //                 ? items[index]
                                                                //                     [
                                                                //                     'vprice']
                                                                //                 : items[index]
                                                                //                     [
                                                                //                     'price'])))),
                                                                CustomDividerVertical(),
                                                                Container(
                                                                  width: 50,
                                                                  child: Center(
                                                                    child: ListText(plist[index]
                                                                            [
                                                                            'qty']
                                                                        .toString()),
                                                                  ),
                                                                ),
                                                                CustomDividerVertical(),
                                                                Container(
                                                                  width: 60,
                                                                  child: Center(
                                                                    child: ListText(plist[index]
                                                                            [
                                                                            'mop']
                                                                        .toString()),
                                                                  ),
                                                                ),
                                                                CustomDividerVertical(),
                                                                Container(
                                                                  width: 60,
                                                                  child: Center(
                                                                    child: ListText(plist[index]
                                                                            [
                                                                            'mrp']
                                                                        .toString()),
                                                                  ),
                                                                ),
                                                                CustomDividerVertical(),

                                                                Container(
                                                                  width: 60,
                                                                  child: Center(
                                                                    child: ListText(plist[index]
                                                                            [
                                                                            'tax_percentage']
                                                                        .toString()),
                                                                  ),
                                                                ),

                                                                CustomDividerVertical(),
                                                                Expanded(
                                                                    child: Container(
                                                                        child: Center(
                                                                            child:
                                                                                ListText(plist[index]['amount'].toString())))),
                                                                CustomDividerVertical(),
                                                                // Container(
                                                                //   width: 40,
                                                                //   child: Center(
                                                                //     child: IconButton(
                                                                //         onPressed: () {
                                                                //           double ttl =
                                                                //               0;
                                                                //           setState(() {
                                                                //             // items.removeAt(
                                                                //             //     index);
                                                                //             // controllers
                                                                //             //     .removeAt(
                                                                //             //         index);
                                                                //             // for (var i =
                                                                //             //         0;
                                                                //             //     i < items.length;
                                                                //             //     i++) {
                                                                //             //   ttl = ttl +
                                                                //             //       double.parse(items[i]['total']!);
                                                                //             // }
                                                                //             // subTotal =
                                                                //             //     ttl.toStringAsFixed(
                                                                //             //         2);
                                                                //           });
                                                                //         },
                                                                //         icon: Icon(
                                                                //           Icons.delete,
                                                                //           // color: primaryColor,
                                                                //           size: 20,
                                                                //         )),
                                                                //   ),
                                                                // ),

                                                                CustomDividerVertical()
                                                              ],
                                                            ),
                                                          ),
                                                          CustomDividerHorizontal()
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(),
                                // SingleChildScrollView(
                                //   scrollDirection: Axis.horizontal,
                                //   child: Container(
                                //     width: Constants(context).scrnWidth + 200,
                                //     child: Column(
                                //       children: [
                                //         Padding(
                                //           padding: const EdgeInsets.all(16.0),
                                //           child: Container(
                                //             color: Colors.grey[300],
                                //             child: Row(
                                //               children: [
                                //                 Container(
                                //                     width: 90,
                                //                     child: Padding(
                                //                       padding:
                                //                           const EdgeInsets.all(8.0),
                                //                       child: Text("ITEM"),
                                //                     )),
                                //                 Container(
                                //                     width: 90,
                                //                     child: Padding(
                                //                       padding:
                                //                           const EdgeInsets.all(8.0),
                                //                       child: Container(
                                //                           child: Padding(
                                //                         padding:
                                //                             const EdgeInsets.all(
                                //                                 8.0),
                                //                         child: Text("RATE"),
                                //                       )),
                                //                     )),
                                //                 Container(
                                //                     width: 90,
                                //                     child: Padding(
                                //                       padding:
                                //                           const EdgeInsets.all(8.0),
                                //                       child: Text("QTY"),
                                //                     )),
                                //                 Container(
                                //                     width: 90,
                                //                     child: Padding(
                                //                       padding:
                                //                           const EdgeInsets.all(8.0),
                                //                       child: Text("MOP"),
                                //                     )),
                                //                 Container(
                                //                     width: 90,
                                //                     child: Padding(
                                //                       padding:
                                //                           const EdgeInsets.all(8.0),
                                //                       child: Text("MRP"),
                                //                     )),
                                //                 Container(
                                //                     width: 90,
                                //                     child: Padding(
                                //                       padding:
                                //                           const EdgeInsets.all(8.0),
                                //                       child: Text("TAX"),
                                //                     ))
                                //               ],
                                //             ),
                                //           ),
                                //         ),
                                //         Padding(
                                //           padding: const EdgeInsets.all(8.0),
                                //           child: Container(
                                //             height: 120,
                                //             child: SingleChildScrollView(
                                //               child: ListView.builder(
                                //                   shrinkWrap: true,
                                //                   physics:
                                //                       NeverScrollableScrollPhysics(),
                                //                   itemCount: plist.length,
                                //                   itemBuilder: ((context, index) {
                                //                     return Card(
                                //                       child: Column(
                                //                         children: [
                                //                           Row(
                                //                             children: [
                                //                               Container(
                                //                                 width: 90,
                                //                                 child: Padding(
                                //                                   padding:
                                //                                       const EdgeInsets
                                //                                           .all(8.0),
                                //                                   child: Text(plist[
                                //                                                   index]
                                //                                               [
                                //                                               "item_name"] ==
                                //                                           null
                                //                                       ? ""
                                //                                       : plist[index]
                                //                                               [
                                //                                               "item_name"]
                                //                                           .toString()),
                                //                                 ),
                                //                               ),
                                //                               Expanded(
                                //                                   child: Container(
                                //                                 width: 90,
                                //                                 child: Padding(
                                //                                   padding:
                                //                                       const EdgeInsets
                                //                                           .all(8.0),
                                //                                   child: Text(plist[
                                //                                                   index]
                                //                                               [
                                //                                               "price_list_rate"] ==
                                //                                           null
                                //                                       ? ""
                                //                                       : plist[index]
                                //                                               [
                                //                                               "price_list_rate"]
                                //                                           .toString()),
                                //                                 ),
                                //                               )),
                                //                               Container(
                                //                                 width: 90,
                                //                                 child: Padding(
                                //                                   padding:
                                //                                       const EdgeInsets
                                //                                           .all(8.0),
                                //                                   child: Text(plist[
                                //                                                   index]
                                //                                               [
                                //                                               "qty"] ==
                                //                                           null
                                //                                       ? ""
                                //                                       : plist[index]
                                //                                               [
                                //                                               "qty"]
                                //                                           .toString()
                                //                                           .toString()),
                                //                                 ),
                                //                               ),
                                //                               Container(
                                //                                 width: 90,
                                //                                 child: Padding(
                                //                                   padding:
                                //                                       const EdgeInsets
                                //                                           .all(8.0),
                                //                                   child: Text(plist[
                                //                                                   index]
                                //                                               [
                                //                                               "mop"] ==
                                //                                           null
                                //                                       ? ""
                                //                                       : plist[index]
                                //                                               [
                                //                                               "mop"]
                                //                                           .toString()),
                                //                                 ),
                                //                               ),
                                //                               Container(
                                //                                 width: 90,
                                //                                 child: Padding(
                                //                                   padding:
                                //                                       const EdgeInsets
                                //                                           .all(8.0),
                                //                                   child: Text(plist[
                                //                                                   index]
                                //                                               [
                                //                                               "mrp"] ==
                                //                                           null
                                //                                       ? ""
                                //                                       : plist[index]
                                //                                               [
                                //                                               "mrp"]
                                //                                           .toString()),
                                //                                 ),
                                //                               ),
                                //                               Container(
                                //                                 width: 90,
                                //                                 child: Padding(
                                //                                   padding:
                                //                                       const EdgeInsets
                                //                                           .all(8.0),
                                //                                   child: Text(plist[
                                //                                                   index]
                                //                                               [
                                //                                               "tax"] ==
                                //                                           null
                                //                                       ? "12"
                                //                                       : tax
                                //                                           .toString()),
                                //                                 ),
                                //                               )
                                //                             ],
                                //                           )
                                //                         ],
                                //                       ),
                                //                     );
                                //                   })),
                                //             ),
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),

                                if (check == "true")
                                  Row(
                                    children: [
                                      Expanded(
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 52,
                                                margin: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  // border: Border.all(
                                                  //     color: Colors
                                                  //         .grey, // Set border color
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
                                                        child:
                                                            CustomSearchableDropDown(
                                                                primaryColor:
                                                                    Colors
                                                                        .black,
                                                                items:
                                                                    sourclist,
                                                                label: modeofpay
                                                                            .toString() ==
                                                                        "null"
                                                                    ? "Select Mode of pay"
                                                                    : modeofpay
                                                                        .toString(),
                                                                labelStyle: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black),
                                                                showLabelInMenu:
                                                                    true,
                                                                onChanged:
                                                                    (value) async {
                                                                  setState(() {
                                                                    dropdownvaluemode =
                                                                        value["name"]
                                                                            .toString();
                                                                    log(dropdownvaluemode
                                                                        .toString());
                                                                  });
                                                                },
                                                                dropDownMenuItems:
                                                                    sourcDropDown ==
                                                                            []
                                                                        ? ['']
                                                                        : sourcDropDown),
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
                                  ),

                                if (check == "true")
                                  Row(
                                    children: [
                                      // Icon(
                                      //   Icons.person_add,
                                      //   color: Colors.black,
                                      //   size: 17,
                                      // ),
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 00, left: 6, right: 6),
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
                                                      //     color: Colors.blue, // Set border color
                                                      //     width: 1.0),
                                                      color: Colors.white,
                                                      //    borderRadius: BorderRadius.circular(20)
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              right: 8.0),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: TextField(
                                                            controller:
                                                                qtycontroller,
                                                            // controller: ledgernameController,
                                                            textAlign:
                                                                TextAlign.left,
                                                            keyboardType:
                                                                TextInputType
                                                                    .name,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  "Collected Amount",
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 80,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 60,
                                      ),
                                      // Expanded(
                                      //   child: Container(
                                      //       // child: Center(
                                      //       // child:
                                      //       ),
                                      // ),
                                    ],
                                  ),
                                if (check == "true")
                                  Row(
                                    children: [
                                      // SizedBox(height: 100,)
                                    ],
                                  ),
                              ],
                            ),
                          ),
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
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 40,),
                      if (check != "true")
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14.0),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 42),
                                child: Container(
                                  width: Constants(context).scrnWidth,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        check = "true";
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary:
                                          Colors.grey[700], // Background color
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15.0),
                                      child: const Text(
                                        'ADD SALES ORDER',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 50,
                          width: Constants(context).scrnWidth,
                          child: ElevatedButton(
                            child: Text(
                              'SAVE ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontStyle: FontStyle.normal),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 15, 46, 148),
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
                              if (datelll == null) {
                                Fluttertoast.showToast(
                                    msg: "Please Add delivery date");
                              } else if (dropdownvaluemode != null &&
                                  qtycontroller.text.isEmpty) {
                                Fluttertoast.showToast(msg: "Add collection");
                              } else {
                                log("hii");
                                isLoading = true;
                                addRequirement(0, mapList, widget.leadtok);

                                Future.delayed(const Duration(seconds: 3), () {
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
                                isLoading
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,

                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          const Text(
                                            'Loading...',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        ],
                                      )
                                    : const Text('Submit');
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Future addRequirement(
    int inde,
    List a,
    String lead,
  ) async {
    //log(plist.firstWhere((plist) => plist["qty"]) + "hhhhhh");
    // log(lead.toString() + "lead name");
    // log(dropdownvaluesource.toString() + "bhvvnvvvnnbnbnn");
    log(taxeasarrray.toString());
    print(a.toString());
    log(a.toString() + "ngvvvvvvvvvvvbbbbbbbbbbbbbb");
    var productc = [];
    var array = [];
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    print(lead.toString() + 'rashidalead');
    for (var i = 0; i < plist.length; i++) {
      mapList.add({
        "item_code": plist[i]["item_code"],
        "description": plist[i]["item_code"],
        "item_group": plist[i]["item_group"],
        "prevdoc_docname": lead.toString(),
        "qty": plist[i]["qty"],
        "price_list_rate": plist[i]["price_list_rate"],
        "mop": plist[i]["mop"],
        "mrp": plist[i]["mrp"],
        "sub_dealer_price": plist[i]["sub_dealer_price"],
        "dealer_delivery_price": plist[i]["dealer_delivery_price"],
        "rate": plist[i]["rate"],
        "amount": plist[i]["amount"],
      });
    }

    for (var d = 0; d < a.length; d++) {
      // log(array[d].toString() + "hggvgvgvgvghggghghgh");
      array.add({
        "name": a[d]["name"] == null ? "" : a[d]["name"],
        'quantity': a[d]["qty"] == null ? "" : a[d]["qty"],
        "color": a[d]["color"] == null ? "" : a[d]["color"],
        "index": d,
      });
      log(array[d]["name"]);
      log(array[d].toString() + "hggvgvgvgvghggghghgh");

      // product = array[d]["name"];
      // Qty = array[d]["quantity"];
      // Series = array[d]["color"];

      //
    }
    // print(array[d]["name"]);
    // print(d.toString() + "hbmbhmbmbmnnmnmnm");

    // for (var i = 0; i < mapList.length; i++) {
    //   name = mapList[i]["name"];
    //   series = mapList[i]["color"];
    //   series = mapList[i]["color"];
    // }
    productc.toString();
    log(datelll.toString() + "bgbbbbbbbbbbbbbbbbbbbbbbbbb");
    log(datel.toString());

    plist.add({"quotation_id": lead.toString()});
    print('rashnote:   ' + productlist["note"]);
    //log(DateFormat('yy/MM/dd').format(datel!).toString());
    // log(array[d]["qty"].toString() + "mnhbbcfbbbbbbbbbgvgvhbjhjkljiikk");
    var baseUrl = urlMain + 'api/resource/Sales Order';
    final msg = jsonEncode({
      // "customer": "ANEESH",

      // "company": "Lamit",

      // "transaction_date": "2022-12-02",

      // "delivery_date": "2022-12-02",

      // "items": [

      //         {

      //             "item_code": "Roof Tile(Lamit)-DARK GREY",

      //             "delivery_date": "2022-12-02",

      //             "item_name": "Roof Tile(Lamit)-DARK GREY",

      //             "price_list_rate": 50.0,

      //             "qty":7,

      //             "mop": "40",

      //             "mrp": "50",

      //             "rate": 50.0,

      //             "amount": 50.0,

      //             "dealer_delivery_price": "20",

      //             "sub_dealer_price": "30"

      //         }

      //     ]

      // "quotation": lead.toString(),
      "mode_of_payment":
          dropdownvaluemode == null ? "" : dropdownvaluemode.toString(),
      "collected_amount": qtycontroller.text == "" ? "" : qtycontroller.text,
      "payment_status": "Collected",
      "collected_date": formattedDate.toString(),
      "super_stockist":
          productlist["company"] == null ? "" : productlist["company"],
      "customer": productlist["customer_name"] == null
          ? ""
          : productlist["customer_name"],
      "company": productlist["company"] == null ? "" : productlist["company"],
      "transaction_date": formattedDate.toString(),
      "valid_till":
          productlist["valid_till"] == null ? "" : productlist["valid_till"],
      "delivery_date": datel == null
          ? ""
          : DateFormat('yyyy/MM/dd').format(datel!).toString(),
      "all_vehicle_permissible": productlist["all_vehicle_permissible"] == null
          ? ""
          : productlist["all_vehicle_permissible"],
      "limited_vehicle_permissible_":
          vehicledrop == "All vehicle permissible" ? 0 : 1,
      "type_of_vehicle_go_to_site":
          productlist["type_of_vehicle_go_to_site"] == null
              ? ""
              : productlist["type_of_vehicle_go_to_site"],
      "tax_category": productlist["tax_category"] == null
          ? ""
          : productlist["tax_category"],
      "items": mapList,
      "all": productlist["all"].toString() == "0" ? 0 : 1,
      "taxes": taxeasarrray,
      "taxes_and_charges": productlist["taxes_and_charges"] == null
          ? ""
          : productlist["taxes_and_charges"],
      "sale_area": productlist["lac"],

      "goods_ape": productlist["goods_ape"].toString() == "0" ? 0 : 1,
      "sml_isuzu": productlist["sml_isuzu"].toString() == "0" ? 0 : 1,
      "mahindra_mini_truck":
          productlist["mahindra_mini_truck"].toString() == "0" ? 0 : 1,
      "mahindra_jeeto_plus":
          productlist["mahindra_jeeto_plus"].toString() == "0" ? 0 : 1,
      "tata_ace": productlist["tata_ace"].toString() == "0" ? 0 : 1,
      "mahindra_bolero_pickups":
          productlist["mahindra_bolero_pickups"].toString() == "0" ? 0 : 1,
      "tata_407": productlist["tata_407"].toString() == "0" ? 0 : 1,
      "eicher": productlist["eicher"].toString() == "0" ? 0 : 1,
      "bharat_benz": productlist["bharat_benz"].toString() == "0" ? 0 : 1,
      "note": (productlist["note"] == "") ? "" : productlist["note"].toString()
    });

    http.Response response =
        await http.post(Uri.parse(baseUrl), body: msg, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    });

    print(response.body);
    print(response.statusCode);
    print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
    if (response.statusCode == 200) {
      addcustomerstatus();
      print(response.body);
      print("haaaaaaaaaaaaaaaaaaaaaaaaa");
      String data = response.body;

      Fluttertoast.showToast(msg: "Order added");
      Future.delayed(Duration(seconds: 1), () {
        Get.to(SalesdetailView(widget.leadtok, "qt", "", "", "", widget.name));
      })

          //  Get.to(SalesdetailView(widget.name, "qt", "", "", "", widget.leadtok));
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
    } else {
      getsf();
    }
  }

  addcustomerstatus() async {
    log("hbbbbbbbbbbb");
    print("object");
    var s = productlist["name"];
    log(widget.name.toString() +
        "dvvvvvvvvvvvvvcjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj");

    final msg = jsonEncode({"created_salesorder": 1});

    http.Response response =
        await http.put(Uri.parse(urlMain + "api/resource/Quotation/$s"),
            headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'Authorization': Tocken,
            },
            body: msg);
    String data = response.body;

    // log(response.body);
    // print(response.statusCode);
    log(data + "hloooooooooooooooooooooooooooooooooooooooooooooooooooooo");
    if (response.statusCode == 200) {
      String data = response.body;
      //Fluttertoast.showToast(msg: "JJHHHHHHHHHHHHHHHH");
      log(data + "hloooooooooooooooooooooooooooooooooooooooooooooooooooooo");
      // log(productList[0]["note"]);
      //  print(data);
      // baisicDetailView2();
    } else {}
  }

  ///https://lamit.erpeaz.com/api/resource/Sales Taxes and Charges Template?filters=[["company","=","Super Stockist 1"],["tax_category","=","INSTATE"]]&fields=["tax_category","name"]
  Future getAllsource() async {
    log(email.toString());
    print("hiiiiiiiii");
    var baseUrl = urlMain +
        'api/resource/User Permission?fields=["for_value"]&filters=[["allow","=","Super Stockist"],["user","=","$email"]]';

    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    });
    log(response.body + "fffffffffffffffffffffffffffffffffffffffffffff");
    print(response.statusCode);
    print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
    if (response.statusCode == 200) {
      print(response.body);
      print("haaaaaaaaaaaaaaaaaaaaaaaaa");
      String data = response.body;
      var jsonData;
      log(data + "workclo,pnu");
      setState(() {
        jsonData = json.decode(data)["data"];
        sourcelist = jsonData;

        for (var i = 0; i < sourcelist.length; i++) {
          sourceDropDown.add(sourcelist[i]['for_value']);
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

  Future gettaxcharge() async {
    print("hiiiiiiiii");

    var baseUrl = urlMain +
        'api/resource/Sales Taxes and Charges Template?filters=[["company","=","Super Stockist 1"],["tax_category","=","INSTATE"]]&fields=["tax_category","name"]';

    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    });
    log(response.body + "taaaaaaaaaaaaaaaaaaaaaxcatagory");
    print(response.statusCode);
    print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
    if (response.statusCode == 200) {
      String data = response.body;
      print(response.body);
      print("haaaaaaaaaaaaaaaaaaaaaaaaa");
      // String data = response.body;
      // var jsonData;
      ;
      setState(() {
        // taxarr = jsonDecode(data)["data"][0]["name"];
      });
      log(taxarr.toString() + "vbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbnc");

      // log(jsonData.toString());
      //setState(() {});
    }
  }

  detailinvoceView() async {
    print("object");
    var s = widget.leadtok;
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
    // log(response.body + "hello biggi problem");
    print(response.statusCode);
    if (response.statusCode == 200) {
      String data = response.body;
      setState(() {
        //baisicDetail = jsonDecode(data)["data"];
        productlist = jsonDecode(data)["data"];
        plist = jsonDecode(data)["data"]["items"];
        selectedNote = productlist["note"];
      });
      print(selectedNote + '--note');
      // for (var i = 0; i < productlist.length; i++) {
      //   log("xgcgbvnbbmbmnbmn");
      //   log(productlist["taxes_and_charges"].toString() +
      //     "nnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
      taxesss(productlist["taxes_and_charges"]);

      log(productlist.toString() + "bvgvgbbgvgvvbvvv");
      // log(productList[0]["note"]);
      print(data);
      //  baisicDetailView2();
    } else {}
  }

  Future modeofpayment() async {
    print("hiiiiiiiii");
    var baseUrl = urlMain + "api/resource/Mode of Payment";

    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    });
    print(response.body + '----repoo');
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
          log(sourcDropDown.toString() + '---droop');
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

  Future taxesss(v) async {
    log("hiii");
    log(v.toString() +
        "gzgxgchvbgbjbxbxanchkgbln.mhlhnlmjnsgxgbcdjmfv.lh/n,.fnsbfsfbkgjgb,");
    print("hiiiiiiiii");
    var s = v;
    log(taxarr.toString());

    var baseUrl =
        //'https://lamit.erpeaz.com/api/resource/Sales Taxes and Charges Template?filters=[["company","=","$s"],["tax_category","=","INSTATE"]]';
        // 'https://lamit.erpeaz.com/api/resource/Sales Taxes and Charges Template?filters=[["company","=","$s"],["tax_category","=","INSTATE"]]';

        urlMain + 'api/resource/Sales Taxes and Charges Template/$s';
    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    });
    log(response.body + "taaaaaaaaaaaaaaaaaaaaaxcatagory");
    print(response.statusCode);
    print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
    if (response.statusCode == 200) {
      String data = response.body;
      print(response.body);
      print("haaaaaaaaaaaaaaaaaaaaaaaaa");
      // String data = response.body;
      // var jsonData;
      ;
      setState(() {
        taxes = jsonDecode(data)["data"];
        log(taxes.toString() +
            "hhhhhhhhhhhhhhhhhhhhhhhhhhhhhllllllllllllllllllllllllllll");
        log(taxes["taxes"][1]["charge_type"] + "gggggggggggggggggggggggggggg");
        taxes["taxes"][1]["charge_type"];
        for (var l = 0; l < taxes.length; l++) {
          //   log(double.pars);
          taxeasarrray.add(
            {
              "charge_type": taxes["taxes"][l]["charge_type"],
              "account_head": taxes["taxes"][l]["account_head"],
              "description": taxes["taxes"][l]["description"],
              "rate": jsonDecode(data)["data"]["taxes"][l]["rate"]
            },
          );
          // log(jsonDecode(data)["taxes"][i]["rate"]);

          log(taxeasarrray.toString() +
              "vbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbnc");
        }

        // charge_type = jsonDecode(data)["data"]["taxes"][0]["charge_type"];
        // account_head = jsonDecode(data)["data"]["taxes"][0]["account_head"];

        // description = jsonDecode(data)["data"]["taxes"][0][" description"];
      });

      // log(jsonData.toString());
      //setState(() {});
    }
  }

  //taxes_and_charges
}
