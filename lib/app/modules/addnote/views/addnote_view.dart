import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lamit/app/modules/leaddetails/views/leaddetails_view.dart';
import 'package:lamit/app/routes/constants.dart';
import 'package:http/http.dart' as http;
import 'package:lamit/tocken/config/url.dart';
import '../../../../tocken/tockn.dart';
import '../controllers/addnote_controller.dart';

class AddnoteView extends StatefulWidget {
  final String? a;
  final String? name;

  AddnoteView(this.a, this.name);

  @override
  State<AddnoteView> createState() => _AddnoteViewState();
}

class _AddnoteViewState extends State<AddnoteView> {
  Position? position;
  AddnoteController? addnoteacontroller;
  TextEditingController controller = TextEditingController();
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
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: HexColor("#F9F9F9"),
        // appBar: AppBar(
        //   title: const Text('AddNote'),
        //   // centerTitle: true,
        // ),
        body: Container(
          color: HexColor("#F9F9F9"),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //       child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Text(
                  //       "Series Number : 1234",
                  //       style: TextStyle(fontWeight: FontWeight.bold),
                  //     ),
                  //   )),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //       child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Text(
                  //       "Role : admin username",
                  //       style: TextStyle(fontWeight: FontWeight.bold),
                  //     ),
                  //   )),
                  // ),
                  Container(
                    child: Container(
                      // height: Constants(context).scrnHeight,
                      // width: Constants(context).scrnWidth,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        child: Icon(
                                          Icons.arrow_back,
                                          size: 18,
                                        ),
                                        onTap: () {
                                          Get.to(LeaddetailsView(
                                              "", "", 0, "", "", ""));
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "ADD LOCATION",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Color.fromARGB(
                                                  255, 1, 58, 104)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                // Padding(
                                //     padding: const EdgeInsets.only(left: 24.0),
                                //     child: Text(
                                //       "ADD YOUR NOTE",
                                //       style: TextStyle(
                                //           //fontWeight: FontWeight.bold,
                                //           fontSize: 14,
                                //           color: Colors.grey),
                                //     )),

                                // Row(
                                //   children: [
                                //     // Icon(
                                //     //   Icons.event_note_outlined,
                                //     //   color: Colors.black,
                                //     //   size: 17,
                                //     // ),
                                //     Expanded(
                                //       flex: 2,
                                //       child: Padding(
                                //         padding: const EdgeInsets.all(8.0),
                                //         child: Container(
                                //           height: 300,
                                //           margin: EdgeInsets.all(5),
                                //           decoration: BoxDecoration(
                                //               color: Colors.white,
                                //               borderRadius:
                                //                   BorderRadius.circular(20)),
                                //           child: Padding(
                                //             padding: const EdgeInsets.only(
                                //                 left: 8.0, right: 8.0),
                                //             child: TextField(
                                //                 controller: controller,
                                //                 //  controller: desController,
                                //                 maxLines: 6,
                                //                 decoration: InputDecoration(
                                //                   hintText: "Note...",
                                //                   border: InputBorder.none,
                                //                 )),
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),

                                SizedBox(
                                  height: 50,
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
                                              width:
                                                  Constants(context).scrnWidth,
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Color.fromARGB(
                                                        255, 2, 73, 131),
                                                  ),
                                                  onPressed: () {
                                                    print("hhhhh");
                                                    addlo();
                                                  },
                                                  child: Text(
                                                    'ADD LOCATION',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            ),
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
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    };
    final msg = jsonEncode({
      "longitude": position!.longitude.toString(),
      "latitude": position!.latitude.toString(),
    });
    var c = widget.a;
    http.Response response = await http.put(
        Uri.parse(urlMain + "api/resource/Lead/$c"),
        headers: headers,
        body: msg);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      String data = response.body;
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
}
