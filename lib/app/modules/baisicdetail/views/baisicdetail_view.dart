import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

import 'package:lamit/app/modules/addbaisicdetail/views/addbaisicdetail_view.dart';

import 'package:lamit/app/routes/constants.dart';
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/tocken/tockn.dart';

class BaisicdetailView extends StatefulWidget {
  final String? leadtocken;

  const BaisicdetailView(this.leadtocken);

  @override
  State<BaisicdetailView> createState() => _BaisicdetailViewState();
}

class _BaisicdetailViewState extends State<BaisicdetailView> {
  var productList;
  var arra;
  String? baisicDetail;
  String? materialStatus;
  String? education;
  String? noOfkids;
  String? companyName;
  String? designation;
  var baisicDetai;

  @override
  void initState() {
    baisicDetailView();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: arra == null
            ? Container()
            : Container(
                height: Constants(context).scrnHeight,
                width: Constants(context).scrnWidth,
                color: Colors.grey[200],
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (() {
                            Get.to(AddbaisicdetailView(
                                "add",
                                "add",
                                widget.leadtocken,
                                baisicDetail.toString(),
                                materialStatus,
                                education,
                                noOfkids,
                                companyName,
                                designation,
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                0,
                                "",
                                ""));
                          }),
                          child: Container(
                            child: Row(
                              children: [
                                Icon(Icons.add_outlined),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "ADD BAISIC DETAILS",
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
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'BASIC DETAIL',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 8, 68, 116),
                                  fontWeight: FontWeight.bold),
                            ),
                             GestureDetector(
                               onTap: () {
                                 Get.to(AddbaisicdetailView(
                                     "",
                                     "edit"
                                         "add",
                                     widget.leadtocken,
                                     "",
                                     "",
                                     "",
                                     "",
                                     "",
                                     "",
                                     "",
                                     "",
                                     "",
                                     "",
                                     "",
                                     "",
                                     "",
                                     0.toInt(),
                                     "",
                                     ""));
                               },
                               child: baisicDetail == "----Select----"
                                   ? Container()
                                   : GestureDetector(
                                       onTap: () {
                                         Get.to(AddbaisicdetailView(
                                             "",
                                             "add",
                                             widget.leadtocken,
                                             baisicDetail.toString(),
                                             materialStatus,
                                             education,
                                             noOfkids,
                                             companyName,
                                             designation,
                                             "",
                                             "",
                                             "",
                                             "",
                                             "",
                                             "",
                                             "",
                                             0,
                                             "",
                                             ""));
                                       },
                                       child: Container(
                                         child: Icon(
                                           Icons.edit,
                                           color: Colors.green,
                                         ),
                                       ),
                                     ),
                             )
                            
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 8),
                        child: Container(
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text("Social Group"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text("Education"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text("Marital Status"),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text("No Of Kids"),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(top: 8.0),
                                  //   child: Text("Company Name"),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text("Occupation"),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(":"),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(top: 8.0),
                                  //   child: Text(":"),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(":"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(":"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(":"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(":"),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    baisicDetail == "----Select----"
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(""),
                                          )
                                        : baisicDetail == null
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(""),
                                              )
                                            : baisicDetail == ""
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: Text(""),
                                                  )
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8),
                                                    child: Text(baisicDetail
                                                        .toString()),
                                                  ),

                                    education == "----Select----"
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: Text(""),
                                          )
                                        : education == null
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8),
                                                child: Text(""),
                                              )
                                            : education == ""
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8),
                                                    child: Text(""),
                                                  )
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8),
                                                    child: Text(
                                                        education.toString()),
                                                  ),

                                    materialStatus == "----Select----"
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: Text(""),
                                          )
                                        : materialStatus == ""
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8),
                                                child: Text(""),
                                              )
                                            : materialStatus == null
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8),
                                                    child: Text(""),
                                                  )
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8),
                                                    child: Text(materialStatus
                                                        .toString()),
                                                  ),
                                    noOfkids == null
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: Text(""),
                                          )
                                        : noOfkids == ""
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8),
                                                child: Text(""),
                                              )
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8),
                                                child:
                                                    Text(noOfkids.toString()),
                                              ),
                                    // companyName == null
                                    //     ? Text("")
                                    //     : companyName == ""
                                    //         ? Text("")
                                    //         : Padding(
                                    //             padding: const EdgeInsets.only(
                                    //                 top: 8.0),
                                    //             child: Text(
                                    //                 companyName.toString()),
                                    //           ),

                                    designation == null
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: Text(""),
                                          )
                                        : designation == ""
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8),
                                                child: Text(""),
                                              )
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(
                                                    designation.toString()),
                                              ),
                                  ],
                                ),
                              ),
                             ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: GestureDetector(
                      //     onTap: (() {
                      //       Get.to(AddbaisicdetailView(
                      //           "addmemb",
                      //           widget.leadtocken,
                      //           "",
                      //           "",
                      //           "",
                      //           "",
                      //           "",
                      //           "",
                      //           "",
                      //           "",
                      //           "",
                      //           "",
                      //           "",
                      //           "",
                      //           "",
                      //           0));
                      //     }),
                      //     child: Container(
                      //       child: Row(
                      //         children: [
                      //           Icon(Icons.add_outlined),
                      //           Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: Text(
                      //               "ADD MEMBER DETAIL",
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (() {
                            Get.to(AddbaisicdetailView(
                                "",
                                "mem",
                                widget.leadtocken,
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                0,
                                "",
                                ""));
                          }),
                          child: Container(
                            child: Row(
                              children: [
                                Icon(Icons.add_outlined),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "ADD MEMBER DETAILS",
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
                      productList == ""
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('MEMBER DETAIL',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 8, 68, 116),
                                      fontWeight: FontWeight.bold)),
                            ),

                      Expanded(
                        child: ListView.builder(
                            // shrinkWrap: true,
                            // physics: NeverScrollableScrollPhysics(),
                            itemCount: productList.length,
                            itemBuilder: ((context, index) {
                              return productList[index]["member_name"] == ""
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 16),
                                      child: Card(
                                        color: Colors.grey[50],
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    Get.to(AddbaisicdetailView(
                                                        "",
                                                        "memb",
                                                        widget.leadtocken,
                                                        "",
                                                        "",
                                                        "",
                                                        "",
                                                        "",
                                                        "",
                                                        productList[index]["member_name"] == ""
                                                            ? ""
                                                            : productList[index]
                                                                ["member_name"],
                                                        productList[index]["education"] == ""
                                                            ? ""
                                                            : productList[index]
                                                                ["education"],
                                                        productList[index]["gender"] == ""
                                                            ? ""
                                                            : productList[index]
                                                                ["gender"],
                                                        productList[index]["relation_with_lead"] == ""
                                                            ? ""
                                                            : productList[index][
                                                                "relation_with_lead"],
                                                        productList[index]["dob"] == ""
                                                            ? ""
                                                            : productList[index]
                                                                ["dob"],
                                                        productList[index]["marital_status"] == ""
                                                            ? ""
                                                            : productList[index][
                                                                "marital_status"],
                                                        productList[index]["age"] == ""
                                                            ? ""
                                                            : productList[index]
                                                                ["age"],
                                                        productList[index]["idx"] == ""
                                                            ? ""
                                                            : productList[index]
                                                                ["idx"],
                                                        productList[index]["occupation"] == ""
                                                            ? ""
                                                            : productList[index]
                                                                ["ocuupation"],
                                                        productList[index]["name"] == "" ? "" : productList[index]["name"].toString()));
                                                  },
                                                  // label: Text('',style: TextStyle(color: Colors.green),),
                                                  icon: Container(
                                                    child: Icon(
                                                      Icons.edit,
                                                      color:Colors.green,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                child: Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("Member name"),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 8.0),
                                                          child:
                                                              Text("Education"),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 8.0),
                                                          child: Text("Gender"),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 8.0),
                                                          child: Text(
                                                              "Relation With Lead"),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 8.0),
                                                          child: Text(
                                                              "Date Of Birth"),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 8.0),
                                                          child: Text(
                                                              "Material Status"),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 8.0),
                                                          child: Text(
                                                              "Occupation"),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                            child: Text(":")),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 8.0),
                                                          child: Text(":"),
                                                        ),

                                                        // Padding(
                                                        //   padding: const EdgeInsets.only(top: 8.0),
                                                        //   child: Text(":"),
                                                        // ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 8.0),
                                                          child: Text(":"),
                                                        ),

                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 8.0),
                                                          child: Text(":"),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 8.0),
                                                          child: Text(":"),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 8.0),
                                                          child: Text(":"),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 8.0),
                                                          child: Text(":"),
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
                                                          GestureDetector(
                                                            onTap: (){
                                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(productList[
                                                                              index]
                                                                          [
                                                                          "member_name"])));
                                                            },
                                                            child: Container(
                                                              width: MediaQuery.of(context).size.width/2,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 8.0),
                                                                child: Text(productList[
                                                                                index]
                                                                            [
                                                                            "member_name"] ==
                                                                        null
                                                                    ? ""
                                                                    : productList[
                                                                                index]
                                                                            [
                                                                            "member_name"]
                                                                        .toString(),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 8.0),
                                                            child: Text(productList[
                                                                            index]
                                                                        [
                                                                        "education"] ==
                                                                    null
                                                                ? ""
                                                                : productList[
                                                                            index]
                                                                        [
                                                                        "education"]
                                                                    .toString()),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 8.0),
                                                            child: Text(productList[
                                                                            index]
                                                                        [
                                                                        "gender"] ==
                                                                    null
                                                                ? ""
                                                                : productList[
                                                                        index]
                                                                    ["gender"]),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 8.0),
                                                            child: Text(productList[
                                                                            index]
                                                                        [
                                                                        "relation_with_lead"] ==
                                                                    null
                                                                ? ""
                                                                : productList[
                                                                            index]
                                                                        [
                                                                        "relation_with_lead"]
                                                                    .toString()),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 8.0),
                                                            child: Text(productList[
                                                                            index]
                                                                        [
                                                                        "dob"] ==
                                                                    null
                                                                ? ""
                                                                : productList[
                                                                            index]
                                                                        ["dob"]
                                                                    .toString()),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 8.0),
                                                            child: Text(productList[
                                                                            index]
                                                                        [
                                                                        "marital_status"] ==
                                                                    null
                                                                ? ""
                                                                : productList[
                                                                            index]
                                                                        [
                                                                        "marital_status"]
                                                                    .toString()),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 8.0),
                                                            child: Text(productList[
                                                                            index]
                                                                        [
                                                                        "occupation"] ==
                                                                    null
                                                                ? ""
                                                                : productList[
                                                                            index]
                                                                        [
                                                                        "occupation"]
                                                                    .toString()),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          )
                                                        ],
                                                      ),
                                                    ),
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
                        height: 280,
                      )
                    ],
                  ),
                ),
              ));
  }

  baisicDetailView() async {
    print("object");
    var s = widget.leadtocken;
    http.Response response = await http.get(
      Uri.parse(urlMain + "api/resource/Lead/$s"),
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
        //baisicDetail = jsonDecode(data)["data"];
        productList = jsonDecode(data)["data"]["member_details1"];
      });

      // log(productList[0]["note"]);
      print(data);
      baisicDetailView2();
    } else {}
  }

  baisicDetailView2() async {
    var s = widget.leadtocken;
    print("object");
    http.Response response = await http.get(
      Uri.parse(urlMain + "api/resource/Lead/$s"),
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
        arra = jsonDecode(data)["data"];
        materialStatus = jsonDecode(data)["data"]["marital_status1"];
        baisicDetail = jsonDecode(data)["data"]["social_group1"];
        education = jsonDecode(data)["data"]["education1"];
        noOfkids = jsonDecode(data)["data"]["numberofkids"];

        companyName = jsonDecode(data)["data"]["company_name1"];
        designation = jsonDecode(data)["data"]["occupation"];
        baisicDetai = jsonDecode(data)["data"];

        //productList =
      });

      // log(productList[0]["note"]);
      print(data);
    } else {}
  }
}
