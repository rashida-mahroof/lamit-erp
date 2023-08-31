import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lamit/app/modules/addquatat/views/addquatat_view.dart';

import 'package:lamit/app/modules/requirement/views/requirement_view.dart';
import 'package:lamit/app/modules/viewrequirement/views/edit-requirement.dart';
import 'package:lamit/app/routes/constants.dart';
import 'package:http/http.dart' as http;
import 'package:lamit/testtttt.dart';
import 'package:lamit/tocken/tockn.dart';

import '../../../../tocken/config/url.dart';

class ViewrequirementView extends StatefulWidget {
  final String? leadtok;
  final String? name;

  const ViewrequirementView(this.leadtok, this.name);

  @override
  State<ViewrequirementView> createState() => _ViewrequirementViewState();
}

class _ViewrequirementViewState extends State<ViewrequirementView> {
  var productList = [];
  var produ;
  @override
  void initState() {
    requirementView();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('AddnotesView'),
      //   centerTitle: true,
      // ),
      body: productList == null
          ? Container()
          : Container(
              height: Constants(context).scrnHeight,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      color: HexColor("#F9F9F9"),
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (() {
                              // var i;
                              // for (var i = 0; i < productList.length; i++) {
                              //   productList[i];
                              // }
                              Get.to(
                                  RequirementView(widget.leadtok, widget.name));
                            }),
                            child: Container(
                              child: Row(
                                children: [
                                  Icon(Icons.add_outlined),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "ADD REQUIREMENT",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (() {
                              // for (var i = 0; i < productList.length; i++) {
                              //   produ = productList[i];
                              // }
                              // Get.to(AddquatatView());

                              Get.to(SalesInvoice(widget.leadtok.toString(),
                                  widget.name.toString(), productList));
                            }),
                            child: Container(
                              child: Row(
                                children: [
                                  Icon(Icons.add_outlined),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "ADD THIS QUOTATION",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Expanded(
                            child: ListView.builder(
                              itemCount: productList.length,
                              itemBuilder: ((context, index) {
                                return Container(
                                    height: 105,
                                    width: Constants(context).scrnWidth,
                                    child: Card(
                                      color: Colors.white,
                                      shape: BeveledRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(1.0)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, top: 8),
                                              child: Text(productList[index]
                                                          ["product"] ==
                                                      null
                                                  ? ""
                                                  : productList[index]
                                                      ["product"])),
                                          Expanded(child: Container()),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              productList[index]["color"] ==
                                                      null
                                                  ? ""
                                                  : productList[index]["color"],
                                              style: TextStyle(
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  productList[index]["qty"] ==
                                                          null
                                                      ? ""
                                                      : "Qty :   " +
                                                          productList[index]
                                                              ["qty"],
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Wrap(
                                                children: [
                                                  IconButton(

                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => EditRequirement(
                                                                    widget
                                                                        .leadtok,
                                                                    widget.name,
                                                                    productList[
                                                                            index]
                                                                        [
                                                                        "product"],
                                                                    productList[
                                                                            index]
                                                                        ["qty"],
                                                                    productList[
                                                                            index]
                                                                        [
                                                                        "color"],
                                                                 productList[
                                                                            index]
                                                                        [
                                                                        "name"])));
                                                      },
                                                      icon: Icon(
                                                        Icons.edit,
                                                        color: Colors.grey[600],
                                                      )),
                                                  IconButton(
                                                      onPressed: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                content: Text("Do you want to delete " +
                                                                    productList[
                                                                            index]
                                                                        [
                                                                        "product"]),
                                                                actions: [
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      style: TextButton.styleFrom(
                                                                          primary: Colors.red[
                                                                              200]),
                                                                      child: Text(
                                                                          'No')),
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        deleteReq(
                                                                            productList[index]["name"],
                                                                            index,productList[index]["parent"]);

                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      style: TextButton.styleFrom(
                                                                          primary: Colors
                                                                              .black54),
                                                                      child: Text(
                                                                          'Yes'))
                                                                ],
                                                              );
                                                            });
                                                      },
                                                      icon: Icon(
                                                        Icons.delete,
                                                        color: Colors.red[300],
                                                      ))
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ));
                              }),

                            ),
                          ),
                        )
                      ])),
                ),
              ),
            ),
    );
  }

  requirementView() async {
    var a = widget.leadtok;
    print("object");
    http.Response response = await http.get(
      Uri.parse(urlMain + "api/resource/Lead/$a"),
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
        productList = jsonDecode(data)["data"]["customer_requirements"];
      });

      // log(productList[0]["note"]);
      print(data + 'rmio');
    } else {}
  }

  void deleteReq(id, index,lead) async {
    print(id+'----id');
    http.Response response =
        await http.post(Uri.parse(urlMain + "api/resource/UpdateTable"),
            headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'Authorization': Tocken,
            },
            body: jsonEncode({
              "doc_type": "Lead",
              "reference_doc": "$lead",
              "table_name": "customer_requirements",
              "delete_id_1": "$id"}));
    log(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Requirement deleted');
      setState(() {
        productList.removeAt(index);
      });
    } else {
      Fluttertoast.showToast(msg: response.reasonPhrase.toString());
    }
  }
}
