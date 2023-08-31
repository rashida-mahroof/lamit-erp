import 'dart:convert';
import 'dart:developer';

import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import 'package:lamit/app/modules/salesdetail/views/salesdetail_view.dart';
import 'package:lamit/app/routes/constants.dart';
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/tocken/tockn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddquatatView extends StatefulWidget {
  final String leadtok;

  final String restorationId = "main";
  final String name;
  final mapList;
  final String a1 = "0";
  AddquatatView(this.leadtok, this.name, this.mapList);

  @override
  State<AddquatatView> createState() => _AddquatatViewState();
}

class _AddquatatViewState extends State<AddquatatView> with RestorationMixin {
  String? get restorationId => widget.restorationId;

  String? a;
  String? mopprice;
  String? mrp;
  String? brand;
  String? tax;
  String? userID;
  String? subdealer;
  String? deler;
  double? subtotal = 0;
  double? total = 0;
  double? net = 0;
  double? totals;
  double? salestax;
  double? taxamount;
  String? qty;
  String? qtydupli;
  double? ta;
  bool value10 = false;
  bool valuefirst = false;
  bool valuesec = false;
  bool valuethird = false;
  bool valuefourth = false;
  bool valuefive = false;
  bool valuesix = false;
  bool value7 = false;
  bool value8 = false;
  bool value9 = false;

  bool isLoading = false;
  var sourcelist = [];
  var sourceDropDown = [];
  String? dropdownvaluesource;
  String? a1;
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
  String nos = "";
  String box = "";
  String? name;
  double? totaltd;
  //var i;
  String? productseries;
  List<Map<String, dynamic>> mapList = [];
  List<Map<String, dynamic>> finalList = [];

  TextEditingController descontroller = TextEditingController();
  TextEditingController qtycontroller = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController veh = TextEditingController();
  double? subto;
  String? productList;

  int? dropdownvalueArea;
  String? dropdownvalueselectne;
  String? vehicledrop;
  var vehtems = [
    'All vehicle permissible',
    'Limited vehicle permissible',
  ];

