import 'dart:convert';
import 'dart:developer';

import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lamit/app/modules/customerdetail/views/customerdetail_view.dart';

import 'package:lamit/app/routes/constants.dart';
import 'package:lamit/tocken/config/url.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../tocken/tockn.dart';

import 'package:http/http.dart' as http;

import '../../converted-leads-view/popupitemWidget.dart';

class ToolsView extends StatefulWidget {
  const ToolsView({Key? key}) : super(key: key);

  @override
  State<ToolsView> createState() => _ToolsViewState();
}

class _ToolsViewState extends State<ToolsView> {
  var productList;
  String? name;
  String? id;
  var laclist;
  var productList3;
  var productList2;
  var customerlist;
  var cusdropdownvalue;
  var custDropDown = [];
  var mobileList = [];
  var selectedKey = 'all';
  @override
  void initState() {
    getsf();
    super.initState();
  }

  SelectedItem(BuildContext context, item) {
    switch (item) {
      case 1:
        setState(() {
          selectedKey = 'name';
          cusdropdownvalue = null;
        });
        break;
      case 2:
        setState(() {
          selectedKey = 'mobile';
          cusdropdownvalue = null;
        });

        break;
        case 3:
        setState(() {
          selectedKey = 'all';
          cusdropdownvalue = null;
        });

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[50],
          leading: IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {
                //
              }),
          title: Text(
            "CUSTOMER",
            style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 7, 38, 210),
                fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            PopupMenuButton<int>(
              position: PopupMenuPosition.under,
              itemBuilder: (context) => [
                PopupMenuItem(
                    value: 0,
                    enabled: false,
                    child: Text(
                      'Filter By',
                      style: TextStyle(fontSize: 11, color: Colors.black45),
                    )),
                const PopupMenuDivider(),
                const PopupMenuItem<int>(
                    value: 1,
                    child: PopUpMenuItemWidget(
                      icon: CupertinoIcons.person,
                      title: 'Name',
                    )),
                const PopupMenuItem<int>(
                    value: 2,
                    child: PopUpMenuItemWidget(
                      icon: CupertinoIcons.phone,
                      title: 'Mobile',
                    )),
                    const PopupMenuItem<int>(
                    value: 3,
                    child: PopUpMenuItemWidget(
                      icon: CupertinoIcons.square_list,
                      title: 'All',
                    )),
              ],
              onSelected: (item) => SelectedItem(context, item),
            ),

            // IconButton(
            //     icon: Icon(FontAwesomeIcons.chartLine),
            //     onPressed: () {
            //       //
            //     }),
          ],
        ),
        body: productList3 == null
            ? Container()
            : productList == null
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      child: Container(
                        color: Colors.grey[50],
                        height: Constants(context).scrnHeight + 700,
                        // width: Constants(context).scrnWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (selectedKey != 'all')
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Container(
                                                width: Constants(context)
                                                    .scrnWidth,
                                                height: 52,
                                                margin: EdgeInsets.all(0),
                                                decoration: BoxDecoration(
                                                  // border: Border.all(
                                                  //     color: Colors.grey, // Set border color
                                                  //     width: 1.0),
                                                  color: HexColor("#F9F9F9"),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                          // margin: EdgeInsets.all(2),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .grey[100],
                                                            //color: Colors.white,
                                                          ),
                                                          child: DropdownSearch<
                                                                  dynamic>(
                                                              showSearchBox:
                                                                  true,
                                                              popupTitle: Text(
                                                                  'Select $selectedKey'),
                                                              popupElevation: 1,
                                                              maxHeight: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  1.2,
                                                              showClearButton:
                                                                  true,
                                                              // showSelectedItems: true,
                                                              clearButtonBuilder:
                                                                  (context) {
                                                                return IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        cusdropdownvalue =
                                                                            null;
                                                                      });
                                                                    },
                                                                    icon: Icon(Icons
                                                                        .close));
                                                              },
                                                              popupShape:
                                                                  BeveledRectangleBorder(),
                                                              // popupProps: PopupProps.dialog(),
                                                              items: (selectedKey ==
                                                                      'name')
                                                                  ? custDropDown
                                                                  : mobileList,
                                                              onChanged:
                                                                  (Value) {
                                                                print(Value);
                                                                setState(() {
                                                                  if (selectedKey ==
                                                                      'name') {
                                                                    cusdropdownvalue = Value
                                                                            .toString()
                                                                        .split(
                                                                            " (")
                                                                        .first;
                                                                  } else {
                                                                    cusdropdownvalue =
                                                                        Value
                                                                            .toString();
                                                                  }
                                                                });
                                                                getlac();
                                                                setState(() {});
                                                              },
                                                              selectedItem:
                                                                  cusdropdownvalue ==
                                                                          null
                                                                      ? 'Select $selectedKey'
                                                                      : cusdropdownvalue)

                                                          // child:
                                                          //     CustomSearchableDropDown(
                                                          //         suffixIcon: Icon(
                                                          //             size: 24,
                                                          //             Icons.search),
                                                          //         primaryColor:
                                                          //             Colors.black,
                                                          //         items:
                                                          //             productList3,
                                                          //         label:
                                                          //             'Customer Search',
                                                          //         showLabelInMenu:
                                                          //             true,
                                                          //         onChanged:
                                                          //             (value) async {
                                                          //           // markedropdownvalue =
                                                          //           //     null;
                                                          //           // log(sourcelist
                                                          //           //     .toString());
                                                          //           // log(value
                                                          //           //     .toString());
                                                          //           setState(() {
                                                          //             // lshow =
                                                          //             //     "show";
                                                          //             cusdropdownvalue =
                                                          //                 null;
                                                          //             cusdropdownvalue =
                                                          //                 value["name"]
                                                          //                     .toString();
                                                          //             // cleadname =
                                                          //             //     value["name"];
                                                          //             // custarea =
                                                          //             //     value["customer_area"].toString();
                                                          //             // log(value
                                                          //             //     .toString());
                                                          //             // log(custarea.toString() +
                                                          //             //     "bnbggggbbfffff");
                                                          //             // //   lac = value["lac"]
                                                          //             //     .toString();
                                                          //             // log("hiiii+" +
                                                          //             //     leadname
                                                          //             //         .toString());
                                                          //             // log(dropdownvaluesource
                                                          //             //     .toString());
                                                          //           });
                                                          //           // log(custarea
                                                          //           //     .toString());
                                                          //           // marketing(
                                                          //           //     custarea,
                                                          //           //     cleadname);
                                                          //           getlac();
                                                          //           setState(() {});
                                                          //         },
                                                          //         dropDownMenuItems:
                                                          //             custDropDown ==
                                                          //                     []
                                                          //                 ? ['']
                                                          //                 : custDropDown),

                                                          ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            cusdropdownvalue != null
                                ? Expanded(
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              // height: Constants(context).scrnHeight + 600,
                                              // width: Constants(context).scrnWidth,
                                              child: ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount:
                                                      productList2.length,
                                                  itemBuilder:
                                                      ((context, index) {
                                                    return Card(
                                                      child: Container(
                                                          child: ListTile(
                                                        onTap: () {
                                                          Get.to(CustomerdetailView(
                                                              productList2[
                                                                      index]
                                                                  ["lead_name"],
                                                              productList2[
                                                                      index]
                                                                  ["name"],
                                                              "cust",
                                                              0));
                                                        },
                                                        title: Text(
                                                          productList2[index]
                                                                  ["name"]
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        subtitle: Text(
                                                          productList2[index]
                                                                  ["lead_name"]
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 10),
                                                        ),
                                                        trailing: Wrap(
                                                          children: [
                                                            if (productList2[
                                                                            index]
                                                                        [
                                                                        "latitude"] !=
                                                                    null ||
                                                                productList2[
                                                                            index]
                                                                        [
                                                                        "longitude"] !=
                                                                    null)
                                                              IconButton(
                                                                  onPressed:
                                                                      (() {
                                                                    MapsLauncher.launchCoordinates(
                                                                        double.parse(productList2[index]
                                                                            [
                                                                            "latitude"]),
                                                                        double.parse(productList2[index]
                                                                            [
                                                                            "longitude"]),
                                                                        '');
                                                                  }),
                                                                  icon: Icon(Icons
                                                                      .location_pin)),
                                                            if (productList2[
                                                                        index][
                                                                    "mobile"] !=
                                                                null)
                                                              IconButton(
                                                                onPressed: () {
                                                                  _makePhoneCall(
                                                                      productList2[
                                                                              index]
                                                                          [
                                                                          "mobile"]);
                                                                },
                                                                icon: Icon(
                                                                    Icons.call),
                                                                color:
                                                                    kDefaultIconDarkColor,
                                                              ),
                                                            if (productList2[
                                                                        index][
                                                                    "whats_app_no"] !=
                                                                null)
                                                              IconButton(
                                                                onPressed: () {
                                                                  launch('whatsapp://send?text=sample text&phone=' +
                                                                      productList2[
                                                                              index]
                                                                          [
                                                                          "whats_app_no"]);
                                                                },
                                                                icon: Container(
                                                                    height: 20,
                                                                    width: 20,
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/55.png',
                                                                      height:
                                                                          20,
                                                                      scale:
                                                                          2.5,
                                                                      // color: Color.fromARGB(255, 15, 147, 59),
                                                                      // opacity:
                                                                      //     const AlwaysStoppedAnimation<double>(
                                                                      //         0.5)
                                                                    )),
                                                              )
                                                          ],
                                                        ),
                                                      )),
                                                    );
                                                  })),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: ListView.builder(
                                        itemCount: productList.length,
                                        itemBuilder: ((context, index) {
                                          return Container(
                                              height: 80,
                                              child: Card(
                                                child: Container(
                                                    child: ListTile(
                                                  onTap: () {
                                                    Get.to(CustomerdetailView(
                                                        productList[index]
                                                            ["lead_name"],
                                                        productList[index]
                                                            ["name"],
                                                        "cust",
                                                        0));
                                                  },
                                                  title: Text(
                                                    productList[index]["name"]
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  subtitle: Text(
                                                    productList[index]
                                                            ["lead_name"]
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  trailing: Wrap(
                                                    children: [
                                                      if (productList[index][
                                                                  "latitude"] !=
                                                              null ||
                                                          productList[index][
                                                                  "longitude"] !=
                                                              null)
                                                        IconButton(
                                                            onPressed: (() {
                                                              MapsLauncher.launchCoordinates(
                                                                  double.parse(
                                                                      productList[
                                                                              index]
                                                                          [
                                                                          "latitude"]),
                                                                  double.parse(
                                                                      productList[
                                                                              index]
                                                                          [
                                                                          "longitude"]),
                                                                  '');
                                                            }),
                                                            icon: Icon(Icons
                                                                .location_pin)),
                                                      if (productList[index]
                                                              ["mobile"] !=
                                                          null)
                                                        IconButton(
                                                          onPressed: () {
                                                            _makePhoneCall(
                                                                productList[
                                                                        index]
                                                                    ["mobile"]);
                                                          },
                                                          icon:
                                                              Icon(Icons.call),
                                                          color:
                                                              kDefaultIconDarkColor,
                                                        ),
                                                      if (productList[index][
                                                              "whats_app_no"] !=
                                                          null)
                                                        IconButton(
                                                          onPressed: () {
                                                            launch('whatsapp://send?text=sample text&phone=' +
                                                                productList[
                                                                        index][
                                                                    "whats_app_no"]);
                                                          },
                                                          icon: Container(
                                                              height: 20,
                                                              width: 20,
                                                              child:
                                                                  Image.asset(
                                                                'assets/55.png',
                                                                height: 20,
                                                                scale: 2.5,
                                                                // color: Color.fromARGB(255, 15, 147, 59),
                                                                // opacity:
                                                                //     const AlwaysStoppedAnimation<double>(
                                                                //         0.5)
                                                              )),
                                                        )
                                                    ],
                                                  ),
                                                )),
                                              ));
                                        })),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ));
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  getsf() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString("userid");
      name = preferences.getString("name");
    });

    print(id.toString());
    print(name.toString());
    getlac();
    // newleadView(id.toString());
  }

  // newleadView(String id) async {
  //   print("object");

  //   http.Response response = await http.get(
  //     Uri.parse(
  //         'https://lamit.erpeaz.com/api/resource/Customer?fields=["name","lead_name"]&filters=[["customer_area", "in","NEDUMANGAD"]]'),
  //     headers: {
  //       'Content-type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': Tocken,
  //     },
  //   );
  //   log(response.body);
  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     String data = response.body;
  //     setState(() {
  //       //baisicDetail = jsonDecode(data)["data"];
  //       productList = jsonDecode(data)["data"];
  //     });

  //     // log(productList[0]["note"]);
  //     print(data);
  //     // baisicDetailView2();
  //   } else {}
  // }

  Future getlac() async {
    print("hiiiiiiiii");
    // https://lamit.erpeaz.com/api/resource/Customer Area?filters=[["allocated_by", "=", "1232435456"]] & limit=100

    var baseUrl = urlMain +
        'api/resource/Assign Sale Area?filters=[["sales_officer", "=", "$id"]] & limit=100';

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
      //  var jsonData;
      setState(() {
        // jsonData = json.decode(data)["data"];
        // laclist = jsonData;
        laclist = jsonDecode(data)["data"];
      });
      leadview(laclist);
      leadview2(laclist);
      custview(laclist);
      //  listLedgers((jsonDecode(data)["data"]));
      // log(jsonData.toString());
      // setState(() {});
    }
  }

  leadview(var lac) async {
    print("hbbbbbbbbbbbbbbbbbbb" + lac.toString());
    //print(skey);

    var l = [];
    // List<String> customerList = ["KANHANGAD", "MANJESHWAR"];

    var i;
    var la = [];
    for (i = 0; i < lac.length; i++) {
      l.add({"name": lac[i]["name"]});
      la.add(l[i]["name"]);
    }
    List<String> e = [
      "",
      "",
    ];
    // e = la;
    log(la.toString() +
        "gfdghfgfcgghghggjhjhjjjjhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
    log(l.toString() + "nbnbbbbbbbbnbbnnbbbnbnbnnbbnbnbnbnnbnbnbnb");
    print(l.toString() + "b bnbnbbnbnnm");

    for (var i = 0; i < l.length; i++) {
      var c = l[i]["name"];
      e.add("$c,$c");
    }
    log(e.toString() +
        "bvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvc");
    // = l.toString();

    http.Response response = await http.get(
        Uri.parse(urlMain +
            'api/resource/Customer?fields=["name","lead_name","mobile","whats_app_no","latitude","longitude"]&filters=[["customer_area", "in","$e"]]&limit=100000&order_by=creation%20desc'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': Tocken,
        });
    String data = response.body;

    log(data);
    setState(() {
      productList = jsonDecode(data)["data"];
    });
    // for (var i = 0; i < productList.length; i++) {
    // //  ledgers.add({'name': productList[i]['data'], 'id': i});
    //   searchResults.add({
    //     "name": productList[i]['first_name'],
    //   });
    // }
    //items.addAll(searchResults);

    // print(leadArray);

    // print("laedarray" + leadArray);

    return null;
  }

  leadview2(var lac) async {
    print("hbbbbbbbbbbbbbbbbbbb" + lac.toString());
    //print(skey);

    var l = [];
    // List<String> customerList = ["KANHANGAD", "MANJESHWAR"];

    var i;
    var la = [];
    for (i = 0; i < lac.length; i++) {
      l.add({"name": lac[i]["name"]});
      la.add(l[i]["name"]);
    }
    List<String> e = [
      "",
      "",
    ];
    // e = la;
    log(la.toString() +
        "gfdghfgfcgghghggjhjhjjjjhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
    log(l.toString() + "nbnbbbbbbbbnbbnnbbbnbnbnnbbnbnbnbnnbnbnbnb");
    print(l.toString() + "b bnbnbbnbnnm");

    for (var i = 0; i < l.length; i++) {
      var c = l[i]["name"];
      e.add("$c,$c");
    }
    log(e.toString() +
        "bvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvc");
    // = l.toString();
    var s = cusdropdownvalue;
    var api;
    if (selectedKey == 'name') {
      api = 'api/resource/Customer?fields=["name","lead_name","mobile","whats_app_no","latitude","longitude"]&filters=[["customer_area", "in","$e"],["name","=","$s"]]&limit=1000000';
    }
    else{
api = 'api/resource/Customer?fields=["name","lead_name","mobile","whats_app_no","latitude","longitude"]&filters=[["customer_area", "in","$e"],["mobile","=","$s"]]&limit=1000000';
    }
    
    http.Response response = await http.get(
        Uri.parse(urlMain +
            api),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': Tocken,
        });
    String data = response.body;

    log(data.toString());
    setState(() {
      productList2 = jsonDecode(data)["data"];
    });
    print(productList2 + 'leed');
    // for (var i = 0; i < productList.length; i++) {
    // //  ledgers.add({'name': productList[i]['data'], 'id': i});
    //   searchResults.add({
    //     "name": productList[i]['first_name'],
    //   });
    // }
    //items.addAll(searchResults);

    // print(leadArray);

    // print("laedarray" + leadArray);

    return null;
  }

  custview(var lac) async {
    log("hbbb" + lac.toString());
    //print(skey);

    var l = [];
    // List<String> customerList = ["KANHANGAD", "MANJESHWAR"];

    var i;
    var la = [];
    for (i = 0; i < lac.length; i++) {
      l.add({"name": lac[i]["name"]});
      la.add(l[i]["name"]);
    }
    List<String> e = [
      "",
      "",
    ];
    // e = la;
    log(la.toString() +
        "gfdghfgfcgghghggjhjhjjjjhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
    log(l.toString() + "nbnbbbbbbbbnbbnnbbbnbnbnnbbnbnbnbnnbnbnbnb");
    print(l.toString() + "b bnbnbbnbnnm");

    for (var i = 0; i < l.length; i++) {
      var c = l[i]["name"];
      e.add("$c,$c");
    }
    log(e.toString() +
        "bvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvc");
    // = l.toString();

    http.Response response = await http.get(
        Uri.parse(urlMain +
            'api/resource/Customer?fields=["name","lead_name","mobile","whats_app_no","latitude","longitude"]&filters=[["customer_area", "in","$e"]]&limit=100000&order_by=creation%20desc'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': Tocken,
        });
    String data = response.body;
    log("hiiiiiiiiiiiiiiiiiiiiiii");

    log(data + "nvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv");
    setState(() {
      productList3 = jsonDecode(data)["data"];
      if (custDropDown.length < 1) {
        for (var i = 0; i < productList3.length; i++) {
          var name = productList3[i]['name'];
          var mobile = productList3[i]['mobile'];
          custDropDown.add('$name ($mobile)');
        }
      }
      if (mobileList.length < 1) {
        for (var i = 0; i < productList3.length; i++) {
          mobileList.add(productList3[i]['mobile']);
        }
      }
    });
    // for (var i = 0; i < productList.length; i++) {
    // //  ledgers.add({'name': productList[i]['data'], 'id': i});
    //   searchResults.add({
    //     "name": productList[i]['first_name'],
    //   });
    // }
    //items.addAll(searchResults);

    // print(leadArray);

    // print("laedarray" + leadArray);

    return null;
  }
}
