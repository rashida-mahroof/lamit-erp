import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lamit/app/modules/home/views/home_view.dart';
import 'package:lamit/app/widget./title.dart';

import '../../../routes/constants.dart';
import '../controllers/salesreturn_controller.dart';

class SalesreturnView extends StatefulWidget {
  const SalesreturnView({Key? key}) : super(key: key);

  @override
  State<SalesreturnView> createState() => _SalesreturnViewState();
}

class _SalesreturnViewState extends State<SalesreturnView> {
  String sum = "";

  var returnBill = [];
  var returnBillItems = [];
  var quantities = [];
  TextEditingController billNoController = new TextEditingController();
  List<TextEditingController> controllers = [];
  List<double> totals = [];
  TextEditingController paidController = new TextEditingController();
  TextEditingController discountController = new TextEditingController();
  double balance = 0.0;
  double grossTotal = 0.0;
  double totalAmount = 0.0;
  double totalVat = 0.0;

  var returnedBills = [];
  var returnedBillItems = [];
  int returnBillNum = 0;
  double vatPercent = 0;
  // getSP() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final db = await database;
  //   var settings = await db.query('Setting');
  //   if (prefs.getBool('isVAT') == true) {
  //     vatPercent = double.parse(settings[0]['vat']) / 100;
  //   } else {
  //     vatPercent = 0;
  //   }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
                builder: (builder) => HomeView(
                      "",
                    )));
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Titles('Sales Return'),

          ///leading: BackButtonHome(),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            controller: billNoController,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              hintText: "Sales Invoice Number",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          //   getReturnBill();
                        },
                        child: Icon(Icons.search)),
                  )
                ],
              ),
              if (returnBill.length > 0)
                Container(
                  width: Constants(context).scrnWidth,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              'Date',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            )),
                            Text(
                              ': ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  DateFormat('dd-MM-y').format(DateTime.parse(
                                      returnBill[0]['date'].toString())),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              'Customer',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            )),
                            Text(
                              ': ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  returnBill[0]['shopName'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              'Total Gross',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            )),
                            Text(
                              ': ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  returnBill[0]['todayBillAmount'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              'Discount',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            )),
                            Text(
                              ': ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  returnBill[0]['discount'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              'Total Amount',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            )),
                            Text(
                              ': ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  returnBill[0]['totalAmount'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              'Received',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            )),
                            Text(
                              ': ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  returnBill[0]['receivedAmount'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              'Balance',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            )),
                            Text(
                              ': ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  returnBill[0]['balanceAmount'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              if (returnBill.length > 0)
                Container(
                  height: 50,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[100],
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      SizedBox(width: 5),
                      Expanded(
                          flex: 2,
                          child: Text(
                            'Items',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )),
                      VerticalDivider(),
                      Container(
                          width: 30,
                          child: Text(
                            'Qty',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )),
                      VerticalDivider(),
                      Container(
                          width: 42,
                          child: Text(
                            'Return Qty',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )),
                      VerticalDivider(),
                      Expanded(
                          child: Text(
                        'Price',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )),
                      VerticalDivider(),
                      Expanded(
                          child: Text(
                        'Total',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ))
                    ],
                  ),
                ),
              if (returnBillItems.length > 0 && quantities.length > 0)
                Expanded(
                    child: ListView.builder(
                  itemCount: returnBillItems.length,
                  itemBuilder: (ctx, index) => Column(
                    children: [
                      Container(
                        height: 50,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  returnBillItems[index]['itemName'],
                                )),
                            VerticalDivider(),
                            Container(
                                width: 30,
                                child: Text(
                                  quantities[index].toString(),
                                )),
                            VerticalDivider(),
                            Container(
                                width: 42,
                                child: TextField(
                                  controller: controllers[index],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(hintText: 'Qty'),
                                  onChanged: (value) {
                                    if (value.isEmpty) {
                                      setState(() {
                                        totals[index] = 0.0;
                                        //  grossTotal = totals.sum;
                                        totalVat = grossTotal * vatPercent;
                                        totalAmount = grossTotal + totalVat;
                                      });
                                    } else {
                                      if (double.parse(value) >
                                          double.parse(
                                              quantities[index].toString())) {
                                        Fluttertoast.showToast(
                                            msg: 'Quantity exceeded !');
                                        controllers[index].clear();
                                      } else {
                                        setState(() {
                                          totals[index] = (double.parse(value) *
                                              double.parse(
                                                  returnBillItems[index]
                                                      ['price']));

                                          // grossTotal = totals.sum;
                                          if (discountController.text.isEmpty) {
                                            totalVat = grossTotal * vatPercent;
                                            totalAmount = grossTotal + totalVat;
                                          } else {
                                            totalVat = grossTotal -
                                                double.parse(discountController
                                                        .text) *
                                                    vatPercent;
                                            totalAmount = grossTotal + totalVat;
                                          }
                                        });
                                      }
                                    }
                                  },
                                )),
                            VerticalDivider(),
                            Expanded(
                                child: Text(
                              returnBillItems[index]['price'],
                            )),
                            VerticalDivider(),
                            Expanded(
                                child: Text(
                              totals[index].toStringAsFixed(2),
                            ))
                          ],
                        ),
                      ),
                      if (index == returnBillItems.length - 1)
                        Container(
                          width: Constants(context).scrnWidth,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        width: 100,
                                        child: Text(
                                          'Total Gross',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        )),
                                    Text(
                                      ': ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Container(
                                      width: 100,
                                      child: Text(
                                        grossTotal.toStringAsFixed(2),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        width: 100,
                                        child: Text(
                                          'Discount',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        )),
                                    Text(
                                      ': ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Container(
                                      width: 100,
                                      child: TextField(
                                        controller: discountController,
                                        keyboardType: TextInputType.phone,
                                        onChanged: (value) {
                                          setState(() {
                                            totalVat = 0.0;
                                            totalAmount = 0.0;
                                            if (value.isEmpty) {
                                              totalVat =
                                                  grossTotal * vatPercent;
                                              totalAmount =
                                                  totalVat + grossTotal;
                                            } else {
                                              totalVat = (grossTotal -
                                                      double.parse(value)) *
                                                  vatPercent;
                                              totalAmount = (grossTotal -
                                                      double.parse(value)) +
                                                  totalVat;
                                            }
                                          });
                                        },
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Discount'),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        width: 100,
                                        child: Text(
                                          'VAT Total',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        )),
                                    Text(
                                      ': ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Container(
                                      width: 100,
                                      child: Text(
                                        totalVat.toStringAsFixed(2),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        width: 100,
                                        child: Text(
                                          'Total Amount',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        )),
                                    Text(
                                      ': ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Container(
                                      width: 100,
                                      child: Text(
                                        totalAmount.toStringAsFixed(2),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        width: 100,
                                        child: Text(
                                          'Paid',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        )),
                                    Text(
                                      ': ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Container(
                                      width: 100,
                                      child: TextField(
                                        controller: paidController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Paid'),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                )),
              if (returnBill.length > 0)
                Container(
                  width: Constants(context).scrnWidth,
                  child: ElevatedButton(
                      onPressed: () {
                        //  insertReturnBill();
                      },
                      child: Text('Submit')),
                )
            ],
          ),
        ),
      ),
    );
  }
}
