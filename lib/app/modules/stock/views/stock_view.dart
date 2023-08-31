import 'dart:convert';
import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:lamit/tocken/config/url.dart';

import '../../../../tocken/tockn.dart';
import '../../../routes/constants.dart';

class StockView extends StatefulWidget {
  @override
  State<StockView> createState() => _StockViewState();
}

class _StockViewState extends State<StockView> {
  var jsonData = [];
  var jdata = [];
  var jsonDat = [];
  TextEditingController textEditingController = new TextEditingController();
  var arealis = [];
  int? dropdownvalueArea;
  var arealist;
  String? name;
  String? productseries;
  @override
  void initState() {
    getAllArea();
    log(name.toString());
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 5),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey.shade300)),
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
                              'Product',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            )
                          : Text(
                              name.toString(),
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                    ),
                    items: jsonData
                        .map((item) => DropdownMenuItem<String>(
                              value: item["index"].toString(),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
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
                        name = jsonData[int.parse(value.toString())]["name"];
                        filterproduct(name.toString());
                        log(name.toString());
                        productseries = jsonData[int.parse(value.toString())]
                            ["product_series"];
                      });
                    },
                    buttonHeight: 20,
                    buttonWidth: Constants(context).scrnWidth,
                    itemHeight: 60,
                    dropdownMaxHeight: 400,
                    searchInnerWidgetHeight: 20,
                    searchController: textEditingController,
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
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          hintText: 'Search for an item...',
                          hintStyle: const TextStyle(fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    searchMatchFn: (item, searchValue) {
                      return (jsonData[int.parse(item.value.toString())]["name"]
                          .toString()
                          .toLowerCase()
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

        // Row(
        //   children: [
        //     Expanded(
        //       flex: 2,
        //       child: Container(
        //         child: Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Container(
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Container(
        //                   height: 50,
        //                   margin: EdgeInsets.all(5),
        //                   decoration: BoxDecoration(
        //                     // border: Border.all(
        //                     //     color: Colors.blue, // Set border color
        //                     //     width: 1.0),
        //                     color: Colors.grey[100],
        //                     // borderRadius:
        //                     //     BorderRadius.circular(20)
        //                   ),
        //                   child: Padding(
        //                     padding: const EdgeInsets.all(8.0),
        //                     child: Row(
        //                       children: [
        //                         DropdownButton(
        //                           icon: Icon(Icons.arrow_drop_down),
        //                           underline: Container(),
        //                           // itemHeight: 60,
        //                           hint: Row(
        //                             children: [
        //                               Text('Product       '),
        //                               SizedBox(
        //                                 width:
        //                                     MediaQuery.of(context).size.width *
        //                                         0.50,
        //                               )
        //                             ],
        //                           ),
        //                           items: jsonData.map((item) {
        //                             // setState(() {
        //                             //   i = item;
        //                             // });
        //                             print(item.toString());
        //                             return DropdownMenuItem(
        //                               value: item["index"],
        //                               child: Row(
        //                                 children: [
        //                                   Text(item["name"].toString()),
        //                                 ],
        //                               ),
        //                             );
        //                           }).toList(),
        //                           onChanged: (newVal) {
        //                             setState(() {
        //                               dropdownvalueArea =
        //                                   int.parse(newVal.toString());

        //                               print(newVal.toString());
        //                               print(newVal.toString());
        //                               setState(() {
        //                                 name = jsonData[
        //                                         int.parse(newVal.toString())]
        //                                     ["name"];
        //                                 productseries = jsonData[
        //                                         int.parse(newVal.toString())]
        //                                     ["product_series"];
        //                               });
        //                               // var i;
        //                               // var a;
        //                               // for (i = 0;
        //                               //     i <= arealist.length;
        //                               //     i++) {
        //                               //   a = arealist;
        //                               // }
        //                               // print(a);

        //                               // filterproduct(
        //                               //     dropdownvalueArea.toString());
        //                             });
        //                             filterproduct(name.toString());
        //                           },
        //                           value: dropdownvalueArea,
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),

        Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Container(
            decoration: BoxDecoration(color: Colors.grey[50]),
            child: Container(
              // decoration: BoxDecoration(color: Colors.grey[50]),
              child: ListView.builder(
                itemCount: jsonDat.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      leading: Container(
                        padding: EdgeInsets.only(right: 12.0),
                        decoration: new BoxDecoration(
                            border: new Border(
                                right: new BorderSide(
                                    width: 1.0, color: Colors.black))),
                        child: Icon(Icons.shopping_cart_checkout,
                            color: Colors.black),
                      ),
                      title: Text(
                        jsonDat[index]["warehouse"] == ""
                            ? ""
                            : jsonDat[index]["warehouse"],
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                      subtitle: Row(
                        children: <Widget>[
                          Text(
                              jsonDat[index]["actual_qty"].toString() == ""
                                  ? ""
                                  : jsonDat[index]["actual_qty"].toString(),
                              style: TextStyle(color: Colors.black))
                        ],
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right,
                          color: Colors.white, size: 30.0));
                }),
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Future getAllArea() async {
    print("hiiiiiiiii");
    var baseUrl = urlMain +
        'api/resource/Item?limit=1000&filters=[["has_variants", "=", "0"]] &fields=["name","product_series"]';

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

  filterproduct(String nam) async {
    print("hiiiiiiiii");
    log(nam.toString());
    // jsonDat.clear();
    // arealis.clear();
    var a = productseries.toString();
    var baseUrl = urlMain +
        'api/resource/Bin?fields=["warehouse","actual_qty","item_code"]&filters=[["item_code", "=", "$nam"]]&limit=100000';

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
      // var jsonData;
      setState(() {
        jsonDat = json.decode(data)["data"];
        arealis = jsonDat;
      });

      // log(jsonData.toString());
      // setState(() {});
    }
  }
  // // https://lamit.erpeaz.com/api/resource/Item?fields=["product_series"]
}
