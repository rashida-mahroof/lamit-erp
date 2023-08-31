import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lamit/app/modules/LeaveApplication/editLeaveApplication.dart';
import 'package:lamit/app/modules/home/views/home_view.dart';
import 'package:lamit/globals.dart' as globals;
import 'package:lamit/app/modules/LeaveApplication/create-leave-application.dart';
import 'package:http/http.dart' as http;
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/tocken/tockn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewLeaveApplication extends StatefulWidget {
  const ViewLeaveApplication({super.key});

  @override
  State<ViewLeaveApplication> createState() => _ViewLeaveApplicationState();
}

class _ViewLeaveApplicationState extends State<ViewLeaveApplication> {
  var empList = [];
  var userID;
  var filt;
  bool countVisible = false;
  var leaveCount;
  void initState() {
    super.initState();

    fetchEmployees();
  }

  dynamic detailList = [];
  dynamic productList = [];
  dynamic paymentList = [];
  void handleClick(String value) {
    switch (value) {
      case 'Me':
        setState(() {
          var a = ["$userID"];
          filt = jsonEncode(a);
        });
        break;
      case 'Others':
        setState(() {
          filt = jsonEncode(empList);
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.to(HomeView("1"));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 30,
          elevation: 0,
          title: Text(
            'Leave Applications',
            style: TextStyle(fontSize: 15),
          ),
          toolbarHeight: kToolbarHeight,
          actions: [
            IconButton(
                onPressed: () {
                  // if()
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateLeaveApplication()));
                },
                icon: Icon(Icons.add)),
            if (globals.role == "Area Sales Manager")
              PopupMenuButton<String>(
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  return {'Me', 'Others'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              )
          ],
        ),
        body: SafeArea(
          child: FutureBuilder(
              future: fetchApplications(filt),
              builder: ((context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                     
                      // physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext, index) {
                        return Card(
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.only(
                                    top: 15, left: 10, right: 10, bottom: 0),
                                title: Text(
                                  snapshot.data[index]["posting_date"]
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.black45, fontSize: 10),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      // Controls visual overflow
                                      overflow: TextOverflow.fade,

                                      // Maximum number of lines for the text to span
                                      maxLines: 1,

                                      // The number of font pixels for each logical pixel
                                      textScaleFactor: 1,
                                      text: TextSpan(
                                        text: snapshot.data[index]["leave_type"]
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black),
                                        children: <TextSpan>[
                                          if (snapshot.data[index]
                                                  ["half_day"] ==
                                              1)
                                            TextSpan(
                                                text: ' ( Half day )',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                )),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      snapshot.data[index]["employee_name"]
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Wrap(
                                      children: [
                                        Text('From: ' +
                                            snapshot.data[index]["from_date"]),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('To: ' +
                                            snapshot.data[index]["to_date"]),
                                        Text(' (' +
                                            snapshot.data[index]
                                                    ["total_leave_days"]
                                                .round()
                                                .toString() +
                                            ')')
                                      ],
                                    ),
                                    Text(
                                      'Description:  ' +
                                          snapshot.data[index]["description"]
                                              .toString(),
                                      style: TextStyle(),
                                    ),
                                    Visibility(
                                      // visible: (globals.loginId ==
                                      //         snapshot.data[index]
                                      //             ["employee"])
                                      //     ? false
                                      //     : true,
                                      child: Text(
                                        'Leave balance:  ' +
                                            snapshot.data[index]
                                                    ["leave_balance"]
                                                .round()
                                                .toString(),
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    if (snapshot.data[index]["employee"] ==
                                            globals.loginId &&
                                        snapshot.data[index]["status"] ==
                                            "Open")
                                      TextButton(
                                          onPressed: () {
                                            Map<String, dynamic> dataList = {
                                              'id': snapshot.data[index]
                                                  ["name"],
                                              'type': snapshot.data[index]
                                                  ["leave_type"],
                                              'from_date': snapshot.data[index]
                                                  ["from_date"],
                                              'todate': snapshot.data[index]
                                                  ["to_date"],
                                              'Description': snapshot
                                                  .data[index]["description"],
                                              "halfday": snapshot.data[index]
                                                  ["half_day"]
                                            };
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        editLeaveApplication(
                                                            data: dataList)));
                                          },
                                          child: Text('Click to edit'))
                                  ],
                                ),
                                trailing:
                                    // (snapshot.data[index]["status"] !=
                                    //         "Open" )?
                                    Text(
                                  snapshot.data[index]["status"].toString(),
                                  style: TextStyle(
                                      color: snapshot.data[index]["status"] ==
                                              "Open"
                                          ? Colors.blue
                                          : snapshot.data[index]["status"] ==
                                                  'Approved'
                                              ? Colors.green
                                              : Colors.red),
                                )
                                // : null
                                ,
                              ),
                              if (snapshot.data[index]["status"] == 'Open' &&
                                  globals.loginId !=
                                      snapshot.data[index]["employee"])
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      OutlinedButton(
                                          onPressed: () {
                                            reject(
                                                snapshot.data[index]["name"]);
                                          },
                                          style: OutlinedButton.styleFrom(
                                              primary: Colors.red),
                                          child: Text('Reject')),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      OutlinedButton(
                                          onPressed: () {
                                            approve(
                                                snapshot.data[index]["name"]);
                                          },
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.green,
                                              foregroundColor: Colors.white),
                                          child: Text('Approve'))
                                    ],
                                  ),
                                )
                            ],
                          ),
                        );
                      });
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })),
        ),
      ),
    );
  }

  fetchEmployees() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userID = preferences.getString("userid");
    print(userID);
    http.Response response = await http.get(
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Tocken.toString(),
      },
      Uri.parse(
          // addURL,
          urlMain +
              'api/resource/Employee?filters=[["reports_to", "=","$userID"]]'),
    );
    if (response.statusCode == 200) {
      // print(response.body + 'hlo');
      String data = response.body;
      print(response.body);
      var eList = jsonDecode(data)["data"];
      // print(eList + 'opopop');
      for (int i = 0; i < eList.length; i++) {
        empList.add(eList[i]["name"]);
      }
      filt = jsonEncode(empList);
      setState(() {});

      // fetchApplications(empList);
      //   areas = areaList.toString();

      //   print(areas.toString() + 'hlo12');
      // } else {
      //   print(response.reasonPhrase.toString());
      // }
      // return areas;
    }
  }

  fetchApplications(f) async {
    log(f + '  i am content of f');
    if (globals.role == "Sales Officer") {
      var a = ["$userID"];
      f = jsonEncode(a);
      print(f + 'kiop');
    }
    String api =
        'api/resource/Leave Application?fields=["employee","name","employee_name","leave_type","posting_date","department","from_date","to_date","status1","half_day","leave_balance","total_leave_days","description","status"]&filters=[["employee", "in",$f]]&limit=1000000&order_by=creation%20desc';
    http.Response response = await http.get(
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Tocken.toString(),
      },
      Uri.parse(urlMain + api),
    );

    if (response.statusCode == 200) {
      log(response.body + 'mereslt');
    } else {
      print(response.reasonPhrase.toString());
    }
    return jsonDecode(response.body)["data"];
  }

  void approve(id) async {
    String api = 'api/resource/Leave Application/$id';
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    };
    var msg = jsonEncode(
        {"status": "Approved", "status1": "Approved", "docstatus": "1"});
    http.Response response = await http.put(
      headers: headers,
      body: msg,
      Uri.parse(urlMain + api),
    );
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Approved');
      setState(() {
        fetchApplications(filt);
      });
    } else {
      Fluttertoast.showToast(msg: response.reasonPhrase.toString());
    }
  }

  void reject(id) async {
    String api = 'api/resource/Leave Application/$id';
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    };
    var msg = jsonEncode(
        {"status": "Rejected", "status1": "Rejected", "docstatus": "1"});
    http.Response response = await http.put(
      headers: headers,
      body: msg,
      Uri.parse(urlMain + api),
    );
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Rejected');
      setState(() {
        fetchApplications(filt);
      });
    } else {
      Fluttertoast.showToast(msg: response.reasonPhrase.toString());
    }
  }
}
