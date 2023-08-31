import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:lamit/app/modules/leaddetails/views/leaddetails_view.dart';
import 'package:lamit/app/routes/constants.dart';
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/widget/customeappbar.dart';

import '../../../../tocken/tockn.dart';
import '../controllers/addaddress_controller.dart';

class AddaddressView extends StatefulWidget {
  final String? lead_name;
  final String name;
  final String? leadtok;
  final String? status;
  final String? dis;

  final String? addresstitle1;
  final String? addressline2;
  final String? taxcategory;
  final String? city;
  final String? state;

  final String? zipcode;

  const AddaddressView(
      this.lead_name,
      this.dis,
      this.name,
      this.leadtok,
      this.status,
      this.addresstitle1,
      this.addressline2,
      this.taxcategory,
      this.state,
      this.city,
      this.zipcode);

  @override
  State<AddaddressView> createState() => _AddaddressViewState();
}

class _AddaddressViewState extends State<AddaddressView> {
  GoogleMapController? mapController;
  TextEditingController? addressTittle;
  TextEditingController? addressLIne;
  TextEditingController? city;
  TextEditingController? postal;
  TextEditingController? state;
  TextEditingController? cuntry;
  TextEditingController? email;
  TextEditingController? zipcode;
  TextEditingController? phone;

  // TextEditingController addressLIne = TextEditingController();
  String? dropdownValue;
  Position? position;

  getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {});
    log('//-----------------------//');
    print(position!.latitude);
    log(position!.longitude.toString());
  }

  @override
  void initState() {
     super.initState();
    addressTittle = new TextEditingController(text: widget.addresstitle1);
    addressLIne = new TextEditingController(text: widget.addressline2);
    state = new TextEditingController(text: widget.state);
    city = new TextEditingController(text: widget.city);
    zipcode = new TextEditingController(text: widget.zipcode);
    if (widget.status == "isaddress") {
      dropdownValue == widget.taxcategory;
    } else {}
    getCurrentLocation();
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize:
              Size(MediaQuery.of(context).size.width, kToolbarHeight),
          child: CustomAppBar(
            title:
                widget.status != "isaddress" ? "EDIT ADDRESS" : "ADD ADDRESS",
          ),
        ),
        // AppBar(
        //   //  title: const Text('Add address'),
        //   backgroundColor: HexColor("#F9F9F9"),
        //   leading: Container(
        //     width: Constants(context).scrnWidth,
        //     height: 200,
        //     child: Row(
        //       children: [
        //         Padding(
        //           padding: const EdgeInsets.all(16.0),
        //           child: GestureDetector(
        //             onTap: () {
        //               Get.back();
        //             },
        //             child: Container(
        //               height: 30,
        //               child: Icon(
        //                 Icons.arrow_back,
        //                 color: Colors.black,
        //               ),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        //   elevation: 0,
        //   title: Text(
        //     widget.status != "isaddress" ? "EDIT ADDRESS" : "ADD ADDRESS",
        //     style: TextStyle(
        //         fontSize: 14,
        //         fontWeight: FontWeight.bold,
        //         color: Color.fromARGB(255, 2, 55, 98)),
        //   ),
        //   // backgroundColor: HexColor("#EEf3f9"),
        // ),

        body: Container(
          //  color: HexColor("#EEf3f9"),
          color: HexColor("#F9F9F9"),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      child: Container(
                        color: HexColor("#F9F9F9"),
                        // height: Constants(context).scrnHeight,
                        // width: Constants(context).scrnWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Container(
                            //   child: Row(
                            //     children: [
                            //       Padding(
                            //         padding: const EdgeInsets.all(16.0),
                            //         child: Text(
                            //           "IS LOADD THCATION",
                            //           style: TextStyle(
                            //               fontSize: 10,
                            //               fontWeight: FontWeight.bold,
                            //               color:
                            //                   Color.fromARGB(255, 2, 55, 98)),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),

                            // Padding(
                            //   padding:
                            //       const EdgeInsets.only(left: 70, right: 70),
                            //   child: Container(
                            //     color: Colors.white,
                            //     child: Row(
                            //       children: [
                            //         Padding(
                            //           padding: const EdgeInsets.all(8.0),
                            //           child: Icon(Icons.my_location),
                            //         ),
                            //         Container(
                            //           width: 110,
                            //           height: 30,
                            //           child: ElevatedButton(
                            //             style: ElevatedButton.styleFrom(
                            //               primary: Color.fromARGB(
                            //                   255, 2, 46, 81), // background
                            //               onPrimary: Colors.white, // foreground
                            //             ),
                            //             onPressed: () {
                            //               addlo();
                            //             },
                            //             child: Text('SAVE'),
                            //           ),
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // ),

                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 50,
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        //
                                        // borderRadius: BorderRadius.circular(20)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextField(
                                            controller: addressTittle,
                                            // controller: ledgernameController,
                                            textAlign: TextAlign.left,
                                            keyboardType: TextInputType.name,
                                            decoration: InputDecoration(
                                              hintText: "Address line1",
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
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
                                    child: Container(
                                      height: 50,
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        //borderRadius: BorderRadius.circular(20)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 32.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextField(
                                            controller: addressLIne,
                                            textAlign: TextAlign.left,
                                            keyboardType: TextInputType.name,
                                            decoration: InputDecoration(
                                              hintText: "Address line 2",
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                // Expanded(
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(8.0),
                                //     child: Container(
                                //       height: 50,
                                //       margin: EdgeInsets.all(5),
                                //       decoration: BoxDecoration(
                                //         // border: Border.all(
                                //         //     color: Colors.blue, // Set border color
                                //         //     width: 1.0),
                                //         color: Colors.white,
                                //         //borderRadius: BorderRadius.circular(20)),
                                //       ),
                                //       child: Padding(
                                //         padding: const EdgeInsets.only(
                                //             left: 8.0, right: 8.0),
                                //         child: Align(
                                //           alignment: Alignment.centerLeft,
                                //           child: TextField(
                                //             controller: postal,
                                //             // controller: ledgernameController,
                                //             textAlign: TextAlign.left,
                                //             keyboardType: TextInputType.name,
                                //             decoration: InputDecoration(
                                //               hintText: "Postal Code",
                                //               border: InputBorder.none,
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),

                                // Icon(
                                //   Icons.receipt,
                                //   color: Colors.blue,
                                // ),
                              ],
                            ),
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: Padding(
                            //         padding: const EdgeInsets.all(8.0),
                            //         child: Container(
                            //           margin: EdgeInsets.all(5),
                            //           decoration: BoxDecoration(
                            //             // border: Border.all(
                            //             //     color:
                            //             //         Colors.blue, // Set border color
                            //             //     width: 1.0),
                            //             color: Colors.white,
                            //             //borderRadius: BorderRadius.circular(20)
                            //           ),
                            //           child: Padding(
                            //               padding: const EdgeInsets.only(
                            //                   left: 8.0, right: 8.0),
                            //               child: Container(
                            //                 height: 50,
                            //                 child: DropdownButton(
                            //                   hint: Text(
                            //                     "Tax Category",
                            //                     style: TextStyle(fontSize: 13),
                            //                   ),
                            //                   underline: Container(),
                            //                   isExpanded: true,
                            //                   elevation: 0,
                            //                   onChanged: (String? newValue) {
                            //                     setState(() {
                            //                       dropdownValue = newValue!;
                            //                     });
                            //                   },
                            //                   value: dropdownValue,
                            //                   items: <String>[
                            //                     'OUTSTATE',
                            //                     'INSTATE',
                            //                   ].map<DropdownMenuItem<String>>(
                            //                       (String value) {
                            //                     return DropdownMenuItem<String>(
                            //                       value: value,
                            //                       child: Text(value),
                            //                     );
                            //                   }).toList(),
                            //                 ),
                            //               )),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),

                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: Padding(
                            //         padding: const EdgeInsets.all(8.0),
                            //         child: Container(
                            //           height: 50,
                            //           margin: EdgeInsets.all(5),
                            //           decoration: BoxDecoration(
                            //             // border: Border.all(
                            //             //     color:
                            //             //         Colors.blue, // Set border color
                            //             //     width: 1.0),
                            //             color: Colors.white,
                            //             // borderRadius: BorderRadius.circular(20)),
                            //           ),
                            //           child: Padding(
                            //             padding: const EdgeInsets.only(
                            //                 left: 8.0, right: 8.0),
                            //             child: Align(
                            //               alignment: Alignment.centerLeft,
                            //               child: TextField(
                            //                 controller: state,
                            //                 // controller: ledgernameController,
                            //                 textAlign: TextAlign.left,
                            //                 keyboardType: TextInputType.name,
                            //                 decoration: InputDecoration(
                            //                   hintText: "State",
                            //                   border: InputBorder.none,
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     // Icon(
                            //     //   Icons.numbers,
                            //     //   color: Colors.black,
                            //     //   size: 17,
                            //     // ),
                            //     // Expanded(
                            //     //   child: Padding(
                            //     //     padding: const EdgeInsets.all(8.0),
                            //     //     child: Container(
                            //     //       height: 40,
                            //     //       margin: EdgeInsets.all(5),
                            //     //       decoration: BoxDecoration(
                            //     //           border: Border.all(
                            //     //               color: Colors
                            //     //                   .black, // Set border color
                            //     //               width: 1.0),
                            //     //           color: Colors.white,
                            //     //           borderRadius:
                            //     //               BorderRadius.circular(20)),
                            //     //       child: Padding(
                            //     //         padding: const EdgeInsets.only(
                            //     //             left: 8.0, right: 8.0),
                            //     //         child: Align(
                            //     //           alignment: Alignment.centerLeft,
                            //     //           child: TextField(
                            //     //             controller: cuntry,
                            //     //             // controller: ledgernameController,
                            //     //             textAlign: TextAlign.left,
                            //     //             keyboardType:
                            //     //                 TextInputType.name,
                            //     //             decoration: InputDecoration(
                            //     //               hintText: "Cuntry",
                            //     //               border: InputBorder.none,
                            //     //             ),
                            //     //           ),
                            //     //         ),
                            //     //       ),
                            //     //     ),
                            //     //   ),
                            //     // ),
                            //   ],
                            // ),
                            // // Row(
                            //   children: [
                            //     Expanded(
                            //       child: Padding(
                            //         padding: const EdgeInsets.all(8.0),
                            //         child: Container(
                            //           height: 50,
                            //           margin: EdgeInsets.all(5),
                            //           decoration: BoxDecoration(
                            //             // border: Border.all(
                            //             //     color:
                            //             //         Colors.blue, // Set border color
                            //             //     width: 1.0),
                            //             color: Colors.white,
                            //             //borderRadius: BorderRadius.circular(20)),
                            //           ),
                            //           child: Padding(
                            //             padding: const EdgeInsets.only(
                            //                 left: 8.0, right: 8.0),
                            //             child: Align(
                            //               alignment: Alignment.centerLeft,
                            //               child: TextField(
                            //                 controller: email,
                            //                 // controller: ledgernameController,
                            //                 textAlign: TextAlign.left,
                            //                 keyboardType: TextInputType.name,
                            //                 decoration: InputDecoration(
                            //                   hintText: "Email",
                            //                   border: InputBorder.none,
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
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
                                      height: 50,
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        // border: Border.all(
                                        //     color:
                                        //         Colors.blue, // Set border color
                                        //     width: 1.0),
                                        color: Colors.white,
                                        // borderRadius: BorderRadius.circular(20)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextField(
                                            controller: city,
                                            // controller: ledgernameController,
                                            textAlign: TextAlign.left,
                                            keyboardType: TextInputType.name,
                                            decoration: InputDecoration(
                                              hintText: "City",
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
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
                                    child: Container(
                                      height: 50,
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        //     border: Border.all(
                                        //         color:
                                        //             Colors.blue, // Set border color
                                        //         width: 1.0),
                                        color: Colors.white,
                                        // borderRadius: BorderRadius.circular(20)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextField(
                                            controller: zipcode,
                                            // controller: ledgernameController,
                                            textAlign: TextAlign.left,
                                            keyboardType: TextInputType.phone,
                                            decoration: InputDecoration(
                                              hintText: "Pin code",
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Row(
                            //   children: [
                            //     Icon(
                            //       Icons.phone,
                            //       color: Colors.black,
                            //       size: 17,
                            //     ),
                            //     Expanded(
                            //       child: Padding(
                            //         padding: const EdgeInsets.all(8.0),
                            //         child: Container(
                            //           height: 50,
                            //           margin: EdgeInsets.all(5),
                            //           decoration: BoxDecoration(
                            //             // border: Border.all(
                            //             //     color:
                            //             //         Colors.blue, // Set border color
                            //             //     width: 1.0),
                            //             color: Colors.white,
                            //             //  borderRadius: BorderRadius.circular(20)),
                            //           ),
                            //           child: Padding(
                            //             padding: const EdgeInsets.only(
                            //                 left: 8.0, right: 8.0),
                            //             child: Align(
                            //               alignment: Alignment.centerLeft,
                            //               child: TextField(
                            //                 controller: phone,
                            //                 //controller: obController,
                            //                 textAlign: TextAlign.left,
                            //                 keyboardType: TextInputType.number,
                            //                 decoration: InputDecoration(
                            //                   hintText: "phone",
                            //                   border: InputBorder.none,
                            //                   //  suffixIcon:
                            //                   //Icon(Icons.phone_android)
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     // Icon(
                            //     //   Icons.receipt,
                            //     //   color: Colors.blue,
                            //     // ),
                            //     // // Expanded(
                            //     //   child: Container(
                            //     //     margin: EdgeInsets.all(5),
                            //     //     decoration: BoxDecoration(
                            //     //         color: Colors.white,
                            //     //         borderRadius:
                            //     //             BorderRadius.circular(5)),
                            //     //     child: Padding(
                            //     //         padding: const EdgeInsets.only(
                            //     //             left: 8.0, right: 8.0),
                            //     //         child: DropdownButton(
                            //     //           hint: Text("Owner"),
                            //     //           underline: Container(),
                            //     //           isExpanded: true,
                            //     //           elevation: 0,
                            //     //           onChanged: (String? newValue) {
                            //     //             setState(() {
                            //     //               dropdownValue = newValue!;
                            //     //             });
                            //     //           },
                            //     //           value: dropdownValue,
                            //     //           items: <String>[
                            //     //             'Admin',
                            //     //             'Bank',
                            //     //           ].map<DropdownMenuItem<String>>(
                            //     //               (String value) {
                            //     //             return DropdownMenuItem<String>(
                            //     //               value: value,
                            //     //               child: Text(value),
                            //     //             );
                            //     //           }).toList(),
                            //     //         )),
                            //     //   ),
                            //     // ),
                            //   ],
                            // ),
                            // // Row(
                            // //   children: [
                            // //     Icon(
                            // //       Icons.event_note_outlined,
                            // //       color: Colors.black,
                            // //       size: 17,
                            // //     ),
                            // //     Expanded(
                            // //       flex: 2,
                            // //       child: Padding(
                            // //         padding: const EdgeInsets.all(8.0),
                            // //         child: Container(
                            // //           height: 80,
                            // //           margin: EdgeInsets.all(5),
                            // //           decoration: BoxDecoration(
                            // //               border: Border.all(
                            // //                   color: Colors
                            // //                       .black, // Set border color
                            // //                   width: 1.0),
                            // //               color: Colors.white,
                            // //               borderRadius:
                            // //                   BorderRadius.circular(20)),
                            // //           child: Padding(
                            // //             padding: const EdgeInsets.only(
                            // //                 left: 8.0, right: 8.0),
                            // //             child: TextField(
                            // //                 //  controller: desController,
                            // //                 maxLines: 6,
                            // //                 decoration: InputDecoration(
                            // //                   hintText: "Description...",
                            // //                   border: InputBorder.none,
                            // //                 )),
                            // //           ),
                            // //         ),
                            // //       ),
                            // //     ),
                            // //   ],
                            // // ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "ADD LOCATION",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 1, 58, 104)),
                              ),
                            ),

                            Row(
                              children: [
                                // Expanded(child: Container()),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 50,
                                          width: Constants(context).scrnWidth,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.grey[100],
                                                ),
                                                onPressed: () {
                                                  print("hhhhh");
                                                  addlo();
                                                },
                                                child: Text(
                                                  'ADD LOCATION',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Divider(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 0),
                                  child: Row(
                                    children: [
                                      //  Expanded(child: Container()),
                                      Expanded(
                                        child: Container(
                                          height: 40,
                                          width: Constants(context).scrnWidth,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Color.fromARGB(255, 2,
                                                    73, 131), // background
                                                onPrimary:
                                                    Colors.yellow, // foreground
                                              ),
                                              onPressed: () {
                                                log(addressTittle.toString());

                                                // LeadaddController().leadadd();
                                                if (addressTittle!.text == "") {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Address Line 1 is Required",
                                                      textColor: Colors.white,
                                                      backgroundColor:
                                                          Color.fromARGB(
                                                              255, 7, 5, 43));
                                                } else {
                                                  if (widget.status !=
                                                      "isaddress") {
                                                    AddaddressController()
                                                        .updateaddAddress(
                                                            "edit",
                                                            widget.lead_name,
                                                            widget.dis
                                                                .toString(),
                                                            widget.name,
                                                            addressLIne!.text,
                                                            city!.text,
                                                            addressTittle!.text,
                                                            zipcode!.text,
                                                            widget.leadtok
                                                                .toString());
                                                  } else {
                                                    AddaddressController()
                                                        .addAddress(
                                                            "add",
                                                            widget.lead_name,
                                                            widget.dis
                                                                .toString(),
                                                            widget.name,
                                                            addressLIne!.text
                                                                .toString(),
                                                            city!.text
                                                                .toString(),
                                                            addressTittle!.text
                                                                .toString(),
                                                            zipcode!.text
                                                                .toString(),
                                                            widget.leadtok
                                                                .toString());
                                                  }
                                                }
                                                setState(() {
                                                  // addressLIne!.clear();
                                                  // addressTittle!.clear();
                                                  // dropdownValue == null;

                                                  // zipcode!.clear();
                                                });
                                              },
                                              child: Text(
                                                'Save',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
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
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> addlo() async {
    log(position!.longitude.toString());
    log(position!.latitude.toString());
    // log(widget.lead_name.toString());
    log(widget.name.toString());
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    };
    final msg = jsonEncode({
      "longitude": position!.longitude.toString(),
      "latitude": position!.latitude.toString(),
    });
    var c = widget.leadtok;
    http.Response response = await http.put(
        Uri.parse(urlMain + "api/resource/Lead/$c"),
        headers: headers,
        body: msg);
    print(response.statusCode);
    print(response.body+'adddd');

    if (response.statusCode == 200) {
      String data = response.body;
      log("hiii");
      print(data);
      Fluttertoast.showToast(msg: "Location Add");

      //   if (jsonDecode(data)["data"]["message"] == "Success") {
      //     Fluttertoast.showToast(
      //         textColor: Colors.black,
      //         msg: "Location Added",
      //         backgroundColor: Colors.blue[100]);
      //     //  status == "Lead" ? Get.to(LeadView()) : Get.to(HotleadView());
      //   } else {}
      // } else if (response.statusCode == 417) {
      //   String dat = response.body;
      //   if (jsonDecode(dat)["exc_type"] == "InvalidEmailAddressError") {
      //     Fluttertoast.showToast(
      //         msg: "enter valid email address",
      //         textColor: Colors.black,
      //         backgroundColor: Colors.blue[100]);
      //   }
      // } else if (response.statusCode == 409) {
      //   print(response.statusCode);
      //   log(response.body);

      //   Fluttertoast.showToast(
      //       msg:
      //           "This email id aleardy used/customer area and district is not match",
      //       backgroundColor: Colors.blue[100],
      //       textColor: Colors.black);

      //   // Get.to(RequirementView(""));
    } else {
      print("error");
    }
  }

  addAddress(
      String? lead_name,
      String district,
      String name,
      String address_title,
      String city,
      String address_line1,
      String pincode,
      String addresstok) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    };
    print("haai");

    http.Response response = await http.put(
      Uri.parse(urlMain + "api/resource/Address"),
      headers: headers,
      body: json.encode({
        "address_line1": address_line1,
        "city": city,
        "country": "India",
        "address_title": lead_name,
        "address_line2": address_title,
        "state": "Kerala",
        "pin_code": pincode,
        "districts": district,
        //"phone": phone,
        //"email_id": email_id,
        "tax_category": "INSTATE",
        "links": [
          {"link_doctype": "Lead", "link_name": addresstok}
        ]
      }),
    );
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Address Updated Successfully",
          backgroundColor: Colors.blue[200]);

      Get.to(LeaddetailsView(name, "iseditaddr", 0, "", "", addresstok));

      String data = response.body;
      print(data);
    } else {
      print(response.body);
    }
  }
}
