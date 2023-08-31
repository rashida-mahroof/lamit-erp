import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:lamit/app/modules/home/views/home_view.dart';
import 'package:lamit/app/routes/constants.dart';

import '../../collectionreport/views/collectionreport_view.dart';
import '../../collectionreport/views/custom_divider_horizontal.dart';
import '../../collectionreport/views/custom_divider_vertical.dart';

class SalesinvoiceView extends StatefulWidget {
  const SalesinvoiceView({Key? key}) : super(key: key);

  @override
  State<SalesinvoiceView> createState() => _SalesinvoiceViewState();
}

class _SalesinvoiceViewState extends State<SalesinvoiceView> {
  String? selectedCustomer;
  String? selectedLedger;
  String? selectedItem;
  String? selectedUnit;
  var settings;
  double vatPercent = 0.0;
  var logopath;
  File? file;
  String? genarate;

  String subTotal = '';
  double vatAmount = 0;
  double totalAmount = 0;
  double balance = 0;
  var array = [];
  int? prefixNo = 0;
  String? prefix = "";
  String? vat;
  String? company;
  String? companyAddress;
  String ob = '0.0';

  TextEditingController qtyController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController remarksController = new TextEditingController();
  TextEditingController oldBalanceController = new TextEditingController();
  TextEditingController recBalanceController = new TextEditingController();
  TextEditingController discountController = new TextEditingController();

  List<Map<String, String>> items = [];
  List<TextEditingController> controllers = [];
  String? itemToAdd;
  ScrollController controller = new ScrollController();
  List<Map<String, dynamic>> offLineCustomers = [];
  List<Map<String, dynamic>> offLineLedger = [];
  List<Map<String, dynamic>> offLineinvoice = [];

  var offLineCustomersDropDown = [];
  List<Map<String, String>> customerDetails = [];

