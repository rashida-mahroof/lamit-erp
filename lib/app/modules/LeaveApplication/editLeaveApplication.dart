import 'dart:convert';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:lamit/app/modules/LeaveApplication/ViewLeaveApplication.dart';
import 'package:lamit/app/modules/lead/views/lead_view.dart';
import 'package:lamit/globals.dart' as globals;
import '../../../tocken/config/url.dart';
import '../../../tocken/tockn.dart';
import '../../../widget/customeappbar.dart';

class editLeaveApplication extends StatefulWidget {
  const editLeaveApplication({
    super.key,
    required this.data,
  });
  final Map<String, dynamic> data;
  @override
  State<editLeaveApplication> createState() => _editLeaveApplicationState();
}

DateTime selectedFromdate = DateTime.now();
DateTime selectedTodate = DateTime.now();

class _editLeaveApplicationState extends State<editLeaveApplication> {
  final _formKey = GlobalKey<FormState>();
  late List<String> leaveTypes = [''];
  final typeController = TextEditingController();
  final reasonController = TextEditingController();
  bool halfDay = false;
  final leaveTypeController = TextEditingController();
  void initState() {
    super.initState();
    print(widget.data.toString() + 'bnbnbn');
    fetchLeaveTypes();
    if (widget.data["Description"] != null) {
      reasonController.text = widget.data["Description"].toString();
    }
    selectedFromdate = DateTime.parse(widget.data["from_date"]);
    selectedTodate = DateTime.parse(widget.data["todate"]);
    if (widget.data["halfday"] == 0) {
      halfDay = false;
    } else {
      halfDay = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 237, 237),
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight),
        child: CustomAppBar(
          title: 'Edit Leave Application',
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomDropdown(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                  errorText: 'This field is required',
                  errorStyle: TextStyle(color: Colors.red),
                  hintStyle: TextStyle(fontSize: 13, color: Colors.black45),
                  hintText: 'Leave Type',
                  items: leaveTypes,
                  selectedStyle: TextStyle(fontSize: 13),
                  controller: leaveTypeController,
                  excludeSelected: false,
                  fillColor: Colors.white,
                  onChanged: (value) {
                    setState(() {
                      leaveTypeController.text = value;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: reasonController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Description',
                    labelStyle: TextStyle(fontSize: 13, color: Colors.black45),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade400, width: 1),
                    ),
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This Field is required';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 45,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "${selectedFromdate.day}/${selectedFromdate.month}/${selectedFromdate.year} - ${selectedTodate.day}/${selectedTodate.month}/${selectedTodate.year}"),
                          IconButton(
                              onPressed: () {
                                pickDate(context);
                              },
                              icon: Icon(Icons.calendar_today))
                        ]),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Material(
                  child: CheckboxListTile(
                    tileColor: Colors.white,
                    title: const Text('Half day'),
                    value: halfDay,
                    onChanged: (bool? value) {
                      setState(() {
                        halfDay = !halfDay;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: Text('Update'),
                        onPressed: () {
                          editLeave();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  pickDate(BuildContext context) async {
    final picked = await showDateRangePicker(
       helpText: 'Select from date and to date',
     
      context: context,
      lastDate: DateTime(2039),
      firstDate: new DateTime(2023),
    );
    if (picked != null && picked != null) {
      print(picked);
      setState(() {
        selectedFromdate = picked.start;
        selectedTodate = picked.end;
      });
    }
  }

  void editLeave() async {
    var id = widget.data["id"];
    var fromDate = selectedFromdate.toString().split(" ").first;
    var toDate = selectedTodate.toString().split(" ").first;
    if (_formKey.currentState!.validate()) {
      print('hi');
      String api = 'api/resource/Leave Application/$id';
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Tocken,
      };
      var msg = jsonEncode({
        "employee": globals.loginId.toString(),
        "from_date": fromDate,
        "to_date": toDate,
        "half_day": halfDay ? 1 : 0,
        "heads_permission": globals.loginId.toString(),
        "posting_date": DateTime.now().toString().split(" ").first,
        "leave_type": leaveTypeController.text,
        "status": "Open",
        "status1": "Open",
        "description": reasonController.text.toString()
      });
      print(msg);
      http.Response response = await http.put(
        headers: headers,
        body: msg,
        Uri.parse(urlMain + api),
      );
      print(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Updated');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ViewLeaveApplication()));
      } else if (response.statusCode == 417) {
        Fluttertoast.showToast(msg: 'You have already applied for this date');
      } else {
        Fluttertoast.showToast(msg: response.reasonPhrase.toString());
      }
    }
  }

  fetchLeaveTypes() async {
    var userId = globals.loginId;
    http.Response response = await http.get(
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Tocken.toString(),
      },
      Uri.parse(urlMain +
          'api/resource/Leave Allocation?fields=["leave_type"]&filters=[["employee","=","$userId"],["docstatus","=" ,"1"]]'),
    );
    if (response.statusCode == 200) {
      // print(response.statusCode);
      String data = response.body;
      print(data);
      var ltypes = jsonDecode(data);
      leaveTypes.clear();
      if (leaveTypes.length <= 1) {
        for (int i = 0; i < ltypes["data"].length; i++) {
          leaveTypes.add(ltypes["data"][i]["leave_type"]);
        }
      }

      print(leaveTypes.toString() + 'llllll');
      leaveTypeController.text = widget.data["type"].toString();
      print(leaveTypeController.text);
    }
  }
}
