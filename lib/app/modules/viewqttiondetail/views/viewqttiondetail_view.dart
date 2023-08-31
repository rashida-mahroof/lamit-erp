import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../tocken/config/url.dart';
import '../../../../tocken/tockn.dart';

class ViewqttiondetailView extends StatefulWidget {
  final String id;

  const ViewqttiondetailView(this.id);

  @override
  State<ViewqttiondetailView> createState() => _ViewqttiondetailViewState();
}

class _ViewqttiondetailViewState extends State<ViewqttiondetailView> {
  var productList;
  @override
  void initState() {
    qtView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: Text('View'),
        // centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ViewqttiondetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  qtView() async {
    var a = widget.id;
    print("object");
    http.Response response = await http.get(
      Uri.parse(urlMain + "api/resource/Quotation/$a"),
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
        //  productList = jsonDecode(data)["data"]["customer_requirements"];
      });

      // log(productList[0]["note"]);
      print(data);
    } else {}
  }
}
//