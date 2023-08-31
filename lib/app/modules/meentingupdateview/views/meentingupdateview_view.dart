import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:lamit/app/routes/constants.dart';
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/tocken/tockn.dart';

class MeentingupdateviewView extends StatefulWidget {
  final String? leadseries;
  final String? name;

  const MeentingupdateviewView(this.leadseries, this.name);

  @override
  State<MeentingupdateviewView> createState() => _MeentingupdateviewViewState();
}

class _MeentingupdateviewViewState extends State<MeentingupdateviewView> {
  var productList = [];
  @override
  void initState() {
    leadview();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('AddnotesView'),
      //   centerTitle: true,
      // ),
      body: productList.length == 0
          ? Container()
          // ? GestureDetector(
          //     onTap: () {
          //       Get.to(MeetingupdatesaddView(
          //           widget.leadseries, widget.name.toString()));
          //     },
          //     child: Container(
          //       child: Row(
          //         children: [
          //           Icon(Icons.add_outlined),
          //           Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Text(
          //               "ADD  MEETING UPDATES ",
          //               style: TextStyle(
          //                   color: Colors.grey, fontWeight: FontWeight.bold),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   )
          : Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(

                  // color: Colors.grey[100],
                  child: Column(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: GestureDetector(
                  //     onTap: (() {
                  //       Get.to(MeetingupdatesaddView(
                  //           widget.leadseries, widget.name.toString()));
                  //     }),
                  //     child: Container(
                  //       child: Row(
                  //         children: [
                  //           Icon(Icons.add_outlined),
                  //           Padding(
                  //             padding: const EdgeInsets.all(8.0),
                  //             child: Text(
                  //               "ADD  MEETING UPDATES ",
                  //               style: TextStyle(
                  //                   color: Colors.grey,
                  //                   fontWeight: FontWeight.bold),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        // shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        itemCount: productList.length,
                        itemBuilder: ((context, index) {
                          return productList[index]["member_name"] == ""
                              ? Container()
                              : Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: Card(
                                    color: Colors.grey[50],
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        height: 15,
                                                        child: Text("Name")),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Container(
                                                          height: 15,
                                                          child: Text(
                                                              "Contact date")),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Container(
                                                          height: 15,
                                                          child: Text(
                                                              "From time")),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Container(
                                                          height: 80,
                                                          child: Text("Notes")),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        child: Container(
                                                            height: 15,
                                                            child: Text(":"))),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Container(
                                                          height: 15,
                                                          child: Text(":")),
                                                    ),

                                                    // Padding(
                                                    //   padding: const EdgeInsets.only(top: 8.0),
                                                    //   child: Text(":"),
                                                    // ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Container(
                                                          height: 15,
                                                          child: Text(":")),
                                                    ),

                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Container(
                                                          height: 80,
                                                          child: Text(":")),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 8.0),
                                                        child: Container(
                                                          height: 15,
                                                          child: Text(productList[
                                                                          index]
                                                                      [
                                                                      "name1"] ==
                                                                  null
                                                              ? ""
                                                              : productList[
                                                                          index]
                                                                      ["name1"]
                                                                  .toString()),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 8.0),
                                                        child: Container(
                                                          height: 15,
                                                          child: Text(productList[
                                                                          index]
                                                                      [
                                                                      "contact_date"] ==
                                                                  null
                                                              ? ""
                                                              : productList[
                                                                          index]
                                                                      [
                                                                      "contact_date"]
                                                                  .toString()),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 8.0),
                                                        child: Container(
                                                          height: 15,
                                                          child: Text(productList[
                                                                          index]
                                                                      [
                                                                      "fromtime"] ==
                                                                  null
                                                              ? ""
                                                              : productList[
                                                                      index]
                                                                  ["fromtime"]),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 8.0),
                                                        child: Container(
                                                          height: 80,
                                                          width: Constants(
                                                                      context)
                                                                  .scrnWidth -
                                                              150,
                                                          child: SingleChildScrollView(
                                                            child: Text(
                                                                productList[index]
                                                                            [
                                                                            "notes"] ==
                                                                        null
                                                                    ? ""
                                                                    : productList[
                                                                                index]
                                                                            [
                                                                            "notes"]
                                                                        .toString(),
                                                                // maxLines: 4,
                                                                overflow:
                                                                    TextOverflow
                                                                        .visible),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    // Padding(
                                                    //   padding:
                                                    //       const EdgeInsets.all(
                                                    //           16.0),
                                                    //   child: GestureDetector(
                                                    //     onTap: () {
                                                    //       Get.to(AddbaisicdetailView(
                                                    //           "member",
                                                    //           widget.leadtocken,
                                                    //           "",
                                                    //           "",
                                                    //           "",
                                                    //           "",
                                                    //           "",
                                                    //           "",
                                                    //           productList[index]
                                                    //               ["member_name"],
                                                    //           productList[index]
                                                    //               ["education"],
                                                    //           productList[index]
                                                    //               ["gender"],
                                                    //           productList[index][
                                                    //               "relation_with_lead"],
                                                    //           productList[index]
                                                    //               ["dob"],
                                                    //           productList[index][
                                                    //               "marital_status"],
                                                    //           productList[index]
                                                    //               ["age"],
                                                    //           productList[index]
                                                    //               ["idx"]));
                                                    //     },
                                                    //     child: Container(
                                                    //       child: Icon(
                                                    //         Icons.edit,
                                                    //         color: Colors.green,
                                                    //       ),
                                                    //     ),
                                                    //   ),
                                                    // )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                        })),
                  ),

                  SizedBox(
                    height: 400,
                  )
                ],
              )),
            ),
    );
  }

  leadview() async {
    var a = widget.leadseries;
    print(a.toString() + "cdvcd");
    // print(skey);
    http.Response response =
        await http.get(Uri.parse(urlMain + "api/resource/Lead/$a"), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    });
    String data = response.body;
    log(data + "jjjjjjjjj");
    setState(() {
      productList = jsonDecode(data)["data"]["meeting_updates2"];
    });

    print("object");
    // print(leadArray);

    // print("laedarray" + leadArray);

    return null;
  }
}
