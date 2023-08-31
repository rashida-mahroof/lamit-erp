import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lamit/app/modules/asmquotation/quotation-view.dart';
import 'package:lamit/app/modules/dash/views/dash_view.dart';
import 'package:lamit/app/modules/home/views/home_view.dart';
import 'package:lamit/widget/customeappbar.dart';
import 'package:http/http.dart' as http;
import 'package:lamit/globals.dart' as globals;
import '../../../tocken/config/url.dart';
import '../../../tocken/tockn.dart';

class ASMQuotationDetailsView extends StatefulWidget {
  final dynamic detailList;
  final dynamic productList;
  final dynamic paymentList;
  const ASMQuotationDetailsView(
      {super.key,
      required this.detailList,
      required this.paymentList,
      required this.productList});

  @override
  State<ASMQuotationDetailsView> createState() =>
      _ASMQuotationDetailsViewState();
}

class _ASMQuotationDetailsViewState extends State<ASMQuotationDetailsView> {
  void initState() {
    super.initState();
    print(globals.loginId + 'myidd');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight),
        child: CustomAppBar(
          title: widget.detailList["title"],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              for (int i = 0; i < widget.productList.length; i++)
                Card(
                    child: ListTile(
                  minLeadingWidth: 10,
                  leading: Container(
                      height: 35,
                      width: 35,
                      child: Image.network(
                        urlMain + widget.productList[i]['image'],
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.broken_image_rounded,
                            color: Colors.grey.shade300,
                          );
                        },
                      )),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.productList[i]["item_name"].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Qty: ' + widget.productList[i]["qty"].toString()),
                      Text('Rate: ₹ ' +
                          widget.productList[i]["rate"].toString()),
                      Wrap(
                        children: [
                          Text('MRP: ₹ ' +
                              widget.productList[i]["mrp"].toString()),
                          SizedBox(
                            width: 10,
                          ),
                          Text('MOP: ₹ ' +
                              widget.productList[i]["mop"].toString()),
                        ],
                      ),
                      Wrap(
                        children: [
                          Text('Dealer Price: ₹ ' +
                              widget.productList[i]["dealer_delivery"]
                                  .toString()),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Subdealer Price: ₹ ' +
                              widget.productList[i]["sub_dealer_"].toString()),
                        ],
                      ),
                    ],
                  ),
                  trailing: Text(
                    '₹ ' + widget.productList[i]['amount'].toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 2, 76, 142)),
                  ),
                )),
              Container(
                margin: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade200)),
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    RowWidget(
                        'Total Amount', widget.detailList["total"].toString()),
                    Divider(),
                    // RowWidget(
                    //     'Total Qty', widget.detailList["total_qty"].toString()),
                    // Divider(),
                    RowWidget(
                        'Tax Amount',
                        widget.detailList["total_taxes_and_charges"]
                            .toString()),
                    Divider(),
                    RowWidget('Grand Total',
                        widget.detailList["rounded_total"].toString()),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
      bottomNavigationBar: (widget.detailList["status"] == 'Draft' &&
              globals.role == "Area Sales Manager")
          ? Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          approveQuotation(widget.detailList["name"]);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            foregroundColor: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 13.0),
                          child: Text('Approve'),
                        )))
              ],
            )
          : null,
    );
  }

  Row RowWidget(label, value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label + ' : ',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        Text('₹ ' + value, style: TextStyle(fontWeight: FontWeight.w600))
      ],
    );
  }

  void approveQuotation(qid) async {
    print(qid + 'apid');
    final msg = jsonEncode({"docstatus": 1});
    http.Response response1 = await http.put(
      Uri.parse(urlMain + 'api/resource/Quotation/$qid'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Tocken.toString(),
      },
      body: msg,
    );

    if (response1.statusCode == 200) {
      print('okkkkkkkkkkkk');
      Fluttertoast.showToast(msg: 'Quotaion approved');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ASMQuotationView()));
    } else {
      print(response1.reasonPhrase.toString());
    }
  }
}