  @override
  Future getAllArea() async {
    print("hiiiiiiiii");
    var baseUrl = urlMain +
        'api/resource/Item?limit=1000&filters=[["has_variants", "=", "0"]] &fields=["name","product_series"]';

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

      setState(() {
        jsonData = json.decode(data)["data"];
        arealist = jsonData;
        for (var i = 0; i <= jsonData.length; i++) {
          setState(() {
            jsonData[i]["index"] = i;
          });

          ;
        }
      });
      ;

      // log(jsonData.toString());
      // setState(() {});
    }
  }

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
        subdealer = jsonDecode(data)["data"]["sub_dealer_price"].toString();
        deler = jsonDecode(data)["data"]["dealer_delivery_price"].toString();

        //arealist = jsonData;
      });
      log(mopprice.toString() + "bnbb nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");

      // log(jsonData.toString());
      // setState(() {});
    }
  }

  String? email;
  getsf() async {
    log(widget.mapList[0]["product"].toString());
    log(widget.mapList.toString());

    SharedPreferences preferences = await SharedPreferences.getInstance();

    email = preferences.getString("emailid");
    log(email.toString());
    getAllArea();

    getAllsource();

    name = preferences.getString("name");

    log(widget.mapList.toString() + "hbjhhhhhhhhhhhhhhhhhh");

    //getlac();
    // sales();

    //print(id.toString());
    //print(name.toString());

    // newleadView(id.toString());
  }

  var taxarr;
  @override
  void initState() {
    a1 = "0";
    getsf();
    // for (var i = 0; i < widget.mapList; i++) {
    //    qtycontroller = new TextEditingController(text: widget.);
    // }

    super.initState();
  }

  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yy').format(now);
    return Scaffold(
      backgroundColor: HexColor("#F9F9F9"),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: HexColor("#F9F9F9"),
        title: const Text(
          "ADD QUOTATION",
          style: TextStyle(
              color: Color.fromARGB(255, 5, 70, 123),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.to(
                SalesdetailView(widget.name, "", "", "", "", widget.leadtok));
          },
        ),
        elevation: 0,
        //  centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          //color: Colors.blue[50],
          color: HexColor("#F9F9F9"),
          child: Container(
            child: Container(
                child: Column(
              //  mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            // margin: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                                //color: Colors.white,
                                                ),
                                            child: CustomSearchableDropDown(
                                                primaryColor: Colors.black,
                                                items: sourcelist,
                                                label: 'Company',
                                                showLabelInMenu: true,
                                                onChanged: (value) async {
                                                  // log(value);
                                                  dropdownvaluesource =
                                                      value["for_value"]
                                                          .toString();
                                                  gettaxcharge();
                                                  log(dropdownvaluesource
                                                          .toString() +
                                                      "dmnnmbm,bm,bg,mb,DVXdzcg");
                                                },
                                                dropDownMenuItems:
                                                    sourceDropDown == []
                                                        ? ['']
                                                        : sourceDropDown),
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
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(formattedDate.toString())
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
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Container(
                      //           child: Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               Padding(
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: Padding(
                      //                   padding:
                      //                       const EdgeInsets.only(left: 8.0),
                      //                   child: Container(
                      //                     child: Text(
                      //                       "Expected Vallid Till Date",
                      //                       style: TextStyle(
                      //                         color: Colors.grey[700],
                      //                         fontSize: 14,
                      //                         // fontWeight: FontWeight.bold
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //               Container(
                      //                 height: 50,
                      //                 margin: EdgeInsets.all(5),
                      //                 decoration: BoxDecoration(
                      //                   // border: Border.all(
                      //                   //     color:
                      //                   //         Colors.grey, // Set border color
                      //                   //     width: 1.0),
                      //                   //  color: HexColor("#F9F9F9"),
                      //                   color: Colors.white,
                      //                   borderRadius: BorderRadius.circular(5),
                      //                 ),
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.only(
                      //                       left: 8.0, right: 8.0),
                      //                   child: Align(
                      //                     alignment: Alignment.centerLeft,
                      //                     child: Container(
                      //                       width: Constants(context).scrnWidth,
                      //                       child: TextButton(
                      //                         onPressed: () {
                      //                           // _keyboardVisible = true;
                      //                           _restorableDatePickerRouteFuture
                      //                               .present();
                      //                           a = "${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}";

                      //                           setState(() {
                      //                             a.toString();
                      //                           });
                      //                         },
                      //                         child: datelll == null
                      //                             ? Text(
                      //                                 'Valid Till',
                      //                                 style: TextStyle(
                      //                                     fontSize: 11,
                      //                                     color: Colors.black),
                      //                               )
                      //                             : Text(
                      //                                 datelll.toString(),
                      //                                 style: TextStyle(
                      //                                     color: Colors.black),
                      //                               ),
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
                      //   ],
                      // ),

                      Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 14),
                          child: Container(
                            //  color: Colors.white,
                            height: 50,
                            width: Constants(context).scrnWidth,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Vehicle "),
                            ),
                          )),

                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: Text(
                                            "Goods Ape",
                                            style: TextStyle(fontSize: 11),
                                          ),
                                        ),
                                      ),
                                      Checkbox(
                                        value: this.valuefirst,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.valuefirst = value!;
                                            a1 = "1";
                                            log(value.toString());
                                          });
                                        },
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Text("Sml Isuzu",
                                              style: TextStyle(fontSize: 11)),
                                        ),
                                      ),
                                      Checkbox(
                                        value: this.valuesec,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.valuesec = value!;
                                            a1 = "1";
                                            log(value.toString());
                                          });
                                        },
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Text("Eicher",
                                              style: TextStyle(fontSize: 11)),
                                        ),
                                      ),
                                      Checkbox(
                                        value: this.valuethird,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.valuethird = value!;
                                            a1 = "1";
                                            log(value.toString());
                                          });
                                        },
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
                                      Expanded(
                                        child: Container(
                                          child: Text(
                                            "Mahindra Mini Truck",
                                            style: TextStyle(fontSize: 11),
                                          ),
                                        ),
                                      ),
                                      Checkbox(
                                        value: this.valuefourth,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.valuefourth = value!;
                                            a1 = "1";
                                            log(value.toString());
                                          });
                                        },
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Text("Mahindra Jeeto Plus",
                                              style: TextStyle(fontSize: 11)),
                                        ),
                                      ),
                                      Checkbox(
                                        value: this.valuefive,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.valuefive = value!;
                                            a1 = "1";
                                            log(value.toString());
                                          });
                                        },
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Text("Tata 407",
                                              style: TextStyle(fontSize: 11)),
                                        ),
                                      ),
                                      Checkbox(
                                        value: this.valuesix,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.valuesix = value!;
                                            a1 = "1";
                                            log(value.toString());
                                          });
                                        },
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
                                      Expanded(
                                        child: Container(
                                          child: Text(
                                            "Mahindra Bolero Pickups",
                                            style: TextStyle(fontSize: 11),
                                          ),
                                        ),
                                      ),
                                      Checkbox(
                                        value: this.value7,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.value7 = value!;
                                            a1 = "1";
                                            log(value.toString());
                                          });
                                        },
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Text("Tata Ace",
                                              style: TextStyle(fontSize: 11)),
                                        ),
                                      ),
                                      Checkbox(
                                        value: this.value8,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.value8 = value!;
                                            a1 = "1";
                                            log(value.toString());
                                          });
                                        },
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Text("Bharat benz",
                                              style: TextStyle(fontSize: 11)),
                                        ),
                                      ),
                                      Checkbox(
                                        value: this.value9,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.value9 = value!;
                                            a1 = "1";
                                            log(value.toString());
                                          });
                                        },
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
                                      Container(
                                        width: 60,
                                        child: Text("All",
                                            style: TextStyle(fontSize: 11)),
                                      ),
                                      Checkbox(
                                        value: this.value10,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.value10 = value!;
                                            a1 = "1";
                                            log(value.toString());
                                          });
                                        },
                                      ),

                                      Expanded(
                                        child: Container(
                                          child: Text("",
                                              style: TextStyle(fontSize: 11)),
                                        ),
                                      ),
                                      Container(),
                                      // Checkbox(
                                      //   value: this.value8,
                                      //   onChanged: (bool? value) {
                                      //     setState(() {
                                      //       this.value8 = value!;
                                      //       log(value.toString());
                                      //     });
                                      //   },
                                      // ),
                                      Expanded(
                                        child: Container(
                                          child: Text("",
                                              style: TextStyle(fontSize: 11)),
                                        ),
                                      ),
                                      Container()
                                    ],
                                  ),
                                ),
                              ),

                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Container(
                              //     child: Row(
                              //       children: [
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ],
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

                          Expanded(
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
                                        height: 90,
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
                                            child: Container(
                                              height: 80,
                                              child: TextField(
                                                controller: descontroller,
                                                // controller: ledgernameController,
                                                textAlign: TextAlign.left,
                                                cursorColor: Colors.black,
                                                keyboardType:
                                                    TextInputType.name,
                                                decoration: InputDecoration(
                                                  hintText: "Notes",
                                                  border: InputBorder.none,
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
                          ),

                          // Expanded(
                          //   child: Container(
                          //       // child: Center(
                          //       // child:
                          //       ),
                          // ),
                        ],
                      ),

                      Row(
                        children: [
                          // Icon(
                          //   Icons.person_add,
                          //   color: Colors.black,
                          //   size: 17,
                          // ),
                          if (vehicledrop == "Limited vehicle permissible")
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            "Type of vehicle go to site",
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                              fontSize: 14,
                                              // fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                      ),
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
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: TextField(
                                              // controller: qtycontroller,
                                              controller: veh,
                                              textAlign: TextAlign.left,
                                              keyboardType: TextInputType.name,
                                              decoration: InputDecoration(
                                                hintText: "type of vehicle",
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

                      // Row(
                      //   children: [
                      //     Expanded(
                      //       flex: 2,
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Container(
                      //               height: 50,
                      //               margin: EdgeInsets.all(5),
                      //               decoration: BoxDecoration(
                      //                 // border: Border.all(
                      //                 //     color: Colors.blue, // Set border color
                      //                 //     width: 1.0),
                      //                 color: Colors.white,
                      //                 // borderRadius:
                      //                 //     BorderRadius.circular(20)
                      //               ),
                      //               child: Padding(
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: Row(
                      //                   children: [
                      //                     DropdownButton(
                      //                       //   icon: Icon(Icons.arrow_drop_down),
                      //                       underline: Container(),
                      //                       // itemHeight: 60,
                      //                       hint: Row(
                      //                         children: [
                      //                           Text('Product'),
                      //                           SizedBox(
                      //                             width: MediaQuery.of(context)
                      //                                     .size
                      //                                     .width *
                      //                                 0.1,
                      //                           )
                      //                         ],
                      //                       ),
                      //                       items: jsonData.map((item) {
                      //                         // setState(() {
                      //                         //   i = item;
                      //                         // });
                      //                         print(item.toString());
                      //                         return DropdownMenuItem(
                      //                           value: item["index"],
                      //                           child: Row(
                      //                             children: [
                      //                               Text(item["name"]
                      //                                   .toString()),
                      //                             ],
                      //                           ),
                      //                         );
                      //                       }).toList(),
                      //                       onChanged: (newVal) {
                      //                         setState(() {
                      //                           dropdownvalueArea = int.parse(
                      //                               newVal.toString());

                      //                           print(newVal.toString());
                      //                           print(newVal.toString());
                      //                           name = jsonData[int.parse(
                      //                               newVal.toString())]["name"];
                      //                           productseries = jsonData[
                      //                                   int.parse(
                      //                                       newVal.toString())]
                      //                               ["product_series"];

                      //                           productdetail(name.toString());

                      //                           // var i;
                      //                           // var a;
                      //                           // for (i = 0;
                      //                           //     i <= arealist.length;
                      //                           //     i++) {
                      //                           //   a = arealist;
                      //                           // }
                      //                           // print(a);

                      //                           // filterproduct(
                      //                           //     dropdownvalueArea.toString());
                      //                         });
                      //                       },
                      //                       value: dropdownvalueArea,
                      //                       icon: const Icon(
                      //                           Icons.keyboard_arrow_down),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      // widget.mapList.length == 0
                      //     ? Container()
                      //     : Container(
                      //         child: Padding(
                      //           padding:
                      //               const EdgeInsets.only(left: 12, right: 12),
                      //           child: Container(
                      //             height: 120,
                      //             width: Constants(context).scrnWidth,
                      //             child: ListView.builder(
                      //                 // physics:
                      //                 //     NeverScrollableScrollPhysics(),
                      //                 itemCount: 4,
                      //                 itemBuilder: ((context, index) {
                      //                   return Card(
                      //                     child: Container(
                      //                       //  color: Colors.blue[100],
                      //                       height: 90,
                      //                       child: Column(
                      //                         crossAxisAlignment:
                      //                             CrossAxisAlignment.start,
                      //                         children: [
                      //                           Padding(
                      //                             padding:
                      //                                 const EdgeInsets.all(8.0),
                      //                             child: Container(
                      //                               child: Row(
                      //                                 crossAxisAlignment:
                      //                                     CrossAxisAlignment
                      //                                         .center,
                      //                                 children: [
                      //                                   Expanded(
                      //                                       flex: 1,
                      //                                       child: Container(
                      //                                           child: Padding(
                      //                                         padding:
                      //                                             const EdgeInsets
                      //                                                 .all(8.0),
                      //                                         child: Text(
                      //                                             widget
                      //                                                 .mapList[
                      //                                                     0][
                      //                                                     "product"]
                      //                                                 .toString(),
                      //                                             style: TextStyle(
                      //                                                 fontSize:
                      //                                                     10)),
                      //                                       ))),

                      //                                   Expanded(
                      //                                       flex: 1,
                      //                                       child: Container(
                      //                                           child: Padding(
                      //                                         padding:
                      //                                             const EdgeInsets
                      //                                                 .all(8.0),
                      //                                         child: Text(
                      //                                             widget
                      //                                                 .mapList[
                      //                                                     0][
                      //                                                     "qty"]
                      //                                                 .toString(),
                      //                                             style: TextStyle(
                      //                                                 fontSize:
                      //                                                     10)),
                      //                                       ))),
                      //                                   Expanded(
                      //                                       flex: 1,
                      //                                       child: Container(
                      //                                           child: Padding(
                      //                                         padding:
                      //                                             const EdgeInsets
                      //                                                 .all(8.0),
                      //                                         child: Text(
                      //                                             widget
                      //                                                 .mapList[
                      //                                                     0][
                      //                                                     "color"]
                      //                                                 .toString(),
                      //                                             style: TextStyle(
                      //                                                 fontSize:
                      //                                                     10)),
                      //                                       ))),
                      //                                   Expanded(
                      //                                       flex: 1,
                      //                                       child: Container(
                      //                                           child: Padding(
                      //                                         padding:
                      //                                             const EdgeInsets
                      //                                                 .all(8.0),
                      //                                         child: Text(
                      //                                             widget
                      //                                                 .mapList[
                      //                                                     index]
                      //                                                     [
                      //                                                     "rate"]
                      //                                                 .toString(),
                      //                                             style: TextStyle(
                      //                                                 fontSize:
                      //                                                     9)),
                      //                                       ))),
                      //                                   Expanded(
                      //                                       flex: 1,
                      //                                       child: Container(
                      //                                           child: Padding(
                      //                                         padding:
                      //                                             const EdgeInsets
                      //                                                 .all(8.0),
                      //                                         child: Text(
                      //                                             widget
                      //                                                 .mapList[
                      //                                                     index]
                      //                                                     [
                      //                                                     "rate"]
                      //                                                 .toString(),
                      //                                             style: TextStyle(
                      //                                                 fontSize:
                      //                                                     9)),
                      //                                       ))),

                      //                                   //     flex: 3,
                      //                                   //     child: Container(
                      //                                   //         child:
                      //                                   //             Padding(
                      //                                   //       padding:
                      //                                   //           const EdgeInsets
                      //                                   //                   .all(
                      //                                   //               8.0),
                      //                                   //       child: Text(
                      //                                   //           mapList[index]["brand"] ==
                      //                                   //                   null
                      //                                   //               ? ""
                      //                                   //               : mapList[index]
                      //                                   //                   [
                      //                                   //                   "brand"],
                      //                                   //           style: TextStyle(
                      //                                   //               fontSize:
                      //                                   //                   9)),
                      //                                   //     ))),
                      //                                 ],
                      //                               ),
                      //                             ),
                      //                           ),
                      //                           Column(
                      //                             children: [],
                      //                           ),
                      //                           // Expanded(
                      //                           //     child: Container(
                      //                           //         child: Padding(
                      //                           //   padding:
                      //                           //       const EdgeInsets
                      //                           //               .all(
                      //                           //           8.0),
                      //                           //   child: Row(
                      //                           //     children: [
                      //                           //       Text(
                      //                           //         "SUB DELEAR PRICE :",
                      //                           //         style:
                      //                           //             TextStyle(
                      //                           //           fontSize:
                      //                           //               9,
                      //                           //         ),
                      //                           //       ),
                      //                           //       Text(
                      //                           //         mapList[index]["sub_dealer"] ==
                      //                           //                 "null"
                      //                           //             ? "PRICE NOT ADDED"
                      //                           //             : mapList[index]["sub_dealer"].toString(),
                      //                           //         style: TextStyle(
                      //                           //             fontSize:
                      //                           //                 9,
                      //                           //             fontWeight:
                      //                           //                 FontWeight.bold),
                      //                           //       ),
                      //                           //     ],
                      //                           //   ),
                      //                           // ))),
                      //                           // Expanded(
                      //                           //     child: Container(
                      //                           //         child: Row(
                      //                           //   children: [
                      //                           //     Padding(
                      //                           //       padding: const EdgeInsets
                      //                           //               .only(
                      //                           //           left:
                      //                           //               8),
                      //                           //       child:
                      //                           //           Text(
                      //                           //         "DELEAR PRICE :",
                      //                           //         style:
                      //                           //             TextStyle(
                      //                           //           fontSize:
                      //                           //               9,
                      //                           //         ),
                      //                           //       ),
                      //                           //     ),
                      //                           //     Text(
                      //                           //       mapList[index]["dealer_delivery"] ==
                      //                           //               "null"
                      //                           //           ? "PRICE NOT ADDED"
                      //                           //           : mapList[index]
                      //                           //               [
                      //                           //               "dealer_delivery"],
                      //                           //       style: TextStyle(
                      //                           //           fontSize:
                      //                           //               9,
                      //                           //           fontWeight:
                      //                           //               FontWeight.bold),
                      //                           //     ),
                      //                           //   ],
                      //                           // )))
                      //                         ],
                      //                       ),
                      //                     ),
                      //                   );
                      //                 })),
                      //           ),
                      //         ),
                      //       ),

                      widget.mapList.length == 0
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: Container(
                                              color: Colors.grey[100],
                                              height: 50,
                                              width:
                                                  Constants(context).scrnWidth +
                                                      300,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      width: 70,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text("Name",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      10)),
                                                        ),
                                                      )),
                                                  Container(
                                                      width: 70,
                                                      child: Padding(
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
                                                      )),
                                                  Container(
                                                      width: 70,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text("MRP",
                                                            style: TextStyle(
                                                                fontSize: 10)),
                                                      )),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                        width: 70,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            "QTY",
                                                            style: TextStyle(
                                                                fontSize: 10),
                                                          ),
                                                        )),
                                                  ),

                                                  Container(
                                                      width: 70,
                                                      child: Text(
                                                        "PRICE",
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      )),
                                                  Container(
                                                      width: 70,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                            "SUB DELEAR PRICE",
                                                            style: TextStyle(
                                                                fontSize: 10)),
                                                      )),
                                                  Container(
                                                      width: 70,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                            "DELEAR PRICE",
                                                            style: TextStyle(
                                                                fontSize: 10)),
                                                      )),
                                                  // Expanded(
                                                  //     child: Container(
                                                  //         child: Padding(
                                                  //   padding: const EdgeInsets.all(8.0),
                                                  //   child: Text("BRAND",
                                                  //       style: TextStyle(fontSize: 10)),
                                                  // ))),
                                                  Container(
                                                      width: 70,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          "TAX",
                                                          style: TextStyle(
                                                              fontSize: 10),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12, right: 12),
                                                child: Container(
                                                  height: 160,
                                                  width: Constants(context)
                                                          .scrnWidth +
                                                      300,
                                                  child: ListView.builder(
                                                      // physics:
                                                      //     NeverScrollableScrollPhysics(),
                                                      itemCount:
                                                          widget.mapList.length,
                                                      itemBuilder:
                                                          ((context, index) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black)),
                                                            // color: Colors.blue[50],
                                                            height: 120,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      Container(
                                                                    child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Container(
                                                                            width:
                                                                                70,
                                                                            child:
                                                                                Container(child: Text(widget.mapList[index]["product"] == null ? "" : widget.mapList[index]["product"].toString(), style: TextStyle(fontSize: 9)))),
                                                                        Container(
                                                                            width:
                                                                                70,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Text(widget.mapList[index]["mop"] == null ? "" : widget.mapList[index]["mop"].toString(), style: TextStyle(fontSize: 9)),
                                                                            )),
                                                                        Container(
                                                                            width:
                                                                                70,
                                                                            child:
                                                                                Text(widget.mapList[index]["mrp"] == null ? "" : widget.mapList[index]["mrp"].toString(), style: TextStyle(fontSize: 9))),

                                                                        Container(
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Container(
                                                                                width: 70,
                                                                                height: 50,
                                                                                margin: EdgeInsets.all(0),
                                                                                decoration: BoxDecoration(
                                                                                    // border: Border.all(
                                                                                    //     color: Colors.blue, // Set border color
                                                                                    //     width: 1.0),
                                                                                    // color: Colors.white,
                                                                                    //    borderRadius: BorderRadius.circular(20)
                                                                                    ),
                                                                                child: Align(
                                                                                  alignment: Alignment.centerLeft,
                                                                                  child: TextField(
                                                                                    style: TextStyle(fontSize: 12),
                                                                                    controller: qtycontroller,
                                                                                    // controller: ledgernameController,
                                                                                    textAlign: TextAlign.left,

                                                                                    keyboardType: TextInputType.name,
                                                                                    decoration: InputDecoration(
                                                                                      hintText: "Enter quantity",
                                                                                      border: InputBorder.none,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          //  width: 70,
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Container(
                                                                                height: 50,
                                                                                width: 70,
                                                                                margin: EdgeInsets.all(0),
                                                                                decoration: BoxDecoration(
                                                                                    // border: Border.all(
                                                                                    //     color: Colors.blue, // Set border color
                                                                                    //     width: 1.0),
                                                                                    // color: Colors.white,
                                                                                    //    borderRadius: BorderRadius.circular(20)
                                                                                    ),
                                                                                child: Align(
                                                                                  alignment: Alignment.centerLeft,
                                                                                  child: TextField(
                                                                                    style: TextStyle(fontSize: 11),
                                                                                    controller: price,
                                                                                    // controller: ledgernameController,
                                                                                    textAlign: TextAlign.left,
                                                                                    keyboardType: TextInputType.name,
                                                                                    decoration: InputDecoration(
                                                                                      hintText: "Enter.. ",
                                                                                      border: InputBorder.none,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),

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

                                                                        Container(
                                                                            width:
                                                                                70,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(16.0),
                                                                              child: Text(widget.mapList[index]["subdealer_price"] == null ? "" : widget.mapList[index]["subdealer_price"].toString(), style: TextStyle(fontSize: 10)),
                                                                            )),

                                                                        Container(
                                                                            width:
                                                                                70,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(16.0),
                                                                              child: Text(widget.mapList[index]["dealer_price"] == null ? "" : widget.mapList[index]["dealer_price"].toString(), style: TextStyle(fontSize: 10)),
                                                                            )),

                                                                        Container(
                                                                            width:
                                                                                70,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Text(widget.mapList[index]["tax"] == null ? "" : widget.mapList[index]["tax"].toString(), style: TextStyle(fontSize: 10)),
                                                                              ),
                                                                            )),
                                                                        Container(
                                                                            width:
                                                                                70,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: IconButton(
                                                                                  icon: Icon(
                                                                                    size: 18,
                                                                                    Icons.add,
                                                                                    color: Colors.green,
                                                                                  ),
                                                                                  onPressed: () {
                                                                                    if (dropdownvalueArea == "") {
                                                                                      Fluttertoast.showToast(msg: "Select Product");
                                                                                    } else if (qtycontroller.text.isEmpty) {
                                                                                      Fluttertoast.showToast(msg: "Enter Quantity");
                                                                                    } else if (price.text.isEmpty) {
                                                                                      Fluttertoast.showToast(msg: "Enter Price");
                                                                                    } else {
                                                                                      setState(() {
                                                                                        ta = 12;
                                                                                        subtotal = double.parse(qtycontroller.text) * double.parse(price.text);
                                                                                        log(subtotal.toString());

                                                                                        // total = double.parse(qtycontroller.text) *
                                                                                        //     double.parse(price.text);
                                                                                        log(subtotal.toString());
                                                                                        totals = double.parse(qtycontroller.text) * double.parse(price.text);
                                                                                        // total = subtotal == null
                                                                                        //     ? 0
                                                                                        //     : subtotal! +
                                                                                        //         (double.parse(
                                                                                        //                 qtycontroller.text) *
                                                                                        //             double.parse(price.text));

                                                                                        // salestax =
                                                                                        //  total * 18.toDouble()!;
                                                                                        // taxamount = total - salestax;
                                                                                        mapList.add({
                                                                                          "item_code": widget.mapList[index]["product"] == null ? "" : widget.mapList[index]["product"],
                                                                                          "item_name": widget.mapList[index]["product"] == null ? "" : widget.mapList[index]["product"],

                                                                                          "item_series": widget.mapList[index]["color"] == null ? "" : widget.mapList[index]["color"],

                                                                                          "description": widget.mapList[index]["product"] == null ? "" : widget.mapList[index]["product"],
                                                                                          "item_group": widget.mapList[index]["product_group"] == null ? "" : widget.mapList[index]["product_group"].toString(),
                                                                                          "image": "",
                                                                                          "qty": qtycontroller == "" ? "1" : qtycontroller.text,
                                                                                          "dealer_delivery": widget.mapList[index]["dealer_price"] == null ? "" : widget.mapList[index]["subdealer_price"],
                                                                                          "subdealer_price": widget.mapList[index]["subdealer_price"] == null ? "" : widget.mapList[index]["subdealer_price"],
                                                                                          "mop": widget.mapList[index]["mop"] == null ? "" : widget.mapList[index]["mop"],
                                                                                          "mrp": widget.mapList[index]["mrp"] == null ? "" : widget.mapList[index]["mop"],
                                                                                          "tax_percentage": "12",
                                                                                          "uom": "Nos",
                                                                                          "price_list_rate": price.text.toString(),
                                                                                          "rate": price.text.toString(),

                                                                                          "amount": double.parse(qtycontroller.text) * double.parse(price.text)

                                                                                          // "name":
                                                                                          //     name == null ? "" : name.toString(),
                                                                                          // "qty": qtycontroller == ""
                                                                                          //     ? "1"
                                                                                          //     : qtycontroller.text.toString(),
                                                                                          // "color": productseries.toString(),
                                                                                          // "mopprice": mopprice.toString(),
                                                                                          // "mrp": mrp.toString(),
                                                                                          // "brand": brand.toString(),
                                                                                          // "tax": tax.toString(),
                                                                                          // "subdeler": subdealer.toString(),
                                                                                          // "deler": deler.toString(),
                                                                                          // "price": price.text.toString(),
                                                                                        });
                                                                                      });

                                                                                      qtycontroller.clear();
                                                                                      price.clear();
                                                                                    }

                                                                                    for (var i = 0; i < mapList.length; i++) {
                                                                                      log(mapList[i]["qty"]);
                                                                                      log(mapList[i]["price_list_rate"]);

                                                                                      setState(() {
                                                                                        log(mapList[i]["amount"].toString() + "amount");
                                                                                        totaltd = mapList[i]["amount"];
                                                                                        subto = mapList[i]["amount"];

                                                                                        // (double.parse(mapList[i]["qty"])) *
                                                                                        //     (double.parse(mapList[i]
                                                                                        //         ["price_list_rate"]))
                                                                                        // );
                                                                                      });

                                                                                      log(total.toString());

                                                                                      ;
                                                                                    }
                                                                                    log(totaltd.toString() + "totaltdddddddddddddddddddddd");
                                                                                    log(totaltd.toString());
                                                                                    total = total! + subtotal!;
                                                                                    net = total == null ? 0 * 12 : total! * 0.12 + total!;
                                                                                  },
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

                      dropdownvalueArea == null
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  child: SingleChildScrollView(
                                    //  scrollDirection: Axis.horizontal,
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: Container(
                                              color: Colors.grey[100],
                                              height: 50,
                                              width:
                                                  Constants(context).scrnWidth,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                      child: Container(
                                                          child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text("MOP",
                                                          style: TextStyle(
                                                              fontSize: 10)),
                                                    ),
                                                  ))),
                                                  Expanded(
                                                      child: Container(
                                                          child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text("MRP",
                                                        style: TextStyle(
                                                            fontSize: 10)),
                                                  ))),
                                                  Expanded(
                                                      child: Container(
                                                          child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                        "SUB DELEAR PRICE",
                                                        style: TextStyle(
                                                            fontSize: 10)),
                                                  ))),
                                                  Expanded(
                                                      child: Container(
                                                          child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text("DELEAR PRICE",
                                                        style: TextStyle(
                                                            fontSize: 10)),
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
                                                          child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
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
                                            padding: const EdgeInsets.all(3.0),
                                            child: Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12, right: 12),
                                                child: Container(
                                                  height: 100,
                                                  width: Constants(context)
                                                      .scrnWidth,
                                                  child: ListView.builder(
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemCount: 1,
                                                      itemBuilder:
                                                          ((context, index) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black)),
                                                            // color: Colors.blue[50],
                                                            height: 70,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      Container(
                                                                    child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Expanded(
                                                                            flex:
                                                                                3,
                                                                            child: Container(
                                                                                child: Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Text(mopprice == null ? "" : mopprice.toString(), style: TextStyle(fontSize: 9)),
                                                                            ))),
                                                                        Expanded(
                                                                            flex:
                                                                                3,
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
                                                                            flex:
                                                                                3,
                                                                            child: Container(
                                                                                child: Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Text(subdealer == null ? "not added" : subdealer.toString(), style: TextStyle(fontSize: 10)),
                                                                            ))),

                                                                        Expanded(
                                                                            flex:
                                                                                3,
                                                                            child: Container(
                                                                                child: Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Text(deler == null ? "not added" : deler.toString(), style: TextStyle(fontSize: 10)),
                                                                            ))),

                                                                        Container(
                                                                            width:
                                                                                70,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Text(tax == null ? "" : tax.toString(), style: TextStyle(fontSize: 10)),
                                                                              ),
                                                                            )),

                                                                        Container(
                                                                            width:
                                                                                70,
                                                                            child:
                                                                                Padding(
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

                      // dropdownvalueArea == null
                      //     ? Container()
                      //     : Row(
                      //         children: [
                      //           // Icon(
                      //           //   Icons.person_add,
                      //           //   color: Colors.black,
                      //           //   size: 17,
                      //           // ),
                      //           Expanded(
                      //             child: Padding(
                      //               padding: const EdgeInsets.all(8.0),
                      //               child: Padding(
                      //                 padding: const EdgeInsets.only(
                      //                     top: 00, left: 6, right: 6),
                      //                 child: Container(
                      //                   child: Column(
                      //                     crossAxisAlignment:
                      //                         CrossAxisAlignment.start,
                      //                     children: [
                      //                       Container(
                      //                         height: 50,
                      //                         margin: EdgeInsets.all(0),
                      //                         decoration: BoxDecoration(
                      //                           // border: Border.all(
                      //                           //     color: Colors.blue, // Set border color
                      //                           //     width: 1.0),
                      //                           color: Colors.white,
                      //                           //    borderRadius: BorderRadius.circular(20)
                      //                         ),
                      //                         child: Padding(
                      //                           padding: const EdgeInsets.only(
                      //                               left: 8.0, right: 8.0),
                      //                           child: Align(
                      //                             alignment:
                      //                                 Alignment.centerLeft,
                      //                             child: TextField(
                      //                               controller: price,
                      //                               // controller: ledgernameController,
                      //                               textAlign: TextAlign.left,
                      //                               keyboardType:
                      //                                   TextInputType.name,
                      //                               decoration: InputDecoration(
                      //                                 hintText: "price",
                      //                                 border: InputBorder.none,
                      //                               ),
                      //                             ),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),

                      //           // Expanded(
                      //           //   child: Container(
                      //           //       // child: Center(
                      //           //       // child:
                      //           //       ),
                      //           // ),
                      //         ],
                      //       ),

                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Container(
                          child: Row(
                            children: [
                              // Icon(
                              //   Icons.person_add,
                              //   color: Colors.black,
                              //   size: 17,
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
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
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(
                            //   height: 30,
                            // ),
                            // Container(
                            //   height: 40,
                            //   width: Constants(context).scrnWidth,
                            //   child: ElevatedButton(
                            //     child: Text('ADD PRODUCT ',
                            //         style: TextStyle(
                            //             color: Color.fromARGB(255, 27, 3, 3),
                            //             fontSize: 14,
                            //             fontStyle: FontStyle.normal)),
                            //     style: ElevatedButton.styleFrom(
                            //       primary: Color.fromARGB(255, 227, 215, 224),
                            //       // side: BorderSide(color: Colors.yellow, width: 5),
                            //       textStyle: TextStyle(
                            //           color: Color.fromARGB(255, 167, 164, 164),
                            //           fontSize: 18,
                            //           fontStyle: FontStyle.normal),
                            //     ),
                            //     onPressed: () {
                            //       if (dropdownvalueArea == "") {
                            //         Fluttertoast.showToast(
                            //             msg: "Select Product");
                            //       } else if (qtycontroller!.text.isEmpty) {
                            //         Fluttertoast.showToast(
                            //             msg: "Enter Quantity");
                            //       } else if (price.text.isEmpty) {
                            //         Fluttertoast.showToast(msg: "Enter Price");
                            //       } else {
                            //         setState(() {
                            //           ta = 12;
                            //           subtotal =
                            //               double.parse(qtycontroller!.text) *
                            //                   double.parse(price.text);
                            //           log(subtotal.toString());

                            //           // total = double.parse(qtycontroller.text) *
                            //           //     double.parse(price.text);
                            //           log(subtotal.toString());
                            //           totals =
                            //               double.parse(qtycontroller!.text) *
                            //                   double.parse(price.text);
                            //           // total = subtotal == null
                            //           //     ? 0
                            //           //     : subtotal! +
                            //           //         (double.parse(
                            //           //                 qtycontroller.text) *
                            //           //             double.parse(price.text));

                            //           // salestax =
                            //           //  total * 18.toDouble()!;
                            //           // taxamount = total - salestax;
                            //           mapList.add({
                            //             "item_code":
                            //                 name == null ? "" : name.toString(),
                            //             "item_name":
                            //                 name == null ? "" : name.toString(),
                            //             "item_series": productseries.toString(),
                            //             "description":
                            //                 name == null ? "" : name.toString(),
                            //             "item_group": brand.toString(),
                            //             "image": "",
                            //             "qty": qtycontroller == ""
                            //                 ? "1"
                            //                 : qtycontroller!.text,
                            //             "dealer_delivery": deler.toString(),
                            //             "sub_dealer_": subdealer.toString(),
                            //             "mop": mopprice.toString(),
                            //             "mrp": mrp.toString(),
                            //             "tax_percentage": tax,
                            //             "uom": "Nos",
                            //             "price_list_rate":
                            //                 price.text.toString(),
                            //             "rate": price.text.toString(),

                            //             "amount":
                            //                 double.parse(qtycontroller!.text) *
                            //                     double.parse(price.text)

                            //             // "name":
                            //             //     name == null ? "" : name.toString(),
                            //             // "qty": qtycontroller == ""
                            //             //     ? "1"
                            //             //     : qtycontroller.text.toString(),
                            //             // "color": productseries.toString(),
                            //             // "mopprice": mopprice.toString(),
                            //             // "mrp": mrp.toString(),
                            //             // "brand": brand.toString(),
                            //             // "tax": tax.toString(),
                            //             // "subdeler": subdealer.toString(),
                            //             // "deler": deler.toString(),
                            //             // "price": price.text.toString(),
                            //           });
                            //         });

                            //         qtycontroller!.clear();
                            //         price.clear();
                            //       }

                            //       for (var i = 0; i < mapList.length; i++) {
                            //         log(mapList[i]["qty"]);
                            //         log(mapList[i]["price_list_rate"]);

                            //         setState(() {
                            //           log(mapList[i]["amount"].toString() +
                            //               "amount");
                            //           totaltd = mapList[i]["amount"];
                            //           subto = mapList[i]["amount"];

                            //           // (double.parse(mapList[i]["qty"])) *
                            //           //     (double.parse(mapList[i]
                            //           //         ["price_list_rate"]))
                            //           // );
                            //         });

                            //         log(total.toString());

                            //         ;
                            //       }
                            //       log(totaltd.toString() +
                            //           "totaltdddddddddddddddddddddd");
                            //       log(totaltd.toString());
                            //       total = total! + subtotal!;
                            //       net = total == null
                            //           ? 0 * 12
                            //           : total! * 0.12 + total!;
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                mapList.length == 0
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 40),
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
                                      mapList.length == 0
                                          ? Container()
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16, right: 16),
                                              child: Container(
                                                color: Colors.grey[100],
                                                height: 50,
                                                width: Constants(context)
                                                    .scrnWidth,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 70,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 14),
                                                        child: Container(
                                                            child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            "ITEM",
                                                            style: TextStyle(
                                                                fontSize: 10),
                                                          ),
                                                        )),
                                                      ),
                                                    ),
                                                    Container(
                                                        width: 70,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text("QTY",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        10)),
                                                          ),
                                                        )),
                                                    Container(
                                                        width: 70,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                              "   SERIES",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      10)),
                                                        )),
                                                    Container(
                                                        width: 70,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text("PRICE",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      10)),
                                                        )),
                                                    Container(
                                                        width: 70,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                              "Subtotal",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      10)),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                      mapList.length == 0
                                          ? Container()
                                          : Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12, right: 12),
                                                child: Container(
                                                  height: 120,
                                                  width: Constants(context)
                                                      .scrnWidth,
                                                  child: ListView.builder(
                                                      // physics:
                                                      //     NeverScrollableScrollPhysics(),
                                                      itemCount: mapList.length,
                                                      itemBuilder:
                                                          ((context, index) {
                                                        return Card(
                                                          child: Container(
                                                            //  color: Colors.blue[100],
                                                            height: 110,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      Container(
                                                                    child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Expanded(
                                                                            flex:
                                                                                1,
                                                                            child: Container(
                                                                                child: Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Text(mapList[index]["item_name"] == "" ? "" : mapList[index]["item_name"], style: TextStyle(fontSize: 10)),
                                                                            ))),

                                                                        Expanded(
                                                                            flex:
                                                                                1,
                                                                            child: Container(
                                                                                child: Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Text(mapList[index]["qty"], style: TextStyle(fontSize: 10)),
                                                                            ))),
                                                                        Expanded(
                                                                            flex:
                                                                                1,
                                                                            child: Container(
                                                                                child: Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Text(mapList[index]["item_series"] == "null" ? "" : mapList[index]["item_series"], style: TextStyle(fontSize: 10)),
                                                                            ))),
                                                                        Expanded(
                                                                            flex:
                                                                                1,
                                                                            child: Container(
                                                                                child: Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Text(mapList[index]["rate"] == "null" ? "" : mapList[index]["rate"], style: TextStyle(fontSize: 9)),
                                                                            ))),
                                                                        Expanded(
                                                                            flex:
                                                                                1,
                                                                            child: Container(
                                                                                child: Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Text(mapList[index]["amount"] == "null" ? "" : mapList[index]["amount"].toString(), style: TextStyle(fontSize: 9)),
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              subtotal == null
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("SUBTOTAL :" + "",
                                          style: TextStyle(fontSize: 11)),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "SUBTOTAL :" + subtotal.toString(),
                                        style: TextStyle(fontSize: 11),
                                      ),
                                    ),
                              ta == null
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("TAX :" + "12",
                                          style: TextStyle(fontSize: 11)),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("TAX  :" + "12",
                                          style: TextStyle(fontSize: 11)),
                                    ),
                              net == null
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("NET  :" + "0",
                                          style: TextStyle(fontSize: 11)),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          "NET :" + total!.toStringAsFixed(2),
                                          style: TextStyle(fontSize: 11)),
                                    )
                            ],
                          ),
                          Row(
                            children: [
                              total == null
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("TOTAL :" + " 0.0",
                                          style: TextStyle(fontSize: 11)),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "TOTAL :" + net.toString(),
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                            ],
                          ),
                          Row(
                            children: [
                              // Text("TOTAL TAX AMOUNT :" + (total * 18)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
                            child: Text(
                              'SAVE QUOTATION',
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
                              log(a1.toString() + "hnnhhhhhhhhhhh");

                              if (dropdownvaluesource == null) {
                                Fluttertoast.showToast(msg: "Add company");
                                // items.clear();
                              } else if (a1.toString() == "null") {
                                Fluttertoast.showToast(msg: "Add vehicle");
                              } else if (dropdownvaluesource == "0") {
                                Fluttertoast.showToast(msg: "Add price");
                              } else {
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
                              var i;
                              // for (i = 0; i <= mapList.length; i++) {
                              //   finalList.add({
                              //     "name": mapList[i]["name"],
                              //     "qty": mapList[i]["qty"],
                              //     "color": mapList[i]["color"],
                              //   });
                              // }
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
    );
  }

  Future addRequirement(
    int inde,
    List a,
    String lead,
  ) async {
    log(mapList.toString() + "hbbbbbbhhhhhhhhhhhhhhhh");
    log(taxarr.toString());
    log(valuefirst.toString());
    print(a.toString());
    log(a.toString() + "ngvvvvvvvvvvvbbbbbbbbbbbbbb");
    log(dropdownvaluesource.toString() + "company masss");
    var productc = [];
    var array = [];
    String? product;
    String? Series;
    String? Qty;
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

      log(taxarr.toString() + "hhgvvvvvvvvvvvvvvvvvvvvvvv");
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
    log(value7.toString() + "value7");
    log(value7.toString() + "value7");
    log(value7.toString() + "value7");
    log(value7.toString() + "value7");
    productc.toString();
    log(product.toString());

    //DateFormat('yy/MM/dd').format(datel!);
    // log(formattedDate.toString());
    DateTime dt = new DateTime.now();
    print(dt.timeZoneOffset);
    print(dt);

    DateTime dt1 = dt.add(new Duration(days: 30));
    String formatteDate = DateFormat('yyyy/MM/dd').format(now);
    String formattedDate = DateFormat('yyyy/MM/dd').format(dt1);
    log(formatteDate);
    //  log(DateFormat('yy/MM/dd').format(datel!).toString());
    // log(array[d]["qty"].toString() + "mnhbbcfbbbbbbbbbgvgvhbjhjkljiikk");
    var baseUrl = urlMain + 'api/resource/Quotation';
    final msg = jsonEncode({
      "party_name": widget.leadtok,
      "company": dropdownvaluesource,
      "super_stockist": dropdownvaluesource,
      "transaction_date": formatteDate.toString(),
      "valid_till": formattedDate.toString(),
      "sale_area": productList.toString(),

      // "all_vehicle_permissible":
      //     vehicledrop == "All vehicle permissible" ? 1 : 0,
      // "Limited vehicle permissible":
      //     vehicledrop == "All vehicle permissible" ? 0 : 1,
      // "type_of_vehicle_go_to_site": veh.text == "" ? "" : veh.text,
      "all": value10 == false ? 0 : 1,
      "goods_ape": valuefirst == false ? 0 : 1,
      "sml_isuzu": valuesec == false ? 0 : 1,
      "mahindra_mini_truck": valuefourth == false ? 0 : 1,
      "mahindra_jeeto_plus": valuefive == false ? 0 : 1,
      "tata_ace": value8 == false ? 0 : 1,
      "mahindra_bolero_pickups": value7 == false ? 0 : 1,
      "tata_407": valuesix == false ? 0 : 1,
      "eicher": valuethird == false ? 0 : 1,
      "bharat_benz": value9 == false ? 0 : 1,
      "tax_category": "INSTATE",
      "items": a,
      "note": descontroller.text == "" ? "" : descontroller.text,
      "taxes_and_charges": taxarr == null ? "" : taxarr
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
      print(response.body);
      print("haaaaaaaaaaaaaaaaaaaaaaaaa");
      String data = response.body;

      Fluttertoast.showToast(msg: "Quotation added");
      Get.to(SalesdetailView(widget.name, "qt", "", "", "", widget.leadtok))

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
    var s = dropdownvaluesource.toString();

    var baseUrl = urlMain +
        'api/resource/Sales Taxes and Charges Template?filters=[["company","=","$s"],["tax_category","=","INSTATE"]]&fields=["tax_category","name","title"]';

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
        taxarr = jsonDecode(data)["data"][0]["name"];
      });
      log(taxarr.toString() + "vbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbnc");

      // log(jsonData.toString());
      //setState(() {});
    }
  }

  saleareView() async {
    var a = widget.leadtok.toString();
    log(a.toString());
    http.Response response = await http.get(
      Uri.parse(urlMain + 'api/resource/Lead/$a?fields=["lead_events"]'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Tocken,
      },
    );
    log(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      String data = response.body;
      setState(() {
        productList = jsonDecode(data)["data"]["lac"];
      });

      // log(productList[0]["note"]);
      print(data);
    } else {}
  }

  //  "taxes": [

  //           {

  //               "charge_type": "On Net Total",

  //               "account_head": "Output Tax CGST - KP",

  //               "description": "Output Tax CGST"

  //           },

  //           {

  //               "charge_type": "On Net Total",

  //               "account_head": "Output Tax SGST - KP",

  //               "description": "Output Tax SGST"

  //           }

  //       ]
}
