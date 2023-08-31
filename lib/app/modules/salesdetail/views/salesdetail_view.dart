import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:lamit/app/modules/addqoutationadd/views/addqoutationadd_view.dart';

import 'package:lamit/app/modules/leaddetails/views/leaddetails_view.dart';
import 'package:lamit/app/modules/stock/views/stock_view.dart';

import 'package:lamit/app/modules/viewrequirement/views/viewrequirement_view.dart';
import 'package:lamit/app/routes/constants.dart';
import 'package:lamit/widget/customeappbar.dart';

import '../../../../tocken/config/url.dart';
import '../../../../tocken/tockn.dart';

class SalesdetailView extends StatefulWidget {
  final String? name;
  final String? status;
  final String? contacts;
  final String? email;
  final String? direction;
  final String? series;

  SalesdetailView(this.name, this.status, this.contacts, this.email,
      this.direction, this.series);

  @override
  State<SalesdetailView> createState() => _SalesdetailViewState();
}

class _SalesdetailViewState extends State<SalesdetailView> {
  var productList;
  var leadcatag;
  var leadname;
  var open;
  bool button = false;
  String? lea;
  var vaaaa;
  bool cusCreated = false;
  void initState() {
    // qttnvie();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.to(LeaddetailsView(widget.name, "", 0, "", "", widget.series));
        return false;
      },
      child: Scaffold(
        backgroundColor: HexColor("#EEf3f9"),
        // // floatingActionButton: FloatingActionButton.extended(
        // //   backgroundColor: Colors.white,
        // //   onPressed: () {
        // //     // Add your onPressed code here!
        // //   },
        //   label: Row(
        //     children: [
        //       Text(
        //         'Add to a customerdet',
        //         style: TextStyle(color: Colors.black),
        //       ),
        //       Text(
        //         ' ?',
        //         style: TextStyle(color: Colors.green),
        //       ),
        //     ],
        //   ),
        //   icon: const Icon(
        //     Icons.people,
        //   ),
        //   //backgroundColor: Colors.green[100],
        // ),
        appBar: PreferredSize(
          preferredSize:
              Size(MediaQuery.of(context).size.width, kToolbarHeight),
          child: CustomAppBar(
            title: 'SALE DETAIL',
          ),
        ),
        //floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        // floatingActionButton: FloatingActionButton(
        //   // isExtended: true,
        //   child: Column(
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Text(
        //           "TASK",
        //           style: TextStyle(fontSize: 9),
        //         ),
        //       ),
        //       Icon(
        //         Icons.add,
        //         size: 13,
        //         color: Colors.black,
        //       ),
        //     ],
        //   ),
        //   // backgroundColor: Colors.blue,
        //   onPressed: () {
        //     setState(() {
        //       _showMyDialog();
        //     });
        //   },
        // ),
        body: Padding(
          padding: const EdgeInsets.only(top: 00),
          child: Container(
            color: HexColor("#EEf3f9"),
            child: Stack(
              children: [
                Container(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40.0),
                          topLeft: Radius.circular(40.0)),
                    ),
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.only(
                    //         topLeft: Radius.circular(40),
                    //         topRight: Radius.circular(40))),

                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      // color: Colors.blue,
                      width: Constants(context).scrnWidth,
                      height: Constants(context).scrnHeight,
                      child: ContainedTabBarView(
                        initialIndex: widget.status == "qt"
                            ? 2
                            : widget.status == "req"
                                ? 1
                                : 0,
                        tabs: [
                          Container(
                            child: Text('STOCK', style: TextStyle(fontSize: 9)),
                          ),
                          Container(
                            child: Text('REQUIREMENT',
                                style: TextStyle(fontSize: 9)),
                          ),
                          Container(
                            child: Text('QUOTATION',
                                style: TextStyle(fontSize: 9)),
                          ),
                        ],
                        views: [
                          StockView(),
                          ViewrequirementView(widget.series, widget.name),
                          AddqoutationaddView(widget.series.toString(),
                              widget.name.toString(), []),
                          //AddcustomerView()
                        ],
                        onChange: (index) {
                          print(index);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  qttnvie() async {
    var a = widget.series;
    print("object");
    http.Response response = await http.get(
      Uri.parse(urlMain +
          'api/resource/Quotation?fields=["reason_for_lost_quotation","total","created_salesorder","created_customer","party_name","customer_name","name","status","grand_total","net_total","total_taxes_and_charges","mobile_number"]&filters=[["party_name","=","$a"]]&limit=100000&order_by=creation%20desc'),
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
        productList = jsonDecode(data)["data"];

        vaaaa = jsonDecode(data)["data"];
        for (var i = 0; i < productList.length; i++) {
          open = productList[i]["created_customer"];
          if (open == 1) {
            button = true;
          }
        }
        for (var i = 0; i < productList.length; i++) {
          if (productList[i]["created_customer"] == 1) {
            cusCreated = true;
          }
        }
      });

      // log(productList[0]["note"]);
      print(data);
    } else {}
  }
}
