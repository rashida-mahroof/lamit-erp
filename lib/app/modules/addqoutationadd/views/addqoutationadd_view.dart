import 'dart:convert';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lamit/app/modules/qttnmainviewwww/views/qttnmainviewwww_view.dart';
import 'package:lamit/app/modules/salesdetail/views/salesdetail_view.dart';
import 'package:lamit/app/modules/salesordercreate/views/salesordercreate_view.dart';

import 'package:lamit/app/routes/constants.dart';
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/tocken/tockn.dart';

class AddqoutationaddView extends StatefulWidget {
  final String leadtok;
  final String name;
  final maplist;

  AddqoutationaddView(this.leadtok, this.name, this.maplist);

  @override
  State<AddqoutationaddView> createState() => _AddqoutationaddViewState();
}

class _AddqoutationaddViewState extends State<AddqoutationaddView> {
  var productList;
  var leadcatag;
  var leadname;
  var open;
  bool cusCreated = false;
  bool isCusVisible = true;
  final textController = TextEditingController();
  TextEditingController resoncontroller = TextEditingController();

  int length = 0;

  _onChanged(String value) {
    setState(() {
      length = value.length;
    });

    if (length == 140) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:
                new Text('Sorry, You have Reached the Maximum input limit...'),
            actions: <Widget>[
              ElevatedButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  bool button = false;
  String? lea;
  var vaaaa;
  @override
  void initState() {
    print('----init working---' + widget.leadtok + widget.name);
    // qttnvie();
    leadcata();
    super.initState();
  }

  // @override
  // void didUpdateWidget(AddqoutationaddView oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
      child: Container(
        height: Constants(context).scrnHeight,
        child: FutureBuilder<List<dynamic>>(
            future: qttnvie(widget.leadtok),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length > 0) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: (() {
                            Get.to(QttnmainviewwwwView(
                                snapshot.data[index]["name"],
                                widget.leadtok,
                                widget.name));
                          }),
                          child: Container(
                            child: Card(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    snapshot.data[index]["status"] == "Lost"
                                        ? Container(
                                            width: 200,
                                            child: Text(
                                              "Reson for lost" +
                                                  ":" +
                                                  " " +
                                                  snapshot.data[index][
                                                          "reason_for_lost_quotation"]
                                                      .toString(),
                                              maxLines: 6,
                                            ),
                                          )
                                        : (snapshot.data[index][
                                                        "created_salesorder"] ==
                                                    0 &&
                                                snapshot.data[index]
                                                        ["status"] ==
                                                    'Open')
                                            ? ElevatedButton(
                                                child: const Text(
                                                    'Lost Quotation'),
                                                onPressed: () {
                                                  _displayTextInputDialog(
                                                    context,
                                                    snapshot.data[index]
                                                        ["name"],
                                                  );
                                                },
                                              )
                                            : Container(),
                                    Row(
                                      children: [
                                        Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Name"),
                                              Text("Quotation ID"),
                                              Text("Status"),
                                              Text("Net total"),
                                              Text("Tax amount"),
                                              Text("Grand total"),
                                              Text("mobile")
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(":"),
                                                Text(":"),
                                                Text(":"),
                                                Text(":"),
                                                Text(":"),
                                                Text(":"),
                                                Text(":")
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(snapshot.data[index]
                                                            ["customer_name"] ==
                                                        null
                                                    ? ""
                                                    : snapshot.data[index]
                                                            ["customer_name"]
                                                        .toString()),
                                                Text(
                                                  snapshot.data[index]["name"],
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade600),
                                                ),
                                                Text(
                                                  snapshot.data[index]
                                                              ["status"] ==
                                                          null
                                                      ? ""
                                                      : snapshot.data[index]
                                                              ["status"]
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: snapshot.data[
                                                                          index]
                                                                      [
                                                                      "status"] ==
                                                                  "Draft" ||
                                                              snapshot.data[
                                                                          index]
                                                                      [
                                                                      "status"] ==
                                                                  "Lost"
                                                          ? Colors.red
                                                          : Colors.green),
                                                ),
                                                Text(
                                                  snapshot.data[index]
                                                              ["net_total"] ==
                                                          null
                                                      ? ""
                                                      : snapshot.data[index]
                                                              ["net_total"]
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  snapshot.data[index][
                                                              "total_taxes_and_charges"] ==
                                                          null
                                                      ? ""
                                                      : snapshot.data[index][
                                                              "total_taxes_and_charges"]
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  snapshot.data[index]
                                                              ["grand_total"] ==
                                                          null
                                                      ? ""
                                                      : snapshot.data[index]
                                                              ["grand_total"]
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  snapshot.data[index][
                                                              "mobile_number"] ==
                                                          null
                                                      ? ""
                                                      : snapshot.data[index]
                                                              ["mobile_number"]
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    button == true
                                        ? Container()
                                        : snapshot.data[index]["status"] ==
                                                    "Open" &&
                                                isCusVisible == true
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      // Get.to(CustomrcreationView(
                                                      //     widget
                                                      //         .leadtok,
                                                      //     widget
                                                      //         .name));
                                                      addRequirement(
                                                          0,
                                                          [],
                                                          widget.leadtok,
                                                          widget.name);
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 2.0),
                                                      child: Container(
                                                          height: 30,
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "CREATE CUSTOMER ",
                                                                style: TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            2,
                                                                            58,
                                                                            104),
                                                                    fontSize:
                                                                        13),
                                                              ),
                                                              // Icon(
                                                              //   Icons.add,
                                                              //   size: 10,
                                                              // )
                                                            ],
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Container(),
                                    if (snapshot.data[index]
                                                ["created_salesorder"] ==
                                            0 &&
                                        cusCreated == true &&
                                        snapshot.data[index]["status"] ==
                                            "Open")
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton.icon(
                                              style: TextButton.styleFrom(
                                                  primary: Colors.blue[900]),
                                              onPressed: () {
                                                Get.to(SalesordercreateView(
                                                    snapshot.data[index]
                                                        ["name"],
                                                    widget.leadtok,
                                                    widget.name));
                                              },
                                              icon: Icon(Icons.add),
                                              label: Text('Sale Order')),
                                        ],
                                      ),
                                    // snapshot.data[index]
                                    //             [
                                    //             "created_salesorder"] ==
                                    //         1
                                    //     ? Container()
                                    //     : cusCreated ==
                                    //             false
                                    //         ? Container()
                                    //         : Column(
                                    //             crossAxisAlignment:
                                    //                 CrossAxisAlignment.start,
                                    //             children: [
                                    // SizedBox(
                                    //   height: 20,
                                    // ),
                                    // if(snapshot.data[index]["status"] != "Draft")
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.end,
                                    //   children: [
                                    //     TextButton.icon(onPressed: (){
                                    //        Get.to(SalesordercreateView(snapshot.data[index]["name"], widget.leadtok, widget.name));

