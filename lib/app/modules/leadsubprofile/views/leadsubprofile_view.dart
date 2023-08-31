import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../controllers/leadsubprofile_controller.dart';

class LeadsubprofileView extends GetView<LeadsubprofileController> {
  const LeadsubprofileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#EEf3f9"),
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Text('Way'),
        ),
        //centerTitle: true,
      ),
      body: Container(
        color: HexColor("#EEf3f9"),
        child: Card(
            color: HexColor("#EEf3f9"),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                            height: 70,
                            child: Card(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                      child: Text(
                                    "ADD DETAIL",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ))
                                ],
                              ),
                            )),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                            height: 70,
                            child: Card(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                      child: Text(
                                    "ADD QUATATION",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ))
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                            height: 70,
                            child: Card(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                      child: Text(
                                    "ADD REQUIREMENT",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ))
                                ],
                              ),
                            )),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                            height: 70,
                            child: Card(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                      child: Text(
                                    "ADD SALESRETUERN",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ))
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                            height: 70,
                            child: Card(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                      child: Text(
                                    "ADD SALES INVOICE",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ))
                                ],
                              ),
                            )),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                            height: 70,
                            child: Card(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                      child: Text(
                                    "ADD AS A CUSTOMER",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ))
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
