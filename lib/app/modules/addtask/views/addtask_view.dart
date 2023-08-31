import 'package:flutter/material.dart';

import 'package:lamit/app/routes/constants.dart';

class AddtaskView extends StatefulWidget {
  const AddtaskView({Key? key}) : super(key: key);

  @override
  State<AddtaskView> createState() => _AddtaskViewState();
}

class _AddtaskViewState extends State<AddtaskView> {
  String? dropdownValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('AddTask'),
          //centerTitle: true,
        ),
        body: Container(
          // color: Colors.blue[50],
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                            height: Constants(context).scrnHeight,
                            width: Constants(context).scrnWidth,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.subject,
                                        color: Colors.black,
                                        size: 17,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 40,
                                            margin: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors
                                                        .black, // Set border color
                                                    width: 1.0),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: TextField(
                                                  // controller: ledgernameController,
                                                  textAlign: TextAlign.left,
                                                  keyboardType:
                                                      TextInputType.name,
                                                  decoration: InputDecoration(
                                                    hintText: "Subject",
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.pages,
                                        color: Colors.black,
                                        size: 17,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 40,
                                            margin: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors
                                                        .black, // Set border color
                                                    width: 1.0),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: TextField(
                                                  // controller: ledgernameController,
                                                  textAlign: TextAlign.left,
                                                  keyboardType:
                                                      TextInputType.name,
                                                  decoration: InputDecoration(
                                                    hintText: "Project",
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
                                      Icon(
                                        Icons.email,
                                        color: Colors.black,
                                        size: 17,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 40,
                                            margin: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors
                                                        .black, // Set border color
                                                    width: 1.0),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: TextField(
                                                  // controller: ledgernameController,
                                                  textAlign: TextAlign.left,
                                                  keyboardType:
                                                      TextInputType.name,
                                                  decoration: InputDecoration(
                                                    hintText: "Email",
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      Icon(
                                        Icons.phone,
                                        //  color: Colors.blue,
                                        color: Colors.black,
                                        size: 17,
                                      ),
                                      // Icon(
                                      //   Icons.receipt,
                                      //   color: Colors.blue,
                                      // ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            margin: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors
                                                        .black, // Set border color
                                                    width: 1.0),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0, right: 8.0),
                                                child: Container(
                                                  height: 40,
                                                  child: DropdownButton(
                                                    hint: Text("Assigned To"),
                                                    underline: Container(),
                                                    isExpanded: true,
                                                    elevation: 0,
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        dropdownValue =
                                                            newValue!;
                                                      });
                                                    },
                                                    value: dropdownValue,
                                                    items: <String>[
                                                      'Admin',
                                                      'User',
                                                    ].map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.description,
                                        color: Colors.black,
                                        size: 17,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            margin: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors
                                                        .black, // Set border color
                                                    width: 1.0),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0, right: 8.0),
                                                child: Container(
                                                  height: 40,
                                                  child: DropdownButton(
                                                    hint: Text("Priority"),
                                                    underline: Container(),
                                                    isExpanded: true,
                                                    elevation: 0,
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        dropdownValue =
                                                            newValue!;
                                                      });
                                                    },
                                                    value: dropdownValue,
                                                    items: <String>[
                                                      'Low',
                                                      'Medioum',
                                                      "High",
                                                      "Urgent"
                                                    ].map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.numbers,
                                        color: Colors.black,
                                        size: 17,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 40,
                                            margin: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors
                                                        .black, // Set border color
                                                    width: 1.0),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: TextField(
                                                  // controller: ledgernameController,
                                                  textAlign: TextAlign.left,
                                                  keyboardType:
                                                      TextInputType.name,
                                                  decoration: InputDecoration(
                                                    hintText: "datepicker",
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
                                      Icon(
                                        Icons.home,
                                        color: Colors.black,
                                        size: 17,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 40,
                                            margin: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors
                                                        .black, // Set border color
                                                    width: 1.0),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text("Time picker"),
                                                // child: TextField(
                                                //   // controller: ledgernameController,
                                                //   textAlign: TextAlign.left,
                                                //   keyboardType: TextInputType.name,
                                                //   decoration: InputDecoration(
                                                //     hintText: "admin@webeas.com",
                                                //     border: InputBorder.none,
                                                //   ),
                                                // ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.event_note_outlined,
                                        color: Colors.black,
                                        size: 17,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 80,
                                            margin: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors
                                                        .black, // Set border color
                                                    width: 1.0),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                              child: TextField(
                                                  //  controller: desController,
                                                  maxLines: 6,
                                                  decoration: InputDecoration(
                                                    hintText: "Description...",
                                                    border: InputBorder.none,
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    children: [
                                      Expanded(child: Container()),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 40,
                                            width: Constants(context).scrnWidth,
                                            child: ElevatedButton(
                                                style: ButtonStyle(
                                                    shape: MaterialStateProperty.all<
                                                            RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        18.0),
                                                            side: BorderSide(
                                                                color: Colors
                                                                    .white)))),
                                                onPressed: () {
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
                                                  'Save',
                                                  style: TextStyle(
                                                      color: Colors.grey[900]),
                                                )),
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
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