  var offLineCustomersIdDropDown = [];
  var offlineProductsIdDropDown = [];
  List<Map<String, dynamic>> offlineProducts = [];
  var offlineProductsDropDown = [];
  List itemPricesOffline = [];
  var units = [];
  List<DropdownMenuItem<String>> unitsDrop = [];
  List<Map<String, dynamic>> offlineUnits = [];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            builder: (builder) => CupertinoAlertDialog(
                  title: Text('Are you sure to cancel and exit ?'),
                  actions: [
                    CupertinoButton(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    CupertinoButton(
                        child: Text('Yes'),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                  builder: (builder) => HomeView(
                                        "",
                                      )));
                        })
                  ],
                ));

        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blueGrey[50],

        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'Sales Invoice',
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
          //title: const Text('LedgerlistView'),
          // centerTitle: true,
        ),
        // appBar: AppBar(
        //   elevation: 0,
        //   title: Titles('Sales Invoice'),
        //   // leading: BackButtonHome(),
        //   actions: [
        //     Center(
        //         child: Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Text(
        //         // 'SAR :' + totalAmount.toStringAsFixed(2),
        //         "Rs :2000",
        //         style:
        //             TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        //       ),
        //     )),
        //     //  if (items.length > 0)
        //     IconButton(
        //         color: Colors.black,
        //         onPressed: () {
        //           //   renderImage();
        //         },
        //         icon: Icon(Icons.print))
        //   ],
        // ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              RepaintBoundary(
                //  key: globalKey,
                child: Visibility(
                    visible: true,
                    child: Container(
                      height: Constants(context).scrnWidth,
                      width: Constants(context).scrnWidth,
                      color: Colors.white,
                      //  child: QrImage(data: qrData
                    )),
              ),
              Container(
                height: Constants(context).scrnHeight,
                width: Constants(context).scrnWidth,
                color: Colors.blueGrey[50],
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person_search,
                                color: Colors.blue,
                              ),
                              //  if (offLineCustomers.length > 0)
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: CustomSearchableDropDown(
                                        primaryColor: Colors.blue,
                                        items: array == [] ? [''] : array,
                                        label: selectedCustomer == null
                                            ? "arun"
                                            //'Select customer'
                                            : offLineCustomersDropDown[
                                                int.parse(selectedCustomer!)],
                                        suffixIcon: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(selectedCustomer == null
                                                ? '0.0'
                                                : 'OB : ' +
                                                    customerDetails[int.parse(
                                                            selectedCustomer!)]
                                                        ['ob']!),
                                            Icon(Icons.arrow_drop_down)
                                          ],
                                        ),
                                        showLabelInMenu: true,
                                        onChanged: (value) async {
                                          setState(() {
                                            selectedCustomer = value;
                                            ob = customerDetails[int.parse(
                                                selectedCustomer!)]['ob']!;
                                          });
                                        },
                                        dropDownMenuItems:
                                            offLineCustomersDropDown == []
                                                ? ['']
                                                : offLineCustomersDropDown),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.manage_search_rounded,
                                color: Colors.blue,
                              ),
                              if (offlineProducts.length > 0)
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: CustomSearchableDropDown(
                                        primaryColor: Colors.blue,
                                        items: itemPricesOffline == []
                                            ? ['']
                                            : itemPricesOffline,
                                        label: 'Select Product',
                                        showLabelInMenu: true,
                                        onChanged: (value) async {
                                          if (value != null) {
                                            selectedItem = value!;
                                          } else if (array.length > 0) {
                                            selectedItem = array[0];
                                          }

                                          log(selectedItem!);
                                          itemToAdd =
                                              offlineProducts[int.parse(value)]
                                                  ['name'];
                                          //   final db = await database;

                                          // units = await db.query('units',
                                          //     where: 'itemID=' +
                                          //         offlineProductsIdDropDown[
                                          //                 int.parse(value)]
                                          //             .toString());
                                          setState(() {
                                            unitsDrop.clear();
                                            // for (var i = 0; i < units.length; i++) {
                                            //   unitsDrop.add(DropdownMenuItem(
                                            //       value: i.toString(),
                                            //       child: Text(units[i]['unitAbre'])));
                                            // }
                                            if (unitsDrop.length > 0) {
                                              log(units.toString());
                                            } else {
                                              priceController =
                                                  new TextEditingController(
                                                      text: vatPercent >
                                                              0
                                                          ? offlineProducts[int
                                                                  .parse(
                                                                      selectedItem!)]
                                                              ['price']
                                                          : offlineProducts[
                                                                  int.parse(
                                                                      selectedItem!)]
                                                              ['saleprice']);
                                              qtyController =
                                                  new TextEditingController(
                                                      text: '1');
                                            }
                                          });
                                        },
                                        dropDownMenuItems:
                                            offlineProductsDropDown == []
                                                ? ['']
                                                : offlineProductsDropDown,
                                      ),
                                    ),
                                  ),
                                ),
                              if (unitsDrop.length > 0)
                                Container(
                                  height: 50,
                                  width: 75,
                                  margin: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: DropdownButton(
                                        underline: Container(),
                                        value: selectedUnit,
                                        items: unitsDrop,
                                        hint: Text('Unit'),
                                        onChanged: (String? unit) {
                                          setState(() {
                                            selectedUnit = unit;
                                            priceController =
                                                new TextEditingController(
                                                    text:
                                                        units[int.parse(unit!)]
                                                            ['price']);
                                            qtyController =
                                                new TextEditingController(
                                                    text: '1');
                                          });
                                        }),
                                  ),
                                ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.my_library_add_outlined,
                                color: Colors.blue,
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: TextField(
                                      controller: qtyController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Qty'),
                                    ),
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.price_change_outlined,
                                color: Colors.blue,
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  margin: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: TextField(
                                      controller: priceController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Price'),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Container(
                                    height: 45,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          // if (selectedCustomer == null) {
                                          //   Fluttertoast.showToast(
                                          //       msg: 'Select a Customer');
                                          // } else if (selectedItem == null) {
                                          //   Fluttertoast.showToast(
                                          //       msg: 'Select an Item');
                                          // } else if (qtyController.text.isEmpty) {
                                          //   Fluttertoast.showToast(
                                          //       msg: 'Enter Quantity');
                                          // } else
                                          {
                                            setState(() {
                                              items.add({
                                                "id": "1",
                                                "Item": "mdimix",
                                                "qty": "3",
                                                "price": "299",
                                                "vprice": "222",
                                                "total": "666",
                                                "unit": "nos",
                                                "unitID": '3',
                                                // "id": offlineProducts[int.parse(
                                                //         selectedItem!)]['id']!
                                                //     .toString(),
                                                // "Item": itemToAdd!,
                                                // "qty": qtyController.text,
                                                // "price": offlineProducts[
                                                //         int.parse(selectedItem!)]
                                                //     ['saleprice'],
                                                // "vprice": priceController.text,
                                                // "total": total.toStringAsFixed(2),
                                                // "unit": unitsDrop.length > 0
                                                //     ? units[int.parse(
                                                //             selectedUnit!)]
                                                //         ['unitAbre']
                                                //     : 'Nos',
                                                // "unitID": unitsDrop.length > 0
                                                //     ? units[int.parse(
                                                //             selectedUnit!)]['id']
                                                //         .toString()
                                                //     : '',
                                              });
                                              controllers.add(
                                                  new TextEditingController(
                                                      text: ((double.parse(
                                                                      priceController
                                                                          .text) *
                                                                  100) /
                                                              (100 +
                                                                  (vatPercent *
                                                                      100)))
                                                          .toStringAsFixed(2)));
                                            });
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              if (controller.hasClients) {
                                                controller.animateTo(
                                                    controller.position
                                                        .maxScrollExtent,
                                                    duration: Duration(
                                                        milliseconds: 500),
                                                    curve: Curves.easeInOut);
                                              }
                                            });

                                            qtyController.clear();
                                            priceController.clear();
                                            selectedItem = null;

                                            offlineProductsDropDown = [];
                                            offlineProductsIdDropDown = [];
                                            itemPricesOffline = [];

                                            Timer(Duration(milliseconds: 200),
                                                () {
                                              for (var i = 0;
                                                  i < offlineProducts.length;
                                                  i++) {
                                                offlineProductsDropDown.add(
                                                    offlineProducts[i]['name']);
                                                offlineProductsIdDropDown.add(
                                                    offlineProducts[i]['id']);
                                                itemPricesOffline
                                                    .add(i.toString());
                                              }
                                            });

                                            double ttl = 0;
                                            for (var i = 0;
                                                i < items.length;
                                                i++) {
                                              ttl = ttl +
                                                  double.parse(
                                                          controllers[i].text) *
                                                      int.parse(
                                                          items[i]['qty']!);
                                            }
                                            subTotal = ttl.toStringAsFixed(2);
                                            vatAmount = double.parse(subTotal) *
                                                vatPercent;
                                            if ((double.parse(subTotal) +
                                                        vatAmount) %
                                                    1 >
                                                0.555) {
                                              totalAmount = (double.parse(
                                                          subTotal) +
                                                      vatAmount) +
                                                  double.parse(customerDetails[
                                                          int.parse(
                                                              selectedCustomer!)]
                                                      ['ob']!);
                                            } else {
                                              totalAmount =
                                                  (double.parse(subTotal) +
                                                          vatAmount) +
                                                      double.parse("2000");
                                              // double.parse(customerDetails[
                                              //         int.parse(
                                              //             selectedCustomer!)]
                                              //     ['ob']!

                                              //     );
                                            }
                                            balance = totalAmount;
                                            "arabi";
                                            // generateQR(settings[0]['nameArabi'],
                                            //     settings[0]['vatnum']);
                                          }
                                        },
                                        child: Text(
                                          'Add',
                                          style: TextStyle(
                                              color: Colors.grey[900]),
                                        ))),
                              )
                            ],
                          ),
                        ],
                      ),
                      if (items.length > 0)
                        ExpansionTile(
                          title: Text('Bill Details'),
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            'SUB TOTAL',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.blue[100]),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 4.0, left: 4.0),
                                          child: Text(
                                            subTotal,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey[900],
                                                fontWeight: FontWeight.w700),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 41,
                                    margin: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0),
                                            child: TextField(
                                              controller: discountController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                  hintText: 'Discount',
                                                  hintStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  border: InputBorder.none),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey[900],
                                                  fontWeight: FontWeight.w700),
                                              onChanged: (value) {
                                                setState(() {
                                                  if (discountController
                                                      .text.isNotEmpty) {
                                                    vatAmount = (double.parse(
                                                                subTotal) -
                                                            double.parse(
                                                                value)) *
                                                        vatPercent;

                                                    totalAmount = vatAmount +
                                                        (double.parse(
                                                                subTotal) -
                                                            double.parse(
                                                                discountController
                                                                    .text));
                                                  } else {
                                                    vatAmount =
                                                        double.parse(subTotal) *
                                                            vatPercent;
                                                    totalAmount = vatAmount +
                                                        double.parse(subTotal);
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                if (vatPercent != 0)
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              'VAT AMOUNT',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.blue[100]),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 4.0, left: 4.0),
                                            child: Text(
                                              vatAmount.toStringAsFixed(2),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey[900],
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            'PREVIOUS BALANCE',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.blue[100]),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 4.0, left: 4.0),
                                          child: Text(
                                            "200"
                                            // customerDetails[
                                            //         int.parse(selectedCustomer!)]
                                            //     ['ob']!,
                                            ,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey[900],
                                                fontWeight: FontWeight.w700),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            'TOTAL AMOUNT',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.blue[100]),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 4.0, left: 4.0),
                                          child: Text(
                                            totalAmount.toStringAsFixed(2),
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey[900],
                                                fontWeight: FontWeight.w700),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 41,
                                    margin: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0),
                                            child: TextField(
                                              controller: recBalanceController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                  hintText: 'Received',
                                                  hintStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  border: InputBorder.none),
                                              onChanged: (value) {
                                                setState(() {
                                                  if (recBalanceController
                                                      .text.isNotEmpty) {
                                                    balance = totalAmount -
                                                        double.parse(value);
                                                  } else {
                                                    balance = totalAmount;
                                                  }
                                                });
                                              },
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey[900],
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            'BALANCE',
                                            style: TextStyle(
                                                fontSize: 9,
                                                color: Colors.blue[100]),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 4.0, left: 4.0),
                                          child: Text(
                                            balance.toStringAsFixed(2),
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey[900],
                                                fontWeight: FontWeight.w700),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 40,
                                    margin: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: DropdownButton(
                                        items: [
                                          DropdownMenuItem(
                                              child: Text('Cash'),
                                              value: 'Cash'),
                                          DropdownMenuItem(
                                              child: Text('Bank'),
                                              value: 'Bank'),
                                          DropdownMenuItem(
                                              child: Text('Credit'),
                                              value: 'Credit')
                                        ],
                                        isExpanded: true,
                                        underline: Container(),
                                        hint: Text('Select Ledger'),
                                        value: selectedLedger,
                                        onChanged: (String? value) async {
                                          setState(() {
                                            selectedLedger = value;
                                            if (value == 'Credit') {
                                              recBalanceController.text = '0.0';
                                            }
                                            FocusScope.of(context).unfocus();
                                          });

                                          log('$selectedLedger');
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 40,
                                    margin: EdgeInsets.all(2),
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          //renderImage();
                                        },
                                        child: Text('SUBMIT')),
                                  ),
                                ),
                              ],
                            ),
                            Divider(color: Colors.transparent)
                          ],
                        ),
                      if (items.length > 0)
                        Expanded(
                            child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            width: 750,
                            child: Column(
                              children: [
                                CustomDividerHorizontal(),
                                Container(
                                  height: 30,
                                  color: Colors.grey[200],
                                  child: Row(
                                    children: [
                                      CustomDividerVertical(),
                                      Container(
                                        width: 50,
                                        child: Center(
                                          child: HeadingText('Sl.No.'),
                                        ),
                                      ),
                                      CustomDividerVertical(),
                                      Expanded(
                                          flex: 2,
                                          child: Container(
                                              child: Center(
                                                  child: HeadingText('Item')))),
                                      CustomDividerVertical(),
                                      Expanded(
                                          child: Container(
                                              child: Center(
                                                  child:
                                                      HeadingText('Price')))),
                                      if (vatPercent != 0)
                                        CustomDividerVertical(),
                                      if (vatPercent != 0)
                                        Expanded(
                                            child: Container(
                                                child: Center(
                                                    child: HeadingText(
                                                        'Price (Inc. VAT)')))),
                                      CustomDividerVertical(),
                                      Container(
                                        width: 50,
                                        child: Center(
                                          child: HeadingText('Qty.'),
                                        ),
                                      ),
                                      CustomDividerVertical(),
                                      Container(
                                        width: 60,
                                        child: Center(
                                          child: HeadingText('Unit'),
                                        ),
                                      ),
                                      CustomDividerVertical(),
                                      Expanded(
                                          child: Container(
                                              child: Center(
                                                  child:
                                                      HeadingText('Total')))),
                                      CustomDividerVertical(),
                                      Container(
                                        width: 40,
                                      ),
                                      CustomDividerVertical()
                                    ],
                                  ),
                                ),
                                CustomDividerHorizontal(),
                                Flexible(
                                    child: ListView.builder(
                                  controller: controller,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: items.length,
                                  itemBuilder: (ctx, index) => Column(
                                    children: [
                                      Container(
                                        color: Colors.grey[50],
                                        height: 30,
                                        child: Row(
                                          children: [
                                            CustomDividerVertical(),
                                            Container(
                                              width: 50,
                                              child: Center(
                                                child: ListText(
                                                    (index + 1).toString()),
                                              ),
                                            ),
                                            CustomDividerVertical(),
                                            Expanded(
                                                flex: 2,
                                                child: Container(
                                                    child: Center(
                                                        child: ListText(
                                                            items[index]
                                                                ['Item'])))),
                                            CustomDividerVertical(),
                                            Expanded(
                                                child: Container(
                                                    child: Center(
                                                        child: TextField(
                                              controller: controllers[index],
                                              decoration: InputDecoration(
                                                  hintText: items[index]
                                                      ['price']!),
                                              keyboardType:
                                                  TextInputType.number,
                                              onTap: () {
                                                controllers[index].selection =
                                                    TextSelection(
                                                        baseOffset: 0,
                                                        extentOffset:
                                                            controllers[index]
                                                                .value
                                                                .text
                                                                .length);
                                              },
                                              onChanged: (value) {
                                                if (value.isEmpty) {
                                                  // controllers[index].text =
                                                  //     offlineProducts[int.parse(
                                                  //             selectedItem!)]
                                                  //         ['saleprice'];
                                                } else {
                                                  setState(() {
                                                    subTotal = '0.0';
                                                    vatAmount = 0.0;
                                                    totalAmount = 0.0;
                                                    items[index]['vprice'] =
                                                        (double.parse(value) +
                                                                double.parse(
                                                                        value) *
                                                                    vatPercent)
                                                            .toStringAsFixed(2);
                                                    items[index]['price'] =
                                                        controllers[index].text;
                                                    items[index]
                                                        ['total'] = (double
                                                                .parse(value) *
                                                            double.parse(
                                                                items[index]
                                                                    ['qty']!))
                                                        .toStringAsFixed(2);
                                                    for (var i = 0;
                                                        i < items.length;
                                                        i++) {
                                                      if (controllers[i]
                                                          .text
                                                          .isEmpty) {
                                                        subTotal = (double.parse(
                                                                    subTotal) +
                                                                int.parse(items[
                                                                        i]
                                                                    ['price']!))
                                                            .toStringAsFixed(2);
                                                      } else {
                                                        subTotal = (double.parse(
                                                                    subTotal) +
                                                                double.parse(controllers[
                                                                            i]
                                                                        .text) *
                                                                    double.parse(
                                                                        items[i]
                                                                            [
                                                                            'qty']!))
                                                            .toStringAsFixed(2);
                                                      }
                                                      vatAmount = double.parse(
                                                              subTotal) *
                                                          vatPercent;

                                                      totalAmount =
                                                          (double.parse(
                                                                  subTotal) +
                                                              vatAmount);
                                                      balance = totalAmount;
                                                    }
                                                  });
                                                }
                                              },
                                            )))),
                                            if (vatPercent != 0)
                                              CustomDividerVertical(),
                                            if (vatPercent != 0)
                                              Expanded(
                                                  child: Container(
                                                      child: Center(
                                                          child: ListText(
                                                              vatPercent > 0
                                                                  ? items[index]
                                                                      ['vprice']
                                                                  : items[index]
                                                                      [
                                                                      'price'])))),
                                            CustomDividerVertical(),
                                            Container(
                                              width: 50,
                                              child: Center(
                                                child: ListText(
                                                    items[index]['qty']),
                                              ),
                                            ),
                                            CustomDividerVertical(),
                                            Container(
                                              width: 60,
                                              child: Center(
                                                child: ListText(
                                                    items[index]['unit']),
                                              ),
                                            ),
                                            CustomDividerVertical(),
                                            Expanded(
                                                child: Container(
                                                    child: Center(
                                                        child: ListText(
                                                            items[index]
                                                                ['total'])))),
                                            CustomDividerVertical(),
                                            Container(
                                              width: 40,
                                              child: Center(
                                                child: IconButton(
                                                    onPressed: () {
                                                      double ttl = 0;
                                                      setState(() {
                                                        items.removeAt(index);
                                                        controllers
                                                            .removeAt(index);
                                                        for (var i = 0;
                                                            i < items.length;
                                                            i++) {
                                                          ttl = ttl +
                                                              double.parse(items[
                                                                  i]['total']!);
                                                        }
                                                        subTotal = ttl
                                                            .toStringAsFixed(2);
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.blue,
                                                      size: 20,
                                                    )),
                                              ),
                                            ),
                                            CustomDividerVertical()
                                          ],
                                        ),
                                      ),
                                      CustomDividerHorizontal()
                                    ],
                                  ),
                                )),
                              ],
                            ),
                          ),
                        )),
                      Divider(),
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
}