                                    //     }, icon: Icon(Icons.add,color: Colors.blue[900]), label: Text(
                                    //                       "Sale Order",
                                    //                       style: TextStyle(color: Colors.blue[900], fontSize: 15),
                                    //                     ),),
                                    //   ],
                                    // ),

                                    // GestureDetector(
                                    //   onTap: () {
                                    //     Get.to(SalesordercreateView(snapshot.data[index]["name"], widget.leadtok, widget.name));
                                    //   },
                                    //   child: Container(
                                    //       height: 30,
                                    //       child: Row(
                                    //         mainAxisAlignment: MainAxisAlignment.end,
                                    //         children: [
                                    //           snapshot.data[index]["status"] == "Open"
                                    //               ? Text(
                                    //                   "Sale Order",
                                    //                   style: TextStyle(color: Colors.blue[900], fontSize: 15),
                                    //                 )
                                    //               : Text(""),
                                    //           snapshot.data[index]["status"] == "Open"
                                    //               ? Icon(
                                    //                   Icons.add,
                                    //                   size: 20,
                                    //                   color: Colors.blue[900],
                                    //                 )
                                    //               : Text("")
                                    //         ],
                                    //       )),
                                    // ),
                                    //   ],
                                    // )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }));
                } else {
                  return Center(
                    child: Text(
                      'No Quotations available right now, Please check again later',
                      style: TextStyle(fontSize: 12, color: Colors.black45),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    ));
  }

  Future<List<dynamic>> qttnvie(String leadtok) async {
    var a = widget.leadtok;
    // print("object");
    http.Response response = await http.get(
      Uri.parse(urlMain +
          'api/resource/Quotation?fields=["reason_for_lost_quotation","total","created_salesorder","created_customer","party_name","customer_name","name","status","grand_total","net_total","total_taxes_and_charges","mobile_number"]&filters=[["party_name","=","$a"]]&limit=100000&order_by=creation%20desc'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Tocken,
      },
    );
    // log(response.body);
    // print(response.statusCode);
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
            isCusVisible = false;
          } 
        }
      });

      // log(snapshot.data[0]["note"]);
      // print(data);
    } else {
     
    }
    return json.decode(response.body)['data'];
  }

  Future addRequirement(
    int inde,
    List a,
    String lead,
    String leadnum,
  ) async {
    setState(() {
        isCusVisible = false;
      });
    log(lea.toString());
    print(a.toString());
    log(a.toString() + "ngvvvvvvvvvvvbbbbbbbbbbbbbb");

    for (var d = 0; d < a.length; d++) {
      // log(array[d].toString() + "hggvgvgvgvghggghghgh");

      // product = array[d]["name"];
      // Qty = array[d]["quantity"];
      // Series = array[d]["color"];

      //
    }
    // print(array[d]["name"]);
    // print(d.toString() + "hbmbhmbmbmnnmnmnm");

    // for (var i = 0; i < mapList.length; i++) {
    //   name = mapList[i]["name"];
    //   series = mapList[i]["color"];
    //   series = mapList[i]["color"];
    // }

    // log(array[d]["qty"].toString() + "mnhbbcfbbbbbbbbbgvgvhbjhjkljiikk");
    var baseUrl = urlMain + 'api/resource/Customer';
    final msg = jsonEncode({
      "lead_name": lea,
      "lead": lea,
      "customer_name": widget.name,
      "customer_group": leadcatag,
      "territory": "India"
    });

    http.Response response =
        await http.post(Uri.parse(baseUrl), body: msg, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    });

    print(msg + '---rel');
    print(response.statusCode);
    print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
    if (response.statusCode == 200) {
     
      addcustomerstatus(leadnum);
      print(response.body);
      print("haaaaaaaaaaaaaaaaaaaaaaaaa");
      String data = response.body;
      // log(data);
      qttnvie(widget.leadtok);
    
      Fluttertoast.showToast(msg: "Customer Added");
      Get.to(SalesdetailView(widget.name, "", "", "", "", lea));

      // Get.to(ToolsView());

      setState(() {
        //customerameController.clear();
      });

      // CustomrcreationView(lead, lea)

      // setState(() {
      //   jsonData = json.decode(data)["data"];
      //   arealist = jsonData;
      //   for (var i = 0; i <= jsonData.length; i++) {
      //     setState(() {
      //       jsonData[i]["index"] = i;
      //     });

      //     ;
      //   }
      // });
      ;

      // log(jsonData.toString());
      // setState(() {});
    } else {
      setState(() {
        isCusVisible = true;
      });
      Fluttertoast.showToast(msg: response.reasonPhrase.toString());
    }
  }

  leadcata() async {
    print("object");
    var s = widget.leadtok;
    http.Response response = await http.get(
      Uri.parse(urlMain + "api/resource/Lead/$s"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Tocken,
      },
    );
    // log(response.body);
    // print(response.statusCode);
    if (response.statusCode == 200) {
      String data = response.body;
      setState(() {
        leadcatag = jsonDecode(data)["data"]["lead_category"];
        lea = jsonDecode(data)["data"]["name"];
        //baisicDetail = jsonDecode(data)["data"];
        // snapshot.data = jsonDecode(data)["data"]["member_details1"];
      });

      // log(snapshot.data[0]["note"]);
      //  print(data);
      // baisicDetailView2();
    } else {}
  }

  Future<void> _displayTextInputDialog(BuildContext context, String na) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Reson for lost qutation'),
            content: Container(
              height: 300,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      height: 80,
                      child: TextField(
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 17),
                          hintText: 'Type',
                          // suffixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                        ),
                        onChanged: _onChanged,
                        maxLength: 140,

                        //onChanged: (value) {},
                        controller: resoncontroller,
                        //decoration: InputDecoration.collapsed(hintText: "j"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Container(
                      width: Constants(context).scrnWidth,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 15, 46, 148),
                          // side: BorderSide(color: Colors.yellow, width: 5),
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontStyle: FontStyle.normal),
                        ),
                        child: const Text(
                          'SAVE',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontStyle: FontStyle.normal),
                        ),
                        onPressed: () {
                          reson(na);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
  // https://lamit.erpeaz.com/api/resource/Quotation/LM-QTN-2023-00257

  addcustomerstatus(String leadnum) async {
    print("object");
    log(vaaaa.toString());

    final msg = jsonEncode({"created_customer": 1});
    for (var i = 0; i < vaaaa.length; i++) {
      var s = vaaaa[i]["name"];
      http.Response response =
          await http.put(Uri.parse(urlMain + "api/resource/Quotation/$s"),
              headers: {
                'Content-type': 'application/json',
                'Accept': 'application/json',
                'Authorization': Tocken,
              },
              body: msg);

      String data = response.body;

      // log(response.body);
      // print(response.statusCode);
      log(data + "hloooooooooooooooooooooooooooooooooooooooooooooooooooooo");
      if (response.statusCode == 200) {
        String data = response.body;
        qttnvie(widget.leadtok);
        // Fluttertoast.showToast(msg: "JJHHHHHHHHHHHHHHHH");
        log(data + "hloooooooooooooooooooooooooooooooooooooooooooooooooooooo");
        // log(snapshot.data[0]["note"]);
        //  print(data);
        // baisicDetailView2();
      } else {}
    }
  }

  reson(String leadnum) async {
    print("object");
    log(leadnum.toString() + 'leeeeeeeeeeeeeee');

    final msg = jsonEncode({
      "status": "Lost",
      "reason_for_lost_quotation":
          resoncontroller.text == "" ? "" : resoncontroller.text
    });
    // for (var i = 0; i < vaaaa.length; i++) {
    // var s = vaaaa[i]["name"];
    http.Response response =
        await http.put(Uri.parse(urlMain + "api/resource/Quotation/$leadnum"),
            headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'Authorization': Tocken,
            },
            body: msg);

    String data = response.body;

    // log(response.body);
    // print(response.statusCode);
    log(data + "hloooooooooooooooooooooooooooooooooooooooooooooooooooooo");
    if (response.statusCode == 200) {
      String data = response.body;
      qttnvie(widget.leadtok);
      Fluttertoast.showToast(msg: "Saved");
      Get.back();
      log(data + "hloooooooooooooooooooooooooooooooooooooooooooooooooooooo");
      setState(() {
        resoncontroller.clear();
      });

      // log(snapshot.data[0]["note"]);
      //  print(data);
      // baisicDetailView2();
    } else {}
    //}
  }

  // Future leadcata() async {
  //   var s = widget.lead;

  //   var baseUrl = 'https://lamit.erpeaz.com/api/resource/Lead/$s';

  //   http.Response response = await http.put(Uri.parse(baseUrl), headers: {
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': Tocken,
  //   });

  //   print(response.body);
  //   print(response.statusCode);
  //   print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
  //   if (response.statusCode == 200) {
  //     print(response.body);
  //     print("haaaaaaaaaaaaaaaaaaaaaaaaa");
  //     String data = response.body;
  //     log(data);
  //     //  Fluttertoast.showToast(msg: "Customer Added");
  //     // Get.to(AddqoutationaddView(widget.leadtok))

  //     // setState(() {
  //     //   jsonData = json.decode(data)["data"];
  //     //   arealist = jsonData;
  //     //   for (var i = 0; i <= jsonData.length; i++) {
  //     //     setState(() {
  //     //       jsonData[i]["index"] = i;
  //     //     });

  //     //     ;
  //     //   }
  //     // });
  //     ;

  //     // log(jsonData.toString());
  //     // setState(() {});
  //   }
  // }

  // https://lamit.erpeaz.com/api/resource/Quotation'
}
