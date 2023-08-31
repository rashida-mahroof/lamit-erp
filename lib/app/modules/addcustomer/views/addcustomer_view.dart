import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lamit/app/routes/constants.dart';

import '../controllers/addcustomer_controller.dart';

class AddcustomerView extends GetView<AddcustomerController> {
  const AddcustomerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('AddcustomerView'),
      //   centerTitle: true,
      // ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(
                            //   height: 30,
                            // ),
                            Center(
                              child: Container(
                                height: 50,
                                width: Constants(context).scrnWidth,
                                child: ElevatedButton(
                                    child: Text(
                                      'ADD AS CUSTOMER',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        //fontStyle: FontStyle.normal
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blue[50],
                                      // side: BorderSide(color: Colors.yellow, width: 5),
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontStyle: FontStyle.normal),
                                    ),
                                    onPressed: () {}),
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
          ),
        ],
      ),
    );
  }
}
