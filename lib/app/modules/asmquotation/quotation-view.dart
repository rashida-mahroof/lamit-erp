import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lamit/app/modules/asmquotation/quotationdetailsview.dart';
import 'package:http/http.dart' as http;
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/tocken/tockn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../widget/customeappbar.dart';
import '../helpers/asmAreas.dart';

class ASMQuotationView extends StatefulWidget {
  const ASMQuotationView({super.key});

  @override
  State<ASMQuotationView> createState() => _ASMQuotationViewState();
}

class _ASMQuotationViewState extends State<ASMQuotationView> {
  void initState() {
    super.initState();
    String area = fetchAreas().toString();
    print(area + 'rmto');
  }

  dynamic detailList = [];
  dynamic productList = [];
  dynamic paymentList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        elevation: 0,
        title: Text(
          'Quotations',
          style: TextStyle(fontSize: 15),
        ),
        toolbarHeight: kToolbarHeight,
        actions: [
          // IconButton(
          //     onPressed: () {
          //       showDialog(
          //           context: context,
          //           builder: (context) {
          //             return AlertDialog();
          //           });
          //     },
          //     icon: Icon(Icons.sort))
        ],
      ),
      body: SafeArea(
          child: FutureBuilder(
              future: fetchQuotaion(areas),
              builder: ((context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      // physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext, index) {
                        return Card(
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            onTap: () async {
                              await getItemandnavigate(
                                  snapshot.data[index]["name"]);
                            },
                            title: Text(
                              snapshot.data[index]["transaction_date"]
                                  .toString(),
                              style: TextStyle(
                                  color: Colors.black45, fontSize: 10),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,

                                  // The number of font pixels for each logical pixel
                                  textScaleFactor: 1,
                                  text: TextSpan(
                                    text: snapshot.data[index]["customer_name"]
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: snapshot.data[index]
                                                      ["mobile_number"] ==
                                                  null
                                              ? ""
                                              : ' (' +
                                                  snapshot.data[index]
                                                          ["mobile_number"]
                                                      .toString() +
                                                  ' )',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ],
                                  ),
                                ),
                                Text(
                                  'Grand Total: ' +
                                      snapshot.data[index]["grand_total"]
                                          .toString(),
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text('Sale area: ' +
                                    snapshot.data[index]["sale_area"])
                              ],
                            ),
                            trailing: Text(
                              snapshot.data[index]["status"].toString(),
                              style: TextStyle(
                                  color: snapshot.data[index]["status"] ==
                                          'Open'
                                      ? Colors.green
                                      : snapshot.data[index]["status"] == 'Lost'
                                          ? Colors.red
                                          : snapshot.data[index]["status"] ==
                                                  'Ordered'
                                              ? Colors.black45
                                              : Colors.blue),
                            ),
                          ),
                        );
                      });
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }))),
    );
  }

  fetchQuotaion(area) async {
    print(area + 'areaaa');
    http.Response response = await http.get(
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Tocken.toString(),
      },
      Uri.parse(urlMain +
          'api/resource/Quotation?fields=["sale_area","name","party_name","transaction_date","company","grand_total","status","customer_name","mobile_number"]&filters=[["sale_area", "in","$area"]]&limit=1000000&order_by=creation%20desc'),
    );
    if (response.statusCode == 200) {
      print(response.body + 'myresultt');
    } else {
      print(response.reasonPhrase.toString());
    }
    return json.decode(response.body)['data'];
  }

  getItemandnavigate(qid) async {
    print(qid + 'iddd');
    http.Response response1 = await http.get(
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Tocken.toString(),
      },
      Uri.parse(urlMain + 'api/resource/Quotation/$qid'),
    );

    if (response1.statusCode == 200) {
      String data = response1.body;
      setState(() {
        detailList = jsonDecode(data)["data"];
        productList = jsonDecode(data)["data"]["items"];
        paymentList = jsonDecode(data)["data"]["payment_schedule"];
      });
      log(productList.toString() + 'plist');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ASMQuotationDetailsView(
                    detailList: detailList,
                    productList: productList,
                    paymentList: paymentList,
                  )));
    } else {
      print(response1.reasonPhrase.toString());
    }
  }
}
