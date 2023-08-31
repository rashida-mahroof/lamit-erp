import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/constants.dart';
import '../controllers/customrlist_controller.dart';

class CustomrlistView extends GetView<CustomrlistController> {
  const CustomrlistView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'CustomListView',
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),

        //centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Colors.blue[50],
                    elevation: 5,
                    child: Container(
                      width: Constants(context).scrnWidth,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    "Mobile ",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text("Address ",
                                      style: TextStyle(fontSize: 15)),
                                  Text("Balance  ",
                                      style: TextStyle(fontSize: 15)),
                                  Text("House Num",
                                      style: TextStyle(fontSize: 15)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ":",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    ":",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(":", style: TextStyle(fontSize: 15)),
                                  Text(":", style: TextStyle(fontSize: 15)),
                                  Text(":", style: TextStyle(fontSize: 15)),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "name",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text("964206422",
                                      style: TextStyle(fontSize: 15)),
                                  Text("address",
                                      style: TextStyle(fontSize: 15)),
                                  Text("ob balance",
                                      style: TextStyle(fontSize: 15)),
                                  Text("housenum",
                                      style: TextStyle(fontSize: 15)),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    // setState(() {
                                    //   deleteConfirm(index);
                                    // });
                                  },
                                  icon: Icon(Icons.delete),
                                  iconSize: 20,
                                  color: Colors.red,
                                ),
                                IconButton(
                                  onPressed: () {
                                    // Navigator.pushReplacement(
                                    //     context,
                                    //     CupertinoPageRoute(
                                    //         builder: (context) => RegPage(
                                    //               customerList[index]['id']
                                    //                   .toString(),
                                    //               "isEDIT",
                                    //               customerList[index]['name'],
                                    //               customerList[index]['mobile'],
                                    //               customerList[index]['address'],
                                    //               customerList[index]['ob'],
                                    //               customerList[index]['vatnum'],
                                    //             )));
                                  },
                                  icon: Icon(Icons.edit),
                                  iconSize: 20,
                                  color: Colors.green,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }

  // body: Column(
  //   children: [
  //     Container(
  //       height: Constants(context).scrnHeight,
  //       width: Constants(context).scrnWidth,
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Column(
  //           children: [
  //             Row(
  //               children: [
  //                 Icon(
  //                   Icons.person_search,
  //                   color: Colors.blue,
  //                 ),
  //                 // Expanded(
  //                 //   child: Container(
  //                 //     margin: EdgeInsets.all(5),
  //                 //     decoration: BoxDecoration(
  //                 //         color: Colors.white,
  //                 //         borderRadius: BorderRadius.circular(5)),
  //                 //     child: Padding(
  //                 //       padding:
  //                 //           const EdgeInsets.only(left: 8.0, right: 8.0),
  //                 //       child: CustomSearchableDropDown(
  //                 //           primaryColor: primaryColor,
  //                 //           items: offLineCustomersIdDropDown.length == 0
  //                 //               ? ['']
  //                 //               : offLineCustomersIdDropDown,
  //                 //           label: 'Select Customer',
  //                 //           showLabelInMenu: true,
  //                 //           onChanged: (value) async {
  //                 //             selectedCustomer = value!;
  //                 //             log('$selectedCustomer');
  //                 //             final db = await database;

  //                 //             var ob = await db.query('CustCre',
  //                 //                 where: 'id=$selectedCustomer');

  //                 //             print(ob);
  //                 //             setState(() {
  //                 //               oldBalance = double.parse(
  //                 //                       ob[0]['balance'].toString())
  //                 //                   .toStringAsFixed(2);
  //                 //             });
  //                 //           },
  //                 //           dropDownMenuItems: offLineCustomersDropDown),
  //                 //     ),
  //                 //   ),
  //                 // )
  //               ],
  //             ),
  //             Row(
  //               children: [
  //                 Icon(
  //                   Icons.account_balance_wallet_outlined,
  //                   color:Colors.blue,
  //                 ),
  //                 Expanded(
  //                   child: Container(
  //                     height: 50,
  //                     margin: EdgeInsets.all(5),
  //                     decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         borderRadius: BorderRadius.circular(5)),
  //                     child: Padding(
  //                       padding:
  //                           const EdgeInsets.only(left: 8.0, right: 8.0),
  //                       child: Align(
  //                           alignment: Alignment.centerLeft,
  //                           child: Text(
  //                            'oldBalance,',
  //                             style: TextStyle(
  //                                 color: Colors.grey[900], fontSize: 16),
  //                           )),
  //                     ),
  //                   ),
  //                 ),
  //                 Icon(
  //                   Icons.receipt,
  //                   color:Colors.blue,
  //                 ),
  //                 Expanded(
  //                   child: Container(
  //                     margin: EdgeInsets.all(5),
  //                     decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         borderRadius: BorderRadius.circular(5)),
  //                     child: Padding(
  //                       padding:
  //                           const EdgeInsets.only(left: 8.0, right: 8.0),
  //                       child: TextField(
  //                          // controller: recBalanceController,
  //                           keyboardType: TextInputType.number,
  //                           decoration: InputDecoration(
  //                               border: InputBorder.none,
  //                               hintText: 'Received'),
  //                           onChanged: (value) {
  //                             // if (double.parse(outsBalance) > 0) {
  //                             //   setState(() {
  //                             //     outsBalance = (double.parse(oldBalance) -
  //                             //             double.parse(value))
  //                             //         .toString();
  //                             // // if (recBalanceController.text.isEmpty) {
  //                             // //   setState(() {
  //                             // //     outsBalance = '0.0';
  //                             // //   });
  //                             // // } else {
  //                             // //   setState(() {
  //                             // //     outsBalance =
  //                             // //         (double.parse(oldBalance) -
  //                             // //                 double.parse(value))
  //                             // //             .toStringAsFixed(2);
  //                             // //   });
  //                             // }
  //                           }),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             Row(
  //               children: [
  //                 Icon(
  //                   Icons.money,
  //                   color:Colors.blue,
  //                 ),
  //                 Expanded(
  //                   child: Container(
  //                     height: 45,
  //                     margin: EdgeInsets.all(5),
  //                     decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         borderRadius: BorderRadius.circular(5)),
  //                     child: Padding(
  //                       padding:
  //                           const EdgeInsets.only(left: 8.0, right: 8.0),
  //                       child: Align(
  //                         alignment: Alignment.centerLeft,
  //                         child: Text(
  //                          'outsBalance',
  //                           style: TextStyle(
  //                               fontSize: 16,
  //                               color: 'outsBalance' == 'Balance'
  //                                   ? Colors.grey
  //                                   : Colors.grey[900]),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 Icon(
  //                   Icons.payment,
  //                   color: Colors.blue,
  //                 ),
  //                 // Expanded(
  //                 //   child: Container(
  //                 //     height: 45,
  //                 //     margin: EdgeInsets.all(5),
  //                 //     decoration: BoxDecoration(
  //                 //         color: Colors.white,
  //                 //         borderRadius: BorderRadius.circular(5)),
  //                 //     child: Padding(
  //                 //         padding: const EdgeInsets.only(
  //                 //             left: 8.0, right: 8.0),
  //                 //         child: DropdownButton(
  //                 //           underline: Container(),
  //                 //           isExpanded: true,
  //                 //           hint: Text('Ledger'),
  //                 //           items: [
  //                 //             DropdownMenuItem(
  //                 //                 child: Text('Cash'), value: 'Cash'),
  //                 //             DropdownMenuItem(
  //                 //                 child: Text('Bank'), value: 'Bank'),
  //                 //             DropdownMenuItem(
  //                 //                 child: Text('Credit'), value: 'Credit')
  //                 //           ],
  //                 //           // onChanged: (String? value) {
  //                 //           //   setState(() {
  //                 //           //     selectedPaymode = value!;
  //                 //           //   });
  //                 //           // },
  //                 //         //  value: selectedPaymode,
  //                 //         )),
  //                 //   ),
  //                 // ),
  //               ],
  //             ),
  //             Row(
  //               children: [
  //                 Icon(
  //                   Icons.event_note_outlined,
  //                   color:Colors.blue
  //                 ),
  //                 Expanded(
  //                   flex: 2,
  //                   child: Container(
  //                     margin: EdgeInsets.all(5),
  //                     decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         borderRadius: BorderRadius.circular(5)),
  //                     child: Padding(
  //                       padding:
  //                           const EdgeInsets.only(left: 8.0, right: 8.0),
  //                       child: TextField(
  //                        // controller: remarksController,
  //                         decoration: InputDecoration(
  //                             border: InputBorder.none,
  //                             hintText: 'Remarks'),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             Divider(),
  //             Row(
  //               children: [
  //                 Expanded(child: Container()),
  //                 Expanded(
  //                   child: Container(
  //                     height: 40,
  //                     width: Constants(context).scrnWidth,
  //                     child: ElevatedButton(
  //                         onPressed: () {
  //                           // if (selectedCustomer == "") {
  //                           //   Fluttertoast.showToast(
  //                           //       msg: "Customer Required",
  //                           //       textColor: Colors.white,
  //                           //       backgroundColor: Colors.red);
  //                           // } else if (oldBalance == "") {
  //                           //   Fluttertoast.showToast(
  //                           //       msg: "Balance Required",
  //                           //       textColor: Colors.white,
  //                           //       backgroundColor: Colors.red);
  //                           // } else if (recBalanceController.text == "") {
  //                           //   Fluttertoast.showToast(
  //                           //       msg: "Received Required",
  //                           //       textColor: Colors.white,
  //                           //       backgroundColor: Colors.red);
  //                           // } else if (recBalanceController.text == "") {
  //                           //   Fluttertoast.showToast(
  //                           //       msg: "Received Required",
  //                           //       textColor: Colors.white,
  //                           //       backgroundColor: Colors.red);
  //                           // } else if (selectedPaymode == "") {
  //                           //   Fluttertoast.showToast(
  //                           //       msg: "Paymode Required",
  //                           //       textColor: Colors.white,
  //                           //       backgroundColor: Colors.red);
  //                           // } else if (outsBalance == "") {
  //                           //   Fluttertoast.showToast(
  //                           //       msg: " Outs Balance Requred ",
  //                           //       textColor: Colors.white,
  //                           //       backgroundColor: Colors.red);
  //                           // } else {
  //                           //   insertCollectionOffline();
  //                           // }
  //                         },
  //                         child: Text(
  //                           'Save',
  //                           style: TextStyle(color: Colors.grey[900]),
  //                         )),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     )
  //   ],
  //)

}
