import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:lamit/app/modules/addaddress/views/addaddress_view.dart';
import 'package:lamit/app/routes/constants.dart';
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/tocken/tockn.dart';
import 'package:maps_launcher/maps_launcher.dart';

class AddressviewView extends StatefulWidget {
  final String? address;

  const AddressviewView(this.address);

  @override
  State<AddressviewView> createState() => _AddressviewViewState();
}

class _AddressviewViewState extends State<AddressviewView> {
  var productlist;
  @override
  void initState() {
    addresView();
    log(productlist.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('AddressviewView'),
      //   centerTitle: true,
      // ),
      body: productlist == null
          ? Container()
          : Container(
              height: Constants(context).scrnHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 18,
                  ),
                  productlist["address_line1"] != null
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (() {
                              Get.to(AddaddressView(
                                productlist["lead_name"] == null
                                    ? ""
                                    : productlist["lead_name"],
                                productlist["districts"] == null
                                    ? ""
                                    : productlist["districts"],
                                productlist["lead_name"] == null
                                    ? ""
                                    : productlist["lead_name"],
                                widget.address,
                                "isaddress",
                                productlist["address_line1"] == null
                                    ? ""
                                    : productlist["address_line1"],
                                productlist["address_line2"] == null
                                    ? ""
                                    : productlist["address_line2"],
                                productlist["tax_category"] == null
                                    ? ""
                                    : productlist["taxcategory"],
                                productlist["states"] == null
                                    ? ""
                                    : productlist["states"],
                                productlist["city"] == null
                                    ? ""
                                    : productlist["city"],
                                productlist["pin_code"] == null
                                    ? ""
                                    : productlist["pin_code"],
                              ));
                            }),
                            child: Container(
                              child: Row(
                                children: [
                                  Icon(Icons.add_outlined),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "ADD ADDRESS DETAIL",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  (productlist["address_line1"] == null)
                      ? Container()
                      : Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'ADDRESS',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(AddaddressView(
                                  productlist["lead_name"] == null
                                      ? ""
                                      : productlist["lead_name"],
                                  productlist["districts"] == null
                                      ? ""
                                      : productlist["districts"],
                                  productlist["lead_name"] == null
                                      ? ""
                                      : productlist["lead_name"],
                                  widget.address,
                                  "isaddressedt",
                                  productlist["address_line1"] == null
                                      ? ""
                                      : productlist["address_line1"],
                                  productlist["address_line2"] == null
                                      ? ""
                                      : productlist["address_line2"],
                                  productlist["tax_category"] == null
                                      ? ""
                                      : productlist["taxcategory"],
                                  productlist["states"] == null
                                      ? ""
                                      : productlist["states"],
                                  productlist["city"] == null
                                      ? ""
                                      : productlist["city"],
                                  productlist["pin_code"] == null
                                      ? ""
                                      : productlist["pin_code"],
                                ));
                              },
                              child: Icon(
                                Icons.edit,
                                size: 20,
                                color: Colors.green,
                              ),
                            )
                          ],
                        ),
                  if(productlist["address_line1"] != null)
                  Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Address Line1"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Address Line2"),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Text("Tax Catagory"),
                                    // ),
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Text("State"),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("City"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Pin code"),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Text(":"),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(":"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(":"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(":"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(":"),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          productlist["address_line1"] == null
                                              ? ""
                                              : productlist["address_line1"]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          productlist["address_line2"] == null
                                              ? ""
                                              : productlist["address_line2"]),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Text(
                                    //       productlist["tax_category"] == null
                                    //           ? ""
                                    //           : productlist["tax_category"]),
                                    // ),
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Text(productlist["states"]),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(productlist["city"] == null
                                          ? ""
                                          : productlist["city"]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          productlist["pin_code"] == null
                                              ? ""
                                              : productlist["pin_code"]),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [],
                                )
                              ],
                            ),
                          ),
                        ),
                        productlist["latitude"] == null
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 0),
                                    child: Row(
                                      children: [
                                        //  Expanded(child: Container()),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 16.0),
                                            child: Container(
                                              height: 40,
                                              width:
                                                  Constants(context).scrnWidth,
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Color.fromARGB(
                                                        255,
                                                        2,
                                                        73,
                                                        131), // background
                                                    onPrimary: Colors
                                                        .yellow, // foreground
                                                  ),
                                                  onPressed: () {
                                                    MapsLauncher.launchCoordinates(
                                                        double.parse(
                                                            productlist[
                                                                "latitude"]),
                                                        double.parse(
                                                            productlist[
                                                                "longitude"]),
                                                        '');
                                                  },
                                                  child: Text(
                                                    'View Location',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                        //  Center(
                        //     child: Padding(
                        //       padding: const EdgeInsets.only(right: 16.0),
                        //       child: Container(
                        //         height: 40,
                        //         child: NiceButtons(
                        //           width: Constants(
                        //             context,
                        //           ).scrnWidth,
                        //           startColor:
                        //               Color.fromARGB(255, 3, 42, 55),
                        //           stretch: false,
                        //           gradientOrientation:
                        //               GradientOrientation.Vertical,
                        //           onTap: (finish) {

                        //           },
                        //           child: Text(
                        //             'Tap to view location',
                        //             style: TextStyle(
                        //                 color: Colors.white, fontSize: 18),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  addresView() async {
    print("object");
    var s = widget.address;
    http.Response response = await http.get(
      Uri.parse(urlMain + "api/resource/Lead/$s"),
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
        //baisicDetail = jsonDecode(data)["data"];
        productlist = jsonDecode(data)["data"];
      });

      // log(productList[0]["note"]);
      print(data);
      //  baisicDetailView2();
    } else {}
  }

//  https://lamit.erpeaz.com/api/resource/Lead/LMT-LEAD-2022-00207
}
