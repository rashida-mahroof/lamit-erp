import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/tocken/tockn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'attendence.dart';

class AttendencelistView extends StatefulWidget {
  final String id;

  const AttendencelistView(this.id);

  @override
  State<AttendencelistView> createState() => _AttendencelistViewState();
}

class _AttendencelistViewState extends State<AttendencelistView> {
  var array;
  String? id;
  String? id1;
  @override
  void initState() {
    getSp();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[50],
          elevation: 0,
          title: Text(
            'Attendence',
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          actions: [IconButton( icon: Icon(Icons.add),
           onPressed: () {
                Get.to(AttendenceView(id.toString()));
              },
          )],

          // centerTitle: true,
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: array == null ? 0 : array.length,
                      itemBuilder: ((context, index) {
                        return Container(
                          height: 70,
                          child: Card(
                            color: Colors.grey[50],
                            child: ListTile(
                              title: Text(
                                  array[index]["employee_name"].toString()),
                              subtitle: Text(array[index]
                                          ["attendance_date".toString()] ==
                                      ""
                                  ? ""
                                  : array[index]["attendance_date".toString()]
                                      .toString()),
                              trailing: Text(array[index]["status"] == ""
                                  ? ""
                                  : array[index]["status".toString()]
                                      .toString()),
                            ),
                          ),
                        );
                      })),
                )
              ],
            ),
          ),
        ));
  }

  getSp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString("userid");
    attendview(preferences.getString("userid"));

    // print(username);
  } //   duration: const Duration(seconds: 1),

  attendview(ids) async {
    setState(() {
      id1 = widget.id;
    });
    log(ids);
    http.Response response = await http.get(
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Tocken.toString(),
      },
      Uri.parse(
          // addURL,
          urlMain +
              'api/resource/Attendance?filters=[["employee","=","$ids"]]&fields=["*"]'),
    );

    String data = response.body;
    log("daaaaaataaaaa" + data);
    if (response.statusCode == 200) {
      String data = response.body;

      setState(() {
        array = jsonDecode(data)["data"];
      });

      // Fluttertoast.showToast(msg: "Attendence aleardy added");

      log("daaaaaataaaaa" + data);
    } else {
      // Fluttertoast.showToast(
      //     msg: "Attendence aleardy added", backgroundColor: Colors.green);
    }
  }
}
