import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/tocken/tockn.dart';

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _value = 0;
  List product = [
    {'id': '1', 'name': 'Watch', 'price': '3200', 'category': 'wearable'},
    {'id': '2', 'name': 'T-Shirt', 'price': '520', 'category': 'wearable'},
    {'id': '3', 'name': 'Jeans', 'price': '840', 'category': 'wearable'},
    {
      'id': '4',
      'name': 'refrigerator',
      'price': '1800',
      'category': 'wearable'
    },
  ];

  @override
  void initState() {
    baisicD();
    super.initState();
  }

  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Products Filter",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Slider(
              min: 0,
              max: 80000,
              onChanged: (double value) {
                setState(() {
                  _value = value;
                });
              },
              value: _value,
            ),
            Text(
              "All Products < Rs. ${_value.toInt()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 20)),
            Column(
              children: product.map((e) {
                if (double.parse(e['price']) < _value) {
                  return Container(
                    height: 80,
                    width: w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text(e['id'])],
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(right: 0)),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text(e['name']), Text(e['category'])],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(e['price']),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
                return Container();
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  baisicD() async {
    // var s = widget.leadtocken;
    print("object");
    http.Response response = await http.get(
      Uri.parse(urlMain +
          'api/resource/Employee/SOF-01?filters=[["user_id", "in", ["salesofficer1@gmail.com"]]]&fields=["work_for_company"]'),
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
        // materialStatus = jsonDecode(data)["data"]["marital_status"];

        //productList =
      });

      // log(productList[0]["note"]);
      print(data);
    } else {}
  }
}
