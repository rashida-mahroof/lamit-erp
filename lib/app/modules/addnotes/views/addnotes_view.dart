import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lamit/app/modules/addnote/views/addnote_view.dart';
import 'package:lamit/app/routes/constants.dart';
import 'package:http/http.dart' as http;
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/tocken/tockn.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:nice_buttons/nice_buttons.dart';

class AddnotesView extends StatefulWidget {
  final String? leadtok;
  final String? name;

  const AddnotesView(this.leadtok, this.name);
  @override
  State<AddnotesView> createState() => _AddnotesViewState();
}

class _AddnotesViewState extends State<AddnotesView> {
  var productList;

  @override
  void initState() {
    addnotView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (() {
                        // var i;
                        // for (var i = 0; i < productList.length; i++) {
                        //   productList[i];
                        // }
                        Get.to(AddnoteView(widget.leadtok, widget.name));
                      }),
                      child: Container(
                        child: Row(
                          children: [
                            Icon(Icons.add_outlined),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "ADD LOCATION",
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
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 1,
                        itemBuilder: ((context, index) {
                          return Container(
                              height: Constants(context).scrnHeight - 200,
                              width: Constants(context).scrnWidth,
                              child: Card(
                                color: Colors.white,
                                shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    productList["latitude"] == null
                                        ? Container()
                                        : Center(
                                            child: NiceButtons(
                                              stretch: false,
                                              gradientOrientation:
                                                  GradientOrientation.Vertical,
                                              onTap: (finish) {
                                                MapsLauncher.launchCoordinates(
                                                    double.parse(productList[
                                                        "latitude"]),
                                                    double.parse(productList[
                                                        "longitude"]),
                                                    '');
                                              },
                                              child: Text(
                                                'Tap to view location',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18),
                                              ),
                                            ),
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

  addnotView() async {
    var a = widget.leadtok;
    print(a.toString());
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
        productList = jsonDecode(data)["data"];
      });

      // log(productList[0]["note"]);
      print(data);
    } else {}
  }

//   addnotview() async {
//     var jsonMap = {
//       "notes": [
//         {
//           "note": 'dnncnncnccncncnccnc',
//         },
//       ]
//     };
//     http.put(Uri.encodeFull(Uri.parse(Tocken)), body: jsonStr , headers: { "Accept" : "application/json"}).then((result) {
//   print(result.statusCode);
//   print(result.body);
// });
//   }
}
