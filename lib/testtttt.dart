import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lamit/app/modules/collectionreport/views/custom_divider_horizontal.dart';
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/tocken/tockn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/modules/collectionreport/views/custom_divider_vertical.dart';
import 'app/modules/salesdetail/views/salesdetail_view.dart';
import 'app/routes/constants.dart';

class SalesInvoice extends StatefulWidget {
  final String leadtok;

  final String restorationId = "main";
  final String name;
  final mapList;
  SalesInvoice(this.leadtok, this.name, this.mapList);
  @override
  _SalesInvoiceState createState() => _SalesInvoiceState();
}

class _SalesInvoiceState extends State<SalesInvoice> with RestorationMixin {
  String? get restorationId => widget.restorationId;
  String? selectedCust;
  String? productList;
  TextEditingController descontroller = TextEditingController();
  String? selectedCustomer;
  String? selectedLedger;
  String? selectedItem;
  String? selectedUnit;
  List<Map<String, dynamic>> mapLis = [];
  List<Map<String, dynamic>> taxeasarrray = [];
  var settings;
  bool va = false;
  double vatPercent = 0.0;
  var logopath;
  File? file;
  String? genarate;
  String? suTotal;
  var controlind;
  var taxarr;
  DateTime now = DateTime.now();
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
  double? totAmount;
  var taxes;
  String a1 = "0";
  var tax;

  String? charge_type;
  String? account_head;
  String? description;
  TextEditingController qtyController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController remarksController = new TextEditingController();
  TextEditingController oldBalanceController = new TextEditingController();
  TextEditingController recBalanceController = new TextEditingController();
  TextEditingController discountController = new TextEditingController();
  var sourceDropDown = [];
  var sourcelist = [];
  TextEditingController veh = TextEditingController();
  String? dropdownvaluesource;
  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2021),
          lastDate: DateTime(2122),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  String? datelll;
  DateTime? datel;
  // var taxeasarrray = [];

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        datel = newSelectedDate;
        datelll =
            'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}';
      });
    }
  }

  String? vehicledrop;
  List<Map<String, String>> items = [];
  List<TextEditingController> controllers = [];
  String? itemToAdd;
  ScrollController controller = new ScrollController();
  List<Map<String, dynamic>> offLineCustomers = [];
  List<Map<String, dynamic>> offLineLedger = [];
  List<Map<String, dynamic>> offLineinvoice = [];
  bool isLoading = false;
  //var mapList;
  bool value10 = false;
  bool valuefirst = false;
  bool valuesec = false;
  bool valuethird = false;
  bool valuefourth = false;
  bool valuefive = false;
  bool valuesix = false;
  bool value7 = false;
  bool value8 = false;
  bool value9 = false;
  var b;

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
  String? email;
  Future getAllsource() async {
    log(email.toString());
    print("hiiiiiiiii");
    var baseUrl = urlMain +
        'api/resource/User Permission?fields=["for_value"]&filters=[["allow","=","Super Stockist"],["user","=","$email"]]';

    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    });
    log(response.body + "fffffffffffffffffffffffffffffffffffffffffffff");
    print(response.statusCode);
    print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
    if (response.statusCode == 200) {
      print(response.body);
      print("haaaaaaaaaaaaaaaaaaaaaaaaa");
      String data = response.body;
      var jsonData;
      log(data + "workclo,pnu");
      setState(() {
        jsonData = json.decode(data)["data"];
        sourcelist = jsonData;

        for (var i = 0; i < sourcelist.length; i++) {
          sourceDropDown.add(sourcelist[i]['for_value']);
          // offLineCustomersIdDropDown.add(offLineCustomers[i]['id'].toString());
          // customerDetails.add({
          //   "address": offLineCustomers[i]['address'],
          //   "vat": offLineCustomers[i]['vatnum'],
          //   "ob": offLineCustomers[i]['balance'].toString()
          // });
          //  array.add(i.toString());
        }
      });

      // log(jsonData.toString());
      //setState(() {});
    }
  }

