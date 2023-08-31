import 'dart:convert';
import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:http/http.dart' as http;
import 'package:lamit/app/modules/home/views/home_view.dart';

import 'package:lamit/app/modules/salesdetail/views/salesdetail_view.dart';
import 'package:lamit/app/routes/constants.dart';
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/widget/customeappbar.dart';

import '../../../../tocken/tockn.dart';

class EditRequirement extends StatefulWidget {
  final String? leadtock;
  final String? name;
  final String product;
  final String qty;
  final String series;
  final String id;

  const EditRequirement(
      this.leadtock, this.name, this.product, this.qty, this.series, this.id);

  @override
  State<EditRequirement> createState() => _EditRequirementState();
}

class _EditRequirementState extends State<EditRequirement> {
  var distlist = [];
  var arealist = [];
  var jsonData = [];
  TextEditingController textEditingController = TextEditingController();
  String nos = "";
  String box = "";
  String? name;
  String? image;
  //var i;
  String? productseries;
  List<Map<String, dynamic>> mapList = [];
  List<Map<String, dynamic>> finalList = [];
  TextEditingController qtycontroller = TextEditingController();

  int? dropdownvalueArea;
  String? dropdownvalueselectne;

  @override
  Future getAllArea() async {
    print("hiiiiiiiii");
    var baseUrl = urlMain +
        'api/resource/Item?limit=1000&filters=[["has_variants", "=", "0"]] &fields=["name","product_series","image"]';

    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    });
    print(response.body);
    print(response.statusCode);
    print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
    if (response.statusCode == 200) {
      print(response.body);
      print("haaaaaaaaaaaaaaaaaaaaaaaaa");
      String data = response.body;

      setState(() {
        jsonData = json.decode(data)["data"];
        arealist = jsonData;
        for (var i = 0; i <= jsonData.length; i++) {
          setState(() {
            jsonData[i]["index"] = i;
          });

          ;
        }
      });
      ;

      // log(jsonData.toString());
      // setState(() {});
    }
  }

  Future filterproduct(String productseries) async {
    print("hiiiiiiiii");
    var a = productseries.toString();
    var baseUrl =
        urlMain + 'api/resource/Item?fields=["name","product_series","image"]';

    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    });
    print(response.body);
    print(response.statusCode);
    print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
    if (response.statusCode == 200) {
      print(response.body);
      print("haaaaaaaaaaaaaaaaaaaaaaaaa");
      String data = response.body;
      var jsonData;
      setState(() {
        jsonData = json.decode(data)["data"];
        arealist = jsonData;
      });

      // log(jsonData.toString());
      // setState(() {});
    }
  }
  // https://lamit.erpeaz.com/api/resource/Item?fields=["product_series"]

  @override
  void initState() {
    print(widget.qty);
    qtycontroller.text = widget.qty.toString();
    productseries = widget.series;
    name = widget.product;
    getAllArea();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F9F9F9"),
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight),
        child: CustomAppBar(
          title: 'UPDATE REQUIREMENT',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Container(
          height: Constants(context).scrnHeight,
          //color: Colors.blue[50],
          color: HexColor("#F9F9F9"),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: Column(
              //  mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            color: Colors.grey[100],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: name == null
                                          ? Text(
                                              widget.product,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color:
                                                    Theme.of(context).hintColor,
                                              ),
                                            )
                                          : Text(
                                              name.toString(),
                                              style: TextStyle(
                                                fontSize: 14,
                                                color:
                                                    Theme.of(context).hintColor,
                                              ),
                                            ),
                                    ),

                                    items: jsonData
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item["index"].toString(),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  item == null
                                                      ? item.toString()
                                                      : item["name"].toString(),
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    value: dropdownvalueArea,
                                    onChanged: (value) {
                                      setState(() {
                                        // dropdownvalueArea = jsonData[
                                        //         int.parse(value.toString())]
                                        //     ["name"];
                                        // log(dropdownvalueArea.toString() +
                                        //     "gggggggggggggg");
                                        name = jsonData[
                                                int.parse(value.toString())]
                                            ["name"];
                                        print(name.toString() + 'lololo');
                                        productseries = jsonData[
                                                int.parse(value.toString())]
                                            ["product_series"];
                                        image = jsonData[
                                                int.parse(value.toString())]
                                            ["image"];
                                        filterproduct(name.toString());
                                      });
                                    },
                                    buttonHeight: 40,
                                    buttonWidth: Constants(context).scrnWidth,
                                    itemHeight: 60,
                                    dropdownMaxHeight: 400,
                                    searchController: textEditingController,
                                    searchInnerWidgetHeight: 20,
                                    searchInnerWidget: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 8,
                                        bottom: 4,
                                        right: 8,
                                        left: 8,
                                      ),
                                      child: TextFormField(
                                        controller: textEditingController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 8,
                                          ),
                                          hintText: 'Search for an item...',
                                          hintStyle:
                                              const TextStyle(fontSize: 12),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                    searchMatchFn: (item, searchValue) {
                                      //   log(dropdownvalueArea.toString());

                                      var b;
                                      // for (var i = 0;
                                      //     i < jsonData.length;
                                      //     i++) {
                                      //   b.add({"index": i});
                                      //}
                                      log(jsonData[int.parse(
                                                  item.value.toString())]
                                              ["name".toString()]
                                          .toString());
                                      return (jsonData[int.parse(
                                                  item.value.toString())]
                                              ["name".toString()]
                                          .toString()
                                          .toLowerCase()
                                          .toString()
                                          .contains(searchValue));
                                    },
                                    //This to clear the search value when you close the menu
                                    onMenuStateChange: (isOpen) {
                                      if (!isOpen) {
                                        textEditingController.clear();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 50,
                                            margin: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              // border: Border.all(
                                              //     color: Colors.blue, // Set border color
                                              //     width: 1.0),
                                              color: Colors.grey[50],
                                              //    borderRadius: BorderRadius.circular(20)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: TextField(
                                                  controller: qtycontroller,
                                                  // controller: ledgernameController,
                                                  textAlign: TextAlign.left,
                                                  keyboardType:
                                                      TextInputType.name,
                                                  decoration: InputDecoration(
                                                    hintText: "Qty",
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // Expanded(
                            //   child: Container(
                            //       // child: Center(
                            //       // child:
                            //       ),
                            // ),

                            Expanded(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 00),
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                "",
                                                style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize: 14,
                                                  // fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              height: 50,
                                              width: 200,
                                              // margin: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  // border: Border.all(
                                                  //     color: Colors.blue, // Set border color
                                                  //     width: 1.0),
                                                  //    color: Colors.grey[50],
                                                  //    borderRadius: BorderRadius.circular(20)
                                                  ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.only(),
                                                child: Align(
                                                  //alignment: Alignment.centerLeft,
                                                  child: Row(
                                                    children: [
                                                      // SizedBox(
                                                      //   height: 10,
                                                      // ),
                                                      //Icon(Icons.add_rounded),

                                                      productseries == null
                                                          ? Container()
                                                          : Expanded(
                                                              child: Container(
                                                                child: Card(
                                                                    child: Container(
                                                                        height: 70,
                                                                        //  width: 150,
                                                                        color: Colors.white,
                                                                        child: Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(productseries.toString()),
                                                                        ))),
                                                              ),
                                                            )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            // Icon(
                            //   Icons.person_add,
                            //   color: Colors.black,
                            //   size: 17,
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // SizedBox(
                              //   height: 30,
                              // ),
                              Container(
                                height: 40,
                                width: Constants(context).scrnWidth,
                                child: ElevatedButton(
                                  child: Text('UPDATE PRODUCT ',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontStyle: FontStyle.normal)),
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 5, 70, 123),
                                    // side: BorderSide(color: Colors.yellow, width: 5),
                                    textStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 167, 164, 164),
                                        fontSize: 18,
                                        fontStyle: FontStyle.normal),
                                  ),
                                  onPressed: () {
                                    if (dropdownvalueArea == "") {
                                      Fluttertoast.showToast(
                                          msg: "Select Product");
                                    } else if (qtycontroller.text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: "Enter Quantity");
                                    } else {
                                      setState(() {
                                        var i;
                                        mapList.add({
                                          "name": name == null
                                              ? ""
                                              : name.toString(),
                                          "qty": qtycontroller == ""
                                              ? ""
                                              : qtycontroller.text.toString(),
                                          "color": productseries.toString(),
                                        });
                                      });
                                      addRequirement(
                                          // for
                                          0,
                                          mapList,
                                          widget.leadtock.toString());
                                      log(mapList.toString() + "enyhaaaavana");

                                      qtycontroller.clear();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }

  addRequirement(
    int inde,
    List a,
    String lead,
  ) async {
    print(widget.id + 'mlmlml');
    log(a.toString() + "ngvvvvvvvvvvvbbbbbbbbbbbbbb");
    var productc = [];
    var array = [];
    String? product;
    String? Series;
    String? Qty;
    for (var d = 0; d < a.length; d++) {
      log(a[d].toString() + "hggvgvgvgvghggghghgh");
      array.add({
        "name": a[d]["name"] == null ? "" : a[d]["name"],
        'quantity': a[d]["qty"] == null ? "" : a[d]["qty"],
        "color": a[d]["color"] == null ? "" : a[d]["color"],
        "index": d,
      });

      log(array[d].toString() + "hggvgvgvgvghggghghgh");

      product = array[d]["name"];
      Qty = array[d]["quantity"];
      Series = array[d]["color"];

      //
    }
    // print(array[d]["name"]);
    // print(d.toString() + "hbmbhmbmbmnnmnmnm");
    productc.toString();
    log(product.toString());
    // log(array[d]["qty"].toString() + "mnhbbcfbbbbbbbbbgvgvhbjhjkljiikk");
    var baseUrl = urlMain + 'api/resource/UpdateTable';
    final msg = jsonEncode({
      "row_id1": widget.id,
      "doc_type": "Lead",
      "reference_doc": lead,
      "table_name": "customer_requirements",
      "product": product.toString(),
      "color": Series.toString(),
      "quantity": Qty.toString(),
      "uom": "Nos",
      "image":
          image == null || image == "" ? '/files/blank.png' : image.toString()
    });
    log(msg + 'editedddddddddd');
    http.Response response =
        await http.post(Uri.parse(baseUrl), body: msg, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    });

    print(response.body);
    print(response.statusCode);
    print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
    if (response.statusCode == 200) {
      // mapList.clear();
      print(response.body);
      print("haaarespons3ebody");
      String data = response.body;
      Get.to(SalesdetailView(widget.name, "req", "", "", "", widget.leadtock))

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
    }
  }
}
