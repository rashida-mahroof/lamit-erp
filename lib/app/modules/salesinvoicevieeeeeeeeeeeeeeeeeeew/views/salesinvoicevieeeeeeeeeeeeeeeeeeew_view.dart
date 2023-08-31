import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import 'package:lamit/app/routes/constants.dart';
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/tocken/tockn.dart';
import 'package:lamit/widget/customeappbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SalesinvoicevieeeeeeeeeeeeeeeeeeewView extends StatefulWidget {
  final String leadtock;

  const SalesinvoicevieeeeeeeeeeeeeeeeeeewView(this.leadtock);

  @override
  State<SalesinvoicevieeeeeeeeeeeeeeeeeeewView> createState() =>
      _SalesinvoicevieeeeeeeeeeeeeeeeeeewViewState();
}

class _SalesinvoicevieeeeeeeeeeeeeeeeeeewViewState
    extends State<SalesinvoicevieeeeeeeeeeeeeeeeeeewView> {
  @override
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

  String? dropdownvaluesource;

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());

  // late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
  //     RestorableRouteFuture<DateTime?>(
  //   onComplete: _selectDate,
  //   onPresent: (NavigatorState navigator, Object? arguments) {
  //     return navigator.restorablePush(
  //       SalesviewView._datePickerRoute,
  //       arguments: _selectedDate.value.millisecondsSinceEpoch,
  //     );
  //  },
  // );

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

  String? email;

  getsf() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    email = preferences.getString("emailid");
    log(email.toString() + "bjcffzsxdfghjkl");
    detailinvoceView();
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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F9F9F9"),
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight),
        child: CustomAppBar(
          title: 'SALES INVOICE VIEW',
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: productlist == null
          ? Container()
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
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
                                                            : "Driver :" +
                                                                " " +
                                                                productlist[
                                                                        "driver1"]
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
                                                                            "vehicle_number"]
                                                                        .toString() ==
                                                                "null"
                                                            ? ""
                                                            : "Vehicle number" +
                                                                " : " +
                                                                productlist[
                                                                        "vehicle_number"]
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
                                                                            "driver_contact"]
                                                                        .toString() ==
                                                                "null"
                                                            ? ""
                                                            : "Driver contact" +
                                                                " : " +
                                                                productlist[
                                                                        "driver_contact"]
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
                                                                            "due_date"]
                                                                        .toString() ==
                                                                "null"
                                                            ? ""
                                                            : "Payment due" +
                                                                " : " +
                                                                productlist[
                                                                        "due_date"]
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

                              productlist["transaction_date"].toString() ==
                                      "null"
                                  ? Container()
                                  : Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        children: [
                                                          Text(productlist[
                                                                          "transaction_date"]
                                                                      .toString() ==
                                                                  "null"
                                                              ? ""
                                                              : DateFormat(
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
                                  // Expanded(
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.all(8.0),
                                  //     child: Padding(
                                  //       padding: const EdgeInsets.only(top: 00),
                                  //       child: Column(
                                  //         crossAxisAlignment:
                                  //             CrossAxisAlignment.start,
                                  //         children: [
                                  //           Padding(
                                  //             padding: const EdgeInsets.only(
                                  //                 left: 8.0, right: 8.0),
                                  //             child: Align(
                                  //               alignment: Alignment.centerLeft,
                                  //               child: Padding(
                                  //                 padding:
                                  //                     const EdgeInsets.only(
                                  //                         top: 8.0, bottom: 8),
                                  //                 child: Text(
                                  //                   "Possible Vehicle Service ",
                                  //                   style: TextStyle(
                                  //                       fontWeight:
                                  //                           FontWeight.bold,
                                  //                       fontSize: 14),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //           productlist["all"].toString() == "0"
                                  //               ? Container()
                                  //               : Padding(
                                  //                   padding:
                                  //                       const EdgeInsets.all(
                                  //                           8.0),
                                  //                   child: Text(productlist[
                                  //                               "all"] ==
                                  //                           1
                                  //                       ? "All"
                                  //                       : "All Vehichles Not Possible "
                                  //                           .toString()),
                                  //                 ),
                                  //           productlist["goods_ape"]
                                  //                       .toString() ==
                                  //                   "0"
                                  //               ? Container()
                                  //               : Padding(
                                  //                   padding:
                                  //                       const EdgeInsets.all(
                                  //                           8.0),
                                  //                   child: Text(productlist[
                                  //                               "goods_ape"] ==
                                  //                           1
                                  //                       ? "Goods ape"
                                  //                       : "Goods ape not possible"
                                  //                           .toString()),
                                  //                 ),
                                  //           plist[0]["sml_isuzu"].toString() ==
                                  //                   "0"
                                  //               ? Container()
                                  //               : Padding(
                                  //                   padding:
                                  //                       const EdgeInsets.all(
                                  //                           8.0),
                                  //                   child: Text(productlist[
                                  //                               "sml_isuzu"] ==
                                  //                           1
                                  //                       ? "Sml isuzu"
                                  //                       : "Sml isuzu not possible"
                                  //                           .toString()),
                                  //                 ),
                                  //           productlist["mahindra_mini_truck"]
                                  //                       .toString() ==
                                  //                   "0"
                                  //               ? Container()
                                  //               : Padding(
                                  //                   padding:
                                  //                       const EdgeInsets.all(
                                  //                           8.0),
                                  //                   child: Text(productlist[
                                  //                               "mahindra_mini_truck"] ==
                                  //                           1
                                  //                       ? "Mahindra mini truck"
                                  //                       : "Mahindra mini truck not possible"
                                  //                           .toString()),
                                  //                 ),
                                  //           productlist["mahindra_jeeto_plus"]
                                  //                       .toString() ==
                                  //                   "0"
                                  //               ? Container()
                                  //               : Padding(
                                  //                   padding:
                                  //                       const EdgeInsets.all(
                                  //                           8.0),
                                  //                   child: Text(productlist[
                                  //                               "mahindra_jeeto_plus"] ==
                                  //                           1
                                  //                       ? "Mahindra jeeto plus"
                                  //                       : "Mahindra jeeto plus not possible"
                                  //                           .toString()),
                                  //                 ),
                                  //           productlist["tata_ace"]
                                  //                       .toString() ==
                                  //                   "0"
                                  //               ? Container()
                                  //               : Padding(
                                  //                   padding:
                                  //                       const EdgeInsets.all(
                                  //                           8.0),
                                  //                   child: Text(productlist[
                                  //                               "tata_ace"] ==
                                  //                           1
                                  //                       ? "Tata ace"
                                  //                       : "Tata ace not possible"
                                  //                           .toString()),
                                  //                 ),
                                  //           productlist["mahindra_bolero_pickups"]
                                  //                       .toString() ==
                                  //                   "0"
                                  //               ? Container()
                                  //               : Padding(
                                  //                   padding:
                                  //                       const EdgeInsets.all(
                                  //                           8.0),
                                  //                   child: Text(productlist[
                                  //                               "mahindra_bolero_pickups"] ==
                                  //                           1
                                  //                       ? "Mahindra bolero pickups"
                                  //                       : "Mahindra bolero pickups not possible"
                                  //                           .toString()),
                                  //                 ),
                                  //           productlist["tata_407"]
                                  //                       .toString() ==
                                  //                   "0"
                                  //               ? Container()
                                  //               : Padding(
                                  //                   padding:
                                  //                       const EdgeInsets.all(
                                  //                           8.0),
                                  //                   child: Text(productlist[
                                  //                               "tata_407"] ==
                                  //                           1
                                  //                       ? "Tata 407"
                                  //                       : "Tata 407 not possible"
                                  //                           .toString()),
                                  //                 ),
                                  //           productlist["eicher"].toString() ==
                                  //                   "0"
                                  //               ? Container()
                                  //               : Padding(
                                  //                   padding:
                                  //                       const EdgeInsets.all(
                                  //                           8.0),
                                  //                   child: Text(productlist[
                                  //                               "eicher"] ==
                                  //                           1
                                  //                       ? "Eicher"
                                  //                       : "Eicher not possible"
                                  //                           .toString()),
                                  //                 ),
                                  //           productlist["bharat_benz"]
                                  //                       .toString() ==
                                  //                   "0"
                                  //               ? Container()
                                  //               : Padding(
                                  //                   padding:
                                  //                       const EdgeInsets.all(
                                  //                           8.0),
                                  //                   child: Text(productlist[
                                  //                               "bharat_benz"] ==
                                  //                           1
                                  //                       ? "Bharat benz"
                                  //                       : "bharat_benz not possible"
                                  //                           .toString()),
                                  //                 ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),

                                  // // // Expanded(
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
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  width: Constants(context).scrnWidth + 150,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Container(
                                          color: Colors.grey[300],
                                          child: Row(
                                            children: [
                                              Container(
                                                  width: 150,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text("ITEM"),
                                                  )),
                                              Container(
                                                  width: 70,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                        child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text("RATE"),
                                                    )),
                                                  )),
                                              Container(
                                                  width: 70,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text("QTY"),
                                                  )),
                                              Container(
                                                  width: 70,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text("MOP"),
                                                  )),
                                              Container(
                                                  width: 70,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text("MRP"),
                                                  )),
                                              Container(
                                                  width: 70,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text("TAX"),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 120,
                                          child: ListView.builder(
                                              itemCount: plist.length,
                                              itemBuilder: ((context, index) {
                                                return Card(
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 150,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(plist[
                                                                          index]
                                                                      [
                                                                      "item_name"]
                                                                  .toString()),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 70,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(plist[
                                                                          index]
                                                                      [
                                                                      "price_list_rate"]
                                                                  .toString()),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 70,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(plist[
                                                                          index]
                                                                      ["qty"]
                                                                  .toString()),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 70,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(plist[
                                                                          index]
                                                                      ["mop"]
                                                                  .toString()),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 70,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(plist[
                                                                          index]
                                                                      ["mrp"]
                                                                  .toString()),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 70,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(plist[
                                                                              index]
                                                                          [
                                                                          "tax_percentage"] ==
                                                                      null
                                                                  ? "nill"
                                                                  : plist[index]
                                                                          [
                                                                          "tax_percentage"]
                                                                      .toString()),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                );
                                              })),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Container(
                                      color: Colors.white,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Net Total : " +
                                                productlist["net_total"]
                                                    .toString()),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Grand Total : " +
                                                productlist["grand_total"]
                                                    .toString()),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Container(
                                        height: 30,
                                        color: Colors.white,
                                        child: Text("Tax amount : " +
                                            productlist[
                                                    "total_taxes_and_charges"]
                                                .toString()),
                                      ),
                                    ),
                                  )
                                ],
                              ),

                              // Padding(
                              //     padding: const EdgeInsets.all(16.0),
                              //     child: Container(
                              //       width: Constants(context).scrnWidth,
                              //       child: ElevatedButton(
                              //         onPressed: () {
                              //           setState(() {
                              //             // check = "true";
                              //           });
                              //         },
                              //         style: ElevatedButton.styleFrom(
                              //           primary: Colors
                              //               .grey[700], // Background color
                              //         ),
                              //         child: const Text(
                              //           'Genarate Pdf',
                              //           style: TextStyle(fontSize: 18),
                              //         ),
                              //       ),
                              //     )),
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

  detailinvoceView() async {
    print("object");
    var s = widget.leadtock;
    log(s + ",nsbhwvcxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    // var Tocken;
    http.Response response = await http.get(
      Uri.parse(urlMain + 'api/resource/Sales Invoice/$s'),
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
      log(productlist.toString() + "bvgvgbbgvgvvbvvv");
      // log(productList[0]["note"]);
      print(data);
      //  baisicDetailView2();
    } else {}
  }
}
