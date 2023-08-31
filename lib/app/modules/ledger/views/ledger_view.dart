import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:lamit/app/routes/constants.dart';
import 'package:http/http.dart' as http;
import 'package:lamit/tocken/config/url.dart';

class LedgerView extends StatefulWidget {
  const LedgerView({Key? key}) : super(key: key);

  @override
  State<LedgerView> createState() => _LedgerViewState();
}

class _LedgerViewState extends State<LedgerView> {
  String? dropdownValue;

  @override
  void initState() {
    super.initState();
    register();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'LedgerCreate',
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
          //  title: const Text('LedgerView'),
          // centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
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
                            Icons.account_balance_wallet_outlined,
                            color: Colors.blue,
                          ),
                          Expanded(
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextField(
                                    // controller: ledgernameController,
                                    textAlign: TextAlign.left,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      hintText: "Name",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.receipt,
                            color: Colors.blue,
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: DropdownButton(
                                    hint: Text("Group"),
                                    underline: Container(),
                                    isExpanded: true,
                                    elevation: 0,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValue = newValue!;
                                      });
                                    },
                                    value: dropdownValue,
                                    items: <String>[
                                      'Cash',
                                      'Bank',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.money,
                            color: Colors.blue,
                          ),
                          Expanded(
                            child: Container(
                              height: 45,
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextField(
                                    //controller: obController,
                                    textAlign: TextAlign.left,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: "Ob Blance",
                                      border: InputBorder.none,
                                      //  suffixIcon:
                                      //Icon(Icons.phone_android)
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
                            Icons.event_note_outlined,
                            color: Colors.blue,
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 80,
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
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
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(child: Container()),
                          Expanded(
                            child: Container(
                              height: 40,
                              width: Constants(context).scrnWidth,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side: BorderSide(
                                                  color: Colors.white)))),
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
                                    style: TextStyle(color: Colors.grey[900]),
                                  )),
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
        ));
  }

  // Testerrr() async {
  //   http.Response response = await http.get(
  //       Uri.parse("https://erp.erpeaz.com/api/resource/customer"),
  //       headers: {});
  //   String data = response.body;
  //   print(data);
  // }

  register() async {
    print("hai");
    http.Response response = await http.post(
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token 2ff6e5f28762a83:f3878b4322c2c4a',
      },
      Uri.parse(urlMain + "api/resource/Customer"),
      // body: jsonEncode({}),
    );
    if (response.statusCode == 200) {
      print(response.statusCode);
      String data = response.body;
      log(data);
      //  array = jsonDecode(data)["data"];

      //  Fluttertoast.showToast(msg: "Attendence aleardy added");
//
      //  log("daaaaaataaaaa" + data);
    } else {
      // Fluttertoast.showToast(
      //     msg: "Attendence aleardy added", backgroundColor: Colors.green);
    }
  }
}
