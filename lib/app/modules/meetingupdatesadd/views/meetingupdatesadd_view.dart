import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:intl/intl.dart';
import 'package:lamit/app/modules/meetingupdatesadd/controllers/meetingupdatesadd_controller.dart';
import 'package:lamit/app/routes/constants.dart';

class MeetingupdatesaddView extends StatefulWidget {
  final String? leadtocken;
  final String name;

  const MeetingupdatesaddView(this.leadtocken, this.name);
  @override
  State<MeetingupdatesaddView> createState() => _MeetingupdatesaddViewState();
}

class _MeetingupdatesaddViewState extends State<MeetingupdatesaddView> {
  DateTime? datel;
  // String? _chosenVal;
  TextEditingController timeinput = TextEditingController();
  DateTime? nextmeetingDate;

  TextEditingController endtime = TextEditingController();

  @override
  void initState() {
    timeinput.text = ""; //set t
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#F9F9F9"),
        // appBar: AppBar(
        //   title: const Text('MeetingupdatesaddView'),
        //   centerTitle: true,
        // ),

        body: Container(
          // color: Colors.blue[100],
          // color: HexColor("#EEf3f9"),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  child: Row(
                    children: [],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 30,
                        child: Icon(
                          Icons.arrow_back,
                          size: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "ADD MEETING UPDATES",
                        style: TextStyle(
                            color: Color.fromARGB(255, 4, 46, 80),
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                ),
                child: Text(
                  "Contacts Dates",
                  style: TextStyle(color: Colors.grey[900]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  color: Colors.grey[100],
                  width: Constants(context).scrnWidth,
                  child: DropdownButton<DateTime>(
                      underline: Container(),
                      hint: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Select Date'),
                          ),
                          //  Icon(Icons.abc)
                          Container(
                            width: MediaQuery.of(context).size.width * 0.55,
                          )
                        ],
                      ),
                      items: ['  Select a date']
                          .map((e) => DropdownMenuItem<DateTime>(
                              child: Text(datel == null
                                  ? e
                                  : DateFormat('yyyy-MM-dd').format(
                                      DateTime.parse(datel.toString())))))
                          .toList(),
                      onChanged: (DateTime? value) {
                        setState(() {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2001),
                                  lastDate: DateTime(2099))
                              .then((date) {
                            setState(() {
                              datel = date;
                            });
                          });
                        });
                      }),
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                            ),
                            child: Text(
                              "From Time",
                              style: TextStyle(color: Colors.grey[900]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 50,
                              color: Colors.grey[100],
                              child: TextField(
                                controller:
                                    timeinput, //editing controller of this TextField
                                decoration: InputDecoration(
                                    // icon: Icon(Icons.timer), //icon of text field
                                    labelText:
                                        "Start Time" //label text of field
                                    ),
                                readOnly:
                                    true, //set it true, so that user will not able to edit text
                                onTap: () async {
                                  TimeOfDay? pickedTime = await showTimePicker(
                                    initialTime: TimeOfDay.now(),
                                    context: context,
                                  );

                                  if (pickedTime != null) {
                                    print(pickedTime
                                        .format(context)); //output 10:51 PM
                                    DateTime parsedTime = DateFormat.jm().parse(
                                        pickedTime.format(context).toString());
                                    //converting to DateTime so that we can further format on different pattern.
                                    print(
                                        parsedTime); //output 1970-01-01 22:53:00.000
                                    String formattedTime =
                                        DateFormat('HH:mm:ss')
                                            .format(parsedTime);
                                    print(formattedTime); //output 14:59:00
                                    //DateFormat() is from intl package, you can format the time on any pattern you need.

                                    setState(() {
                                      timeinput.text =
                                          formattedTime; //set the value of text field.
                                    });
                                  } else {
                                    print("Time is not selected");
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 12.0, bottom: 8),
                            child: Text(
                              "End Time",
                              style: TextStyle(color: Colors.grey[900]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              height: 50,
                              color: Colors.grey[100],
                              child: TextField(
                                controller:
                                    endtime, //editing controller of this TextField
                                decoration: InputDecoration(
                                    // icon: Icon(Icons.timer), //icon of text field
                                    labelText: "End Time" //label text of field
                                    ),
                                readOnly:
                                    true, //set it true, so that user will not able to edit text
                                onTap: () async {
                                  TimeOfDay? pickedTime = await showTimePicker(
                                    initialTime: TimeOfDay.now(),
                                    context: context,
                                  );

                                  if (pickedTime != null) {
                                    print(pickedTime
                                        .format(context)); //output 10:51 PM
                                    DateTime parsedTime = DateFormat.jm().parse(
                                        pickedTime.format(context).toString());
                                    //converting to DateTime so that we can further format on different pattern.
                                    print(
                                        parsedTime); //output 1970-01-01 22:53:00.000
                                    String formattedTime =
                                        DateFormat('HH:mm:ss')
                                            .format(parsedTime);
                                    print(formattedTime); //output 14:59:00
                                    //DateFormat() is from intl package, you can format the time on any pattern you need.

                                    setState(() {
                                      endtime.text =
                                          formattedTime; //set the value of text field.
                                    });
                                  } else {
                                    print("Time is not selected");
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                ),
                child: Text(
                  "Next Contact Dates",
                  style: TextStyle(color: Colors.grey[900]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  color: Colors.grey[100],
                  width: Constants(context).scrnWidth,
                  child: DropdownButton<DateTime>(
                      underline: Container(),
                      hint: Row(
                        children: [
                          Text('Select Date'),
                          //  Icon(Icons.abc)
                          Container(
                            width: MediaQuery.of(context).size.width * 0.55,
                          )
                        ],
                      ),
                      items: ['Select a date']
                          .map((e) => DropdownMenuItem<DateTime>(
                              child: Text(nextmeetingDate == null
                                  ? e
                                  : DateFormat('yyyy-MM-dd').format(
                                      DateTime.parse(
                                          nextmeetingDate.toString())))))
                          .toList(),
                      onChanged: (DateTime? value) {
                        setState(() {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2001),
                                  lastDate: DateTime(2099))
                              .then((date) {
                            setState(() {
                              nextmeetingDate = date;
                            });
                          });
                        });
                      }),
                ),
              ),
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
                            log(nextmeetingDate.toString());
                            MeetingupdatesaddController().meetingupdates(
                                widget.name,
                                "",
                                [],
                                widget.leadtocken.toString(),
                                DateFormat('yyyy-MM-dd')
                                    .format(DateTime.parse(datel.toString())),
                                timeinput.text,
                                endtime.text,
                                nextmeetingDate == null
                                    ? ""
                                    : DateFormat('yyyy-MM-dd').format(
                                        DateTime.parse(
                                            nextmeetingDate.toString())));
                            // if (ledgernameCon
                            //troller!.text == "") {
                            //   Fluttertoast.showToast(
                            //       msg: "Name Required",
                            //       textColor: Colors.white,
                            //       backgroundColor: Colors.red);
                            // } else if (dropdownValue == "") {
                            //   Fluttertoast.showToast(
                            //       msg: "Group Required",
                            //       textColor: Colors.white,
                            //       backgroundColor: Colors.red);
                            // } else if (obController!.text == "") {
                            //   Fluttertoast.showToast(
                            //       msg: "Ob Required",
                            //       textColor: Colors.white,
                            //       backgroundColor: Colors.red);
                            // } else if (desController!.text == "") {
                            //   Fluttertoast.showToast(
                            //       msg: "Description Required",
                            //       textColor: Colors.white,
                            //       backgroundColor: Colors.red);
                            // } else {
                            //   if (widget.isEDIT == "isEDIT") {
                            //     update();
                            //     print("kkjjjjjjjjjjj" + widget.isEDIT);
                            //   } else {
                            //     insertCollectionOffline();
                            //   }
                            // }
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
        ));
  }
}
