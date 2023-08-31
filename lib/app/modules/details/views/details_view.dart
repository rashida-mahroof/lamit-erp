import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:lamit/app/modules/leadadd/views/leadadd_view.dart';
import 'package:lamit/app/routes/constants.dart';
import 'package:lamit/globals.dart';
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/tocken/tockn.dart';
import 'package:lamit/globals.dart' as globals;

class DetailsView extends StatefulWidget {
  final String? address;

  const DetailsView(this.address);

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  var productlist;

  @override
  void initState() {
    detailView();

    super.initState();
  }

  var selectedStatus;
  var selectedStage;
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('DetailsView'),
      //   centerTitle: true,
      // ),
      body: productlist == null
          ? Container()
          : Container(
              // height: MediaQuery.of(context).size.height / 1.8,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'DETAIL',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),

                        // Expanded(child: Container()),
                        Padding(
                          padding: const EdgeInsets.only(right: 0),
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.green,
                                      ),
                                      onPressed: () {
                                        Get.to(LeadaddView(
                                            productlist["name"] == ""
                                                ? ""
                                                : productlist["name"],
                                            "isdetail",
                                            productlist["first_name"] == ""
                                                ? ""
                                                : productlist["first_name"],
                                            productlist["last_name"] == ""
                                                ? ""
                                                : productlist["last_name"],
                                            productlist["mobile_no"] == null
                                                ? ""
                                                : productlist["mobile_no"] ==
                                                        "----select----"
                                                    ? ""
                                                    : productlist["mobile_no"],
                                            productlist["whatsapp_no"] == null
                                                ? ""
                                                : productlist["whatsapp_no"] ==
                                                        "----select----"
                                                    ? ""
                                                    : productlist[
                                                        "whatsapp_no"],
                                            productlist["districts"] == null
                                                ? ""
                                                : productlist["districts"] ==
                                                        "----Select----"
                                                    ? ""
                                                    : productlist["districts"],
                                            productlist["lead_category"] == null
                                                ? ""
                                                : productlist[
                                                            "lead_category"] ==
                                                        "----Select----"
                                                    ? ""
                                                    : productlist[
                                                        "lead_category"],
                                            productlist["lac"] == null
                                                ? ""
                                                : productlist["lac"] ==
                                                        "----Select----"
                                                    ? ""
                                                    : productlist["lac"],
                                            productlist["referenced_by"] == null
                                                ? ""
                                                : productlist[
                                                            "referenced_by"] ==
                                                        "----Select----"
                                                    ? ""
                                                    : productlist[
                                                        "referenced_by"],
                                            productlist["gender"] == null
                                                ? ""
                                                : productlist["gender"],
                                            productlist["expected_time_to_purchas"] ==
                                                    null
                                                ? ""
                                                : productlist[
                                                    "expected_time_to_purchas"],
                                            productlist["source"] == null
                                                ? ""
                                                : productlist["source"],
                                            productlist["email_id"] == null
                                                ? ""
                                                : productlist["email_id"],
                                            productlist["source"] == "CUSTOMER"
                                                ? productlist["customer1"] ==
                                                        null
                                                    ? ""
                                                    : productlist["customer1"]
                                                : productlist["source"] ==
                                                        "EMPLOYEE"
                                                    ? productlist[
                                                                "employee1"] ==
                                                            null
                                                        ? ""
                                                        : productlist[
                                                            "employee1"]
                                                    : productlist["source"] ==
                                                            "SHOPS"
                                                        ? productlist[
                                                                    "shop1"] ==
                                                                null
                                                            ? ""
                                                            : productlist[
                                                                "shop1"]
                                                        : productlist[
                                                                    "source"] ==
                                                                "ENGINEER / ARCHITECTS"
                                                            ? productlist[
                                                                        "engineer1"] ==
                                                                    null
                                                                    : productlist[
                                                                    "source"] ==
                                                                "CONTRACTORS / TRUSS WORKERS"
                                                            ? productlist[
                                                                        "contractor"] ==
                                                                    null
                                                                ? ""
                                                                : productlist[
                                                                    "contractor"] :
                                                                     productlist[
                                                                    "source"] ==
                                                                "DEALER" ? productlist[
                                                                        "dealer"] : productlist[
                                                                    "source"] ==
                                                                "SUB DEALER" ? productlist[
                                                                        "sub_dealer"] 
                                                            : "",
                                            productlist["locations"] == null
                                                ? ""
                                                : productlist["locations"],
                                                productlist["stage"] ?? ''));
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            if (productlist["lead_category"] == 'Engineer' &&
                                productlist["created_engineer"] == 0)
                              OutlinedButton(
                                  onPressed: () {
                                    putData(productlist["name"], 1);
                                  },
                                  child: Text(
                                    'Convert to Engineer',
                                    style:
                                        TextStyle(color: Colors.blue.shade900),
                                  )),
                            if (productlist["lead_category"] == 'Contractor' &&
                                productlist["created_contractor"] == 0)
                              OutlinedButton(
                                  onPressed: () {
                                    putData(productlist["name"], 2);
                                  },
                                  child: Text('Convert to Conractor',
                                      style: TextStyle(
                                          color: Colors.blue.shade900))),
                            if (productlist["lead_category"] == 'Shop' &&
                                productlist["created_shop1"] == 0)
                              OutlinedButton(
                                  onPressed: () {
                                    putData(productlist["name"], 3);
                                  },
                                  child: Text('Convert to Shop',
                                      style: TextStyle(
                                          color: Colors.blue.shade900)))
                          ],
                        ),
                      ],
                    ),
                    // if (productlist["status"] == 'Lead' ||
                    //     productlist["status"] == 'Do Not Contact' ||
                    //     productlist["status"] == 'Lost' ||
                    //     productlist["status"] == 'Hot' ||
                    //     productlist["status"] == 'Warm' ||
                    //     productlist["status"] == 'Cold')
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: ((context) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return AlertDialog(
                                          title: Text('change status'),
                                          content: Wrap(
                                            children: [
                                              for (int i = 0;
                                                  i < globals.statusList.length;
                                                  i++)
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      right: 5.0),
                                                  child: OutlinedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          primary: (selectedStatus
                                                                      .toString() ==
                                                                  globals.statusList[i]
                                                                      .toString())
                                                              ? Colors
                                                                  .purple.shade900
                                                              : Colors
                                                                  .grey.shade400,
                                                          foregroundColor:
                                                              Colors.white),
                                                      onPressed: () {
                                                        // setState(() {
                                                        selectedStatus =
                                                            globals.statusList[i];

                                                        // });
                                                        setState(() {});
                                                        print(selectedStatus);
                                                      },
                                                      child: Text(
                                                        globals.statusList[i],
                                                        style: TextStyle(),
                                                      )),
                                                )
                                            ],
                                          ),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.red[200]),
                                                child: Text('Close')),
                                            ElevatedButton(
                                                onPressed: () {
                                                  changeStatus(productlist["name"],
                                                      selectedStatus);
                                                     
                                                  
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Submit'))
                                          ],
                                        );
                                      });
                                    }));
                              },
                              child: Text("change status")),
                        
                          OutlinedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: ((context) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return AlertDialog(
                                          title: Text('change stage'),
                                          content: Wrap(
                                            children: [
                                              
                                              for (int i = 0;
                                                  i < globals.stageList.length;
                                                  i++)
                                                  
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      right: 5.0),
                                                  child: OutlinedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          backgroundColor: (selectedStage
                                                                       ==
                                                                  globals.stageList[i]
                                                                      )
                                                              ? Colors
                                                                  .purple.shade900
                                                              : Colors
                                                                  .grey.shade400,
                                                          foregroundColor:
                                                              Colors.white),
                                                      onPressed: () {
                                                        // setState(() {
                                                        selectedStage =
                                                            globals.stageList[i];

                                                        // });
                                                        setState(() {});
                                                        print(selectedStage);
                                                      },
                                                      child: Text(
                                                        globals.stageList[i],
                                                        style: TextStyle(),
                                                      )),
                                                )
                                            ],
                                          ),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.red[200]),
                                                child: Text('Close')),
                                            ElevatedButton(
                                                onPressed: () {
                                                  changeStage(productlist["name"],
                                                      selectedStage);
                                                     
                                                  
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Submit'))
                                          ],
                                        );
                                      });
                                    }));
                              },
                              child: Text("change Stage")),
                        
                        ],
                      ),
                    
                    Container(
                       height: MediaQuery.of(context).size.height/2,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("First name"),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Last name"),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Mobile Number"),
                                        ),
                                      ),
                            
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Whatsapp Number"),
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Email"),
                                        ),
                                      ),
                                      // Container(
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.all(8.0),
                                      //     child: Text("Email"),
                                      //
                                      // ),
                                      //  ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("District"),
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Catagory"),
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Customer Area"),
                                        ),
                                      ),
                            
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Gender"),
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Status"),
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Expected Purchase"),
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Source"),
                                        ),
                                      ),
                            
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Source Name"),
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Location"),
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Stage"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Container(
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.all(8.0),
                                      //     child: Text(":"),
                                      //   ),
                                      // ),
                                      // Container(
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.all(8.0),
                                      //     child: Text(":"),
                                      //   ),
                                      // ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(":"),
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(":"),
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(":"),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(":"),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(":"),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(":"),
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(":"),
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(":"),
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(":"),
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(":"),
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(":"),
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(":"),
                                        ),
                                      ),
                                      
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(":"),
                                        ),
                                      ),
                            
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(":"),
                                        ),
                                      ),
                                                                          Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(":"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      //first_name
                                      //   "" district"
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(productlist["first_name"] ==
                                                  "null"
                                              ? ""
                                              : productlist["first_name"] == null
                                                  ? ""
                                                  : productlist["first_name"] ==
                                                          "----select----"
                                                      ? ""
                                                      : productlist["first_name"]
                                                          .toString()),
                                        ),
                                      ),
                            
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              productlist["last_name"] == null
                                                  ? ""
                                                  : productlist["last_name"] ==
                                                          "----select----"
                                                      ? ""
                                                      : productlist["last_name"]),
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              productlist["mobile_no"] == null
                                                  ? ""
                                                  : productlist["mobile_no"] ==
                                                          "----select----"
                                                      ? ""
                                                      : productlist["mobile_no"]
                                                          .toString()),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            productlist["whatsapp_no"] == null
                                                ? ""
                                                : productlist["whatsapp_no"] ==
                                                        "----select----"
                                                    ? ""
                                                    : productlist["whatsapp_no"]
                                                        .toString()),
                                      ),
                            
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Text(productlist[
                                                          "email_id"] ==
                                                      null
                                                  ? ""
                                                  : productlist["email_id"] ==
                                                          "----select----"
                                                      ? ""
                                                      : productlist["email_id"]),
                                            ),
                                          ),
                                        ),
                                      ),
                            
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              productlist["districts"] == null
                                                  ? ""
                                                  : productlist["ldistricts"] ==
                                                          "----Select----"
                                                      ? ""
                                                      : productlist["districts"]),
                                        ),
                                      ),
                            
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(productlist[
                                                      "lead_category"] ==
                                                  null
                                              ? ""
                                              : productlist["lead_category"] ==
                                                      "----Select----"
                                                  ? ""
                                                  : productlist["lead_category"]),
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(productlist["lac"] == null
                                              ? ""
                                              : productlist["lac"] ==
                                                      "----Select----"
                                                  ? ""
                                                  : productlist["lac"]),
                                        ),
                                      ),
                            
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              productlist["gender"] == null
                                                  ? ""
                                                  : productlist["gender"]),
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(productlist[
                                                      "status"] ==
                                                  null
                                              ? ""
                                              : productlist[
                                                  "status"]),
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(productlist[
                                                      "expected_time_to_purchas"] ==
                                                  null
                                              ? ""
                                              : productlist[
                                                  "expected_time_to_purchas"]),
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              productlist["source"] == null
                                                  ? ""
                                                  : productlist["source"]),
                                        ),
                                      ),
                            
                                      productlist["source"] == "CUSTOMER"
                                          ? Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(productlist[
                                                            "customer1"] ==
                                                        null
                                                    ? ""
                                                    : productlist["customer1"]),
                                              ),
                                            )
                                          : productlist["source"] == "EMPLOYEE"
                                              ? Container(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: Text(productlist[
                                                                "employee1"] ==
                                                            null
                                                        ? ""
                                                        : productlist[
                                                            "employee1"]),
                                                  ),
                                                )
                                                :productlist["source"] == "CONTRACTORS / TRUSS WORKERS"
                                              ? Container(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: Text(productlist[
                                                                "contractor"] ==
                                                            null
                                                        ? ""
                                                        : productlist[
                                                            "contractor"]),
                                                  ),
                                                )
                                              : productlist["source"] == "SHOPS"
                                                  ? Container(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                8.0),
                                                        child: Text(productlist[
                                                                    "shop1"] ==
                                                                null
                                                            ? ""
                                                            : productlist[
                                                                "shop1"]),
                                                      ),
                                                    )
                                                  : productlist["source"] ==
                                                              "ENGINEER / ARCHITECTS" ||
                                                          productlist["source"] ==
                                                              "SHOPS" ||
                                                          productlist["source"] ==
                                                              "CUSTOMER" ||
                                                          productlist["source"] ==
                                                              "EMPLOYEE"
                                                      ? Container(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(productlist[
                                                                        "engineer1"] ==
                                                                    null
                                                                ? ""
                                                                : productlist[
                                                                    "engineer1"]),
                                                          ),
                                                        ):(productlist["source"] ==
                                                              "DEALER") ?  Container(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(productlist[
                                                                        "dealer"] ==
                                                                    null
                                                                ? ""
                                                                : productlist[
                                                                    "dealer"]),
                                                          ),
                                                        ):(productlist["source"] ==
                                                              "SUB DEALER") ?  Container(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(productlist[
                                                                        "sub_dealer"] ==
                                                                    null
                                                                ? ""
                                                                : productlist[
                                                                    "sub_dealer"]),
                                                          ),
                                                        )
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            child: Text(""),
                                                          ),
                                                        ),
                                      // if (productlist["locations"] != null ||
                                      // productlist["locations" != ""])
                                      // if(productlist["locations"] =
                                      //                 Null ||
                                      //             productlist["locations" == ""])
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text((productlist["locations"] ==
                                                      null ||
                                                  productlist["locations"] == "")
                                              ? ""
                                              : productlist["locations"]
                                                  .toString()),
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text((productlist["stage"] ==
                                                      null ||
                                                  productlist["stage"] == "")
                                              ? ""
                                              : productlist["stage"]
                                                  .toString()),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                            
                                //  Expanded(child: Container()),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  
                  ],
                ),
              ),
            ),
    );
  }

  void changeStatus(id, status) async {
    print('$id::::::$status');
    String api = 'api/resource/Lead/$id';
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    };
    var msg = jsonEncode({"status": status});
    print(msg);
    http.Response response = await http.put(
      headers: headers,
      body: msg,
      Uri.parse(urlMain + api),
    );
    print(response.body);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Updated');
       setState((){});
      detailView();
    } else {
      Fluttertoast.showToast(msg: response.reasonPhrase.toString());
    }
  }
  void changeStage(id, stage) async {
    print('$id::::::$stage');
    String api = 'api/resource/Lead/$id';
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    };
    var msg = jsonEncode({"stage": stage});
    print(msg);
    http.Response response = await http.put(
      headers: headers,
      body: msg,
      Uri.parse(urlMain + api),
    );
    print(response.body);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Updated');
       setState((){});
      detailView();
    } else {
      Fluttertoast.showToast(msg: response.reasonPhrase.toString());
    }
  }

  detailView() async {
    print("object");
    var s = widget.address;
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
        productlist = jsonDecode(data)["data"];
      });
      setState(() {
        selectedStatus = productlist["status"];
        selectedStage = productlist["stage"];
      });
      // log(productList[0]["note"]);
      log(data + ';;;;;');
      //  baisicDetailView2();
    } else {}
  }

  void postData(type) async {
    print('hi');
    String api;
    if (type == 1) {
      api = 'api/resource/Engineer';
    } else if (type == 2) {
      api = 'api/resource/Contractor';
    } else {
      api = 'api/resource/Shop';
    }

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    };
    var msg;
    if (type == 3) {
      msg = jsonEncode({
        "lead_id": productlist["name"],
        "organization_name": productlist["lead_name"],
        "mobile": productlist["mobile_no"],
        "email": productlist["email_id"],
        "address": ""
      });
    } else {
      msg = jsonEncode({
        "lead_id": productlist["name"],
        "name1": productlist["lead_name"],
        "mobile": productlist["mobile_no"],
        "email": productlist["email_id"],
        "address": ""
      });
    }

    print(msg);
    http.Response response = await http.post(
      headers: headers,
      body: msg,
      Uri.parse(urlMain + api),
    );
    print(response.body);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Updated');
      await detailView();
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => ViewLeaveApplication()));
    } else {
      Fluttertoast.showToast(msg: response.reasonPhrase.toString());
    }
  }

  void putData(id, type) async {
    if (type == 3) {}
    String api = 'api/resource/Lead/$id';
    var msg;
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    };
    if (type == 1) {
      msg = jsonEncode({"created_engineer": 1});
    } else if (type == 2) {
      msg = jsonEncode({"created_contractor": 1});
    } else {
      msg = jsonEncode({"created_shop1": 1});
    }

    print(msg);
    http.Response response = await http.put(
      headers: headers,
      body: msg,
      Uri.parse(urlMain + api),
    );
    print(response.body);
    if (response.statusCode == 200) {
      postData(type);

      // Fluttertoast.showToast(msg: 'Updated');
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => ViewLeaveApplication()));
    } else {
      Fluttertoast.showToast(msg: response.reasonPhrase.toString());
    }
  }
}
