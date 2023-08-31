import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:lamit/app/routes/constants.dart';
import 'package:lamit/attendencelist.dart';
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/tocken/tockn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'app/modules/home/views/home_view.dart';

class AttendenceView extends StatefulWidget {
  final String id;

  const AttendenceView(this.id);
  @override
  _AttendenceView createState() => _AttendenceView();
}

class _AttendenceView extends State<AttendenceView> {
  bool value = false;
  bool values = false;
  var array;
  String? username;
  String? api_secret;
  String? api_key;
  String? dropdownvalue;
  TextEditingController _controller = TextEditingController();
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
    getSp();
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime timeBackPressed = DateTime.now();

    // List of items in our dropdown menu

    var items = [
      'Present',
      'Half Day',
    ];
    DateTime now = DateTime.now();

    String formattedDate = DateFormat('EEE d MMM').format(now);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: Text(
          'My attendence',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),

        //
        actions: [],
        //centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                    children: [
                      // Icon(
                      //   Icons.people,
                      //   color: Colors.green,
                      // ),
                      Expanded(
                        child: Card(
                          color: Colors.grey[50],
                          child: Container(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(username.toString())),
                          ),
                        ),
                      ),
                      // Icon(Icons.home, color: Colors.green),
                      Expanded(
                        child: Card(
                          color: Colors.grey[50],
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Lamit"),
                              // child: TextField(
                              //   decoration: InputDecoration(
                              //     hintText: "webeaz technolgies",
                              //     filled: true,
                              //     // fillColor: Colors.blueAccent,
                              //     border: OutlineInputBorder(
                              //         borderSide: BorderSide.none,
                              //         borderRadius: BorderRadius.circular(50)),
                              //   ),
                              // ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                    children: [
                      //   Icon(Icons.place, color: Colors.green),
                      // Expanded(
                      //   child: Card(
                      //     color: Colors.grey[50],
                      //     child: Container(
                      //       child: Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Text("calicut")),
                      //     ),
                      //   ),
                      // ),
                      // // Icon(Icons.date_range, color: Colors.green),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Card(
                            color: Colors.grey[50],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 30,
                                width: Constants(context).scrnWidth,
                                child: Container(
                                  // width: 60,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: DropdownButton(
                                          underline: Container(),
                                          // Initial Value
                                          hint: Text("Select"),
                                          value: dropdownvalue,

                                          // Down Arrow Icon
                                          icon: Icon(
                                            Icons.keyboard_arrow_down,
                                          ),

                                          // Array list of items
                                          items: items.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Column(
                                                children: [
                                                  Expanded(child: Text(items)),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                          // After selecting the desired option,it will
                                          // change button value to selected value
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropdownvalue = newValue!;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Icon(Icons.data_exploration, color: Colors.green),
                      // Expanded(
                      //   child: Container(
                      //     child: Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Text("department")),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                    children: [
                      //   Icon(Icons.approval, color: Colors.green),
                      Expanded(
                        child: Card(
                          color: Colors.grey[50],
                          child: Container(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(DateFormat('hh:mm:ss')
                                    .format(DateTime.now()))),
                          ),
                        ),
                      ),
                      // Icon(Icons.date_range, color: Colors.green),
                      Expanded(
                        child: Card(
                          color: Colors.grey[50],
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(child: Text(formattedDate)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     child: Row(
              //       children: [
              //         Icon(Icons.details, color: Colors.green),
              //         Expanded(
              //           child: Container(
              //             child: Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Container(child: Text("general")),
              //             ),
              //           ),
              //         ),

              //       ],
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     children: [
              //       Icon(Icons.watch_later, color: Colors.green),
              //       Expanded(
              //         child: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Text("late entry"),
              //         ),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Checkbox(
              //           value: this.value,
              //           onChanged: (bool? value) {
              //             setState(() {
              //               this.value = value!;
              //             });
              //           },
              //         ),
              //       ),
              //       Icon(Icons.watch_later_outlined, color: Colors.green),
              //       Expanded(
              //         child: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Text("early exit"),
              //         ),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Checkbox(
              //           value: this.values,
              //           onChanged: (bool? value) {
              //             setState(() {
              //               this.values = value!;
              //             });
              //           },
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              if (dropdownvalue == "Half Day")
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.grey[50],
                    child: Container(
                      height: 80,
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.blueAccent)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          maxLength: 140,
                          decoration: new InputDecoration.collapsed(
                              hintText: 'Type reson'),
                          controller: _controller,
                          onSubmitted: (String value) async {
                            await showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Thanks!'),
                                  content: Text(
                                      'You typed "$value", which has length ${value.characters.length}.'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 3, 50, 89),
                          shape: StadiumBorder()),
                      onPressed: () {
                        log(dropdownvalue.toString());
                        if (dropdownvalue == null) {
                          Fluttertoast.showToast(
                              msg: "Select attendence type",
                              textColor: Colors.black,
                              backgroundColor: Colors.blue[100]);
                        } else {
                          register();
                        }

                        //t();
                        // addattentence();
                        // ScaffoldMessenger.of(context)
                        //     .showSnackBar(SnackBar(
                        //   backgroundColor: Colors.blue,
                        //   content: const Text('Submit success full'),
                        //   duration: const Duration(seconds: 1),
                        //   action: SnackBarAction(
                        //     textColor: Colors.black,
                        //     label: 'Go to page',
                        //     onPressed: () {},
                        //   ),
                        // ));
                      },
                    ),
                  ),
                ),
              ),
              Expanded(child: Container()),
              // Padding(
              //   padding: const EdgeInsets.only(left: 200),
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Container(
              //       //color: Colors.green,
              //       child: ListTile(
              //         onTap: () {
              //           // Timer(Duration(milliseconds: 200), () {
              //           //   showDialog(
              //           //       context: context,
              //           //       builder: (ctx) => Dialog(
              //           //           shape: RoundedRectangleBorder(
              //           //               borderRadius:
              //           //                   BorderRadius.circular(10)),
              //           //           child: CustomDialog(
              //           //               "",
              //           //               "logout",
              //           //               'Are you sure ?',
              //           //               'You are about to logout from the app.',
              //           //               () async {
              //           //             logout();
              //           //           })));
              //           // });
              //         },
              //         title: Row(
              //           children: [
              //             Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Text("logout"),
              //             ),
              //             Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Icon(
              //                 Icons.power_settings_new,
              //                 color: Colors.red,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Add your onPressed code here!
      //     showDialog(
      //         context: context,
      //         builder: (BuildContext context) {
      //           return AlertDialog(
      //             content: Stack(
      //               clipBehavior: Clip.none,
      //               children: <Widget>[
      //                 Positioned(
      //                   right: -40.0,
      //                   top: -40.0,
      //                   child: InkResponse(
      //                     onTap: () {
      //                       Navigator.of(context).pop();
      //                     },
      //                     child: CircleAvatar(
      //                       child: Icon(Icons.close),
      //                       backgroundColor: Colors.red,
      //                     ),
      //                   ),
      //                 ),
      //                 Form(
      //                   //  key: _formKey,
      //                   child: Column(
      //                     mainAxisSize: MainAxisSize.min,
      //                     children: <Widget>[
      //                       Padding(
      //                         padding: const EdgeInsets.all(8.0),
      //                         child: Container(
      //                           width: MediaQuery.of(context).size.width,
      //                           child: ElevatedButton(
      //                             child: Text(
      //                               "Attendence List",
      //                               style: TextStyle(color: Colors.black),
      //                             ),
      //                             style: ElevatedButton.styleFrom(
      //                                 primary: Colors.green[50],
      //                                 shape: StadiumBorder()),
      //                             onPressed: () {
      //                               Get.to(AttendencelistView());
      //                               print("haaai");
      //                               // if (_formKey.currentState.validate()) {
      //                               //   _formKey.currentState.save();
      //                               // }
      //                             },
      //                           ),
      //                         ),
      //                       ),
      //                       Padding(
      //                         padding: const EdgeInsets.all(8.0),
      //                         child: Container(
      //                           width: MediaQuery.of(context).size.width,
      //                           child: ElevatedButton(
      //                             child: Text(
      //                               "Add attendence",
      //                               style: TextStyle(color: Colors.black),
      //                             ),
      //                             style: ElevatedButton.styleFrom(
      //                                 primary: Colors.green[50],
      //                                 shape: StadiumBorder()),
      //                             onPressed: () {
      //                               //  textt();
      //                               //addattentence();
      //                               // Get.to(AttendencelistView());
      //                               //  Get.to(ViewprofileView());
      //                               // if (_formKey.currentState.validate()) {
      //                               //   _formKey.currentState.save();
      //                               // }
      //                             },
      //                           ),
      //                         ),
      //                       ),
      //                       // Padding(
      //                       //   padding: EdgeInsets.all(8.0),
      //                       //   child: TextFormField(),
      //                       // ),
      //                       Padding(
      //                         padding: const EdgeInsets.all(8.0),
      //                         child: Container(
      //                           width: MediaQuery.of(context).size.width,
      //                           child: ElevatedButton(
      //                             child: Text("back"),
      //                             style: ElevatedButton.styleFrom(
      //                                 primary: Colors.blue,
      //                                 shape: StadiumBorder()),
      //                             onPressed: () {
      //                               // if (_formKey.currentState.validate()) {
      //                               //   _formKey.currentState.save();
      //                               // }
      //                             },
      //                           ),
      //                         ),
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           );
      //         });
      //   },
      //   backgroundColor: Colors.amber,
      //   child: const Icon(Icons.ads_click),
      // ),
    );
  }

  getSp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString("fullname");
      api_key = preferences.getString("userid");
      api_secret = preferences.getString("api_secret");
    });

    print(username);
  }

  register() async {
    log(DateFormat('yyy-MM-dd').format(DateTime.now()));
    http.Response response = await http.post(
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Tocken,
      },
      Uri.parse(
          // addURL,
          urlMain + 'api/resource/Attendance'),
      body: jsonEncode({
        "docstatus": 0,
        "status": dropdownvalue == "" ? "" : dropdownvalue,
        "status_1": "Open",
        "employee": api_key,
        "employee_name": username.toString(),
        "employee_number": api_key,
        "designation": "Sales Officer",
        // "attendance_approver": "asm2@gmail.com",
        // "approver": "Area Manager2",
        "attendance_date": DateFormat('yyy-MM-dd').format(DateTime.now()),

        "reporting_time": DateFormat('hh:mm:ss').format(DateTime.now()),
        "company": "Lamit",
        "longitude": position!.longitude.toString(),
        "latitude": position!.latitude.toString(),
        //"name": "HR-ATT-2023-00001",
        //  "leave_type": "Casual Leave",
        //"leave_type": "Compensatory Off",
        //"reason_for_leave": "dcdec",
        "reason": _controller.text == "" ? "" : _controller.text,
      }),
    );
    String data = response.body;
    log(data.toString());
    if (response.statusCode == 200) {
      String data = response.body;
      array = jsonDecode(data)["data"];

      Fluttertoast.showToast(
          msg: "Attendence added",
          textColor: Colors.black,
          backgroundColor: Colors.blue[50]);

      Get.to(AttendencelistView(widget.id.toString()));
      log("daaaaaataaaaa" + data);
    } else {
      Fluttertoast.showToast(
          msg: "Attendence aleardy added",
          textColor: Colors.black,
          backgroundColor: Colors.blue[50]);
    }
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Navigator.pop(context);
    prefs.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeView("")),
        (Route<dynamic> route) => false);
  }
}