//String? email;
  getsf() async {
    log(widget.mapList.toString());

    SharedPreferences preferences = await SharedPreferences.getInstance();

    email = preferences.getString("emailid");
    log(email.toString());
    //getAllArea();

    getAllsource();

    // name = preferences.getString("name");

    log(widget.mapList.toString() + "hbjhhhhhhhhhhhhhhhhhh");

    //getlac();
    // sales();

    //print(id.toString());
    //print(name.toString());

    // newleadView(id.toString());
  }

  @override
  void initState() {
    getsf();
    log(widget.mapList.toString() + 'mrr');
    for (var i = 0; i < widget.mapList.length; i++) {
      items.add({
        "id": widget.mapList[i]["idx"].toString(),
        "item_series": widget.mapList[i]["color"] == null
            ? ""
            : widget.mapList[i]["color"],
        "item_group": widget.mapList[i]["product_group"] == null
            ? ""
            : widget.mapList[i]["product_group"].toString(),
        "Item": widget.mapList[i]["product"].toString(),
        "qty": widget.mapList[i]["qty"].toString(),
        "price": "0",
        "mop": widget.mapList[i]["mop"].toString(),
        "total": "0".toString(),
        "mrp": widget.mapList[i]["mrp"].toString(),
        "dealer_price": widget.mapList[i]["dealer_price"].toString(),
        "sub_dealer_price": widget.mapList[i]["subdealer_price"].toString(),
        "tax": widget.mapList[i]["tax"].toString(),
        "image": widget.mapList[i]["image"].toString(),
        "with_tax_rate": "0".toString(),
        "with_tax_amount": "0".toString()
      });
      controllers.add(new TextEditingController(text: "0"));
      // ((double.parse(priceController.text) * 100) /
      //         (100 + (vatPercent * 100)))
      //  .toStringAsFixed(2)));
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   if (controller.hasClients) {
      //     controller.animateTo(controller.position.maxScrollExtent,
      // duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      // }
      //  });
      saleareView();
    }
    // getOfflineData();

    // getOfflineInvoLogo();

    super.initState();
  }

  String qrData = 'afpc';
  File? qrFile;
  final GlobalKey globalKey = GlobalKey();

  Future<void> renderImage() async {
    //Get the render object from context.
    final RenderRepaintBoundary boundary =
        globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    //Convert to the image
    //final Image image = await boundary.toImage();

    final ui.Image image = await boundary.toImage();
    // var dir = await getExternalStorageDirectory();
    //var path = dir!.path;
    var pngBytes = await image.toByteData(format: ui.ImageByteFormat.png);
    //File('$path/qr.png').writeAsBytesSync(pngBytes!.buffer.asInt8List());
    // qrFile = File('$path/qr.png');
    log('real path is =>>>>>' + qrFile!.path);
    // insertBillOffline();
  }

  String ob = '0.0';

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yy').format(now);
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            builder: (builder) => CupertinoAlertDialog(
                  title: Text('Are you sure to cancel and exit ?'),
                  actions: [
                    CupertinoButton(
                        child: Text(
                          'No',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    CupertinoButton(
                        child: Text(
                          'Yes',
                          style: TextStyle(color: Colors.green),
                        ),
                        onPressed: () {
                          Get.to(SalesdetailView(
                              widget.name, "req", "", "", "", widget.leadtok));
                        })
                  ],
                ));

        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blueGrey[50],
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          elevation: 0,
          title: Text('Quotation'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.to(SalesdetailView(
                  widget.name, "req", "", "", "", widget.leadtok));
            },
          ),
          actions: [
            // Center(
            //     child: Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text(
            //     'Rs :' + balance.toStringAsFixed(2),
            //     style:
            //         TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            //   ),
            // )),
            // if (items.length > 0)
            //   IconButton(
            //       color: Colors.black,
            //       onPressed: () {
            //         renderImage();
            //       },
            //       icon: Icon(Icons.print))
          ],
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  // RepaintBoundary(
                  //   key: globalKey,
                  //   child: Visibility(
                  //     visible: true,
                  //     child: Container(
                  //         height: Constants(context).scrnWidth,
                  //         width: Constants(context).scrnWidth,
                  //         color: Colors.white,
                  //         child: QrImage(data: qrData)),
                  //   ),
                  // ),
                  SingleChildScrollView(
                    child: Container(
                      height: Constants(context).scrnHeight + 400,
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
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 52,
                                              margin: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                // border: Border.all(
                                                //     color:
                                                //         Colors.grey, // Set border color
                                                //     width: 1.0),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      // margin: EdgeInsets.all(2),
                                                      decoration: BoxDecoration(
                                                          //color: Colors.white,
                                                          ),
                                                      child:
                                                          CustomSearchableDropDown(
                                                              primaryColor:
                                                                  Colors.black,
                                                              items: sourcelist,
                                                              label: 'Company',
                                                              showLabelInMenu:
                                                                  true,
                                                              onChanged:
                                                                  (value) async {
                                                                // log(value);
                                                                dropdownvaluesource =
                                                                    value["for_value"]
                                                                        .toString();
                                                                gettaxcharge();

                                                                log(dropdownvaluesource
                                                                        .toString() +
                                                                    "dmnnmbm,bm,bg,mb,DVXdzcg");
                                                              },
                                                              dropDownMenuItems:
                                                                  sourceDropDown ==
                                                                          []
                                                                      ? ['']
                                                                      : sourceDropDown),
                                                    ),
                                                  )
                                                ],
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
                                      flex: 2,
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 50,
                                                margin: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  // border: Border.all(
                                                  //     color: Colors.blue, // Set border color
                                                  //     width: 1.0),
                                                  color: Colors.white,
                                                  // borderRadius:
                                                  //     BorderRadius.circular(20)
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Text(formattedDate
                                                          .toString())
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                Row(
                                  children: [
                                    // Icon(
                                    //   Icons.manage_search_rounded,
                                    //   //  color: primaryColor,
                                    // ),
                                    // // if (offlineProducts.length > 0)

                                    // Expanded(
                                    //   child: Container(
                                    //     margin: EdgeInsets.all(2),
                                    //     decoration: BoxDecoration(
                                    //         color: Colors.white,
                                    //         borderRadius: BorderRadius.circular(5)),
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.only(
                                    //           left: 8.0, right: 8.0),
                                    //       child: CustomSearchableDropDown(
                                    //         //   primaryColor: primaryColor,
                                    //         items: itemPricesOffline == []
                                    //             ? ['']
                                    //             : itemPricesOffline,
                                    //         label: 'Select Product',
                                    //         showLabelInMenu: true,
                                    //         onChanged: (value) async {
                                    //           if (value != null) {
                                    //             selectedItem = value!;
                                    //           } else if (array.length > 0) {
                                    //             selectedItem = array[0];
                                    //           }

                                    //           log(selectedItem!);
                                    //           itemToAdd =
                                    //               offlineProducts[int.parse(value)]
                                    //                   ['name'];
                                    //           //  final db = await database;

                                    //           // units = await db.query('units',
                                    //           //     where: 'itemID=' +
                                    //           //         offlineProductsIdDropDown[
                                    //           //                 int.parse(value)]
                                    //           //             .toString());
                                    //           setState(() {
                                    //             unitsDrop.clear();
                                    //             // for (var i = 0; i < units.length; i++) {
                                    //             //   unitsDrop.add(DropdownMenuItem(
                                    //             //       value: i.toString(),
                                    //             //       child: Text(units[i]['unitAbre'])));
                                    //             // }
                                    //             if (unitsDrop.length > 0) {
                                    //               log(units.toString());
                                    //             } else {
                                    //               priceController =
                                    //                   new TextEditingController(
                                    //                       text: vatPercent > 0
                                    //                           ? offlineProducts[
                                    //                                   int.parse(
                                    //                                       selectedItem!)]
                                    //                               ['price']
                                    //                           : offlineProducts[
                                    //                                   int.parse(
                                    //                                       selectedItem!)]
                                    //                               ['saleprice']);
                                    //               qtyController =
                                    //                   new TextEditingController(
                                    //                       text: '1');
                                    //             }
                                    //           });
                                    //         },
                                    //         dropDownMenuItems:
                                    //             offlineProductsDropDown == []
                                    //                 ? ['']
                                    //                 : offlineProductsDropDown,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),

                                    if (unitsDrop.length > 0)
                                      Container(
                                        height: 50,
                                        width: 75,
                                        margin: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5)),
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
                                                          text: units[int.parse(
                                                              unit!)]['price']);
                                                  qtyController =
                                                      new TextEditingController(
                                                          text: '1');
                                                });
                                              }),
                                        ),
                                      ),
                                  ],
                                ),
                                // Row(
                                //   children: [
                                //     Icon(
                                //       Icons.my_library_add_outlined,
                                //       //   color: primaryColor,
                                //     ),
                                //     Expanded(
                                //       child: Container(
                                //         margin: EdgeInsets.all(2),
                                //         decoration: BoxDecoration(
                                //             color: Colors.white,
                                //             borderRadius: BorderRadius.circular(5)),
                                //         child: Padding(
                                //           padding: const EdgeInsets.only(
                                //               left: 8.0, right: 8.0),
                                //           child: TextField(
                                //             controller: qtyController,
                                //             keyboardType: TextInputType.number,
                                //             decoration: InputDecoration(
                                //                 border: InputBorder.none,
                                //                 hintText: 'Qty'),
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //     Icon(
                                //       Icons.price_change_outlined,
                                //       // color: primaryColor,
                                //     ),
                                //     Expanded(
                                //       flex: 2,
                                //       child: Container(
                                //         margin: EdgeInsets.all(2),
                                //         decoration: BoxDecoration(
                                //             color: Colors.white,
                                //             borderRadius: BorderRadius.circular(5)),
                                //         child: Padding(
                                //           padding: const EdgeInsets.only(
                                //               left: 8.0, right: 8.0),
                                //           child: TextField(
                                //             controller: priceController,
                                //             keyboardType: TextInputType.number,
                                //             decoration: InputDecoration(
                                //                 border: InputBorder.none,
                                //                 hintText: 'Price'),
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //     Padding(
                                //       padding: const EdgeInsets.only(right: 5.0),
                                //       child: Container(
                                //           height: 45,
                                //           child: ElevatedButton(
                                //               onPressed: () {
                                //                 // if (selectedCustomer == null) {
                                //                 //   Fluttertoast.showToast(
                                //                 //       msg: 'Select a Customer');
                                //                 // } else if (selectedItem == null) {
                                //                 //   Fluttertoast.showToast(
                                //                 //       msg: 'Select an Item');
                                //                 // } else if (qtyController.text.isEmpty) {
                                //                 //   Fluttertoast.showToast(
                                //                 //       msg: 'Enter Quantity');
                                //                 // } else {
                                //                 setState(() {
                                //                   double total = ((double.parse(
                                //                                   priceController
                                //                                       .text) *
                                //                               100) /
                                //                           (vatPercent * 100 + 100)) *
                                //                       double.parse(qtyController.text);

                                //                   for (var i = 0;
                                //                       i < widget.mapList.length;
                                //                       i++) {
                                //                     widget.mapList.add({
                                //                       "item_code": widget.mapList[i]
                                //                                   ["product"] ==
                                //                               null
                                //                           ? ""
                                //                           : widget.mapList[i]
                                //                               ["product"],
                                //                       "item_name": widget.mapList[i]
                                //                                   ["product"] ==
                                //                               null
                                //                           ? ""
                                //                           : widget.mapList[i]
                                //                               ["product"],

                                //                       "item_series": widget.mapList[i]
                                //                                   ["color"] ==
                                //                               null
                                //                           ? ""
                                //                           : widget.mapList[i]["color"],

                                //                       "description": widget.mapList[i]
                                //                                   ["product"] ==
                                //                               null
                                //                           ? ""
                                //                           : widget.mapList[i]
                                //                               ["product"],
                                //                       "item_group": widget.mapList[i]
                                //                                   ["product_group"] ==
                                //                               null
                                //                           ? ""
                                //                           : widget.mapList[i]
                                //                                   ["product_group"]
                                //                               .toString(),
                                //                       "image": "",
                                //                       "qty": qtyController == ""
                                //                           ? "1"
                                //                           : qtyController,
                                //                       "dealer_delivery": widget
                                //                                       .mapList[i]
                                //                                   ["dealer_price"] ==
                                //                               null
                                //                           ? ""
                                //                           : widget.mapList[i]
                                //                               ["subdealer_price"],
                                //                       "sub_dealer_": widget.mapList[i]
                                //                                   ["subdealer_price"] ==
                                //                               null
                                //                           ? ""
                                //                           : widget.mapList[i]
                                //                               ["subdealer_price"],
                                //                       "mop": widget.mapList[i]["mop"] ==
                                //                               null
                                //                           ? ""
                                //                           : widget.mapList[i]["mop"],
                                //                       "mrp": widget.mapList[i]["mrp"] ==
                                //                               null
                                //                           ? ""
                                //                           : widget.mapList[i]["mop"],
                                //                       "tax_percentage": "12",
                                //                       "uom": "Nos",
                                //                       "price_list_rate": priceController
                                //                           .text
                                //                           .toString(),
                                //                       "rate": priceController.text
                                //                           .toString(),

                                //                       "amount": double.parse(
                                //                               qtyController.text) *
                                //                           double.parse(
                                //                               priceController.text)

                                //                       // "name":
                                //                       //     name == null ? "" : name.toString(),
                                //                       // "qty": qtycontroller == ""
                                //                       //     ? "1"
                                //                       //     : qtycontroller.text.toString(),
                                //                       // "color": productseries.toString(),
                                //                       // "mopprice": mopprice.toString(),
                                //                       // "mrp": mrp.toString(),
                                //                       // "brand": brand.toString(),
                                //                       // "tax": tax.toString(),
                                //                       // "subdeler": subdealer.toString(),
                                //                       // "deler": deler.toString(),
                                //                       // "price": price.text.toString(),
                                //                     });
                                //                   }

                                //                   controllers.add(
                                //                       new TextEditingController(
                                //                           text: ((double.parse(
                                //                                           priceController
                                //                                               .text) *
                                //                                       100) /
                                //                                   (100 +
                                //                                       (vatPercent *
                                //                                           100)))
                                //                               .toStringAsFixed(2)));
                                //                 });
                                //                 WidgetsBinding.instance
                                //                     .addPostFrameCallback((_) {
                                //                   if (controller.hasClients) {
                                //                     controller.animateTo(
                                //                         controller
                                //                             .position.maxScrollExtent,
                                //                         duration:
                                //                             Duration(milliseconds: 500),
                                //                         curve: Curves.easeInOut);
                                //                   }
                                //                 });

                                //                 qtyController.clear();
                                //                 priceController.clear();
                                //                 selectedItem = null;

                                //                 offlineProductsDropDown = [];
                                //                 offlineProductsIdDropDown = [];
                                //                 itemPricesOffline = [];

                                //                 Timer(Duration(milliseconds: 200), () {
                                //                   for (var i = 0;
                                //                       i < offlineProducts.length;
                                //                       i++) {
                                //                     offlineProductsDropDown.add(
                                //                         offlineProducts[i]['name']);
                                //                     offlineProductsIdDropDown
                                //                         .add(offlineProducts[i]['id']);
                                //                     itemPricesOffline.add(i.toString());
                                //                   }
                                //                 });

                                //                 double ttl = 0;
                                //                 for (var i = 0; i < items.length; i++) {
                                //                   ttl = ttl +
                                //                       double.parse(
                                //                               controllers[i].text) *
                                //                           int.parse(items[i]['qty']!);
                                //                 }
                                //                 subTotal = ttl.toStringAsFixed(2);
                                //                 vatAmount = double.parse(subTotal) *
                                //                     double.parse(ttl.toString());
                                //                 if ((double.parse(subTotal) +
                                //                             vatAmount) %
                                //                         1 >
                                //                     0.555) {
                                //                   totalAmount =
                                //                       (double.parse(subTotal) +
                                //                           vatAmount);
                                //                 } else {
                                //                   // totalAmount =
                                //                   //     (double.parse(subTotal) +
                                //                   //             vatAmount) +
                                //                   //         double.parse("3");
                                //                 }
                                //                 //  balance = totAmount!;
                                //                 // generateQR(settings[0]['nameArabi'],
                                //                 //     settings[0]['vatnum']);
                                //               },
                                //               //},
                                //               child: Text(
                                //                 'Add',
                                //                 style:
                                //                     TextStyle(color: Colors.grey[900]),
                                //               ))),
                                //     )
                                //   ],
                                // ),
                              ],
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 14),
                                child: Container(
                                  //  color: Colors.white,
                                  height: 50,
                                  width: Constants(context).scrnWidth,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Possible Vehicle Service"),
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Container(
                                child: Column(
                                  children: [
                                    value10 == true
                                        ? Container()
                                        : Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      child: Text(
                                                        "Goods Ape",
                                                        style: TextStyle(
                                                            fontSize: 11),
                                                      ),
                                                    ),
                                                  ),
                                                  Checkbox(
                                                    value: this.valuefirst,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        this.valuefirst =
                                                            value!;
                                                        this.valuefirst == true
                                                            ? a1 = "1"
                                                            : a1 = "0";
                                                        log(value.toString());
                                                      });
                                                    },
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      child: Text("Sml Isuzu",
                                                          style: TextStyle(
                                                              fontSize: 11)),
                                                    ),
                                                  ),
                                                  Checkbox(
                                                    value: this.valuesec,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        this.valuesec = value!;
                                                        this.valuesec == true
                                                            ? a1 = "1"
                                                            : a1 = "0";
                                                        log(value.toString());
                                                      });
                                                    },
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      child: Text("Eicher",
                                                          style: TextStyle(
                                                              fontSize: 11)),
                                                    ),
                                                  ),
                                                  Checkbox(
                                                    value: this.valuethird,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        this.valuethird =
                                                            value!;
                                                        this.valuethird == true
                                                            ? a1 = "1"
                                                            : a1 = "0";
                                                        log(value.toString());
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                    value10 == true
                                        ? Container()
                                        : Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      child: Text(
                                                        "Mahindra Mini Truck",
                                                        style: TextStyle(
                                                            fontSize: 11),
                                                      ),
                                                    ),
                                                  ),
                                                  Checkbox(
                                                    value: this.valuefourth,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        this.valuefourth =
                                                            value!;
                                                        this.valuefourth == true
                                                            ? a1 = "1"
                                                            : a1 = "0";
                                                        log(value.toString());
                                                      });
                                                    },
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      child: Text(
                                                          "Mahindra Jeeto Plus",
                                                          style: TextStyle(
                                                              fontSize: 11)),
                                                    ),
                                                  ),
                                                  Checkbox(
                                                    value: this.valuefive,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        this.valuefive = value!;
                                                        this.valuefive == true
                                                            ? a1 = "1"
                                                            : a1 = "0";
                                                        log(value.toString());
                                                      });
                                                    },
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      child: Text("Tata 407",
                                                          style: TextStyle(
                                                              fontSize: 11)),
                                                    ),
                                                  ),
                                                  Checkbox(
                                                    value: this.valuesix,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        this.valuesix = value!;
                                                        this.valuesix == true
                                                            ? a1 = "1"
                                                            : a1 = "0";
                                                        log(value.toString());
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                    value10 == true
                                        ? Container()
                                        : Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      child: Text(
                                                        "Mahindra Bolero Pickups",
                                                        style: TextStyle(
                                                            fontSize: 11),
                                                      ),
                                                    ),
                                                  ),
                                                  Checkbox(
                                                    value: this.value7,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        this.value7 = value!;
                                                        this.value7 == true
                                                            ? a1 = "1"
                                                            : a1 = "0";
                                                        log(value.toString());
                                                      });
                                                    },
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      child: Text("Tata Ace",
                                                          style: TextStyle(
                                                              fontSize: 11)),
                                                    ),
                                                  ),
                                                  Checkbox(
                                                    value: this.value8,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        this.value8 = value!;
                                                        this.value8 == true
                                                            ? a1 = "1"
                                                            : a1 = "0";
                                                        log(value.toString());
                                                      });
                                                    },
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      child: Text("Bharat benz",
                                                          style: TextStyle(
                                                              fontSize: 11)),
                                                    ),
                                                  ),
                                                  Checkbox(
                                                    value: this.value9,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        this.value9 = value!;
                                                        value9 == true
                                                            ? a1 = "1"
                                                            : a1 = "0";
                                                        log(value.toString());
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 60,
                                              child: Text("All",
                                                  style:
                                                      TextStyle(fontSize: 11)),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                child: Checkbox(
                                                  value: this.value10,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      this.value10 = value!;
                                                      this.value10 == true
                                                          ? a1 = "1"
                                                          : a1 = "0";
                                                      value9 = false;
                                                      value8 = false;
                                                      value7 = false;
                                                      valuesix = false;
                                                      valuefive = false;
                                                      valuefourth = false;
                                                      valuethird = false;
                                                      valuesec = false;
                                                      value = false;
                                                      log(value.toString());
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: Text("",
                                                    style: TextStyle(
                                                        fontSize: 11)),
                                              ),
                                            ),
                                            Container(),
                                            // Checkbox(
                                            //   value: this.value8,
                                            //   onChanged: (bool? value) {
                                            //     setState(() {
                                            //       this.value8 = value!;
                                            //       log(value.toString());
                                            //     });
                                            //   },
                                            // ),
                                            Expanded(
                                              child: Container(
                                                child: Text("",
                                                    style: TextStyle(
                                                        fontSize: 11)),
                                              ),
                                            ),
                                            Container()
                                          ],
                                        ),
                                      ),
                                    ),

                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Container(
                                    //     child: Row(
                                    //       children: [
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                // Icon(
                                //   Icons.person_add,
                                //   color: Colors.black,
                                //   size: 17,
                                // ),

                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 00, left: 6, right: 6),
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 90,
                                              margin: EdgeInsets.all(0),
                                              decoration: BoxDecoration(
                                                // border: Border.all(
                                                //     color: Colors.blue, // Set border color
                                                //     width: 1.0),
                                                color: Colors.white,
                                                //    borderRadius: BorderRadius.circular(20)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0, right: 8.0),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Container(
                                                    height: 80,
                                                    child: TextField(
                                                      controller: descontroller,
                                                      // controller: ledgernameController,
                                                      maxLines: 5,
                                                      cursorColor: Colors.black,
                                                      // maxLength: 140,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Notes",
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // Expanded(
                                //   child: Container(
                                //       // child: Center(
                                //       // child:
                                //       ),
                                // ),
                              ],
                            ),
                            // ExpansionTile(
                            //   title: Text(
                            //     'Bill Details',
                            //     style: TextStyle(color: Colors.black),
                            //   ),
                            //   children: [
                            //     Row(
                            //       children: [
                            //         Expanded(
                            //           child: Container(
                            //             margin: EdgeInsets.all(2),
                            //             decoration: BoxDecoration(
                            //                 color: Colors.white,
                            //                 borderRadius: BorderRadius.circular(5)),
                            //             child: Column(
                            //               crossAxisAlignment:
                            //                   CrossAxisAlignment.start,
                            //               children: [
                            //                 Padding(
                            //                   padding: const EdgeInsets.all(4.0),
                            //                   child: Text(
                            //                     'SUB TOTAL',
                            //                     style: TextStyle(
                            //                       fontSize: 10,
                            //                       // color: secondaryColor[300]
                            //                     ),
                            //                   ),
                            //                 ),
                            //                 Padding(
                            //                   padding: const EdgeInsets.only(
                            //                       bottom: 4.0, left: 4.0),
                            //                   child: Text(
                            //                     subTotal,
                            //                     style: TextStyle(
                            //                         fontSize: 15,
                            //                         color: Colors.grey[900],
                            //                         fontWeight: FontWeight.w700),
                            //                   ),
                            //                 )
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //         // Expanded(
                            //         //   child: Container(
                            //         //     height: 41,
                            //         //     margin: EdgeInsets.all(2),
                            //         //     decoration: BoxDecoration(
                            //         //         color: Colors.white,
                            //         //         borderRadius: BorderRadius.circular(5)),
                            //         //     child: Column(
                            //         //       crossAxisAlignment:
                            //         //           CrossAxisAlignment.start,
                            //         //       mainAxisSize: MainAxisSize.min,
                            //         //       children: [
                            //         //         Expanded(
                            //         //           child: Padding(
                            //         //             padding:
                            //         //                 const EdgeInsets.only(left: 4.0),
                            //         //             child: TextField(
                            //         //               controller: discountController,
                            //         //               keyboardType: TextInputType.number,
                            //         //               decoration: InputDecoration(
                            //         //                   hintText: 'Discount',
                            //         //                   hintStyle: TextStyle(
                            //         //                       fontWeight:
                            //         //                           FontWeight.normal),
                            //         //                   border: InputBorder.none),
                            //         //               style: TextStyle(
                            //         //                   fontSize: 15,
                            //         //                   color: Colors.grey[900],
                            //         //                   fontWeight: FontWeight.w700),
                            //         //               onChanged: (value) {
                            //         //                 setState(() {
                            //         //                   if (discountController
                            //         //                       .text.isNotEmpty) {
                            //         //                     vatAmount = (double.parse(
                            //         //                                 subTotal) -
                            //         //                             double.parse(value)) *
                            //         //                         vatPercent;

                            //         //                     totalAmount = vatAmount +
                            //         //                         (double.parse(subTotal) -
                            //         //                             double.parse(
                            //         //                                 discountController
                            //         //                                     .text));
                            //         //                   } else {
                            //         //                     vatAmount =
                            //         //                         double.parse(subTotal) *
                            //         //                             vatPercent;
                            //         //                     totalAmount = vatAmount +
                            //         //                         double.parse(subTotal);
                            //         //                   }
                            //         //                 });
                            //         //               },
                            //         //             ),
                            //         //           ),
                            //         //         )
                            //         //       ],
                            //         //     ),
                            //         //   ),
                            //         // ),
                            //       ],
                            //     ),
                            //     Row(
                            //       children: [
                            //         if (vatPercent != 0)
                            //           Expanded(
                            //             child: Container(
                            //               margin: EdgeInsets.all(2),
                            //               decoration: BoxDecoration(
                            //                   color: Colors.white,
                            //                   borderRadius: BorderRadius.circular(5)),
                            //               child: Column(
                            //                 crossAxisAlignment:
                            //                     CrossAxisAlignment.start,
                            //                 children: [
                            //                   Padding(
                            //                     padding: const EdgeInsets.all(4.0),
                            //                     child: Text(
                            //                       'VAT AMOUNT',
                            //                       style: TextStyle(
                            //                         fontSize: 10,
                            //                         // color: secondaryColor[300]
                            //                       ),
                            //                     ),
                            //                   ),
                            //                   Padding(
                            //                     padding: const EdgeInsets.only(
                            //                         bottom: 4.0, left: 4.0),
                            //                     child: Text(
                            //                       vatAmount.toStringAsFixed(2),
                            //                       style: TextStyle(
                            //                           fontSize: 15,
                            //                           color: Colors.grey[900],
                            //                           fontWeight: FontWeight.w700),
                            //                     ),
                            //                   )
                            //                 ],
                            //               ),
                            //             ),
                            //           ),
                            //         // Expanded(
                            //         //   child: Container(
                            //         //     margin: EdgeInsets.all(2),
                            //         //     decoration: BoxDecoration(
                            //         //         color: Colors.white,
                            //         //         borderRadius: BorderRadius.circular(5)),
                            //         //     child: Column(
                            //         //       crossAxisAlignment:
                            //         //           CrossAxisAlignment.start,
                            //         //       children: [
                            //         //         Padding(
                            //         //           padding: const EdgeInsets.all(4.0),
                            //         //           child: Text(
                            //         //             'PREVIOUS BALANCE',
                            //         //             style: TextStyle(
                            //         //               fontSize: 10,
                            //         //               // color: secondaryColor[300]
                            //         //             ),
                            //         //           ),
                            //         //         ),
                            //         //         Padding(
                            //         //           padding: const EdgeInsets.only(
                            //         //               bottom: 4.0, left: 4.0),
                            //         //           child: Text(
                            //         //             "3",
                            //         //             style: TextStyle(
                            //         //                 fontSize: 15,
                            //         //                 color: Colors.grey[900],
                            //         //                 fontWeight: FontWeight.w700),
                            //         //           ),
                            //         //         )
                            //         //       ],
                            //         //     ),
                            //         //   ),
                            //         // ),
                            //       ],
                            //     ),
                            //     Row(
                            //       children: [
                            //         Expanded(
                            //           child: Container(
                            //             margin: EdgeInsets.all(2),
                            //             decoration: BoxDecoration(
                            //                 color: Colors.white,
                            //                 borderRadius: BorderRadius.circular(5)),
                            //             child: Column(
                            //               crossAxisAlignment:
                            //                   CrossAxisAlignment.start,
                            //               children: [
                            //                 Padding(
                            //                   padding: const EdgeInsets.all(4.0),
                            //                   child: Text(
                            //                     'TAX AMOUNT',
                            //                     style: TextStyle(
                            //                       fontSize: 10,
                            //                       //   color: secondaryColor[300]
                            //                     ),
                            //                   ),
                            //                 ),
                            //                 Padding(
                            //                   padding: const EdgeInsets.only(
                            //                       bottom: 4.0, left: 4.0),
                            //                   child: Text(
                            //                     totAmount == null
                            //                         ? "0"
                            //                         : totAmount!.toStringAsFixed(2),
                            //                     style: TextStyle(
                            //                         fontSize: 15,
                            //                         color: Colors.grey[900],
                            //                         fontWeight: FontWeight.w700),
                            //                   ),
                            //                 )
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //         // Expanded(
                            //         //   child: Container(
                            //         //     height: 41,
                            //         //     margin: EdgeInsets.all(2),
                            //         //     decoration: BoxDecoration(
                            //         //         color: Colors.white,
                            //         //         borderRadius: BorderRadius.circular(5)),
                            //         //     child: Column(
                            //         //       crossAxisAlignment:
                            //         //           CrossAxisAlignment.start,
                            //         //       mainAxisSize: MainAxisSize.min,
                            //         //       children: [
                            //         //         Expanded(
                            //         //           child: Padding(
                            //         //             padding:
                            //         //                 const EdgeInsets.only(left: 4.0),
                            //         //             child: TextField(
                            //         //               controller: recBalanceController,
                            //         //               keyboardType: TextInputType.number,
                            //         //               decoration: InputDecoration(
                            //         //                   hintText: 'Received',
                            //         //                   hintStyle: TextStyle(
                            //         //                       fontWeight:
                            //         //                           FontWeight.normal),
                            //         //                   border: InputBorder.none),
                            //         //               onChanged: (value) {
                            //         //                 setState(() {
                            //         //                   if (recBalanceController
                            //         //                       .text.isNotEmpty) {
                            //         //                     balance = totalAmount -
                            //         //                         double.parse(value);
                            //         //                   } else {
                            //         //                     balance = totalAmount;
                            //         //                   }
                            //         //                 });
                            //         //               },
                            //         //               style: TextStyle(
                            //         //                   fontSize: 18,
                            //         //                   color: Colors.grey[900],
                            //         //                   fontWeight: FontWeight.w600),
                            //         //             ),
                            //         //           ),
                            //         //         )
                            //         //       ],
                            //         //     ),
                            //         //   ),
                            //         // ),
                            //       ],
                            //     ),
                            //     Row(
                            //       children: [
                            //         Expanded(
                            //           child: Container(
                            //             margin: EdgeInsets.all(2),
                            //             decoration: BoxDecoration(
                            //                 color: Colors.white,
                            //                 borderRadius: BorderRadius.circular(5)),
                            //             child: Column(
                            //               crossAxisAlignment:
                            //                   CrossAxisAlignment.start,
                            //               children: [
                            //                 Padding(
                            //                   padding: const EdgeInsets.all(4.0),
                            //                   child: Text(
                            //                     'TOTAL',
                            //                     style: TextStyle(
                            //                       fontSize: 9,
                            //                       //   color: secondaryColor[300]
                            //                     ),
                            //                   ),
                            //                 ),
                            //                 Padding(
                            //                   padding: const EdgeInsets.only(
                            //                       bottom: 4.0, left: 4.0),
                            //                   child: Text(
                            //                     balance.toStringAsFixed(2),
                            //                     style: TextStyle(
                            //                         fontSize: 15,
                            //                         color: Colors.grey[900],
                            //                         fontWeight: FontWeight.w700),
                            //                   ),
                            //                 )
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //         // Expanded(
                            //         //   child: Container(
                            //         //     height: 40,
                            //         //     margin: EdgeInsets.all(2),
                            //         //     decoration: BoxDecoration(
                            //         //         color: Colors.white,
                            //         //         borderRadius: BorderRadius.circular(5)),
                            //         //     child: Padding(
                            //         //       padding: const EdgeInsets.only(
                            //         //           left: 8.0, right: 8.0),
                            //         //       child: DropdownButton(
                            //         //         items: [
                            //         //           DropdownMenuItem(
                            //         //               child: Text('Cash'), value: 'Cash'),
                            //         //           DropdownMenuItem(
                            //         //               child: Text('Bank'), value: 'Bank'),
                            //         //           DropdownMenuItem(
                            //         //               child: Text('Credit'),
                            //         //               value: 'Credit')
                            //         //         ],
                            //         //         isExpanded: true,
                            //         //         underline: Container(),
                            //         //         hint: Text('Select Ledger'),
                            //         //         value: selectedLedger,
                            //         //         onChanged: (String? value) async {
                            //         //           setState(() {
                            //         //             selectedLedger = value;
                            //         //             if (value == 'Credit') {
                            //         //               recBalanceController.text = '0.0';
                            //         //             }
                            //         //             FocusScope.of(context).unfocus();
                            //         //           });

                            //         //           log('$selectedLedger');
                            //         //         },
                            //         //       ),
                            //         //     ),
                            //         //   ),
                            //         // ),
                            //       ],
                            //     ),
                            //     // Row(
                            //     //   children: [
                            //     //     Expanded(
                            //     //       child: Container(
                            //     //         height: 40,
                            //     //         margin: EdgeInsets.all(2),
                            //     //         child: ElevatedButton(
                            //     //             onPressed: () async {
                            //     //               renderImage();
                            //     //             },
                            //     //             child: Text('SUBMIT')),
                            //     //       ),
                            //     //     ),
                            //     //   ],
                            //     // ),
                            //     Divider(color: Colors.transparent)
                            //   ],
                            // ),

                            Row(
                              children: [
                                // Icon(
                                //   Icons.person_add,
                                //   color: Colors.black,
                                //   size: 17,
                                // ),
                                if (vehicledrop ==
                                    "Limited vehicle permissible")
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 00),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  "Type of vehicle go to site",
                                                  style: TextStyle(
                                                    color: Colors.grey[700],
                                                    fontSize: 14,
                                                    // fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 50,
                                              margin: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                // border: Border.all(
                                                //     color: Colors.blue, // Set border color
                                                //     width: 1.0),
                                                color: Colors.white,
                                                //    borderRadius: BorderRadius.circular(20)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0, right: 8.0),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: TextField(
                                                    // controller: qtycontroller,
                                                    controller: veh,
                                                    textAlign: TextAlign.left,
                                                    keyboardType:
                                                        TextInputType.name,
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          "type of vehicle",
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                // Expanded(
                                //   child: Container(
                                //       // child: Center(
                                //       // child:
                                //       ),
                                // ),

                                //   Expanded(
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: Padding(
                                //         padding: const EdgeInsets.only(top: 20),
                                //         child: Column(
                                //           crossAxisAlignment: CrossAxisAlignment.start,
                                //           children: [
                                //             Padding(
                                //               padding: const EdgeInsets.all(8.0),
                                //               child: Padding(
                                //                 padding:
                                //                     const EdgeInsets.only(left: 8.0),
                                //                 child: Text(
                                //                   "",
                                //                   style: TextStyle(
                                //                     color: Colors.grey[700],
                                //                     fontSize: 14,
                                //                     // fontWeight: FontWeight.bold
                                //                   ),
                                //                 ),
                                //               ),
                                //             ),
                                //             GestureDetector(
                                //               onTap: () {},
                                //               child: Container(
                                //                 height: 50,
                                //                 width: 200,
                                //                 // margin: EdgeInsets.all(5),
                                //                 decoration: BoxDecoration(
                                //                     // border: Border.all(
                                //                     //     color: Colors.blue, // Set border color
                                //                     //     width: 1.0),
                                //                     //    color: Colors.grey[50],
                                //                     //    borderRadius: BorderRadius.circular(20)
                                //                     ),
                                //                 child: Padding(
                                //                   padding: const EdgeInsets.only(),
                                //                   child: Align(
                                //                     //alignment: Alignment.centerLeft,
                                //                     child: Row(
                                //                       children: [
                                //                         // SizedBox(
                                //                         //   height: 10,
                                //                         // ),
                                //                         //Icon(Icons.add_rounded),

                                //                         productseries == null
                                //                             ? Container()
                                //                             : Expanded(
                                //                                 child: Card(
                                //                                     child: Container(
                                //                                         height: 70,
                                //                                         //  width: 150,
                                //                                         color: Colors
                                //                                             .white,
                                //                                         child: Padding(
                                //                                           padding:
                                //                                               const EdgeInsets
                                //                                                       .all(
                                //                                                   8.0),
                                //                                           child: Text(
                                //                                               productseries
                                //                                                   .toString()),
                                //                                         ))),
                                //                               )
                                //                       ],
                                //                     ),
                                //                   ),
                                //                 ),
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                              ],
                            ),
                            if (items.length > 0)
                              ExpansionTile(
                                title: Text(
                                  'Bill Details',
                                  style: TextStyle(color: Colors.black),
                                ),
                                children: [
                                  Row(
                                    children: [
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
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  'SUB TOTAL',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    // color: secondaryColor[300]
                                                  ),
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
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Expanded(
                                      //   child: Container(
                                      //     height: 41,
                                      //     margin: EdgeInsets.all(2),
                                      //     decoration: BoxDecoration(
                                      //         color: Colors.white,
                                      //         borderRadius: BorderRadius.circular(5)),
                                      //     child: Column(
                                      //       crossAxisAlignment:
                                      //           CrossAxisAlignment.start,
                                      //       mainAxisSize: MainAxisSize.min,
                                      //       children: [
                                      //         Expanded(
                                      //           child: Padding(
                                      //             padding:
                                      //                 const EdgeInsets.only(left: 4.0),
                                      //             child: TextField(
                                      //               controller: discountController,
                                      //               keyboardType: TextInputType.number,
                                      //               decoration: InputDecoration(
                                      //                   hintText: 'Discount',
                                      //                   hintStyle: TextStyle(
                                      //                       fontWeight:
                                      //                           FontWeight.normal),
                                      //                   border: InputBorder.none),
                                      //               style: TextStyle(
                                      //                   fontSize: 15,
                                      //                   color: Colors.grey[900],
                                      //                   fontWeight: FontWeight.w700),
                                      //               onChanged: (value) {
                                      //                 setState(() {
                                      //                   if (discountController
                                      //                       .text.isNotEmpty) {
                                      //                     vatAmount = (double.parse(
                                      //                                 subTotal) -
                                      //                             double.parse(value)) *
                                      //                         vatPercent;

                                      //                     totalAmount = vatAmount +
                                      //                         (double.parse(subTotal) -
                                      //                             double.parse(
                                      //                                 discountController
                                      //                                     .text));
                                      //                   } else {
                                      //                     vatAmount =
                                      //                         double.parse(subTotal) *
                                      //                             vatPercent;
                                      //                     totalAmount = vatAmount +
                                      //                         double.parse(subTotal);
                                      //                   }
                                      //                 });
                                      //               },
                                      //             ),
                                      //           ),
                                      //         )
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),
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
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    'VAT AMOUNT',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      // color: secondaryColor[300]
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 4.0,
                                                          left: 4.0),
                                                  child: Text(
                                                    vatAmount
                                                        .toStringAsFixed(2),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.grey[900],
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      // Expanded(
                                      //   child: Container(
                                      //     margin: EdgeInsets.all(2),
                                      //     decoration: BoxDecoration(
                                      //         color: Colors.white,
                                      //         borderRadius: BorderRadius.circular(5)),
                                      //     child: Column(
                                      //       crossAxisAlignment:
                                      //           CrossAxisAlignment.start,
                                      //       children: [
                                      //         Padding(
                                      //           padding: const EdgeInsets.all(4.0),
                                      //           child: Text(
                                      //             'PREVIOUS BALANCE',
                                      //             style: TextStyle(
                                      //               fontSize: 10,
                                      //               // color: secondaryColor[300]
                                      //             ),
                                      //           ),
                                      //         ),
                                      //         Padding(
                                      //           padding: const EdgeInsets.only(
                                      //               bottom: 4.0, left: 4.0),
                                      //           child: Text(
                                      //             "3",
                                      //             style: TextStyle(
                                      //                 fontSize: 15,
                                      //                 color: Colors.grey[900],
                                      //                 fontWeight: FontWeight.w700),
                                      //           ),
                                      //         )
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  Row(
                                    children: [
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
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  'TAX AMOUNT',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    //   color: secondaryColor[300]
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 4.0, left: 4.0),
                                                child: Text(
                                                  totAmount == null
                                                      ? "0"
                                                      : totAmount!
                                                          .toStringAsFixed(2),
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey[900],
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Expanded(
                                      //   child: Container(
                                      //     height: 41,
                                      //     margin: EdgeInsets.all(2),
                                      //     decoration: BoxDecoration(
                                      //         color: Colors.white,
                                      //         borderRadius: BorderRadius.circular(5)),
                                      //     child: Column(
                                      //       crossAxisAlignment:
                                      //           CrossAxisAlignment.start,
                                      //       mainAxisSize: MainAxisSize.min,
                                      //       children: [
                                      //         Expanded(
                                      //           child: Padding(
                                      //             padding:
                                      //                 const EdgeInsets.only(left: 4.0),
                                      //             child: TextField(
                                      //               controller: recBalanceController,
                                      //               keyboardType: TextInputType.number,
                                      //               decoration: InputDecoration(
                                      //                   hintText: 'Received',
                                      //                   hintStyle: TextStyle(
                                      //                       fontWeight:
                                      //                           FontWeight.normal),
                                      //                   border: InputBorder.none),
                                      //               onChanged: (value) {
                                      //                 setState(() {
                                      //                   if (recBalanceController
                                      //                       .text.isNotEmpty) {
                                      //                     balance = totalAmount -
                                      //                         double.parse(value);
                                      //                   } else {
                                      //                     balance = totalAmount;
                                      //                   }
                                      //                 });
                                      //               },
                                      //               style: TextStyle(
                                      //                   fontSize: 18,
                                      //                   color: Colors.grey[900],
                                      //                   fontWeight: FontWeight.w600),
                                      //             ),
                                      //           ),
                                      //         )
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  Row(
                                    children: [
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
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  'TOTAL',
                                                  style: TextStyle(
                                                    fontSize: 9,
                                                    //   color: secondaryColor[300]
                                                  ),
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
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Expanded(
                                      //   child: Container(
                                      //     height: 40,
                                      //     margin: EdgeInsets.all(2),
                                      //     decoration: BoxDecoration(
                                      //         color: Colors.white,
                                      //         borderRadius: BorderRadius.circular(5)),
                                      //     child: Padding(
                                      //       padding: const EdgeInsets.only(
                                      //           left: 8.0, right: 8.0),
                                      //       child: DropdownButton(
                                      //         items: [
                                      //           DropdownMenuItem(
                                      //               child: Text('Cash'), value: 'Cash'),
                                      //           DropdownMenuItem(
                                      //               child: Text('Bank'), value: 'Bank'),
                                      //           DropdownMenuItem(
                                      //               child: Text('Credit'),
                                      //               value: 'Credit')
                                      //         ],
                                      //         isExpanded: true,
                                      //         underline: Container(),
                                      //         hint: Text('Select Ledger'),
                                      //         value: selectedLedger,
                                      //         onChanged: (String? value) async {
                                      //           setState(() {
                                      //             selectedLedger = value;
                                      //             if (value == 'Credit') {
                                      //               recBalanceController.text = '0.0';
                                      //             }
                                      //             FocusScope.of(context).unfocus();
                                      //           });

                                      //           log('$selectedLedger');
                                      //         },
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Expanded(
                                  //       child: Container(
                                  //         height: 40,
                                  //         margin: EdgeInsets.all(2),
                                  //         child: ElevatedButton(
                                  //             onPressed: () async {
                                  //               renderImage();
                                  //             },
                                  //             child: Text('SUBMIT')),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
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
                                                        child: HeadingText(
                                                            'Item')))),
                                            CustomDividerVertical(),
                                            Expanded(
                                                child: Container(
                                                    child: Center(
                                                        child: HeadingText(
                                                            'Price')))),
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
                                                child: HeadingText('mop'),
                                              ),
                                            ),
                                            CustomDividerVertical(),
                                            Container(
                                              width: 60,
                                              child: Center(
                                                child: HeadingText('mrp'),
                                              ),
                                            ),
                                            CustomDividerVertical(),
                                            Container(
                                              width: 60,
                                              child: Center(
                                                child: HeadingText('Qty'),
                                              ),
                                            ),
                                            CustomDividerVertical(),
                                            Container(
                                              width: 60,
                                              child: Center(
                                                child: HeadingText('Tax'),
                                              ),
                                            ),
                                            CustomDividerVertical(),
                                            Container(
                                              width: 60,
                                              child: Center(
                                                child: HeadingText(
                                                  'Without tax rate',
                                                ),
                                              ),
                                            ),
                                            CustomDividerVertical(),
                                            Container(
                                              width: 60,
                                              child: Center(
                                                child: HeadingText(
                                                  'Subdealer price',
                                                ),
                                              ),
                                            ),
                                            CustomDividerVertical(),
                                            Container(
                                              width: 60,
                                              child: Center(
                                                child:
                                                    HeadingText('Dealer price'),
                                              ),
                                            ),
                                            CustomDividerVertical(),
                                            Expanded(
                                                child: Container(
                                                    child: Center(
                                                        child: HeadingText(
                                                            'Total')))),
                                            // CustomDividerVertical(),
                                            // Expanded(
                                            //     child: Container(
                                            //         child: Center(
                                            //             child: HeadingText(
                                            //                 'Without tax amount')))),
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
                                              itemBuilder: (ctx, index) {
                                                controllers.add(
                                                    new TextEditingController());
                                                return Column(
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
                                                                  (index + 1)
                                                                      .toString()),
                                                            ),
                                                          ),
                                                          CustomDividerVertical(),
                                                          Expanded(
                                                              flex: 2,
                                                              child: Container(
                                                                  child: Center(
                                                                      child: ListText(
                                                                          items[index]
                                                                              [
                                                                              'Item'])))),
                                                          CustomDividerVertical(),
                                                          Expanded(
                                                              child: Container(
                                                                  child: Center(
                                                                      child:
                                                                          TextField(
                                                            style: TextStyle(
                                                                fontSize: 11),
                                                            controller:
                                                                controllers[
                                                                    index],
                                                            decoration:
                                                                InputDecoration(
                                                                    hintText:
                                                                        "0"),
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            onTap: () {
                                                              controllers[index]
                                                                      .selection =
                                                                  TextSelection(
                                                                      baseOffset:
                                                                          0,
                                                                      extentOffset: controllers[
                                                                              index]
                                                                          .value
                                                                          .text
                                                                          .length);
                                                            },
                                                            onChanged: (value) {
                                                              if (value
                                                                  .isEmpty) {
                                                                setState(() {
                                                                  va = true;
                                                                });
                                                                print(value
                                                                        .toString() +
                                                                    '--empty');
                                                                // controllers[index].text =
                                                                //     offlineProducts[int.parse(
                                                                //             selectedItem!)]
                                                                //         ['saleprice'];
                                                              } else {
                                                                setState(() {
                                                                  subTotal =
                                                                      '0.0';
                                                                  vatAmount =
                                                                      0.0;
                                                                  totalAmount =
                                                                      0.0;

                                                                  items[index][
                                                                      'vprice'] = (double.parse(
                                                                              value) +
                                                                          double.parse(value) *
                                                                              vatPercent)
                                                                      .toStringAsFixed(
                                                                          2);
                                                                  items[index][
                                                                          'price'] =
                                                                      controllers[
                                                                              index]
                                                                          .text;

                                                                  // with_tax_amount
                                                                  items[index][
                                                                      'total'] = (double.parse(
                                                                              value) *
                                                                          double.parse(items[index]
                                                                              [
                                                                              'qty']!))
                                                                      .toStringAsFixed(
                                                                          2);
                                                                  double a = 100 +
                                                                      double.parse(
                                                                          items[index]
                                                                              [
                                                                              'tax']!);
                                                                  double b =
                                                                      double.parse(
                                                                              value) *
                                                                          100;

                                                                  var tot = items[
                                                                          index]
                                                                      [
                                                                      'with_tax_rate'] = (b /
                                                                          a).toStringAsFixed(2);
                                                                  print(
                                                                      'rate|||||' +
                                                                          tot);
                                                                  items[index][
                                                                      'with_tax_amount'] = (double.parse(
                                                                              tot) *
                                                                          double.parse(items[index]
                                                                              [
                                                                              'qty']!))
                                                                      .toStringAsFixed(
                                                                          2);
                                                                  print('amount234--' +
                                                                      items[index]
                                                                              [
                                                                              'with_tax_amount']
                                                                          .toString());
                                                                  suTotal = items[
                                                                          index]
                                                                      [
                                                                      'total'] = (double.parse(
                                                                              value) *
                                                                          double.parse(items[index]
                                                                              [
                                                                              'qty']!))
                                                                      .toStringAsFixed(
                                                                          2);
                                                                  for (var i =
                                                                          0;
                                                                      i <
                                                                          items
                                                                              .length;
                                                                      i++) {
                                                                    if (controllers[
                                                                            i]
                                                                        .text
                                                                        .isEmpty) {
                                                                      subTotal =
                                                                          suTotal
                                                                              .toString();
                                                                    } else {
                                                                      subTotal =
                                                                          (double.parse(subTotal) + double.parse(controllers[i].text) * double.parse(items[i]['qty']!))
                                                                              .toStringAsFixed(2);
                                                                    }
                                                                    vatAmount =
                                                                        totalAmount +
                                                                            double.parse(subTotal);

                                                                    totAmount = subTotal ==
                                                                            "0"
                                                                        ? 0 * 12
                                                                        : double.parse(subTotal) *
                                                                                0.12 +
                                                                            totalAmount;
                                                                    (double.parse(
                                                                            subTotal) +
                                                                        vatAmount);
                                                                    balance = double.parse(
                                                                            subTotal) +
                                                                        totAmount!;
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
                                                                        child: ListText(vatPercent >
                                                                                0
                                                                            ? items[index]['vprice']
                                                                            : items[index]['price'])))),
                                                          CustomDividerVertical(),
                                                          Container(
                                                            width: 50,
                                                            child: Center(
                                                              child: ListText(
                                                                  items[index]
                                                                      ['qty']),
                                                            ),
                                                          ),
                                                          CustomDividerVertical(),
                                                          Container(
                                                            width: 60,
                                                            child: Center(
                                                              child: ListText(
                                                                  items[index]
                                                                      ['mop']),
                                                            ),
                                                          ),
                                                          CustomDividerVertical(),
                                                          Container(
                                                            width: 60,
                                                            child: Center(
                                                              child: ListText(
                                                                  items[index]
                                                                      ['mrp']),
                                                            ),
                                                          ),
                                                          CustomDividerVertical(),
                                                          Container(
                                                            width: 60,
                                                            child: Center(
                                                              child: ListText(
                                                                  items[index]
                                                                      ['qty']),
                                                            ),
                                                          ),
                                                          CustomDividerVertical(),
                                                          Container(
                                                            width: 60,
                                                            child: Center(
                                                              child: ListText(
                                                                  items[index]
                                                                      ['tax']),
                                                            ),
                                                          ),
                                                          CustomDividerVertical(),
                                                          Container(
                                                            width: 60,
                                                            child: Center(
                                                              child: ListText(
                                                                  items[index][
                                                                      'with_tax_rate']),
                                                            ),
                                                          ),
                                                          CustomDividerVertical(),
                                                          Container(
                                                            width: 60,
                                                            child: Center(
                                                              child: ListText(
                                                                  items[index][
                                                                      'sub_dealer_price']),
                                                            ),
                                                          ),
                                                          CustomDividerVertical(),
                                                          Container(
                                                            width: 60,
                                                            child: Center(
                                                              child: ListText(
                                                                  items[index][
                                                                      'dealer_price']),
                                                            ),
                                                          ),
                                                          CustomDividerVertical(),
                                                          CustomDividerVertical(),
                                                          Expanded(
                                                              child: Container(
                                                                  child: Center(
                                                                      child: ListText(items[index]
                                                                              [
                                                                              'total']
                                                                          .toString())))),
                                                          CustomDividerVertical(),
                                                          // Expanded(
                                                          //     child: Container(
                                                          //         child: Center(
                                                          //             child: ListText(items[index]
                                                          //                     [
                                                          //                     'with_tax_amount']
                                                          //                 .toString())))),
                                                          // CustomDividerVertical(),
                                                          Container(
                                                            width: 40,
                                                            child: Center(
                                                              child: IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    double ttl =
                                                                        0;
                                                                    setState(
                                                                        () {
                                                                      items.removeAt(
                                                                          index);
                                                                      controllers
                                                                          .removeAt(
                                                                              index);
                                                                      for (var i =
                                                                              0;
                                                                          i < items.length;
                                                                          i++) {
                                                                        ttl = ttl +
                                                                            double.parse(items[i]['total']!);
                                                                      }
                                                                      subTotal =
                                                                          ttl.toStringAsFixed(
                                                                              2);
                                                                    });
                                                                  },
                                                                  icon: Icon(
                                                                    Icons
                                                                        .delete,
                                                                    // color: primaryColor,
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
                                                );
                                              })),
                                    ],
                                  ),
                                ),
                              )),
                            Divider(),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // SizedBox(
                                        //   height: 30,
                                        // ),
                                        Container(
                                          height: 50,
                                          width: Constants(context).scrnWidth,
                                          child: ElevatedButton(
                                            child: Text(
                                              'SAVE QUOTATION',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              primary: Color.fromARGB(
                                                  255, 15, 46, 148),
                                              // side: BorderSide(color: Colors.yellow, width: 5),
                                              textStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontStyle: FontStyle.normal),
                                            ),
                                            onPressed: () {
                                              log("hii");
                                              setState(() {
                                                mapLis.clear();
                                              });

                                              for (var i = 0;
                                                  i < items.length;
                                                  i++) {
                                                //  log(widget.mapList[i]["product"]);
                                                log(
                                                  controllers[i]
                                                      .text
                                                      .toString(),
                                                );
                                                controlind = controllers[i]
                                                    .text
                                                    .toString();
                                                log(controlind);

                                                mapLis.add({
                                                  "item_code":
                                                      items[i]["Item"] == null
                                                          ? ""
                                                          : items[i]["Item"],
                                                  "item_name":
                                                      items[i]["Item"] == null
                                                          ? ""
                                                          : items[i]["Item"],

                                                  "item_series": items[i]
                                                              ["item_series"] ==
                                                          null
                                                      ? ""
                                                      : items[i]["item_series"],

                                                  "description":
                                                      items[i]["Item"] == null
                                                          ? ""
                                                          : items[i]["Item"],
                                                  "item_group": items[i]
                                                              ["item_group"] ==
                                                          null
                                                      ? ""
                                                      : items[i]["item_group"]
                                                          .toString(),
                                                  "image": widget.mapList[i]
                                                      ["image"],
                                                  "qty": items[i]["qty"] == null
                                                      ? ""
                                                      : items[i]["qty"]
                                                          .toString(),
                                                  "dealer_delivery": items[i][
                                                              "dealer_price"] ==
                                                          null
                                                      ? ""
                                                      : widget.mapList[i]
                                                          ["dealer_price"],
                                                  "sub_dealer_price": items[i][
                                                              "sub_dealer_price"] ==
                                                          null
                                                      ? ""
                                                      : items[i]
                                                          ["sub_dealer_price"],
                                                  "mop": items[i]["mop"] == null
                                                      ? ""
                                                      : items[i]["mop"],
                                                  "mrp": items[i]["mrp"] == null
                                                      ? ""
                                                      : items[i]["mop"],
                                                  "tax_percentage": "12",
                                                  "uom": "Nos",
                                                  "price_list_rate": items[i][
                                                              "with_tax_rate"] ==
                                                          null
                                                      ? ""
                                                      : items[i]
                                                              ["with_tax_rate"]
                                                          .toString(),
                                                  "rate": items[i][
                                                              "with_tax_rate"] ==
                                                          null
                                                      ? ""
                                                      : items[i]
                                                              ["with_tax_rate"]
                                                          .toString(),
                                                  "with_tax_rate":
                                                      controllers[i].text == ""
                                                          ? "0"
                                                          : controllers[i].text,
                                                  "amount": items[i][
                                                              "with_tax_amount"] ==
                                                          null
                                                      ? ""
                                                      : items[i][
                                                              "with_tax_amount"]
                                                          .toString(),
                                                  "with_tax_amount":
                                                      items[i]["total"] == null
                                                          ? ""
                                                          : items[i]["total"]
                                                              .toString(),

                                                  // "name":
                                                  //     name == null ? "" : name.toString(),
                                                  // "qty": qtycontroller == ""
                                                  //     ? "1"
                                                  //     : qtycontroller.text.toString(),
                                                  // "color": productseries.toString(),
                                                  // "mopprice": mopprice.toString(),
                                                  // "mrp": mrp.toString(),
                                                  // "brand": brand.toString(),
                                                  // "tax": tax.toString(),
                                                  // "subdeler": subdealer.toString(),
                                                  // "deler": deler.toString(),
                                                  // "price": price.text.toString(),
                                                });
                                              }
                                              var c;
                                              setState(() {
                                                for (var i = 0;
                                                    i < controllers.length;
                                                    i++) {
                                                  if (controllers[i]
                                                          .text
                                                          .toString() ==
                                                      "0") {
                                                    va = true;
                                                  }
                                                  print(controllers
                                                          .toList()
                                                          .toString() +
                                                      'ooop');
                                                  // va = controllers[i]
                                                  //             .text
                                                  //             .toString() ==
                                                  //         "0"
                                                  //     ? true
                                                  //     : false;
                                                  log(va.toString() +
                                                      "lllllllllll");
                                                }
                                              });

                                              print("hii");
                                              log(va.toString() +
                                                  "hhhhhhhhhhh");

                                              log(b.toString() +
                                                  "nnnnnnnnnnnnnnnnnnnnnnnnnnn");
                                              if (dropdownvaluesource == null) {
                                                Fluttertoast.showToast(
                                                    msg: "Add company");
                                              } else if (va == true) {
                                                Fluttertoast.showToast(
                                                    msg: "Add price");
                                                setState(() {
                                                  va = false;
                                                });

// controllers.clear();
                                              } else if (a1 == "0") {
                                                Fluttertoast.showToast(
                                                    msg: "Add vehicle");
// controllers.clear();
                                              } else {
                                                log(taxeasarrray.toString());
                                                isLoading = true;
                                                addRequirement(
                                                    0, mapLis, widget.leadtok);
                                                Future.delayed(
                                                    const Duration(seconds: 3),
                                                    () {
                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                                });
                                                isLoading
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,

                                                        // ignore: prefer_const_literals_to_create_immutables
                                                        children: [
                                                          const Text(
                                                            'Loading...',
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          const CircularProgressIndicator(
                                                            color: Colors.white,
                                                          ),
                                                        ],
                                                      )
                                                    : const Text('Submit');
                                              }
                                              var i;
                                              // for (i = 0; i <= mapList.length; i++) {
                                              //   finalList.add({
                                              //     "name": mapList[i]["name"],
                                              //     "qty": mapList[i]["qty"],
                                              //     "color": mapList[i]["color"],
                                              //   });
                                              // }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  saleareView() async {
    var a = widget.leadtok.toString();
    log(a.toString());
    http.Response response = await http.get(
      Uri.parse(urlMain + 'api/resource/Lead/$a?fields=["lead_events"]'),
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
        productList = jsonDecode(data)["data"]["lac"];
      });

      // log(productList[0]["note"]);
      print(data);
    } else {}
  }

  Future addRequirement(
    int inde,
    List a,
    String lead,
  ) async {
    log(taxeasarrray.toString() + "hhhhhhhhhhhhhhhhh");
    log(account_head.toString() + "jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj");
    log(taxarr.toString());
    log(valuefirst.toString());
    print(a.toString());
    log(a.toString() + "ngvvvvvvvvvvvbbbbbbbbbbbbbb");
    log(dropdownvaluesource.toString() + "company masss");
    var productc = [];
    var array = [];
    String? product;
    String? Series;
    String? Qty;
    for (var d = 0; d < a.length; d++) {
      // log(array[d].toString() + "hggvgvgvgvghggghghgh");
      array.add({
        "name": a[d]["name"] == null ? "" : a[d]["name"],
        'quantity': a[d]["qty"] == null ? "" : a[d]["qty"],
        "color": a[d]["color"] == null ? "" : a[d]["color"],
        "index": d,
      });
      log(array[d]["name"]);
      log(array[d].toString() + "hggvgvgvgvghggghghgh");

      log(taxarr.toString() + "hhgvvvvvvvvvvvvvvvvvvvvvvv");
      // product = array[d]["name"];
      // Qty = array[d]["quantity"];
      // Series = array[d]["color"];

      //
    }
    // print(array[d]["name"]);
    // print(d.toString() + "hbmbhmbmbmnnmnmnm");

    // for (var i = 0; i < mapList.length; i++) {
    //   name = mapList[i]["name"];
    //   series = mapList[i]["color"];
    //   series = mapList[i]["color"];
    // }
    log(value7.toString() + "value7");
    log(value7.toString() + "value7");
    log(value7.toString() + "value7");
    log(value7.toString() + "value7");
    productc.toString();
    log(product.toString());

    //DateFormat('yy/MM/dd').format(datel!);
    // log(formattedDate.toString());
    DateTime dt = new DateTime.now();
    print(dt.timeZoneOffset);
    print(dt);

    DateTime dt1 = dt.add(new Duration(days: 30));
    String formatteDate = DateFormat('yyyy/MM/dd').format(now);
    String formattedDate = DateFormat('yyyy/MM/dd').format(dt1);
    log(formatteDate);
    //  log(DateFormat('yy/MM/dd').format(datel!).toString());
    // log(array[d]["qty"].toString() + "mnhbbcfbbbbbbbbbgvgvhbjhjkljiikk");
    var baseUrl = urlMain + 'api/resource/Quotation';
    final msg = jsonEncode({
      "party_name": widget.leadtok,
      "company": dropdownvaluesource,
      "super_stockist": dropdownvaluesource,
      "transaction_date": formatteDate.toString(),
      "valid_till": formattedDate.toString(),
      "sale_area": productList.toString(),

      // "all_vehicle_permissible":
      //     vehicledrop == "All vehicle permissible" ? 1 : 0,
      // "Limited vehicle permissible":
      //     vehicledrop == "All vehicle permissible" ? 0 : 1,
      // "type_of_vehicle_go_to_site": veh.text == "" ? "" : veh.text,
      "all": value10 == false ? 0 : 1,
      "goods_ape": valuefirst == false ? 0 : 1,
      "sml_isuzu": valuesec == false ? 0 : 1,
      "mahindra_mini_truck": valuefourth == false ? 0 : 1,
      "mahindra_jeeto_plus": valuefive == false ? 0 : 1,
      "tata_ace": value8 == false ? 0 : 1,
      "mahindra_bolero_pickups": value7 == false ? 0 : 1,
      "tata_407": valuesix == false ? 0 : 1,
      "eicher": valuethird == false ? 0 : 1,
      "bharat_benz": value9 == false ? 0 : 1,
      "tax_category": "INSTATE",
      "items": mapLis,
      "note": descontroller.text == "" ? "" : descontroller.text,
      "taxes_and_charges": taxarr == null ? "" : taxarr,
      "taxes": taxeasarrray
    });
    log(msg + 'huuu');
    http.Response response =
        await http.post(Uri.parse(baseUrl), body: msg, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    });

    print(response.body);
    print(response.statusCode);
    print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
    if (response.statusCode == 200) {
      print(response.body);
      print("haaaaaaaaaaaaaaaaaaaaaaaaa");
      String data = response.body;
      mapLis.clear();

      Fluttertoast.showToast(msg: "Quotation added");
      Get.to(SalesdetailView(widget.name, "qt", "", "", "", widget.leadtok));

      // setState(() {
      //   jsonData = json.decode(data)["data"];
      //   arealist = jsonData;
      //   for (var i = 0; i <= jsonData.length; i++) {
      //     setState(() {
      //       jsonData[i]["index"] = i;
      //     });

      //     ;
      //   }
      // });
      ;

      // log(jsonData.toString());
      // setState(() {});
    } else if (response.statusCode == 417) {
      Fluttertoast.showToast(msg: response.reasonPhrase.toString());
      print(response.body);
    } else {
      print(response.statusCode.toString() + 'err status code');
      Fluttertoast.showToast(msg: response.reasonPhrase.toString());
    }
  }

  Future taxesss() async {
    print("hiiiiiiiii");
    var s = taxarr.toString();
    log(taxarr.toString());

    var baseUrl =
        //'https://lamit.erpeaz.com/api/resource/Sales Taxes and Charges Template?filters=[["company","=","$s"],["tax_category","=","INSTATE"]]';
        // 'https://lamit.erpeaz.com/api/resource/Sales Taxes and Charges Template?filters=[["company","=","$s"],["tax_category","=","INSTATE"]]';

        urlMain + 'api/resource/Sales Taxes and Charges Template/$s';
    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    });
    log(response.body + "taaaaaaaaaaaaaaaaaaaaaxcatagory");
    print(response.statusCode);
    print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
    if (response.statusCode == 200) {
      String data = response.body;
      print(response.body);
      print("haaaaaaaaaaaaaaaaaaaaaaaaa");
      // String data = response.body;
      // var jsonData;
      ;
      setState(() {
        taxes = jsonDecode(data)["data"];
        log(taxes.toString() +
            "hhhhhhhhhhhhhhhhhhhhhhhhhhhhhllllllllllllllllllllllllllll");
        log(taxes["taxes"][1]["charge_type"] + "gggggggggggggggggggggggggggg");
        for (var i = 0; i < taxes.length; i++) {
          //   log(double.pars);
          taxeasarrray.add(
            {
              "charge_type": taxes["taxes"][i]["charge_type"],
              "account_head": taxes["taxes"][i]["account_head"],
              "description": taxes["taxes"][i]["description"],
              "rate": jsonDecode(data)["data"]["taxes"][i]["rate"]
            },
          );
          // log(jsonDecode(data)["taxes"][i]["rate"]);

          log(taxeasarrray.toString() +
              "vbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbnc");
        }

        charge_type = jsonDecode(data)["data"]["taxes"][0]["charge_type"];
        account_head = jsonDecode(data)["data"]["taxes"][0]["account_head"];

        description = jsonDecode(data)["data"]["taxes"][0][" description"];
      });

      // log(jsonData.toString());
      //setState(() {});
    }
  }

  Future gettaxcharge() async {
    print("hiiiiiiiii");
    var s = dropdownvaluesource.toString();

    var baseUrl =
        //'https://lamit.erpeaz.com/api/resource/Sales Taxes and Charges Template?filters=[["company","=","$s"],["tax_category","=","INSTATE"]]';
        urlMain +
            'api/resource/Sales Taxes and Charges Template?filters=[["company","=","$s"],["tax_category","=","INSTATE"]]';

    //  'https://lamit.erpeaz.com/api/resource/Sales Taxes and Charges Template/Output Tax Instate 12% - KP';
    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    });
    log(response.body + "taaaaaaaaaaaaaaaaaaaaaxcatagory");
    print(response.statusCode);
    print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
    if (response.statusCode == 200) {
      String data = response.body;
      print(response.body);
      print("haaaaaaaaaaaaaaaaaaaaaaaaa");
      // String data = response.body;
      // var jsonData;
      ;
      setState(() {
        taxarr = jsonDecode(data)["data"][0]["name"];
      });
      taxesss();
      log(taxarr.toString() + "vbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbnc");

      // log(jsonData.toString());
      //setState(() {});
    }
  }

  // insertBillItemsOffline(String refId, int i) async {
  //   final db = await database;

  //   var billitems = BillItems(
  //       items[i]['Item']!,
  //       items[i]['qty']!,
  //       items[i]['price']!,
  //       items[i]['total']!,
  //       refId,
  //       items[i]['unit'],
  //       items[i]['unitID'],
  //       items[i]['id'].toString());

  //   var a = await db.insert('billItems', billitems.toMap(),
  //       conflictAlgorithm: ConflictAlgorithm.replace);
  //   print("gdgffhg" + a.toString());
  // }

  // insertBillOffline() async {
  //   final db = await database;

  //   var bill = Bill(
  //       offLineCustomersDropDown[int.parse(selectedCustomer!)],
  //       '',
  //       subTotal,
  //       discountController.text.isEmpty ? '0' : discountController.text,
  //       totalAmount.toStringAsFixed(2),
  //       recBalanceController.text.isEmpty
  //           ? balance.toStringAsFixed(2)
  //           : recBalanceController.text,
  //       recBalanceController.text.isEmpty ? '0' : balance.toStringAsFixed(2),
  //       '0',
  //       'bill',
  //       prefix! + prefixNo!.toString(),
  //       selectedLedger,
  //       vatAmount.toStringAsFixed(2),
  //       prefix,
  //       prefixNo,
  //       //int.parse(prefixNo!),
  //       '',
  //       int.parse(
  //         DateFormat('yMMdd').format(DateTime.now()),
  //       ),
  //       offLineCustomersIdDropDown[int.parse(selectedCustomer!)]);

  //   final refid = await db.insert(
  //     'bills',
  //     bill.toMap(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  //   log('Inserted to ID : ' + refid.toString());
  //   var i = 0;
  //   for (i = 0; i < items.length; i++) {
  //     insertBillItemsOffline(refid.toString(), i);
  //   }
  //   if (i == items.length) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text('Success'),
  //       backgroundColor: Colors.green,
  //     ));
  //     if (vatPercent == 0) {
  //       genarate == "A4"
  //           ? GeneratePDFnoVAT(
  //                   offLineCustomersDropDown[int.parse(selectedCustomer!)],
  //                   items,
  //                   await _readFontData(),
  //                   prefix! + prefixNo!.toString(),
  //                   file,
  //                   discountController.text.isEmpty
  //                       ? 0
  //                       : double.parse(discountController.text),
  //                   qrFile,
  //                   double.parse(subTotal),
  //                   vatAmount,
  //                   double.parse(subTotal),
  //                   recBalanceController.text.isEmpty
  //                       ? totalAmount
  //                       : double.parse(recBalanceController.text),
  //                   recBalanceController.text.isEmpty ? 0.0 : balance,
  //                   customerDetails[int.parse(selectedCustomer!)]['address'],
  //                   customerDetails[int.parse(selectedCustomer!)]['vat'],
  //                   vatPercent,
  //                   selectedLedger,
  //                   settings[0]['name'],
  //                   settings[0]['vatnumArabic'],
  //                   customerDetails[int.parse(selectedCustomer!)]['ob'])
  //               .generateInvoice(settings[0]['nameArabi'],
  //                   settings[0]['addressArabic'], settings[0]['vatnum'])
  //           : GeneratePDF3inch(
  //                   offLineCustomersDropDown[int.parse(selectedCustomer!)],
  //                   items,
  //                   await _readFontData(),
  //                   prefix! + prefixNo!.toString(),
  //                   file,
  //                   discountController.text.isEmpty
  //                       ? 0.0
  //                       : double.parse(discountController.text),
  //                   items.length.toDouble(),
  //                   double.parse(subTotal),
  //                   double.parse(vatAmount.toStringAsFixed(2)),
  //                   double.parse(
  //                     totalAmount.toStringAsFixed(2),
  //                   ),
  //                   recBalanceController.text.isNotEmpty
  //                       ? double.parse(
  //                           recBalanceController.text,
  //                         )
  //                       : totalAmount,
  //                   recBalanceController.text.isEmpty
  //                       ? 0.0
  //                       : double.parse(balance.toStringAsFixed(2)),
  //                   qrFile,
  //                   offLineCustomers[int.parse(selectedCustomer!)]['vatnum'],
  //                   vatPercent)
  //               .generateInvoice(settings[0]['name'],
  //                   settings[0]['addressArabic'], settings[0]['vatnum']);
  //     } else {
  //       genarate == "A4"
  //           ? GeneratePDF(
  //                   offLineCustomersDropDown[int.parse(selectedCustomer!)],
  //                   items,
  //                   await _readFontData(),
  //                   prefix! + prefixNo!.toString(),
  //                   file,
  //                   discountController.text.isEmpty
  //                       ? 0
  //                       : double.parse(discountController.text),
  //                   qrFile,
  //                   double.parse(subTotal),
  //                   vatAmount,
  //                   totalAmount,
  //                   recBalanceController.text.isEmpty
  //                       ? totalAmount
  //                       : double.parse(recBalanceController.text),
  //                   recBalanceController.text.isEmpty ? 0.0 : balance,
  //                   customerDetails[int.parse(selectedCustomer!)]['address'],
  //                   customerDetails[int.parse(selectedCustomer!)]['vat'],
  //                   vatPercent,
  //                   selectedLedger,
  //                   settings[0]['name'],
  //                   settings[0]['vatnumArabic'],
  //                   customerDetails[int.parse(selectedCustomer!)]['ob'])
  //               .generateInvoice(settings[0]['nameArabi'],
  //                   settings[0]['addressArabic'], settings[0]['vatnum'])
  //           : GeneratePDF3inch(
  //                   offLineCustomersDropDown[int.parse(selectedCustomer!)],
  //                   items,
  //                   await _readFontData(),
  //                   prefix! + prefixNo!.toString(),
  //                   file,
  //                   discountController.text.isEmpty
  //                       ? 0.0
  //                       : double.parse(discountController.text),
  //                   items.length.toDouble(),
  //                   double.parse(subTotal),
  //                   double.parse(vatAmount.toStringAsFixed(2)),
  //                   double.parse(
  //                     totalAmount.toStringAsFixed(2),
  //                   ),
  //                   recBalanceController.text.isNotEmpty
  //                       ? double.parse(
  //                           recBalanceController.text,
  //                         )
  //                       : totalAmount,
  //                   recBalanceController.text.isEmpty
  //                       ? 0.0
  //                       : double.parse(balance.toStringAsFixed(2)),
  //                   qrFile,
  //                   offLineCustomers[int.parse(selectedCustomer!)]['vatnum'],
  //                   vatPercent)
  //               .generateInvoice(settings[0]['name'],
  //                   settings[0]['addressArabic'], settings[0]['vatnum']);
  //     }
  //     // var ob1 = await db.rawQuery(
  //     //     'select SUM(balanceAmount) from bills where shopid=' +
  //     //         offLineCustomersIdDropDown[int.parse(selectedCustomer!)]
  //     //             .toString());
  //     await db.rawUpdate(
  //         'UPDATE CustCre SET balance = ?  WHERE id = ' +
  //             offLineCustomersIdDropDown[int.parse(selectedCustomer!)],
  //         [
  //           recBalanceController.text.isEmpty ? '0' : balance.toStringAsFixed(2)
  //         ]);

  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (builder) => SalesInvoice()));

  //     setState(() {
  //       selectedCustomer = null;
  //       selectedItem = null;
  //       items.clear();
  //       totalAmount = 0.0;
  //       vatAmount = 0.0;
  //       subTotal = '0.0';
  //       discountController.clear();
  //       recBalanceController.clear();
  //       balance = 0.0;
  //     });
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text('Failed'),
  //       backgroundColor: Colors.red,
  //     ));
  //   }
  // }

  // getOfflineData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (prefs.getString('ledger') != null) {
  //     setState(() {
  //       selectedLedger = prefs.getString('ledger');
  //     });
  //   } else {
  //     selectedLedger = 'Cash';
  //   }
  //   final db = await database;
  //   offLineCustomers =
  //       await db.rawQuery('select * from CustCre order by name asc');
  //   offLineLedger = await db.query('LedCre');
  //   offlineProducts = await db.query(
  //     ' ProductAd',
  //   );
  //   log(offlineProducts.toString());
  //   if (offlineProducts.length <= 0) {
  //     Fluttertoast.showToast(msg: 'No Products Found! Add Some Products First');
  //     // Navigator.pushReplacement(
  //     //     context,
  //     //     CupertinoPageRoute(
  //     //         builder: (builder) =>
  //     //             ProductAdd('', '', '', '', '', '', '', '', '')
  //     //             ));
  //   } else if (offLineCustomers.length <= 0) {
  //     Fluttertoast.showToast(
  //         msg: 'No Customers Found! Add Some Customers First');
  //     Navigator.pushReplacement(
  //         context,
  //         CupertinoPageRoute(
  //             builder: (builder) => RegPage('', '', '', '', '', '', '')));
  //   }
  //   settings = await db.query('Setting');
  //   if (prefs.getBool('isVAT') == true) {
  //     vatPercent = double.parse(settings[0]['vat']) / 100;
  //   } else {
  //     vatPercent = 0;
  //   }

  //   log(vatPercent.toString() + '<<<<<<<============>>>>>>>>>');
  //   offlineUnits = await db.query('units');
  //   setState(() {
  //     file = File(settings[0]['logo']);
  //     prefix = settings[0]['prefixa'];
  //     if (prefs.getBool('isA4') == null || prefs.getBool('isA4')!) {
  //       genarate = 'A4';
  //     } else {
  //       genarate = '3i';
  //     }
  //     vat = settings[0]['vatnum'];
  //     company = settings[0]['name'];
  //     companyAddress = settings[0]['addressArabic'];
  //   });

  //   //print(await db.query('bills', where: 'id>0 and id<=3'));
  //   setState(() {
  //     for (var i = 0; i < offLineCustomers.length; i++) {
  //       offLineCustomersDropDown.add(offLineCustomers[i]['name']);
  //       offLineCustomersIdDropDown.add(offLineCustomers[i]['id'].toString());
  //       customerDetails.add({
  //         "address": offLineCustomers[i]['address'],
  //         "vat": offLineCustomers[i]['vatnum'],
  //         "ob": offLineCustomers[i]['balance'].toString()
  //       });
  //       array.add(i.toString());
  //     }

  //     print('cust details are :' + customerDetails.toString());

  //     selectedCustomer = array[0].toString();

  //     log(selectedCustomer! + '---------------');
  //     for (var i = 0; i < offlineProducts.length; i++) {
  //       offlineProductsDropDown.add(offlineProducts[i]['name']);
  //       offlineProductsIdDropDown.add(offlineProducts[i]['id']);
  //       itemPricesOffline.add(i.toString());
  //     }
  //   });

  //   var pn = await db.rawQuery(
  //       'SELECT ((case when count(prefixNo)=0 then 0 else MAX(prefixNo) end) +1) as billno FROM  bills');
  //   log('=========>>>>>' + pn.toString());
  //   setState(() {
  //     prefixNo = (pn[0]['billno']);
  //   });
  //   print('================== $prefixNo');
  // }

  //fonts
  Future<List<int>> _readFontData() async {
    final ByteData bytes = await rootBundle.load('assets/fonts/Arial.ttf');
    return bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
  }

  void generateQR(String companyName, String vatRegNum) async {
    BytesBuilder bytesBuilder = BytesBuilder();

    // Seller name
    bytesBuilder.addByte(1);
    List<int> sellerNameBytes = utf8.encode(companyName);
    bytesBuilder.addByte(sellerNameBytes.length);
    bytesBuilder.add(sellerNameBytes);

    //VAT reg num
    bytesBuilder.addByte(2);
    List<int> vatRegNumBytes = utf8.encode(vatRegNum);
    bytesBuilder.addByte(vatRegNumBytes.length);
    bytesBuilder.add(vatRegNumBytes);

    //Time stamp
    bytesBuilder.addByte(3);
    List<int> timeStampBytes = utf8
        .encode(DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now()) + 'Z');
    log('The timestamp ============>' + timeStampBytes.toString());
    bytesBuilder.addByte(timeStampBytes.length);
    bytesBuilder.add(timeStampBytes);

    //invoice total with VAT
    bytesBuilder.addByte(4);
    List<int> invTotalBytes = utf8.encode(
      totalAmount.toStringAsFixed(2),
    );
    bytesBuilder.addByte(invTotalBytes.length);
    bytesBuilder.add(invTotalBytes);

    //vat total
    bytesBuilder.addByte(5);
    List<int> totalVatBytes = utf8.encode(vatAmount.toStringAsFixed(3));
    bytesBuilder.addByte(totalVatBytes.length);
    bytesBuilder.add(totalVatBytes);

    //to base64
    Uint8List qrCodeAsBytes = bytesBuilder.toBytes();
    final Base64Encoder b64Encoder = Base64Encoder();
    qrData = b64Encoder.convert(qrCodeAsBytes);

    print('Amounts are : - $vatAmount  and  $totalAmount');
    log('Base64 for QRCode ===>>> $base64');
  }
}

class HeadingText extends StatelessWidget {
  final String? name;
  HeadingText(this.name);
  @override
  Widget build(BuildContext context) {
    return Text(
      name!,
      style: TextStyle(
          color: Colors.grey[900], fontWeight: FontWeight.w600, fontSize: 11),
    );
  }
}

class ListText extends StatelessWidget {
  final String? name;
  ListText(this.name);
  @override
  Widget build(BuildContext context) {
    return Text(
      name!,
      style: TextStyle(color: Colors.grey[900], fontSize: 9),
    );
  }
//    "taxes": [

//             {

//                 "charge_type": "On Net Total",

//                 "account_head": "Output Tax CGST - KP",

//                 "description": "Output Tax CGST"

//             },

//             {

//                 "charge_type": "On Net Total",

//                 "account_head": "Output Tax SGST - KP",

//                 "description": "Output Tax SGST"

//             }

//         ]

// }

  // "taxes":[{
  //        "charge_type": "On Net Total",

  //              "account_head": "Output Tax SGST - KP",

  //                "description": "Output Tax SGST"

  //     }

  //             ],
}
