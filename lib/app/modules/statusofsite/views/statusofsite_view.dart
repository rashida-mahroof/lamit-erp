import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:lamit/app/modules/sitestatusadd/views/sitestatusadd_view.dart';
import 'package:lamit/app/routes/constants.dart';
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/tocken/tockn.dart';
import 'package:http/http.dart' as http;
import 'package:lamit/widget/imagevie.dart';

class StatusofsiteView extends StatefulWidget {
  final String? leadtok;
  final String? name;

  const StatusofsiteView(this.leadtok, this.name);

  @override
  State<StatusofsiteView> createState() => _StatusofsiteViewState();
}

class _StatusofsiteViewState extends State<StatusofsiteView> {
  var productList = [];
  @override
  void initState() {
    eventsView();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('AddnotesView'),
      //   centerTitle: true,
      // ),
      body: Container(
        color: Colors.grey[100],
        height: Constants(context).scrnHeight,
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
                        Get.to(SitestatusaddView(widget.leadtok, widget.name));
                      }),
                      child: Container(
                        child: Row(
                          children: [
                            Icon(Icons.add_outlined),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "ADD SITE OF STATUS ",
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
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: productList.length,
                        itemBuilder: ((context, index) {
                          return Container(
                              height: 350,
                              width: Constants(context).scrnWidth,
                              child: Card(
                                color: Colors.white,
                                shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Container(
                                  // width: Constants(context).scrnWidth,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15.0, vertical: 8),
                                            child: Text(
                                              productList[index]["creation"]
                                                          .toString() ==
                                                      "null"
                                                  ? ""
                                                  : DateFormat("dd-MM-y")
                                                      .format(DateTime.parse(
                                                      productList[index]
                                                          ["creation"],
                                                    )),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              //  productList[index]["event_name"]
                                            )),

                                        //  Icon(Icons.edit),
                                        //Expanded(child: Container()),
                                        if (productList[index]
                                                ["current_status"] !=
                                            null)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.0),
                                            child: Container(
                                              child: Text(
                                                "CURRENT STATUS :  " +
                                                    productList[index]
                                                            ["current_status"]
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.green),
                                              ),
                                            ),
                                          ),
                                        SizedBox(
                                          height: 10,
                                        ),

                                        GestureDetector(
                                          onTap: () {
                                            Get.to(SizeWidget(
                                                3,
                                                urlMain +
                                                    productList[index]
                                                            ["upload_photo"]
                                                        .toString()));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Container(
                                              height: 90,
                                              width: 90,
                                              child: CachedNetworkImage(
                                                imageUrl: urlMain +
                                                    productList[index]
                                                            ["upload_photo"]
                                                        .toString(),
                                                placeholder: (context, url) =>
                                                    new CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        new Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Container(
                                            child: Text(
                                              "REMARKS",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey.shade400),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Container(
                                            // height: 50,
                                            child: Text(
                                                productList[index]["remarks"]
                                                            .toString() ==
                                                        "null"
                                                    ? ""
                                                    : productList[index]
                                                        ["remarks"],
                                                style: TextStyle(
                                                  height: 1.5,
                                                  color: Colors.black54,
                                                  // fontSize: 17,

                                                  // fontWeight: FontWeight.w600,
                                                ),
                                                overflow: TextOverflow.visible),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        )
                                        // Padding(
                                        //   padding: const EdgeInsets.only(
                                        //       left: 16.0),
                                        //   child: Container(
                                        //     child: Text(
                                        //       productList[index]["remarks"]
                                        //                   .toString() ==
                                        //               "null"
                                        //           ? ""
                                        //           : productList[index]
                                        //               ["remarks"],
                                        //       maxLines:
                                        //           3, //2 or more line you want
                                        //       overflow: TextOverflow.ellipsis,

                                        //       style: TextStyle(
                                        //         fontSize: 14,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                        }),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                  )
                ])),
          ),
        ),
      ),
    );
  }

  eventsView() async {
    print("object");
    var a = widget.leadtok;
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
        productList = jsonDecode(data)["data"]["site_status"];
      });
      log(productList.toString());

      // log(productList[0]["note"]);
      print(data);
    } else {}
  }
}
