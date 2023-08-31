import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:lamit/app/modules/salesinvoicereport/views/salesinvoicereport_view.dart';
import 'package:lamit/app/modules/salesinvoicevieeeeeeeeeeeeeeeeeeew/views/salesinvoicevieeeeeeeeeeeeeeeeeeew_view.dart';
import 'package:lamit/app/routes/constants.dart';
import 'package:http/http.dart' as http;
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/tocken/tockn.dart';

class SalesinvoiceviewView extends StatefulWidget {
  final String seris;
  final int indexValue;
  const SalesinvoiceviewView(this.seris, this.indexValue);

  @override
  State<SalesinvoiceviewView> createState() => _SalesinvoiceviewViewState();
}

class _SalesinvoiceviewViewState extends State<SalesinvoiceviewView> {
  var productlist;
  @override
  void initState() {
    detailinvoceView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: productlist == null
          ? Container()
          : Column(
              children: [
                Container(
                  child: Container(
                    height: Constants(context).scrnHeight - 190,
                    width: Constants(context).scrnWidth,
                    child: ListView.builder(
                        itemCount: productlist.length,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(SalesinvoicevieeeeeeeeeeeeeeeeeeewView(
                                  productlist[index]["name"].toString()));
                            },
                            child: Container(
                              child: Card(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      //mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Cusomer name"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Mobile no"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Locations"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Amount"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Tax amount"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Grand total"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Posting Date"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Payment status"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Outstanding balance"),
                                        ),
                                        Container(
                                          child: Column(
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  log('rashname: ' +
                                                      productlist[index]["name"]
                                                          .toString());
                                                  log(productlist[index]
                                                          ["customer"]
                                                      .toString());
                                                  Get.to(
                                                    SalesinvoicereportView(
                                                        productlist[index]
                                                                        ["name"]
                                                                    .toString() ==
                                                                ""
                                                            ? ""
                                                            : productlist[index]
                                                                    ["name"]
                                                                .toString(),
                                                        widget.seris.toString(),
                                                        productlist[index][
                                                                    "customer"] ==
                                                                ""
                                                            ? ""
                                                            : productlist[index]
                                                                    ["customer"]
                                                                .toString(),
                                                        productlist[index][
                                                                    "customer"] ==
                                                                ""
                                                            ? ""
                                                            : productlist[index]
                                                                    ["customer"]
                                                                .toString(),
                                                        productlist[index]
                                                            ["status"],
                                                        widget.indexValue),
                                                  );
                                                },
                                                child: Container(
                                                  child: Container(
                                                      child: Row(
                                                    children: [
                                                      //Expanded(child: Container()),
                                                      Text(
                                                        "Delivery note +",
                                                        style: TextStyle(
                                                            color: Colors.blue),
                                                      ),
                                                      // Icon(
                                                      //   Icons.arrow_downward,
                                                      //   size: 12,
                                                      // ),
                                                    ],
                                                  )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      //mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(":"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(":"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(":"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(":"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(":"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(":"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(":"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(":"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(":"),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      //mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(productlist[index]
                                                      ["customer"] ==
                                                  null
                                              ? ""
                                              : productlist[index]["customer"]
                                                  .toString()),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(productlist[index]
                                                  ["mobile_no"]
                                              .toString()),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(productlist[index]
                                                  ["customer_location"]
                                              .toString()),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(productlist[index]
                                                  ["total"]
                                              .toString()),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(productlist[index]
                                                  ["total_taxes_and_charges"]
                                              .toString()),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(productlist[index]
                                                  ["grand_total"]
                                              .toString()),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(productlist[index]
                                                  ["posting_date"]
                                              .toString()),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(productlist[index]
                                                  ["status"]
                                              .toString()),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(productlist[index]
                                                  ["outstanding_amount"]
                                              .toString()),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                )
              ],
            ),
    );
  }

  detailinvoceView() async {
    log(widget.seris.toString());
    print("object");
    var s = widget.seris;
    // var Tocken;
    http.Response response = await http.get(
      Uri.parse(urlMain +
          'api/resource/Sales Invoice?filters=[["lead_id", "=", "$s"]]&fields=["*"]&limit=100000&order_by=creation%20desc'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Tocken,
      },
    );
    log(response.body + 'payrash');
    print(response.statusCode);
    if (response.statusCode == 200) {
      String data = response.body;
      setState(() {
        //baisicDetail = jsonDecode(data)["data"];
        productlist = jsonDecode(data)["data"];
      });

      // log(productList[0]["note"]);

      //  baisicDetailView2();
    } else {}
  }
}
