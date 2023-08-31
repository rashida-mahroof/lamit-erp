import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lamit/app/modules/event/views/event_view.dart';
import 'package:lamit/app/routes/constants.dart';
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/tocken/tockn.dart';
import 'package:http/http.dart' as http;

class ProductdetailView extends StatefulWidget {
  final String? leadtok;

  const ProductdetailView(this.leadtok);

  @override
  State<ProductdetailView> createState() => _ProductdetailViewState();
}

class _ProductdetailViewState extends State<ProductdetailView> {
  var productList = [];
  @override
  void initState() {
    productView();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('StatusofsiteView'),
        //   centerTitle: true,
        // ),
        body: Scaffold(
      // appBar: AppBar(
      //   title: const Text('AddnotesView'),
      //   centerTitle: true,
      // ),
      body: Container(
        height: Constants(context).scrnHeight,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                color: Colors.grey[100],
                child: Column(children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: GestureDetector(
                  //     onTap: (() {
                  //       Get.to(EventView(""));
                  //     }),
                  //     child: Container(
                  //       child: Row(
                  //         children: [
                  //           Icon(Icons.add_outlined),
                  //           Padding(
                  //             padding: const EdgeInsets.all(8.0),
                  //             child: Text(
                  //               "PRODUCT DETAIL",
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
                  Container(
                    child: Expanded(
                      child: ListView.builder(
                        itemCount: productList.length,
                        itemBuilder: ((context, index) {
                          return Container(
                            height: 130,
                            child: Card(
                              child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("PRODUCT NAME"),
                                                    Text(
                                                      productList[index]
                                                              ["product"]
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 17),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Category"),
                                                    Text(
                                                      "3WAY",
                                                      style: TextStyle(
                                                          fontSize: 17),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("QTY"),
                                                  Text(productList[index]
                                                          ["qty"] +
                                                      ": nos"),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  )
                ])),
          ),
        ),
      ),
    ));
  }

  // asd() async {
  //   try {
  //     ///[1] CREATING INSTANCE
  //     var dioRequest = dio.Dio();
  //     dioRequest.options.baseUrl = '<YOUR-URL>';

  //     //[2] ADDING TOKEN
  //     dioRequest.options.headers = {
  //       'Authorization': '<IF-YOU-NEED-ADD-TOKEN-HERE>',
  //       'Content-Type': 'application/x-www-form-urlencoded'
  //     };

  //     //[3] ADDING EXTRA INFO
  //     var formData = new dio.FormData.fromMap(
  //         {'<SOME-EXTRA-FIELD>': 'username-forexample'});

  //     //[4] ADD IMAGE TO UPLOAD
  //     var image = "/files/Screenshot from 2022-09-28 17-45-41.png";
  //     var file = await dio.MultipartFile.fromFile(image.path,
  //         filename: basename(image.path),
  //         contentType: MediaType("image", basename(image.path)));

  //     formData.files.add(MapEntry('photo', file));

  //     //[5] SEND TO SERVER
  //     var response = await dioRequest.post(
  //       url,
  //       data: formData,
  //     );
  //     final result = json.decode(response.toString())['result'];
  //   } catch (err) {
  //     print('ERROR  $err');
  //   }
  // }
  pickphoto() {}
  productView() async {
    print("object");
    var leadtock = widget.leadtok;
    http.Response response = await http.get(
      Uri.parse(urlMain + "api/resource/Lead/$leadtock"),
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
        productList = jsonDecode(data)["data"]["products"];
      });

      // log(productList[0]["note"]);
      print(data);
    } else {}
  }
}
