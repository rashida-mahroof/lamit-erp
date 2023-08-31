import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lamit/app/modules/event/views/event_view.dart';
import 'package:lamit/app/routes/constants.dart';
import 'package:http/http.dart' as http;
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/tocken/tockn.dart';

class EvetviewView extends StatefulWidget {
  final String? leadtok;
  final String? name;

  const EvetviewView(this.leadtok, this.name);
  @override
  State<EvetviewView> createState() => _EvetviewViewState();
}

class _EvetviewViewState extends State<EvetviewView> {
  var productList = [];
  String? restorationId;

  @override
  void initState() {
    super.initState();
    eventsView();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F9F9F9"),
      // appBar: AppBar(
      //   title: const Text('AddnotesView'),
      //   centerTitle: true,
      // ),
      body: Container(
        color: Colors.grey[100],
        height: Constants(context).scrnHeight + 400,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                color: Colors.grey[100],
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
                            EventView(widget.leadtok, widget.name.toString()));
                      }),
                      child: Container(
                        child: Row(
                          children: [
                            Icon(Icons.add_outlined),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "ADD A EVENT",
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
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        // shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        itemCount: productList.length,
                        itemBuilder: ((context, index) {
                          return Card(
                            child: ListTile(
                              title: Wrap(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Event name :  ',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black54)),
                                    Text(productList[index]["event_name"],
                                        style: TextStyle(
                                          // height: 1.5,
                                          // fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        )),
                                  ]),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Divider(),
                                  Visibility(
                                    visible: productList[index]["date"] == null
                                        ? false
                                        : true,
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Dates:   ',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black54),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: productList[index]["date"]
                                                  .toString(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Remarks:   ',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.black54)),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        // height: 300,
                                        child: Text(
                                            productList[index]["remarks"]
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.black54,
                                              height: 1.5,
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );

                          return productList[index]["member_name"] == ""
                              ? Container()
                              : Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: Card(
                                    color: Colors.grey[200],
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
                                                        child:
                                                            Text("Event name")),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Container(
                                                          height: 15,
                                                          child: Text("Dates")),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Container(
                                                          height: 120,
                                                          child:
                                                              Text("Remarks")),
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
                                                          height: 120,
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
                                                          child: Text(
                                                            productList[index][
                                                                        "event_name"] ==
                                                                    null
                                                                ? ""
                                                                : productList[
                                                                            index]
                                                                        [
                                                                        "event_name"]
                                                                    .toString(),
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                          ),
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
                                                                      "date"] ==
                                                                  null
                                                              ? ""
                                                              : productList[
                                                                          index]
                                                                      ["date"]
                                                                  .toString()),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 8.0),
                                                        child: Container(
                                                          height: 120,
                                                          width: Constants(
                                                                      context)
                                                                  .scrnWidth -
                                                              200,
                                                          child: Text(
                                                              productList[index]
                                                                          [
                                                                          "remarks"] ==
                                                                      null
                                                                  ? ""
                                                                  : productList[
                                                                              index]
                                                                          [
                                                                          "remarks"]
                                                                      .toString(),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis),
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
                    height: 380,
                  )
                ])),
          ),
        ),
      ),
    );
  }

  eventsView() async {
    var a = widget.leadtok.toString();
    log(a.toString());
    http.Response response = await http.get(
      Uri.parse(urlMain + 'api/resource/Lead/$a?fields=["lead_events"]'),
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
        productList = jsonDecode(data)["data"]["lead_events"];
      });

      // log(productList[0]["note"]);
      print(data);
    } else {}
  }
}
