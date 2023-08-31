import 'dart:convert';
import 'dart:developer';
import 'package:lamit/globals.dart' as globals;
// import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import 'package:lamit/app/routes/constants.dart';
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/tocken/tockn.dart';
import 'package:lamit/widget/customeappbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/leadadd_controller.dart';
import 'package:http/http.dart' as http;

class LeadaddView extends StatefulWidget {
  final String? lid;
  final String? fname;
  final String? status;
  final String? lname;
  final String? mnum;
  final String? whatsnum;
  final String? Dist;
  final String? catagory;
  final String? custarea;
  final String? Refer;
  final String? Gender;
  final String? expectedpurchase;
  final String? Source;
  final String? email;
  final String? name;
  final String? stage;
  final String restorationId = "main";
  final String location;

  const LeadaddView(
    this.lid,
    this.status,
    this.fname,
    this.lname,
    this.mnum,
    this.whatsnum,
    this.Dist,
    this.catagory,
    this.custarea,
    this.Refer,
    this.Gender,
    this.expectedpurchase,
    this.Source,
    this.email,
    this.name,
    this.location,
    this.stage
  );

  @override
  State<LeadaddView> createState() => _LeadaddViewState();
}

class _LeadaddViewState extends State<LeadaddView> with RestorationMixin {
  String? get restorationId => widget.restorationId;
  String? a = '';
  String? userID;
  String? dist;

  void main() {
    print(isMobileNumberValid("+9197845975511")); // true
    print(isMobileNumberValid("123")); // false
    print(isMobileNumberValid("879")); // false
  }

  bool isMobileNumberValid(String phoneNumber) {
    String regexPattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
    var regExp = new RegExp(regexPattern);

    if (phoneNumber.length == 0) {
      return false;
    } else if (regExp.hasMatch(phoneNumber)) {
      return true;
    }
    return false;
  }

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
  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        datelll =
            '${_selectedDate.value.year}-${_selectedDate.value.month}-${_selectedDate.value.day}';
        DateTime currentDate = DateTime.now();
    DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(datelll!);
    bool isOneMonthHigher =
        parsedDate.isBefore(currentDate.add(Duration(days: 30)));
        if(isOneMonthHigher){
         setState((){
           selectedStage = 'Hot';
         });
        }else{
          setState((){
            selectedStage='Cold';
          });
        }
        setState(() {
          a = "${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}";

          //  a.toString();
        });
      });
    }
  }

  //text field

  TextEditingController? reference;
  TextEditingController? fname;
  TextEditingController? lname;
  TextEditingController? email;

  TextEditingController? mnumber;
  TextEditingController? phnumber;
  TextEditingController? whatsappNumber;
  TextEditingController? city;
  TextEditingController? state;
  TextEditingController? zipCode;
  TextEditingController? district;
  TextEditingController? ldname;
  final location = TextEditingController();

  GoogleMapController? mapController;
  String? latitude = '';
  String? valid;
  String? svalid;
  String? longitude = '';
  var offemployname = [];
  var shopname = [];
  var engineername = [];
  var contractorName = [];
  var dealerName=[];
  var subdealerName = [];
  String? selectedStage;
  //String? dropdownValue;
  DateTime timeBackPressed = DateTime.now();
  DateTime now = DateTime.now();
  bool _keyboardVisible = false;
  var array = [];
  var arealist = [];
  var catlist = [];

  var sourcelist = [];
  var referencelist = [];
  var laclist = [];
  var distlist = [];
  var emloyeelist = [];
  var shoplist = [];
  var engineerlist = [];
  var dealerList =[];
  var subDealerList = [];
  var contractorlist = [];
  String? refdropdownvalue;
  var refitems = ["Male", "Female"];
  var offLineCustomersDropDown = [];
  var stageList = ['Hot','Warm','Cold','Lost','Do Not Connect','Closed'];
  var offLineCustomersname = [];
  var lacDropDown = [];
  var sourceDropDown = [];

  Future getAllArea() async {
    print("hiiiiiiiii");
    var baseUrl = urlMain + "api/resource/Sales Area&limit=100000";

    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
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
      var jsonData;
      setState(() {
        jsonData = json.decode(data)["data"];
        arealist = jsonData;
      });

      // log(jsonData.toString());
      // setState(() {});
    }
  }

  Future getAllCat() async {
    print("hiiiiiiiii");
    var baseUrl = urlMain +
        'api/resource/Customer Group?filters=[["is_group", "=", "0"]]&limit=100000';

    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
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
      String dat = response.body;
      //var jsonData;
      log(dat + "hhgggggggggggggghvvvvvvvvvvvvvvvvvvvv");
      setState(() {
        var jsonD = json.decode(dat)["data"];
        catlist = jsonD;

        for (var i = 0; i < catlist.length; i++) {
          offLineCustomersDropDown.add(catlist[i]['name']);
          // offLineCustomersIdDropDown.add(offLineCustomers[i]['id'].toString());
          // customerDetails.add({
          //   "address": offLineCustomers[i]['address'],
          //   "vat": offLineCustomers[i]['vatnum'],
          //   "ob": offLineCustomers[i]['balance'].toString()
          // });
          array.add(i.toString());
        }
        log(offLineCustomersDropDown.toString());
        // catlist=json.decode(data)["data"]["name"];
      });

      // log(jsonData.toString());
      //   setState(() {});
    }
  }

  Future getAlldist(String cust) async {
    // print("hiiiiiiiii");
    print("gggffdisssssssssssssssss");
    var baseUrl = urlMain + "api/resource/Sale Area/$cust?limit=100000";

    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
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
      var jsonData;
      setState(() {
        jsonData = json.decode(data)["data"];
        // distlist = jsonData;
        dist = json.decode(data)["data"]["district"];
      });

      // log(jsonData.toString());
      // setState(() {});
    }
  }

  var status;
  bool isLoading = false;

  // getCurrentLocation() async {
  //   LocationPermission permission;
  //   permission = await Geolocator.requestPermission();
  //   position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);

  //   setState(() {});
  //   log('//-----------------------//');
  //   print(position!.latitude);
  //   log(position!.longitude.toString());
  // }

  Future getAllsource() async {
    print("hiiiiiiiii");
    var baseUrl = urlMain + "api/resource/Lead Source";

    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
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
      var jsonData;
      setState(() {
        jsonData = json.decode(data)["data"];
        sourcelist = jsonData;

        for (var i = 0; i < sourcelist.length; i++) {
          sourceDropDown.add(sourcelist[i]['name']);
          // offLineCustomersIdDropDown.add(offLineCustomers[i]['id'].toString());
          // customerDetails.add({
          //   "address": offLineCustomers[i]['address'],
          //   "vat": offLineCustomers[i]['vatnum'],
          //   "ob": offLineCustomers[i]['balance'].toString()
          // });
          array.add(i.toString());
        }
      });

      // log(jsonData.toString());
      //setState(() {});
    }
  }

  String? employDropdownvalue1;

  Future getlac() async {
    var baseUrl;
    print("hiiiiiiiii");
    // https://lamit.erpeaz.com/api/resource/Customer Area?filters=[["allocated_by", "=", "1232435456"]] & limit=100
    if (globals.role == "Area Sales Manager") {
      baseUrl = urlMain +
          // 'api/resource/Assign Sale Area?filters=[["sales_officer", "=", "$userID"]]&limit=100000"';
          'api/resource/Assign Sale Area?filters=[["area_sales_manager", "=","$userID"]]&limit=10000000';
    } else {
      baseUrl = urlMain +
          'api/resource/Assign Sale Area?filters=[["sales_officer", "=", "$userID"]]&limit=100000"';
      // 'api/resource/Assign Sale Area?filters=[["area_sales_manager", "=","$userID"]]&limit=10000000';
    }

    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
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
      var jsonData;
      setState(() {
        jsonData = json.decode(data)["data"];
        laclist = jsonData;
        for (var i = 0; i < laclist.length; i++) {
          lacDropDown.add(laclist[i]['name']);
          // offLineCustomersIdDropDown.add(offLineCustomers[i]['id'].toString());
          // customerDetails.add({
          //   "address": offLineCustomers[i]['address'],
          //   "vat": offLineCustomers[i]['vatnum'],
          //   "ob": offLineCustomers[i]['balance'].toString()
          // });
          array.add(i.toString());
        }
        print(lacDropDown.toString() + 'rashmahru');
      });

      // log(jsonData.toString());
      // setState(() {});
    }
  }

  Future getAllreference() async {
    var baseUrl = urlMain + "api/resource/Customer?limit=100000";

    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    });
    print(response.body);
    print(response.statusCode);
    print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
    if (response.statusCode == 200) {
      print("dkjhbjhjchhchbffffhcjbhc" + response.body);
      print("haaaaaaaaaaaaaaaaaaaaaaaaa");
      String data = response.body;
      var jsonData;
      setState(() {
        jsonData = json.decode(data)["data"];
        referencelist = jsonData;
      });
      for (var i = 0; i < referencelist.length; i++) {
        offLineCustomersname.add(referencelist[i]['name']);
        // offLineCustomersIdDropDown.add(offLineCustomers[i]['id'].toString());
        // customerDetails.add({
        //   "address": offLineCustomers[i]['address'],
        //   "vat": offLineCustomers[i]['vatnum'],
        //   "ob": offLineCustomers[i]['balance'].toString()
        // });
        array.add(i.toString());
      }

      employeeReference();
      shopReference();
      engineerReference();
      ContractorReference();
      FetchDealers();
      fetchSubDealers();
      //   print("cbhdddddddddddddddd" + jsonData.toString());
      // log(jsonData.toString());
      //setState(() {});
    }
  }

//   _checkPermission() async {
//     var status = await Permission.location.status;
//     if (status.isDenied) {
//       await Permission.location.request();
//     } else if (status.isGranted) {
//       getCurrentLocation();
//     }
// // You can can also directly ask the permission about its status.
//     if (await Permission.location.isRestricted) {
//       // The OS restricts access, for example because of parental controls.
//       await Permission.location.request();
//     }

//     if (await Permission.location.isGranted) {
//       getCurrentLocation();
//     }
//   }

  Position? position;

  // getCurrentLocation() async {
  //   position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);

  //   setState(() {});
  //   log('//-----------------------//');
  //   print(position!.latitude);
  //   log(position!.longitude.toString());
  // }

  // // void _onMapCreated(GoogleMapController controller) async {
  // //   mapController = controller;
  // // }

  Map<MarkerId, Marker> markers = {};

  // _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
  //   MarkerId markerId = MarkerId(id);
  //   Marker marker =
  //       Marker(markerId: markerId, icon: descriptor, position: position);
  //   markers[markerId] = marker;
  // }
  @override
  void initState() {
    log(widget.location.toString() + 'opkio');
    // log(widget.Source.toString());
    // log(widget.name.toString());

    // var keyboardVisibilityController = KeyboardVisibilityController();
    // Query
    // log('Keyboard visibility direct query: ${keyboardVisibilityController.isVisible}');

    // Subscribe
    // keyboardVisibilityController.onChange.listen((bool visible) {
    //   print('Keyboard visibility update. Is visible: ${visible}');
    // });

    // getAllArea();
    // getAllCat();
    // getAllsource();
    //getAllreference();
    fname = new TextEditingController(text: widget.fname);
    lname = new TextEditingController(text: widget.lname);
    mnumber = new TextEditingController(text: widget.mnum);
    whatsappNumber = new TextEditingController(text: widget.whatsnum);
    email = new TextEditingController(text: widget.email);
    setState(() {
      location.text = widget.location;
    });
    // location = new TextEditingController(text:)

    if (widget.status == "isdetail") {
      dropdownvaluesource = widget.Source;
      dropdownvaluelac = widget.custarea;
      dist = widget.Dist;
      dropdownvaluereference = widget.name;
      shopdropdownvalue = widget.name;
      contractordownvalueArea = widget.name;
      employDropdownvalue1 = widget.name;
      dealerdownvalueArea =widget.name;
      subdealerdownvalueArea =widget.name;
      employDropdownvalue = widget.name;

      engineerdownvalueArea = widget.name;
      dropdownvaluecat = widget.catagory;
      refdropdownvalue = widget.Gender;
      selectedStage = widget.stage;
      log(employDropdownvalue.toString());
      datelll = widget.expectedpurchase == null
          ? "Pick expected Date"
          : widget.expectedpurchase;
    }
    log(engineerdownvalueArea.toString() + "contvalue");
    getsf();
    // getCurrentLocation();
    log(widget.name.toString());
    log(dropdownvaluesource.toString() + "jjjjjjjjjjjjjjjjjjjjj");
    //getAlldist();

    // _checkPermission();
    super.initState();
  }

  String? dropdownvalueArea;
  String? dropdownvaluecat;
  String? dropdownvaluesource;
  String? dropdownvaluereference;
  String? dropdownvaluelac;
  String? dropdownvaluedis;

  String? employDropdownvalue;
  String? shopdropdownvalue;
  String? engineerdownvalueArea;
  String? contractordownvalueArea;
  String? dealerdownvalueArea;
  String? subdealerdownvalueArea;

  int _index = 0;

  // final List<Widget> _children = [
  //   DashView(),
  //   // LeadView(),
  //   ToolsView(),
  // ];
  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    //date

    // DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    //   String formattedDate = DateFormat('EEE d MMM').format(now);
    return Scaffold(
      // backgroundColor: HexColor("#EEf3f9"),
      backgroundColor: Colors.white,
      // bottomNavigationBar: Container(
      //   height: 70,;;;
      //   decoration: BoxDecoration(
      //     color: Colors.red,
      //     borderRadius: const BorderRadius.only(
      //       topLeft: Radius.circular(60),
      //       topRight: Radius.circular(60),
      //     ),
      //   ),
      //   child: BottomNavigationBar(
      //     unselectedItemColor: Colors.white,
      //     selectedItemColor: Colors.grey,
      //     backgroundColor: Color.fromARGB(255, 4, 7, 105),
      //     onTap: onTabTapped,
      //     currentIndex: _index,
      //     items: [
      //       BottomNavigationBarItem(
      //         icon: GestureDetector(
      //             onTap: (() {
      //               Get.to(HomeView(
      //                 "",
      //               ));
      //             }),
      //             child: Container(child: Icon(Icons.dashboard))),
      //         label: 'Dashboard',
      //       ),
      //       // BottomNavigationBarItem(
      //       //   icon: Icon(Icons.leaderboard),
      //       //   label: 'Lead',
      //       // ),
      //       BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.event,
      //         ),
      //         label: 'Events',
      //       )
      //     ],
      //   ),
      // ),
      // // floatingActionButton: _keyboardVisible == true
      //     ? Container()
      //     : Container(
      //         child: Padding(
      //           padding: const EdgeInsets.only(),
      //           child: Stack(
      //             children: [
      //               CircleAvatar(
      //                 backgroundColor: Colors.white,
      //                 radius: 40,
      //                 child: Container(
      //                     color: Colors.white,
      //                     child: FloatingActionButton(
      //                         backgroundColor: Color.fromARGB(255, 4, 7, 105),
      //                         child: Icon(Icons.save),
      //                         onPressed: () {})),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.only(top: 90, left: 10),
      //                 child: Text(
      //                   "Create Lead",
      //                   style: TextStyle(color: Colors.white, fontSize: 11),
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //       ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // appBar: AppBar(
      //   title: Padding(
      //     padding: const EdgeInsets.only(left: 0.0, right: 8),
      //     //   child: Row(
      //     //     children: [
      //     //      IconButton(
      //     //   icon: Padding(
      //     //     padding: const EdgeInsets.only(left: 16.0),
      //     //     child: Icon(Icons.arrow_back, color: Colors.black),
      //     //   ),
      //     //   onPressed: () => Navigator.of(context).pop(),
      //     // ),
      //     //       Text(
      //     //         'CREATE A LEAD',
      //     //         style: TextStyle(
      //     //             fontSize: 16,
      //     //             color: Color.fromARGB(255, 2, 76, 142),
      //     //             fontWeight: FontWeight.bold),
      //     //       ),
      //     //     ],
      //     //   ),
      //   ),
      //   leading: Expanded(
      //     child: Container(
      //       child: Row(
      //         children: [
      //           Container(
      //             width: 30,
      //             child: IconButton(
      //               icon: Padding(
      //                 padding: const EdgeInsets.only(left: 0.0),
      //                 child: Icon(Icons.arrow_back, color: Colors.black),
      //               ),
      //               onPressed: () => Navigator.of(context).pop(),
      //             ),
      //           ),
      //           Container(
      //             child: Text(
      //               'CREATE A LEAD',
      //               style: TextStyle(
      //                   fontSize: 16,
      //                   color: Color.fromARGB(255, 2, 76, 142),
      //                   fontWeight: FontWeight.bold),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   // title: const Text(
      //   //   'CREATE A LEAD',
      //   //   style: TextStyle(
      //   //       fontSize: 16,
      //   //       color: Color.fromARGB(255, 2, 76, 142),
      //   //       fontWeight: FontWeight.bold),
      //   // ),
      //   // // centerTitle: true,
      // ),

      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight),
        child: CustomAppBar(
          title: 'CREATE A LEAD',
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.all(16.0),
                        //   child: Container(
                        //     child: Row(
                        //       children: [
                        //         GestureDetector(
                        //             onTap: (() {
                        //               Get.to(HomeView(""));
                        //             }),
                        //             child:
                        //                 Icon(Icons.arrow_back, color: Colors.black)),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // // Padding(
                        //   padding: const EdgeInsets.only(left: 8.0, right: 8),
                        //   child: Container(
                        //     height: 100,
                        //     child: Row(
                        //       children: [
                        //         Expanded(
                        //           child: Padding(
                        //             padding: const EdgeInsets.all(8.0),
                        //             child: Container(
                        //               height: 40,
                        //               margin: EdgeInsets.all(5),
                        //               decoration: BoxDecoration(
                        //                 border: Border.all(
                        //                     color: Colors.grey, // Set border color
                        //                     width: 1.0),
                        //                 color: HexColor("#F9F9F9"),
                        //                 borderRadius: BorderRadius.circular(5),
                        //               ),
                        //               child: Align(
                        //                 alignment: Alignment.centerLeft,
                        //                 child: Row(
                        //                   children: [
                        //                     Padding(
                        //                       padding: const EdgeInsets.all(8.0),
                        //                       child: Icon(
                        //                         Icons.date_range,
                        //                         color: Colors.grey,
                        //                       ),
                        //                     ),
                        //                     Padding(
                        //                       padding: const EdgeInsets.all(8.0),
                        //                       child: Text(
                        //                         formattedDate,
                        //                         style: TextStyle(
                        //                             color: Color.fromARGB(
                        //                                 255, 2, 76, 142),
                        //                             fontSize: 14,
                        //                             fontWeight: FontWeight.bold),
                        //                       ),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //         Expanded(
                        //           child: Padding(
                        //             padding: const EdgeInsets.all(8.0),
                        //             child: Container(
                        //               height: 40,
                        //               margin: EdgeInsets.all(5),
                        //               decoration: BoxDecoration(
                        //                 border: Border.all(
                        //                     color: Colors.grey, // Set border color
                        //                     width: 1.0),
                        //                 color: HexColor("#F9F9F9"),
                        //                 borderRadius: BorderRadius.circular(5),
                        //               ),
                        //               child: Align(
                        //                 alignment: Alignment.centerLeft,
                        //                 child: SingleChildScrollView(
                        //                   child: Row(
                        //                     children: [
                        //                       Padding(
                        //                         padding: const EdgeInsets.all(8.0),
                        //                         child: Icon(
                        //                           Icons.timelapse,
                        //                           color: Colors.grey,
                        //                         ),
                        //                       ),
                        //                       Padding(
                        //                         padding: const EdgeInsets.all(8.0),
                        //                         child: Text(
                        //                           DateFormat('kk:mm').format(now),
                        //                           style: TextStyle(
                        //                               color: Color.fromARGB(
                        //                                   255, 2, 76, 142),
                        //                               fontSize: 14,
                        //                               fontWeight: FontWeight.bold),
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // // Padding(
                        //   padding: const EdgeInsets.all(20.0),
                        //   child: Text(
                        //     "ADD THIS LOCATION",
                        //     style: TextStyle(
                        //         color: Color.fromARGB(255, 2, 76, 142),
                        //         fontSize: 19,
                        //         fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                        // Center(
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(0.0),
                        //     child: Container(
                        //       height: 50,
                        //       width: 300,
                        //       child: Card(
                        //         color: Colors.grey[100],
                        //         child: Center(
                        //           child: Container(
                        //             child: Row(
                        //               children: [
                        //                 Padding(
                        //                   padding: const EdgeInsets.all(8.0),
                        //                   child: Icon(
                        //                     Icons.location_pin,
                        //                     color: Colors.black,
                        //                   ),
                        //                 ),
                        //                 Padding(
                        //                   padding: const EdgeInsets.all(8.0),
                        //                   child: Text(
                        //                     "Use  Current Location",
                        //                     style: TextStyle(
                        //                       color: Colors.black,
                        //                       fontSize: 14,
                        //                       //  fontWeight: FontWeight.bold
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 00),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Container(
                              child: Column(
                                children: [
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
                                            padding:
                                                const EdgeInsets.only(top: 00),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey, // Set border color
                                                        width: 1.0),
                                                    color: HexColor("#F9F9F9"),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  height: 50,
                                                  margin: EdgeInsets.all(5),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            right: 8.0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: TextField(
                                                        controller: fname,
                                                        // controller: ledgernameController,
                                                        textAlign:
                                                            TextAlign.left,
                                                        keyboardType:
                                                            TextInputType.name,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "First Name",
                                                          border:
                                                              InputBorder.none,
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
                                  //
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
                                            padding:
                                                const EdgeInsets.only(top: 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey, // Set border color
                                                        width: 1.0),
                                                    color: HexColor("#F9F9F9"),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  height: 50,
                                                  margin: EdgeInsets.all(5),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            right: 8.0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: TextField(
                                                        controller: lname,
                                                        // controller: ledgernameController,
                                                        textAlign:
                                                            TextAlign.left,
                                                        keyboardType:
                                                            TextInputType.name,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText: "Last Name",
                                                          border:
                                                              InputBorder.none,
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

                                  // Row(
                                  //   children: [
                                  //     // Icon(
                                  //     //   Icons.person_add,
                                  //     //   color: Colors.black,
                                  //     //   size: 17,
                                  //     // ),
                                  //     Expanded(
                                  //       child: Padding(
                                  //         padding: const EdgeInsets.all(8.0),
                                  //         child: Column(
                                  //           crossAxisAlignment:
                                  //               CrossAxisAlignment.start,
                                  //           children: [
                                  //             Padding(
                                  //               padding:
                                  //                   const EdgeInsets.only(left: 8.0),
                                  //               child: Container(
                                  //                 child: Padding(
                                  //                   padding:
                                  //                       const EdgeInsets.all(8.0),
                                  //                   child: Text(
                                  //                     "Name of the lead",
                                  //                     style: TextStyle(
                                  //                       fontSize: 14,
                                  //                       // fontWeight: FontWeight.bold,
                                  //                       color: Colors.grey[700],
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //             Container(
                                  //               decoration: BoxDecoration(
                                  //                 border: Border.all(
                                  //                     color: Colors
                                  //                         .grey, // Set border color
                                  //                     width: 1.0),
                                  //                 color: HexColor("#F9F9F9"),
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(5),
                                  //               ),
                                  //               height: 50,
                                  //               margin: EdgeInsets.all(5),
                                  //               child: Padding(
                                  //                 padding: const EdgeInsets.only(
                                  //                     left: 8.0, right: 8.0),
                                  //                 child: Align(
                                  //                   alignment: Alignment.centerLeft,
                                  //                   child: TextField(
                                  //                     controller: ldname,
                                  //                     // controller: ledgernameController,
                                  //                     textAlign: TextAlign.left,
                                  //                     keyboardType:
                                  //                         TextInputType.name,
                                  //                     decoration: InputDecoration(
                                  //                       hintText: "Eg:lead one",
                                  //                       border: InputBorder.none,
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),

                                  // Row(
                                  //   children: [
                                  //     // Icon(
                                  //     //   Icons.person_add,
                                  //     //   color: Colors.black,
                                  //     //   size: 17,
                                  //     // ),
                                  //     Expanded(
                                  //       child: Padding(
                                  //         padding: const EdgeInsets.all(8.0),
                                  //         child: Column(
                                  //           crossAxisAlignment:
                                  //               CrossAxisAlignment.start,
                                  //           children: [
                                  //             Padding(
                                  //               padding: const EdgeInsets.all(8.0),
                                  //               child: Padding(
                                  //                 padding: const EdgeInsets.only(
                                  //                     left: 8.0),
                                  //                 child: Text(
                                  //                   "Phone number",
                                  //                   style: TextStyle(
                                  //                     color: Colors.grey[700],
                                  //                     fontSize: 14,
                                  //                     // fontWeight: FontWeight.bold
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //             Container(
                                  //               decoration: BoxDecoration(
                                  //                 border: Border.all(
                                  //                     color: Colors
                                  //                         .grey, // Set border color
                                  //                     width: 1.0),
                                  //                 color: HexColor("#F9F9F9"),
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(5),
                                  //               ),
                                  //               height: 50,
                                  //               margin: EdgeInsets.all(5),
                                  //               child: Padding(
                                  //                 padding: const EdgeInsets.only(
                                  //                     left: 8.0, right: 8.0),
                                  //                 child: Align(
                                  //                   alignment: Alignment.centerLeft,
                                  //                   child: TextField(
                                  //                     controller: phnumber,
                                  //                     // controller: ledgernameController,
                                  //                     textAlign: TextAlign.left,
                                  //                     keyboardType:
                                  //                         TextInputType.number,
                                  //                     decoration: InputDecoration(
                                  //                       hintText: "Enter your number",
                                  //                       border: InputBorder.none,
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),

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
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors
                                                          .grey, // Set border color
                                                      width: 1.0),
                                                  color: HexColor("#F9F9F9"),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                height: 50,
                                                margin: EdgeInsets.all(5),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0,
                                                          right: 8.0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: TextField(
                                                      controller: mnumber,
                                                      // controller: ledgernameController,
                                                      textAlign: TextAlign.left,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            "Enter your mobile number",
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
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
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors
                                                          .grey, // Set border color
                                                      width: 1.0),
                                                  color: HexColor("#F9F9F9"),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                height: 50,
                                                margin: EdgeInsets.all(5),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0,
                                                          right: 8.0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: TextField(
                                                      controller:
                                                          whatsappNumber,
                                                      // controller: ledgernameController,
                                                      textAlign: TextAlign.left,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            "Enter your whatsapp number",
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
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
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors
                                                          .grey, // Set border color
                                                      width: 1.0),
                                                  color: HexColor("#F9F9F9"),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                height: 50,
                                                margin: EdgeInsets.all(5),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0,
                                                          right: 8.0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: TextField(
                                                      controller: email,
                                                      // controller: ledgernameController,
                                                      textAlign: TextAlign.left,
                                                      keyboardType:
                                                          TextInputType
                                                              .emailAddress,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Email",
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
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
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8, left: 6),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[100],
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey, // Set border color
                                                        width: 1.0),
                                                    //   color: HexColor("#F9F9F9"),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  height: 50,
                                                  width: Constants(context)
                                                      .scrnWidth,
                                                  child: DropdownButton(
                                                    menuMaxHeight: 100,

                                                    // hint: "Reference",
                                                    hint: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text("Gender"),
                                                      ),
                                                    ),
                                                    underline: Container(),
                                                    // Initial Value
                                                    value: refdropdownvalue,

                                                    // Down Arrow Icon
                                                    // icon: const Icon(
                                                    //     Icons.keyboard_arrow_down),

                                                    // Array list of items
                                                    items: refitems
                                                        .map((String items) {
                                                      return DropdownMenuItem(
                                                        value: items,
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      16.0),
                                                              child: Row(
                                                                children: [
                                                                  Text(items),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              width: Constants(
                                                                          context)
                                                                      .scrnWidth *
                                                                  0.52,
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    }).toList(),
                                                    // After selecting the desired option,it will
                                                    // change button value to selected value
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        refdropdownvalue =
                                                            newValue!;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 50,
                                                  margin: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey, // Set border color
                                                        width: 1.0),
                                                    color: HexColor("#F9F9F9"),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            right: 8.0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Container(
                                                        width:
                                                            Constants(context)
                                                                .scrnWidth,
                                                        child: TextButton(
                                                            onPressed: () {
                                                              _keyboardVisible =
                                                                  true;
                                                              _restorableDatePickerRouteFuture
                                                                  .present();
                                                              //  a = "${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}";
                                                            },
                                                            child:
                                                                datelll == null
                                                                    ? Text(
                                                                        'Pick Expected Date ',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                11,
                                                                            color:
                                                                                Colors.black),
                                                                      )
                                                                    : datelll ==
                                                                            ""
                                                                        ? Text(
                                                                            'Pick Expected Date ',
                                                                            style:
                                                                                TextStyle(fontSize: 11, color: Colors.black),
                                                                          )
                                                                        : Text(
                                                                            datelll.toString(),
                                                                            style:
                                                                                TextStyle(color: Colors.black),
                                                                          )),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                if (datelll != null)
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        datelll = null;
                                                      });
                                                    },
                                                    child: Row(
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                datelll = null;
                                                              });
                                                            },
                                                            icon: Icon(
                                                              Icons.clear,
                                                              color: Colors.red,
                                                            )),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16.0),
                                                          child: Text(
                                                            'Expected Date Clear ',
                                                            style: TextStyle(
                                                                fontSize: 11,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Row(
                                  //   children: [
                                  //     Icon(
                                  //       Icons.home,
                                  //       color: Colors.black,
                                  //       size: 17,
                                  //     ),
                                  //     Expanded(
                                  //       child: Padding(
                                  //         padding: const EdgeInsets.all(8.0),
                                  //         child: Container(
                                  //           height: 40,
                                  //           margin: EdgeInsets.all(5),
                                  //           decoration: BoxDecoration(
                                  //               border: Border.all(
                                  //                   color: Colors.blue, // Set border color
                                  //                   width: 1.0),
                                  //               color: Colors.white,
                                  //               borderRadius: BorderRadius.circular(20)),
                                  //           child: Padding(
                                  //             padding: const EdgeInsets.only(
                                  //                 left: 8.0, right: 8.0),
                                  //             child: Align(
                                  //               alignment: Alignment.centerLeft,
                                  //               child: Padding(
                                  //                 padding: const EdgeInsets.all(8.0),
                                  //                 child: TextField(
                                  //                   controller: whatsappNumber,
                                  //                   // controller: ledgernameController,
                                  //                   textAlign: TextAlign.left,
                                  //                   keyboardType: TextInputType.name,
                                  //                   decoration: InputDecoration(
                                  //                     hintText: "Whatsapp Number",
                                  //                     border: InputBorder.none,
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //               // child: TextField(
                                  //               //   // controller: ledgernameController,
                                  //               //   textAlign: TextAlign.left,
                                  //               //   keyboardType: TextInputType.name,
                                  //               //   decoration: InputDecoration(
                                  //               //     hintText: "admin@webeas.com",
                                  //               //     border: InputBorder.none,
                                  //               //   ),
                                  //               // ),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     Icon(
                                  //       Icons.account_balance_wallet_outlined,
                                  //       color: Colors.black,
                                  //       size: 17,
                                  //     ),
                                  //     Expanded(
                                  //       child: Padding(
                                  //         padding: const EdgeInsets.all(8.0),
                                  //         child: Container(
                                  //           height: 40,
                                  //           margin: EdgeInsets.all(5),
                                  //           decoration: BoxDecoration(
                                  //               border: Border.all(
                                  //                   color: Colors.blue, // Set border color
                                  //                   width: 1.0),
                                  //               color: Colors.white,
                                  //               borderRadius: BorderRadius.circular(20)),
                                  //           child: Padding(
                                  //             padding: const EdgeInsets.only(
                                  //                 left: 8.0, right: 8.0),
                                  //             child: Align(
                                  //               alignment: Alignment.centerLeft,
                                  //               child: TextField(
                                  //                 controller: city,
                                  //                 // controller: ledgernameController,
                                  //                 textAlign: TextAlign.left,
                                  //                 keyboardType: TextInputType.name,
                                  //                 decoration: InputDecoration(
                                  //                   hintText: "City",
                                  //                   border: InputBorder.none,
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  // Row(
                                  //   children: [
                                  //     Icon(
                                  //       Icons.account_balance_wallet_outlined,
                                  //       color: Colors.black,
                                  //       size: 17,
                                  //     ),
                                  //     Expanded(
                                  //       child: Padding(
                                  //         padding: const EdgeInsets.all(8.0),
                                  //         child: Container(
                                  //           height: 40,
                                  //           margin: EdgeInsets.all(5),
                                  //           decoration: BoxDecoration(
                                  //               border: Border.all(
                                  //                   color: Colors.blue, // Set border color
                                  //                   width: 1.0),
                                  //               color: Colors.white,
                                  //               borderRadius: BorderRadius.circular(20)),
                                  //           child: Padding(
                                  //             padding: const EdgeInsets.only(
                                  //                 left: 8.0, right: 8.0),
                                  //             child: Align(
                                  //               alignment: Alignment.centerLeft,
                                  //               child: TextField(
                                  //                 controller: state,
                                  //                 // controller: ledgernameController,
                                  //                 textAlign: TextAlign.left,
                                  //                 keyboardType: TextInputType.name,
                                  //                 decoration: InputDecoration(
                                  //                   hintText: "State",
                                  //                   border: InputBorder.none,
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     Icon(
                                  //       Icons.account_balance_wallet_outlined,
                                  //       color: Colors.black,
                                  //       size: 17,
                                  //     ),
                                  //     Expanded(
                                  //       child: Padding(
                                  //         padding: const EdgeInsets.all(8.0),
                                  //         child: Container(
                                  //           height: 40,
                                  //           margin: EdgeInsets.all(5),
                                  //           decoration: BoxDecoration(
                                  //               border: Border.all(
                                  //                   color: Colors.blue, // Set border color
                                  //                   width: 1.0),
                                  //               color: Colors.white,
                                  //               borderRadius: BorderRadius.circular(20)),
                                  //           child: Padding(
                                  //             padding: const EdgeInsets.only(
                                  //                 left: 8.0, right: 8.0),
                                  //             child: Align(
                                  //               alignment: Alignment.centerLeft,
                                  //               child: TextField(
                                  //                 controller: zipCode,
                                  //                 // controller: ledgernameController,
                                  //                 textAlign: TextAlign.left,
                                  //                 keyboardType: TextInputType.name,
                                  //                 decoration: InputDecoration(
                                  //                   hintText: "Zip code",
                                  //                   border: InputBorder.none,
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  Row(
                                    children: [
                                      // Icon(
                                      //   Icons.money,
                                      //   color: Colors.black,
                                      //   size: 17,
                                      // ),
                                      // Expanded(
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.all(8.0),
                                      //     child: Container(
                                      //       height: 40,
                                      //       margin: EdgeInsets.all(5),
                                      //       decoration: BoxDecoration(
                                      //           border: Border.all(
                                      //               color: Colors
                                      //                   .blue, // Set border color
                                      //               width: 1.0),
                                      //           color: Colors.white,
                                      //           borderRadius:
                                      //               BorderRadius.circular(20)),
                                      //       child: Padding(
                                      //         padding: const EdgeInsets.only(
                                      //             left: 8.0, right: 8.0),
                                      //         child: Align(
                                      //           alignment: Alignment.centerLeft,
                                      //           child: TextField(
                                      //             controller: district,
                                      //             //controller: obController,
                                      //             textAlign: TextAlign.left,
                                      //             keyboardType:
                                      //                 TextInputType.name,
                                      //             decoration: InputDecoration(
                                      //               hintText: "District",
                                      //               border: InputBorder.none,
                                      //               //  suffixIcon:
                                      //               //Icon(Icons.phone_android)
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      // Icon(
                                      //   Icons.date_range,
                                      //   color: Colors.black,
                                      //   size: 17,
                                      // ),
                                      // Expanded(
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.all(8.0),
                                      //     child: Container(
                                      //       height: 40,
                                      //       margin: EdgeInsets.all(5),
                                      //       decoration: BoxDecoration(
                                      //           border: Border.all(
                                      //               color: Colors.blue, // Set border color
                                      //               width: 1.0),
                                      //           color: Colors.white,
                                      //           borderRadius: BorderRadius.circular(20)),
                                      //       child: Padding(
                                      //         padding: const EdgeInsets.only(
                                      //             left: 8.0, right: 8.0),
                                      //         child: Align(
                                      //           alignment: Alignment.centerLeft,
                                      //           child: TextField(
                                      //             controller: ldname,
                                      //             //controller: obController,
                                      //             textAlign: TextAlign.left,
                                      //             keyboardType: TextInputType.name,
                                      //             decoration: InputDecoration(
                                      //               hintText: "Lead Name",
                                      //               border: InputBorder.none,
                                      //               //  suffixIcon:
                                      //               //Icon(Icons.phone_android)
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),

                                      // Icon(
                                      //   Icons.receipt,
                                      //   color: Colors.blue,
                                      // ),
                                      // // Expanded(
                                      //   child: Container(
                                      //     margin: EdgeInsets.all(5),
                                      //     decoration: BoxDecoration(
                                      //         color: Colors.white,
                                      //         borderRadius:
                                      //             BorderRadius.circular(5)),
                                      //     child: Padding(
                                      //         padding: const EdgeInsets.only(
                                      //             left: 8.0, right: 8.0),
                                      //         child: DropdownButton(
                                      //           hint: Text("Owner"),
                                      //           underline: Container(),
                                      //           isExpanded: true,
                                      //           elevation: 0,
                                      //           onChanged: (String? newValue) {
                                      //             setState(() {
                                      //               dropdownValue = newValue!;
                                      //             });
                                      //           },
                                      //           value: dropdownValue,
                                      //           items: <String>[
                                      //             'Admin',
                                      //             'Bank',
                                      //           ].map<DropdownMenuItem<String>>(
                                      //               (String value) {
                                      //             return DropdownMenuItem<String>(
                                      //               value: value,
                                      //               child: Text(value),
                                      //             );
                                      //           }).toList(),
                                      //         )),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Expanded(
                                  //       flex: 2,
                                  //       child: Padding(
                                  //         padding: const EdgeInsets.all(8.0),
                                  //         child: Column(
                                  //           crossAxisAlignment:
                                  //               CrossAxisAlignment.start,
                                  //           children: [
                                  //             Padding(
                                  //               padding: const EdgeInsets.all(8.0),
                                  //               child: Padding(
                                  //                 padding: const EdgeInsets.only(
                                  //                     left: 8.0),
                                  //                 child: Text(
                                  //                   "District",
                                  //                   style: TextStyle(
                                  //                     color: Colors.grey[700],
                                  //                     fontSize: 14,
                                  //                     // fontWeight: FontWeight.bold
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //             Container(
                                  //               height: 50,
                                  //               margin: EdgeInsets.all(5),
                                  //               decoration: BoxDecoration(
                                  //                 border: Border.all(
                                  //                     color: Colors
                                  //                         .grey, // Set border color
                                  //                     width: 1.0),
                                  //                 color: HexColor("#F9F9F9"),
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(5),
                                  //               ),
                                  //               child: Padding(
                                  //                 padding: const EdgeInsets.all(8.0),
                                  //                 child: Row(
                                  //                   children: [
                                  //                     // Icon(Icons.arrow_drop_down),
                                  //                     Container(
                                  //                       height: 300,
                                  //                       child: DropdownButton(
                                  //                         icon: Row(
                                  //                           children: [
                                  //                             Icon(Icons
                                  //                                 .arrow_drop_down),
                                  //                           ],
                                  //                         ),
                                  //                         underline: Container(),
                                  //                         // itemHeight: 60,
                                  //                         hint: Row(
                                  //                           children: [
                                  //                             Text('District   '),
                                  //                             SizedBox(
                                  //                                 width: MediaQuery.of(
                                  //                                             context)
                                  //                                         .size
                                  //                                         .width *
                                  //                                     0.45)
                                  //                           ],
                                  //                         ),
                                  //                         items: distlist.map((item) {
                                  //                           return DropdownMenuItem(
                                  //                             value: item['name']
                                  //                                 .toString(),
                                  //                             child: Card(
                                  //                               child: Row(
                                  //                                 children: [
                                  //                                   Text(item['name']
                                  //                                       .toString()),
                                  //                                 ],
                                  //                               ),
                                  //                             ),
                                  //                           );
                                  //                         }).toList(),
                                  //                         onChanged: (newVal) {
                                  //                           setState(() {
                                  //                             dropdownvaluedis =
                                  //                                 newVal.toString();
                                  //                           });
                                  //                         },
                                  //                         value: dropdownvaluedis,
                                  //                       ),
                                  //                     ),
                                  //                   ],
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  // Row(
                                  //   children: [
                                  //     Expanded(
                                  //       child: Container(
                                  //         margin: EdgeInsets.all(2),
                                  //         decoration: BoxDecoration(
                                  //             color: Colors.white,
                                  //             borderRadius: BorderRadius.circular(5)),
                                  //         child: Padding(
                                  //           padding: const EdgeInsets.only(
                                  //               left: 8.0, right: 8.0),
                                  //           child: CustomSearchableDropDown(
                                  //               primaryColor: Colors.black,
                                  //               items: catlist,
                                  //               label: 'Catagories',
                                  //               showLabelInMenu: true,
                                  //               onChanged: (value) async {
                                  //                 dropdownvaluecat = value;
                                  //               },
                                  //               dropDownMenuItems:
                                  //                   offLineCustomersDropDown == []
                                  //                       ? ['']
                                  //                       : offLineCustomersDropDown),
                                  //         ),
                                  //       ),
                                  //     )
                                  //   ],
                                  // ),
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
                                                  border: Border.all(
                                                      color: Colors
                                                          .grey, // Set border color
                                                      width: 1.0),
                                                  color: HexColor("#F9F9F9"),
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
                                                                    Colors
                                                                        .black,
                                                                items: catlist,
                                                                label: widget
                                                                            .status ==
                                                                        "isdetail"
                                                                    ? widget
                                                                        .catagory
                                                                    : 'Categories',
                                                                showLabelInMenu:
                                                                    true,
                                                                onChanged:
                                                                    (value) async {
                                                                  setState(() {
                                                                    dropdownvaluecat =
                                                                        value["name"]
                                                                            .toString();
                                                                    log(dropdownvaluecat
                                                                        .toString());
                                                                  });
                                                                },
                                                                dropDownMenuItems:
                                                                    offLineCustomersDropDown ==
                                                                            []
                                                                        ? ['']
                                                                        : offLineCustomersDropDown),
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
                                                  border: Border.all(
                                                      color: Colors
                                                          .grey, // Set border color
                                                      width: 1.0),
                                                  color: HexColor("#F9F9F9"),
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
                                                                    Colors
                                                                        .black,
                                                                items:
                                                                    sourcelist,
                                                                label: widget
                                                                            .status ==
                                                                        "isdetail"
                                                                    ? widget
                                                                        .Source
                                                                    : 'Source',
                                                                showLabelInMenu:
                                                                    true,
                                                                onChanged:
                                                                    (value) async {
                                                                  setState(() {
                                                                    dropdownvaluereference =
                                                                        null;
                                                                    shopdropdownvalue =
                                                                        null;
                                                                    employDropdownvalue =
                                                                        null;
                                                                    engineerdownvalueArea =
                                                                        null;
                                                                    contractordownvalueArea =
                                                                        null;
                                                                    print(contractordownvalueArea.toString()+'contname');
                                                                    if (widget
                                                                            .status ==
                                                                        "isedit") {
                                                                      dropdownvaluesource =
                                                                          widget
                                                                              .status;
                                                                    } else {
                                                                      dropdownvaluesource =
                                                                          value["name"]
                                                                              .toString();
                                                                      log(dropdownvaluesource
                                                                          .toString());
                                                                    }
                                                                  });
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

                                  Container(
                                    child: Column(
                                      children: [
                                        if (dropdownvaluesource == "CUSTOMER")
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        height: 52,
                                                        margin:
                                                            EdgeInsets.all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .grey, // Set border color
                                                              width: 1.0),
                                                          color: HexColor(
                                                              "#F9F9F9"),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                // margin: EdgeInsets.all(2),
                                                                decoration:
                                                                    BoxDecoration(
                                                                        //color: Colors.white,
                                                                        ),
                                                                child:
                                                                    CustomSearchableDropDown(
                                                                        primaryColor:
                                                                            Colors
                                                                                .black,
                                                                        items:
                                                                            referencelist,
                                                                        label: widget.Source ==
                                                                                "CUSTOMER"
                                                                            ? widget
                                                                                .name
                                                                            : 'Customer Name',
                                                                        showLabelInMenu:
                                                                            true,
                                                                        onChanged:
                                                                            (value) async {
                                                                          setState(
                                                                              () {
                                                                            dropdownvaluereference =
                                                                                value["name"].toString();
                                                                            log(dropdownvaluereference.toString());
                                                                          });
                                                                        },
                                                                        dropDownMenuItems: offLineCustomersname ==
                                                                                []
                                                                            ? [
                                                                                ''
                                                                              ]
                                                                            : offLineCustomersname),
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
                                        //employee
                                        if (dropdownvaluesource == "EMPLOYEE")
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        height: 52,
                                                        margin:
                                                            EdgeInsets.all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .grey, // Set border color
                                                              width: 1.0),
                                                          color: HexColor(
                                                              "#F9F9F9"),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                // margin: EdgeInsets.all(2),
                                                                decoration:
                                                                    BoxDecoration(
                                                                        //color: Colors.white,
                                                                        ),
                                                                child:
                                                                    CustomSearchableDropDown(
                                                                        primaryColor:
                                                                            Colors
                                                                                .black,
                                                                        items:
                                                                            emloyeelist,
                                                                        label: widget.Source ==
                                                                                "EMPLOYEE"
                                                                            ? widget
                                                                                .name
                                                                            : 'Employee Name',
                                                                        showLabelInMenu:
                                                                            true,
                                                                        onChanged:
                                                                            (value) async {
                                                                          setState(
                                                                              () {
                                                                            employDropdownvalue =
                                                                                value["name"].toString();
                                                                            employDropdownvalue1 =
                                                                                value["name"].toString();
                                                                            log(employDropdownvalue.toString());
                                                                          });
                                                                        },
                                                                        dropDownMenuItems: offemployname ==
                                                                                []
                                                                            ? [
                                                                                ''
                                                                              ]
                                                                            : offemployname),
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

                                        //shop
                                        if (dropdownvaluesource == "SHOPS")
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        height: 52,
                                                        margin:
                                                            EdgeInsets.all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .grey, // Set border color
                                                              width: 1.0),
                                                          color: HexColor(
                                                              "#F9F9F9"),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                // margin: EdgeInsets.all(2),
                                                                decoration:
                                                                    BoxDecoration(
                                                                        //color: Colors.white,
                                                                        ),
                                                                child:
                                                                    CustomSearchableDropDown(
                                                                        primaryColor:
                                                                            Colors
                                                                                .black,
                                                                        items:
                                                                            shoplist,
                                                                        label: widget.Source ==
                                                                                "SHOPS"
                                                                            ? widget
                                                                                .name
                                                                            : 'Shop Name',
                                                                        showLabelInMenu:
                                                                            true,
                                                                        onChanged:
                                                                            (value) async {
                                                                          setState(
                                                                              () {
                                                                            shopdropdownvalue =
                                                                                value["name"].toString();
                                                                            log(shopdropdownvalue.toString());
                                                                          });
                                                                        },
                                                                        dropDownMenuItems: shopname ==
                                                                                []
                                                                            ? [
                                                                                ''
                                                                              ]
                                                                            : shopname),
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

                                        //engineer
                                        if (dropdownvaluesource ==
                                            "ENGINEER / ARCHITECTS")
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        height: 52,
                                                        margin:
                                                            EdgeInsets.all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .grey, // Set border color
                                                              width: 1.0),
                                                          color: HexColor(
                                                              "#F9F9F9"),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                // margin: EdgeInsets.all(2),
                                                                decoration:
                                                                    BoxDecoration(
                                                                        //color: Colors.white,
                                                                        ),
                                                                child:
                                                                    CustomSearchableDropDown(
                                                                        primaryColor:
                                                                            Colors
                                                                                .black,
                                                                        items:
                                                                            engineerlist,
                                                                        label: widget.Source ==
                                                                                "ENGINEER / ARCHITECTS"
                                                                            ? widget
                                                                                .name
                                                                            : 'Engineer Name',
                                                                        showLabelInMenu:
                                                                            true,
                                                                        onChanged:
                                                                            (value) async {
                                                                          setState(
                                                                              () {
                                                                            engineerdownvalueArea =
                                                                                value["name"].toString();
                                                                            log(engineerdownvalueArea.toString()+'engname');
                                                                          });
                                                                        },
                                                                        dropDownMenuItems: engineername ==
                                                                                []
                                                                            ? [
                                                                                ''
                                                                              ]
                                                                            : engineername),
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
                                        if (dropdownvaluesource ==
                                            "CONTRACTORS / TRUSS WORKERS")
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        height: 52,
                                                        margin:
                                                            EdgeInsets.all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .grey, // Set border color
                                                              width: 1.0),
                                                          color: HexColor(
                                                              "#F9F9F9"),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                // margin: EdgeInsets.all(2),
                                                                decoration:
                                                                    BoxDecoration(
                                                                        //color: Colors.white,
                                                                        ),
                                                                child:
                                                                    CustomSearchableDropDown(
                                                                        primaryColor:
                                                                            Colors
                                                                                .black,
                                                                        items:
                                                                            contractorlist,
                                                                        label: widget.Source ==
                                                                                "CONTRACTORS / TRUSS WORKERS"
                                                                            ? widget
                                                                                .name
                                                                            : 'Contractor Name',
                                                                        showLabelInMenu:
                                                                            true,
                                                                        onChanged:
                                                                            (value) async {
                                                                          setState(
                                                                              () {
                                                                            contractordownvalueArea =
                                                                                value["name"].toString();
                                                                            log(contractordownvalueArea.toString());
                                                                          });
                                                                        },
                                                                        dropDownMenuItems: contractorName ==
                                                                                []
                                                                            ? [
                                                                                ''
                                                                              ]
                                                                            : contractorName),
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
                                     if (dropdownvaluesource == "SUB DEALER")
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        height: 52,
                                                        margin:
                                                            EdgeInsets.all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .grey, // Set border color
                                                              width: 1.0),
                                                          color: HexColor(
                                                              "#F9F9F9"),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                // margin: EdgeInsets.all(2),
                                                                decoration:
                                                                    BoxDecoration(
                                                                        //color: Colors.white,
                                                                        ),
                                                                child:
                                                                    CustomSearchableDropDown(
                                                                        primaryColor:
                                                                            Colors
                                                                                .black,
                                                                        items:
                                                                            subDealerList,
                                                                        label: widget.Source ==
                                                                                "SUB DEALER"
                                                                            ? widget
                                                                                .name
                                                                            : 'Subdealer Name',
                                                                        showLabelInMenu:
                                                                            true,
                                                                        onChanged:
                                                                            (value) async {
                                                                          setState(
                                                                              () {
                                                                            subdealerdownvalueArea =
                                                                                value["name"].toString();
                                                                            log(subdealerdownvalueArea.toString());
                                                                          });
                                                                        },
                                                                        dropDownMenuItems: subdealerName ==
                                                                                []
                                                                            ? [
                                                                                ''
                                                                              ]
                                                                            : subdealerName),
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
if (dropdownvaluesource == "DEALER")
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        height: 52,
                                                        margin:
                                                            EdgeInsets.all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .grey, // Set border color
                                                              width: 1.0),
                                                          color: HexColor(
                                                              "#F9F9F9"),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                // margin: EdgeInsets.all(2),
                                                                decoration:
                                                                    BoxDecoration(
                                                                        //color: Colors.white,
                                                                        ),
                                                                child:
                                                                    CustomSearchableDropDown(
                                                                        primaryColor:
                                                                            Colors
                                                                                .black,
                                                                        items:
                                                                            dealerList,
                                                                        label: widget.Source ==
                                                                                "DEALER"
                                                                            ? widget
                                                                                .name
                                                                            : 'Dealer Name',
                                                                        showLabelInMenu:
                                                                            true,
                                                                        onChanged:
                                                                            (value) async {
                                                                          setState(
                                                                              () {
                                                                            dealerdownvalueArea =
                                                                                value["name"].toString();
                                                                            log(dealerdownvalueArea.toString());
                                                                          });
                                                                        },
                                                                        dropDownMenuItems: dealerName ==
                                                                                []
                                                                            ? [
                                                                                ''
                                                                              ]
                                                                            : dealerName),
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

                                     
                                      ],
                                    ),
                                  ),
                                  (globals.role == "Area Sales Manager")
                                      ? Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 52,
                                                      margin: EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey, // Set border color
                                                            width: 1.0),
                                                        color:
                                                            HexColor("#F9F9F9"),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                              // margin: EdgeInsets.all(2),
                                                              decoration:
                                                                  BoxDecoration(
                                                                      //color: Colors.white,
                                                                      ),
                                                              child:
                                                                  CustomSearchableDropDown(
                                                                      primaryColor:
                                                                          Colors
                                                                              .black,
                                                                      items:
                                                                          arealist,
                                                                      // asm_areas,
                                                                      label:
                                                                          'Customer Area12',
                                                                      showLabelInMenu:
                                                                          true,
                                                                      onChanged:
                                                                          (value) async {
                                                                        setState(
                                                                            () {
                                                                          dropdownvaluelac =
                                                                              value["name"];
                                                                          log(dropdownvaluelac
                                                                              .toString());
                                                                        });
                                                                        getAlldist(
                                                                            dropdownvaluelac.toString());
                                                                      },
                                                                      dropDownMenuItems: lacDropDown ==
                                                                              []
                                                                          ? ['']
                                                                          : lacDropDown),
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
                                        )
                                      : Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 52,
                                                      margin: EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey, // Set border color
                                                            width: 1.0),
                                                        color:
                                                            HexColor("#F9F9F9"),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                              // margin: EdgeInsets.all(2),
                                                              decoration:
                                                                  BoxDecoration(
                                                                      //color: Colors.white,
                                                                      ),
                                                              child:
                                                                  CustomSearchableDropDown(
                                                                      primaryColor:
                                                                          Colors
                                                                              .black,
                                                                      items:
                                                                          laclist,
                                                                      label: widget.status ==
                                                                              "isdetail"
                                                                          ? widget
                                                                              .custarea
                                                                          : 'Customer Area',
                                                                      showLabelInMenu:
                                                                          true,
                                                                      onChanged:
                                                                          (value) async {
                                                                        setState(
                                                                            () {
                                                                          dropdownvaluelac =
                                                                              value["name"].toString();
                                                                          log(dropdownvaluelac
                                                                              .toString());
                                                                        });
                                                                        getAlldist(
                                                                            dropdownvaluelac.toString());
                                                                      },
                                                                      dropDownMenuItems: lacDropDown ==
                                                                              []
                                                                          ? ['']
                                                                          : lacDropDown),
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
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors
                                                          .grey, // Set border color
                                                      width: 1.0),
                                                  color: HexColor("#F9F9F9"),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                height: 50,
                                                margin: EdgeInsets.all(5),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0,
                                                          right: 8.0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: TextField(
                                                      controller: location,
                                                      // controller: ledgernameController,
                                                      textAlign: TextAlign.left,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Location",
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
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
                                                  border: Border.all(
                                                      color: Colors
                                                          .grey, // Set border color
                                                      width: 1.0),
                                                  color: HexColor("#F9F9F9"),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(dist == null
                                                            ? "District"
                                                            : dist.toString()),
                                                      ),
                                                       
                                                     
                                                    ],
                                                  ),
                                                ),
                                              ),
                                             
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
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8, left: 6),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[100],
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey, // Set border color
                                                        width: 1.0),
                                                    //   color: HexColor("#F9F9F9"),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  height: 50,
                                                  width: Constants(context)
                                                      .scrnWidth,
                                                  child: DropdownButton(
                                                    
                                                    // hint: "Reference",
                                                    hint: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text("Stage"),
                                                      ),
                                                    ),
                                                    underline: Container(),
                                                    // Initial Value
                                                    value: selectedStage,

                                                    // Down Arrow Icon
                                                    // icon: const Icon(
                                                    //     Icons.keyboard_arrow_down),

                                                    // Array list of items
                                                    items: stageList
                                                        .map((String items) {
                                                      return DropdownMenuItem(
                                                        value: items,
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      16.0),
                                                              child: Row(
                                                                children: [
                                                                  Text(items),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              width: Constants(
                                                                          context)
                                                                      .scrnWidth *
                                                                  .4,
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    }).toList(),
                                                    // After selecting the desired option,it will
                                                    // change button value to selected value
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        selectedStage =
                                                            newValue!;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),

                                            
                                  if (widget.status != "isdetail")
                                    Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: Container(
                                        height: 50,
                                        width: Constants(context).scrnWidth,
                                        child: ElevatedButton(
                                          child: Text(
                                            widget.status == "isdetail"
                                                ? 'Update Lead'
                                                : 'Create Lead',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            print(location.toString() + 'ttt5');
                                            setState(() {
                                              if (widget.status == "isdetail") {
                                                String pattern =
                                                    r'(^(?:[+0]12)?[0-12]{10,13}$)';
                                                RegExp regExp =
                                                    new RegExp(pattern);
                                                log(refdropdownvalue
                                                        .toString() +
                                                    "hlloooo");
                                                if (fname!.text.isEmpty) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "First Name is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                } else if (mnumber!
                                                    .text.isEmpty) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Mobile Number is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                }
                                                if (mnumber!.text.length == 0) {
                                                  valid = "";
                                                } else if (!regExp
                                                    .hasMatch(mnumber!.text)) {
                                                  setState(() {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            " 'Please enter valid mobile number'",
                                                        backgroundColor:
                                                            Colors.blue[100],
                                                        textColor:
                                                            Colors.black);
                                                    ;
                                                    mnumber!.clear();
                                                  });
                                                } else if (whatsappNumber!
                                                        .text !=
                                                    "") {
                                                  if (!regExp.hasMatch(
                                                      whatsappNumber!.text)) {
                                                    setState(() {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Please enter valid whatsapp number",
                                                          backgroundColor:
                                                              Colors.blue[100],
                                                          textColor:
                                                              Colors.black);
                                                      ;
                                                      whatsappNumber!.clear();
                                                    });
                                                  }
                                                } else if (refdropdownvalue ==
                                                    null) {
                                                  Fluttertoast.showToast(
                                                      msg: "Gender is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                } else if (dropdownvaluecat ==
                                                    null) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Catagories Is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                } else if (dropdownvaluesource ==
                                                    null) {
                                                  Fluttertoast.showToast(
                                                      msg: "Source Is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                } else if (dropdownvaluelac ==
                                                    null) {
                                                  Fluttertoast.showToast(
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black,
                                                      msg:
                                                          "Customer Area is Required");
                                                }
                                                // else if (phnumber.text.isEmpty) {
                                                //   Fluttertoast.showToast(
                                                //       msg: "Phon Number is Required",
                                                //       backgroundColor: Colors.blue[100],
                                                //       textColor: Colors.black);
                                                //   }
                                                else {
                                                  log(widget.status.toString());
                                                  if (widget.status ==
                                                      "isdetail") {
                                                    var m = datelll!.substring(
                                                        datelll!.length - 4,
                                                        datelll!.length - 3);
                                                    log(m.toString() +
                                                        "jnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
                                                    var ab = datelll!.length ==
                                                            8
                                                        ? datelll!.substring(
                                                                0,
                                                                datelll!.length -
                                                                    4) +
                                                            "-" +
                                                            "0" +
                                                            (datelll!.substring(
                                                                datelll!.length -
                                                                    3,
                                                                datelll!
                                                                    .length)) +
                                                            "0"
                                                        : datelll!.length == 9
                                                            ? datelll!.substring(
                                                                    0,
                                                                    datelll!.length -
                                                                        5) +
                                                                "-" +
                                                                "0" +
                                                                m.toString() +
                                                                (datelll!.substring(
                                                                    datelll!.length -
                                                                        3,
                                                                    datelll!
                                                                        .length))
                                                            : datelll
                                                                .toString();

                                                    DateTime b = DateTime.parse(
                                                        ab.toString());

                                                    DateTime c = DateTime.parse(
                                                        formattedDate);
                                                    ;
                                                    int d =
                                                        b.difference(c).inDays;
                                                    //String? stat;
                                                    if (d <= 30) {
                                                      status = "Hot";
                                                    } else {
                                                      status = "Lead";
                                                    }
                                                    log(status);
                                                    print("statusss" + status);

                                                    // var date2String =
                                                    //     outputformat.format(date1);
                                                    print(mnumber!.text
                                                        .toString());
                                                    //   log(date2String.toString());

                                                    isLoading = true;

                                                    log("1234");
                                                    LeadaddController()
                                                        .leadedit(
                                                            widget.lid
                                                                .toString(),
                                                            refdropdownvalue == ""
                                                                ? ""
                                                                : refdropdownvalue
                                                                    .toString(),
                                                            fname!.text,
                                                            lname!.text,
                                                            // a
                                                            //     .toString()
                                                            //     .replaceAll("/", "-"),

                                                            datelll == null
                                                                ? ""
                                                                : datelll
                                                                    .toString(),
                                                            dropdownvalueArea ==
                                                                    ""
                                                                ? ""
                                                                : dropdownvalueArea
                                                                    .toString(),
                                                            dropdownvaluesource ==
                                                                    ""
                                                                ? ""
                                                                : dropdownvaluesource
                                                                    .toString(),
                                                            userID.toString(),
                                                            refdropdownvalue ==
                                                                    ""
                                                                ? ""
                                                                : dropdownvaluesource
                                                                    .toString(),
                                                            widget
                                                                        .status ==
                                                                    "isdetail"
                                                                ? widget
                                                                        .Refer
                                                                    .toString()
                                                                : reference!
                                                                    .text,
                                                            "",
                                                            dropdownvaluecat ==
                                                                    ""
                                                                ? ""
                                                                : dropdownvaluecat
                                                                    .toString(),
                                                            email!.text,
                                                            mnumber!.text,
                                                            phnumber == "null"
                                                                ? ""
                                                                : "",
                                                            whatsappNumber!
                                                                .text,
                                                            dropdownvaluelac ==
                                                                    ""
                                                                ? ""
                                                                : dropdownvaluelac
                                                                    .toString(),
                                                            dist.toString(),
                                                            ldname == "null"
                                                                ? ""
                                                                : "",
                                                            dropdownvaluesource ==
                                                                    "CUSTOMER"
                                                                ? dropdownvaluereference
                                                                    .toString()
                                                                : dropdownvaluesource ==
                                                                        "SHOPS"
                                                                    ? shopdropdownvalue
                                                                        .toString()
                                                                    : dropdownvaluesource ==
                                                                            "EMPLOYEE"
                                                                        ? employDropdownvalue
                                                                            .toString()
                                                                        : dropdownvaluesource ==
                                                                                "ENGINEER / ARCHITECTS"
                                                                            ? engineerdownvalueArea
                                                                                .toString()
                                                                            : dropdownvaluesource ==
                                                                                    "CONTRACTORS / TRUSS WORKERS"
                                                                                ? contractordownvalueArea
                                                                                    .toString()   
                                                                                    :dropdownvaluesource == "DEALER"
                                                                                    ? dealerdownvalueArea.toString() :
                                                                                    dropdownvaluesource == "SUB DEALER"
                                                                                    ? subdealerdownvalueArea.toString()  
                                                                                : "",
                                                            refdropdownvalue ==
                                                                    null
                                                                ? ""
                                                                : dropdownvaluesource ==
                                                                        "CUSTOMER"
                                                                    ? 'a'
                                                                    : dropdownvaluesource ==
                                                                            "SHOPS"
                                                                        ? 'b'
                                                                        : dropdownvaluesource ==
                                                                                "EMPLOYEE"
                                                                            ? "c"
                                                                            : "d",
                                                            status == null
                                                                ? "Lead"
                                                                : status
                                                                    .toString(),
                                                            location.text,
                                                            selectedStage.toString() ?? ' '
                                                            );
                                                  } else {
                                                    log("123467");
                                                    LeadaddController()
                                                        .leadedit(
                                                            widget.lid
                                                                .toString(),
                                                            refdropdownvalue == ""
                                                                ? ""
                                                                : refdropdownvalue
                                                                    .toString(),
                                                            fname!.text,
                                                            lname!.text,
                                                            // a
                                                            //     .toString()
                                                            //     .replaceAll("/", "-"),

                                                            datelll == null
                                                                ? ""
                                                                : datelll
                                                                    .toString(),
                                                            dropdownvalueArea ==
                                                                    ""
                                                                ? ""
                                                                : dropdownvalueArea
                                                                    .toString(),
                                                            dropdownvaluesource ==
                                                                    ""
                                                                ? ""
                                                                : dropdownvaluesource
                                                                    .toString(),
                                                            userID.toString(),
                                                            refdropdownvalue ==
                                                                    ""
                                                                ? ""
                                                                : dropdownvaluesource
                                                                    .toString(),
                                                            widget
                                                                        .status ==
                                                                    "isdetail"
                                                                ? widget
                                                                        .Refer
                                                                    .toString()
                                                                : reference!
                                                                    .text,
                                                            "",
                                                            dropdownvaluecat ==
                                                                    ""
                                                                ? ""
                                                                : dropdownvaluecat
                                                                    .toString(),
                                                            email!.text,
                                                            mnumber!.text,
                                                            phnumber == "null"
                                                                ? ""
                                                                : "",
                                                            whatsappNumber!
                                                                .text,
                                                            dropdownvaluelac ==
                                                                    ""
                                                                ? ""
                                                                : dropdownvaluelac
                                                                    .toString(),
                                                            dist.toString(),
                                                            ldname == "null"
                                                                ? ""
                                                                : "",
                                                            dropdownvaluesource ==
                                                                    "CUSTOMER"
                                                                ? dropdownvaluereference
                                                                    .toString()
                                                                : dropdownvaluesource ==
                                                                        "SHOPS"
                                                                    ? shopdropdownvalue
                                                                        .toString()
                                                                    : dropdownvaluesource ==
                                                                            "EMPLOYEE"
                                                                        ? employDropdownvalue
                                                                            .toString()
                                                                        : dropdownvaluesource ==
                                                                                "ENGINEER / ARCHITECTS"
                                                                            ? engineerdownvalueArea
                                                                                .toString()
                                                                            : dropdownvaluesource ==
                                                                                    "CONTRACTORS / TRUSS WORKERS"
                                                                                ? contractordownvalueArea
                                                                                    .toString()
                                                                                     :dropdownvaluesource == "DEALER"
                                                                                    ? dealerdownvalueArea.toString() :
                                                                                    dropdownvaluesource == "SUB DEALER"
                                                                                    ? subdealerdownvalueArea.toString()
                                                                                : "",
                                                            refdropdownvalue ==
                                                                    null
                                                                ? ""
                                                                : dropdownvaluesource ==
                                                                        "CUSTOMER"
                                                                    ? 'a'
                                                                    : dropdownvaluesource ==
                                                                            "SHOPS"
                                                                        ? 'b'
                                                                        : dropdownvaluesource ==
                                                                                "EMPLOYEE"
                                                                            ? "c"
                                                                            : "d",
                                                            status == null
                                                                ? "Lead"
                                                                : status
                                                                    .toString(),
                                                            location.text,selectedStage.toString() ?? ' ');
                                                  }
                                                }
                                                log(widget.status.toString());
                                                if (widget.status ==
                                                        "isdetail" &&
                                                    widget.expectedpurchase ==
                                                        null) {
                                                  var m = datelll!.substring(
                                                      datelll!.length - 4,
                                                      datelll!.length - 3);
                                                  log(m.toString() +
                                                      "jnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
                                                  var ab = datelll!.length == 8
                                                      ? datelll!.substring(
                                                              0,
                                                              datelll!.length -
                                                                  4) +
                                                          "-" +
                                                          "0" +
                                                          (datelll!.substring(
                                                              datelll!.length -
                                                                  3,
                                                              datelll!
                                                                  .length)) +
                                                          "0"
                                                      : datelll!.length == 9
                                                          ? datelll!.substring(
                                                                  0,
                                                                  datelll!.length -
                                                                      5) +
                                                              "-" +
                                                              "0" +
                                                              m.toString() +
                                                              (datelll!.substring(
                                                                  datelll!.length -
                                                                      3,
                                                                  datelll!
                                                                      .length))
                                                          : datelll.toString();

                                                  log(widget.expectedpurchase
                                                      .toString());
                                                  DateTime b = DateTime.parse(
                                                      ab.toString());

                                                  DateTime c = DateTime.parse(
                                                      formattedDate);
                                                  ;
                                                  int d =
                                                      b.difference(c).inDays;
                                                  //String? stat;
                                                  if (d <= 30) {
                                                    status = "Hot";
                                                  } else {
                                                    status = "Lead";
                                                  }
                                                  log(status);
                                                  print("statusss" + status);

                                                  // var date2String =
                                                  //     outputformat.format(date1);
                                                  print(
                                                      mnumber!.text.toString());

                                                  isLoading = true;
                                                  log("12345");

                                                  //   log(date2String.toString());
                                                  LeadaddController().leadedit(
                                                      widget.lid.toString(),
                                                      refdropdownvalue == ""
                                                          ? ""
                                                          : refdropdownvalue
                                                              .toString(),
                                                      fname!.text,
                                                      lname!.text,
                                                      // a
                                                      //     .toString()
                                                      //     .replaceAll("/", "-"),

                                                      datelll == null
                                                          ? ""
                                                          : datelll.toString(),
                                                      dropdownvalueArea == ""
                                                          ? ""
                                                          : dropdownvalueArea
                                                              .toString(),
                                                      dropdownvaluesource == ""
                                                          ? ""
                                                          : dropdownvaluesource
                                                              .toString(),
                                                      userID.toString(),
                                                      refdropdownvalue == ""
                                                          ? ""
                                                          : dropdownvaluesource
                                                              .toString(),
                                                      widget.status == "isdetail"
                                                          ? widget.Refer
                                                              .toString()
                                                          : reference!.text,
                                                      "",
                                                      dropdownvaluecat == ""
                                                          ? ""
                                                          : dropdownvaluecat
                                                              .toString(),
                                                      email!.text,
                                                      mnumber!.text,
                                                      phnumber == "null"
                                                          ? ""
                                                          : "",
                                                      whatsappNumber!.text,
                                                      dropdownvaluelac == ""
                                                          ? ""
                                                          : dropdownvaluelac
                                                              .toString(),
                                                      dist.toString(),
                                                      ldname == "null"
                                                          ? ""
                                                          : "",
                                                      dropdownvaluesource ==
                                                              "CUSTOMER"
                                                          ? dropdownvaluereference
                                                              .toString()
                                                          : dropdownvaluesource ==
                                                                  "SHOPS"
                                                              ? shopdropdownvalue
                                                                  .toString()
                                                              : dropdownvaluesource ==
                                                                      "EMPLOYEE"
                                                                  ? employDropdownvalue
                                                                      .toString()
                                                                  : dropdownvaluesource ==
                                                                          "ENGINEER / ARCHITECTS"
                                                                      ? engineerdownvalueArea
                                                                          .toString()
                                                                      : dropdownvaluesource ==
                                                                              "CONTRACTORS / TRUSS WORKERS"
                                                                          ? contractordownvalueArea
                                                                              .toString()
                                                                               :dropdownvaluesource == "DEALER"
                                                                                    ? dealerdownvalueArea.toString() :
                                                                                    dropdownvaluesource == "SUB DEALER"
                                                                                    ? subdealerdownvalueArea.toString()
                                                                          : widget
                                                                              .name
                                                                              .toString(),
                                                      refdropdownvalue == null
                                                          ? ""
                                                          : dropdownvaluesource ==
                                                                  "CUSTOMER"
                                                              ? 'a'
                                                              : dropdownvaluesource ==
                                                                      "SHOPS"
                                                                  ? 'b'
                                                                  : dropdownvaluesource ==
                                                                          "EMPLOYEE"
                                                                      ? "c"
                                                                      : "d",
                                                      status == null
                                                          ? "Lead"
                                                          : status.toString(),
                                                      location.text,selectedStage.toString() ?? ' ');
                                                } else {
                                                  log(shopdropdownvalue
                                                          .toString() +
                                                      "ggggggggggggggg");

                                                  setState(() {
                                                    // log(shopdropdownvalue
                                                    //     .toString());
                                                    shopdropdownvalue =
                                                        shopdropdownvalue ==
                                                                null
                                                            ? widget.name
                                                            : widget.status ==
                                                                    "SHOPS"
                                                                ? widget.name
                                                                    .toString()
                                                                : shopdropdownvalue;
                                                    employDropdownvalue =
                                                        employDropdownvalue ==
                                                                null
                                                            ? widget.name
                                                            : widget.status ==
                                                                    "EMPLOYEE"
                                                                ? widget.name
                                                                : employDropdownvalue;
                                                    dropdownvaluereference =
                                                        dropdownvaluereference ==
                                                                null
                                                            ? widget.name
                                                            : widget.status ==
                                                                    "CUSTOMER"
                                                                ? widget.name
                                                                : dropdownvaluereference;
                                                    engineerdownvalueArea =
                                                        engineerdownvalueArea ==
                                                                null
                                                            ? widget.name
                                                            : widget.status ==
                                                                    "ENGINEER / ARCHITECTS"
                                                                ? widget.name
                                                                : engineerdownvalueArea;
                                                    contractordownvalueArea =
                                                        contractordownvalueArea ==
                                                                null
                                                            ? widget.name
                                                            : widget.status ==
                                                                    "CONTRACTORS / TRUSS WORKERS"
                                                                ? widget.name
                                                                
                                                                : contractordownvalueArea;
                                                  });
                                                  log("123");
                                                  var m = datelll!.substring(
                                                      datelll!.length - 4,
                                                      datelll!.length - 3);
                                                  log(m.toString() +
                                                      "jnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
                                                  var ab = datelll!.length == 8
                                                      ? datelll!.substring(
                                                              0,
                                                              datelll!.length -
                                                                  4) +
                                                          "-" +
                                                          "0" +
                                                          (datelll!.substring(
                                                              datelll!.length -
                                                                  3,
                                                              datelll!
                                                                  .length)) +
                                                          "0"
                                                      : datelll!.length == 9
                                                          ? datelll!.substring(
                                                                  0,
                                                                  datelll!.length -
                                                                      5) +
                                                              "-" +
                                                              "0" +
                                                              m.toString() +
                                                              (datelll!.substring(
                                                                  datelll!.length -
                                                                      3,
                                                                  datelll!
                                                                      .length))
                                                          : datelll.toString();

                                                  DateTime b = DateTime.parse(
                                                      ab.toString());

                                                  DateTime c = DateTime.parse(
                                                      formattedDate);
                                                  ;
                                                  int d =
                                                      b.difference(c).inDays;
                                                  //String? stat;
                                                  if (d <= 30) {
                                                    status = "Hot";
                                                  } else {
                                                    status = "Lead";
                                                  }
                                                  log(status);
                                                  print("statusss" + status);

                                                  // var date2String =
                                                  //     outputformat.format(date1);
                                                  print(
                                                      mnumber!.text.toString());
                                                  //   log(date2String.toString());

                                                  isLoading = true;
                                                  log("1");
                                                  LeadaddController().leadedit(
                                                      widget.lid.toString(),
                                                      refdropdownvalue == ""
                                                          ? ""
                                                          : refdropdownvalue
                                                              .toString(),
                                                      fname!.text,
                                                      lname!.text,
                                                      // a
                                                      //     .toString()
                                                      //     .replaceAll("/", "-"),

                                                      datelll == null
                                                          ? ""
                                                          : datelll.toString(),
                                                      dropdownvalueArea == ""
                                                          ? ""
                                                          : dropdownvalueArea
                                                              .toString(),
                                                      dropdownvaluesource == ""
                                                          ? ""
                                                          : dropdownvaluesource
                                                              .toString(),
                                                      userID.toString(),
                                                      refdropdownvalue == ""
                                                          ? ""
                                                          : dropdownvaluesource
                                                              .toString(),
                                                      widget.status == "isdetail"
                                                          ? widget.Refer
                                                              .toString()
                                                          : reference!.text,
                                                      "",
                                                      dropdownvaluecat == ""
                                                          ? ""
                                                          : dropdownvaluecat
                                                              .toString(),
                                                      email!.text,
                                                      mnumber!.text,
                                                      phnumber == "null"
                                                          ? ""
                                                          : "",
                                                      whatsappNumber!.text,
                                                      dropdownvaluelac == ""
                                                          ? ""
                                                          : dropdownvaluelac
                                                              .toString(),
                                                      dist.toString(),
                                                      ldname == "null"
                                                          ? ""
                                                          : "",
                                                      dropdownvaluesource ==
                                                              "CUSTOMER"
                                                          ? dropdownvaluereference
                                                              .toString()
                                                          : dropdownvaluesource ==
                                                                  "SHOPS"
                                                              ? shopdropdownvalue
                                                                  .toString()
                                                              : dropdownvaluesource ==
                                                                      "EMPLOYEE"
                                                                  ? employDropdownvalue
                                                                      .toString()
                                                                  : dropdownvaluesource ==
                                                                          "ENGINEER / ARCHITECTS"
                                                                      ? engineerdownvalueArea
                                                                          .toString()
                                                                      : dropdownvaluesource ==
                                                                              "CONTRACTORS / TRUSS WORKERS"
                                                                          ? contractordownvalueArea
                                                                              .toString()
                                                                               :dropdownvaluesource == "DEALER"
                                                                                    ? dealerdownvalueArea.toString() :
                                                                                    dropdownvaluesource == "SUB DEALER"
                                                                                    ? subdealerdownvalueArea.toString()
                                                                          : widget
                                                                              .name
                                                                              .toString(),
                                                      refdropdownvalue == null
                                                          ? ""
                                                          : dropdownvaluesource ==
                                                                  "CUSTOMER"
                                                              ? 'a'
                                                              : dropdownvaluesource ==
                                                                      "SHOPS"
                                                                  ? 'b'
                                                                  : dropdownvaluesource ==
                                                                          "EMPLOYEE"
                                                                      ? "c"
                                                                      : "d",
                                                      status == null
                                                          ? "Lead"
                                                          : status.toString(),
                                                      location.text,selectedStage.toString() ?? ' ');
                                                }
                                              } else {
                                                String pattern =
                                                    r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                                RegExp regExp =
                                                    new RegExp(pattern);
                                                log(refdropdownvalue
                                                        .toString() +
                                                    "hlloooo");
                                                if (fname!.text.isEmpty) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "First Name is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                } else if (mnumber!
                                                    .text.isEmpty) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Mobile Number is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                }
                                                if (mnumber!.text.length == 0) {
                                                  valid = "";
                                                } else if (!regExp
                                                    .hasMatch(mnumber!.text)) {
                                                  setState(() {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            " 'Please enter valid mobile number'",
                                                        backgroundColor:
                                                            Colors.blue[100],
                                                        textColor:
                                                            Colors.black);
                                                    ;
                                                    mnumber!.clear();
                                                  });
                                                } else if (whatsappNumber!
                                                            .text !=
                                                        "" &&
                                                    !regExp.hasMatch(
                                                        whatsappNumber!.text)) {
                                                  setState(() {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Please enter valid whatsapp number",
                                                        backgroundColor:
                                                            Colors.blue[100],
                                                        textColor:
                                                            Colors.black);
                                                    ;
                                                    whatsappNumber!.clear();
                                                  });
                                                } else if (refdropdownvalue ==
                                                    null) {
                                                  Fluttertoast.showToast(
                                                      msg: "Gender is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                } else if (dropdownvaluecat ==
                                                    null) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Categories is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                } else if (dropdownvaluesource ==
                                                    null) {
                                                  Fluttertoast.showToast(
                                                      msg: "Source is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                } else if (dropdownvaluesource ==
                                                        "CUSTOMER" &&
                                                    refdropdownvalue == "") {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Customer name is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                } else if (dropdownvaluesource ==
                                                        "EMPLOYEE" &&
                                                    employDropdownvalue ==
                                                        null) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Employee name is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                } else if (dropdownvaluesource ==
                                                        "SHOPS" &&
                                                    shopdropdownvalue == null) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Shops name is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                } else if (dropdownvaluesource ==
                                                        "ENGINEER / ARCHITECTS" &&
                                                    engineerdownvalueArea ==
                                                        null) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Engineer name is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                }else if (dropdownvaluesource ==
                                                        "DEALER" &&
                                                    dealerdownvalueArea ==
                                                        null) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Dealer name is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                }else if (dropdownvaluesource ==
                                                        "SUB DEALER" &&
                                                    subdealerdownvalueArea ==
                                                        null) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "SubDealer name is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                } else if (dropdownvaluesource ==
                                                        "CONTRACTORS / TRUSS WORKERS" &&
                                                    contractordownvalueArea ==
                                                        null) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "contractor name is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                } else if (dropdownvaluelac ==
                                                    null) {
                                                  Fluttertoast.showToast(
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black,
                                                      msg:
                                                          "Customer Area Is Required");
                                                }
                                                // else if (phnumber.text.isEmpty) {
                                                //   Fluttertoast.showToast(
                                                //       msg: "Phon Number is Required",
                                                //       backgroundColor: Colors.blue[100],
                                                //       textColor: Colors.black);
                                                //   }
                                                else {
                                                  log(datelll.toString() +
                                                      "hiii");

                                                  log(datelll.toString());
                                                  if (datelll != null) {
                                                    print(userID.toString());
                                                    log(a.toString() +
                                                        "mmmmmmmmmmm");
                                                    log(DateFormat('dd/MM/yyyy')
                                                        .format(now)
                                                        .toString());
                                                    log(DateTime.now()
                                                        .toString());
                                                    var inputformat =
                                                        DateFormat(
                                                            "dd/MM/yyyy");
                                                    var date1 = inputformat
                                                        .parse(datelll == ""
                                                            ? DateFormat(
                                                                    'dd/MM/yyyy')
                                                                .format(DateTime
                                                                    .now())
                                                            : a.toString());
                                                    var outputformat =
                                                        DateFormat('yyy-MM-dd');
                                                    var date2 = outputformat
                                                        .format(date1);
                                                    print(date2.toString());

                                                    DateTime b = DateTime.parse(
                                                        date1.toString());

                                                    DateTime c = DateTime.parse(
                                                        formattedDate);
                                                    ;
                                                    int d =
                                                        b.difference(c).inDays;
                                                    //String? stat;
                                                    if (d <= 30) {
                                                      status = "Hot";
                                                    } else {
                                                      status = "Lead";
                                                    }
                                                    log(status);
                                                    print("statusss" + status);

                                                    var date2String =
                                                        outputformat
                                                            .format(date1);
                                                    print(mnumber!.text
                                                        .toString());
                                                    log(date2String.toString());

                                                    isLoading = true;

                                                    LeadaddController().leadadd(
                                                        refdropdownvalue == ""
                                                            ? ""
                                                            : refdropdownvalue
                                                                .toString(),
                                                        fname!.text,
                                                        lname!.text,
                                                        // a
                                                        //     .toString()
                                                        //     .replaceAll("/", "-"),

                                                        datelll == null
                                                            ? ""
                                                            : datelll
                                                                .toString(),
                                                        dropdownvalueArea == ""
                                                            ? ""
                                                            : dropdownvalueArea
                                                                .toString(),
                                                        dropdownvaluesource ==
                                                                ""
                                                            ? ""
                                                            : dropdownvaluesource
                                                                .toString(),
                                                        userID.toString(),
                                                        refdropdownvalue == ""
                                                            ? ""
                                                            : dropdownvaluesource
                                                                .toString(),
                                                        reference == ""
                                                            ? ""
                                                            : "",
                                                        "",
                                                        dropdownvaluecat == ""
                                                            ? ""
                                                            : dropdownvaluecat
                                                                .toString(),
                                                        email!.text,
                                                        mnumber!.text,
                                                        //  phnumber!.text,
                                                        "",
                                                        whatsappNumber!.text,
                                                        dropdownvaluelac == ""
                                                            ? ""
                                                            : dropdownvaluelac
                                                                .toString(),
                                                        dist.toString(),
                                                        // ldname!.text,
                                                        "",
                                                        dropdownvaluesource ==
                                                                "CUSTOMER"
                                                            ? dropdownvaluereference
                                                                .toString()
                                                            : dropdownvaluesource ==
                                                                    "SHOPS"
                                                                ? shopdropdownvalue
                                                                    .toString()
                                                                : dropdownvaluesource ==
                                                                        "EMPLOYEE"
                                                                    ? employDropdownvalue1
                                                                        .toString()
                                                                    : dropdownvaluesource ==
                                                                            "ENGINEER / ARCHITECTS"
                                                                        ? engineerdownvalueArea
                                                                            .toString()
                                                                        : dropdownvaluesource ==
                                                                                "CONTRACTORS / TRUSS WORKERS"
                                                                            ? contractordownvalueArea
                                                                                .toString()
                                                                                 :dropdownvaluesource == "DEALER"
                                                                                    ? dealerdownvalueArea.toString() :
                                                                                    dropdownvaluesource == "SUB DEALER"
                                                                                    ? subdealerdownvalueArea.toString()
                                                                            : "",
                                                        refdropdownvalue == null
                                                            ? ""
                                                            : dropdownvaluesource ==
                                                                    "CUSTOMER"
                                                                ? 'a'
                                                                : dropdownvaluesource ==
                                                                        "SHOPS"
                                                                    ? 'b'
                                                                    : dropdownvaluesource ==
                                                                            "EMPLOYEE"
                                                                        ? "c"
                                                                        : "d",
                                                        status == null
                                                            ? "Lead"
                                                            : status.toString(),
                                                        location.text
                                                            .toString(),selectedStage.toString() ?? ' ');
                                                  } else {
                                                    log(a.toString());
                                                    log(status.toString());
                                                    isLoading = true;
                                                    LeadaddController().leadadd(
                                                        refdropdownvalue == ""
                                                            ? ""
                                                            : refdropdownvalue
                                                                .toString(),
                                                        fname!.text,
                                                        lname!.text,
                                                        // a
                                                        //     .toString()
                                                        //     .replaceAll("/", "-"),

                                                        datelll == null
                                                            ? ""
                                                            : datelll
                                                                .toString(),
                                                        dropdownvalueArea == ""
                                                            ? ""
                                                            : dropdownvalueArea
                                                                .toString(),
                                                        dropdownvaluesource ==
                                                                ""
                                                            ? ""
                                                            : dropdownvaluesource
                                                                .toString(),
                                                        userID.toString(),
                                                        refdropdownvalue == ""
                                                            ? ""
                                                            : dropdownvaluesource
                                                                .toString(),
                                                        reference == ""
                                                            ? ""
                                                            : "",
                                                        "",
                                                        dropdownvaluecat == ""
                                                            ? ""
                                                            : dropdownvaluecat
                                                                .toString(),
                                                        email!.text,
                                                        mnumber!.text,
                                                        //  phnumber!.text,
                                                        "",
                                                        whatsappNumber!.text,
                                                        dropdownvaluelac == ""
                                                            ? ""
                                                            : dropdownvaluelac
                                                                .toString(),
                                                        dist.toString(),
                                                        // ldname!.text,
                                                        "",
                                                        dropdownvaluesource ==
                                                                "CUSTOMER"
                                                            ? dropdownvaluereference
                                                                .toString()
                                                            : dropdownvaluesource ==
                                                                    "SHOPS"
                                                                ? shopdropdownvalue
                                                                    .toString()
                                                                : dropdownvaluesource ==
                                                                        "EMPLOYEE"
                                                                    ? employDropdownvalue1
                                                                        .toString()
                                                                    : dropdownvaluesource ==
                                                                            "ENGINEER / ARCHITECTS"
                                                                        ? engineerdownvalueArea
                                                                            .toString()
                                                                        : dropdownvaluesource ==
                                                                                "CONTRACTORS / TRUSS WORKERS"
                                                                            ? contractordownvalueArea
                                                                                .toString()
                                                                                 :dropdownvaluesource == "DEALER"
                                                                                    ? dealerdownvalueArea.toString() :
                                                                                    dropdownvaluesource == "SUB DEALER"
                                                                                    ? subdealerdownvalueArea.toString()
                                                                            : "",
                                                        refdropdownvalue == null
                                                            ? ""
                                                            : dropdownvaluesource ==
                                                                    "CUSTOMER"
                                                                ? 'a'
                                                                : dropdownvaluesource ==
                                                                        "SHOPS"
                                                                    ? 'b'
                                                                    : dropdownvaluesource ==
                                                                            "EMPLOYEE"
                                                                        ? "c"
                                                                        : "d",
                                                        status == null
                                                            ? "Lead"
                                                            : status.toString(),
                                                        location.text
                                                            .toString(),selectedStage.toString() ?? ' ');
                                                  }
                                                }
                                              }
                                            });
                                            Future.delayed(
                                                const Duration(seconds: 3), () {
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
                                            //  addlo();
                                            //  addlo();

                                            // Get.to(LeadaddView());
                                          }

                                          // Get.to(LeadaddView());

                                          ,
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Color.fromARGB(
                                                          255, 4, 7, 105)),
                                              padding:
                                                  MaterialStateProperty.all(
                                                      EdgeInsets.all(5)),
                                              textStyle:
                                                  MaterialStateProperty.all(
                                                      TextStyle(fontSize: 16))),
                                        ),
                                      ),
                                    ),
                                  if (widget.status == "isdetail")
                                    Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: Container(
                                        height: 50,
                                        width: Constants(context).scrnWidth,
                                        child: ElevatedButton(
                                          child: Text(
                                            widget.status == "isdetail"
                                                ? 'Update Lead'
                                                : 'Create Lead',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            print(location.text.toString() +
                                                'ttt5');
                                            setState(() {
                                              if (widget.status == "isdetail") {
                                                String pattern =
                                                    r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                                RegExp regExp =
                                                    new RegExp(pattern);
                                                log(refdropdownvalue
                                                        .toString() +
                                                    "hlloooo");
                                                if (fname!.text.isEmpty) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "First Name is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                } else if (mnumber!
                                                    .text.isEmpty) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Mobile Number is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                }
                                                if (mnumber!.text.length == 0) {
                                                  valid = "";
                                                } else if (!regExp
                                                    .hasMatch(mnumber!.text)) {
                                                  setState(() {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            " 'Please enter valid mobile number'",
                                                        backgroundColor:
                                                            Colors.blue[100],
                                                        textColor:
                                                            Colors.black);
                                                    ;
                                                    mnumber!.clear();
                                                  });
                                                } else if (whatsappNumber!
                                                        .text !=
                                                    "") {
                                                  if (!regExp.hasMatch(
                                                      whatsappNumber!.text)) {
                                                    setState(() {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Please enter valid whatsapp number",
                                                          backgroundColor:
                                                              Colors.blue[100],
                                                          textColor:
                                                              Colors.black);
                                                      ;
                                                      whatsappNumber!.clear();
                                                    });
                                                  }
                                                } else if (refdropdownvalue ==
                                                    null) {
                                                  Fluttertoast.showToast(
                                                      msg: "Gender is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                } else if (dropdownvaluecat ==
                                                    null) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Catagories Is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                } else if (dropdownvaluesource ==
                                                    null) {
                                                  Fluttertoast.showToast(
                                                      msg: "Source Is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                } else if (dropdownvaluelac ==
                                                    null) {
                                                  Fluttertoast.showToast(
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black,
                                                      msg:
                                                          "Customer Area is Required");
                                                }
                                                // else if (phnumber.text.isEmpty) {
                                                //   Fluttertoast.showToast(
                                                //       msg: "Phon Number is Required",
                                                //       backgroundColor: Colors.blue[100],
                                                //       textColor: Colors.black);
                                                //   }
                                                else {
                                                  log(widget.status.toString());
                                                  log(datelll.toString() +
                                                      "hhhhhhhhhhh");
                                                  setState(() {
                                                    datelll.toString();
                                                  });
                                                  if (datelll != null &&
                                                      datelll != "") {
                                                    log(datelll.toString() +
                                                        "bhhhhhhhhhhhhhhhhh");
                                                    var m = datelll!.substring(
                                                        datelll!.length - 4,
                                                        datelll!.length - 3);
                                                    log(m.toString() +
                                                        "jnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
                                                    var ab = datelll!.length ==
                                                            8
                                                        ? datelll!.substring(
                                                                0,
                                                                datelll!.length -
                                                                    4) +
                                                            "-" +
                                                            "0" +
                                                            (datelll!.substring(
                                                                datelll!.length -
                                                                    3,
                                                                datelll!
                                                                    .length)) +
                                                            "0"
                                                        : datelll!.length == 9
                                                            ? datelll!.substring(
                                                                    0,
                                                                    datelll!.length -
                                                                        5) +
                                                                "-" +
                                                                "0" +
                                                                m.toString() +
                                                                (datelll!.substring(
                                                                    datelll!.length -
                                                                        3,
                                                                    datelll!
                                                                        .length))
                                                            : datelll
                                                                .toString();

                                                    log(ab.toString() +
                                                        "hhhhhhhhhhhhhhhhhnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
                                                    // DateTime b = DateTime.parse(
                                                    //     datelll.toString());

                                                    DateTime c = DateTime.parse(
                                                        formattedDate);
                                                    ;
                                                    int d = DateTime.parse(
                                                            ab.toString())
                                                        .difference(c)
                                                        .inDays;
                                                    //String? stat;
                                                    if (d <= 30) {
                                                      status = "Hot";
                                                    } else {
                                                      status = "Lead";
                                                    }
                                                    log(status);
                                                    print("statusss" + status);

                                                    // var date2String =
                                                    //     outputformat.format(date1);
                                                    print(mnumber!.text
                                                        .toString());
                                                    //   log(date2String.toString());

                                                    isLoading = true;

                                                    log("1234");
                                                    LeadaddController()
                                                        .leadedit(
                                                            widget.lid
                                                                .toString(),
                                                            refdropdownvalue == ""
                                                                ? ""
                                                                : refdropdownvalue
                                                                    .toString(),
                                                            fname!.text,
                                                            lname!.text,
                                                            // a
                                                            //     .toString()
                                                            //     .replaceAll("/", "-"),

                                                            datelll == null
                                                                ? ""
                                                                : datelll
                                                                    .toString(),
                                                            dropdownvalueArea ==
                                                                    ""
                                                                ? ""
                                                                : dropdownvalueArea
                                                                    .toString(),
                                                            dropdownvaluesource ==
                                                                    ""
                                                                ? ""
                                                                : dropdownvaluesource
                                                                    .toString(),
                                                            userID.toString(),
                                                            refdropdownvalue ==
                                                                    ""
                                                                ? ""
                                                                : dropdownvaluesource
                                                                    .toString(),
                                                            widget
                                                                        .status ==
                                                                    "isdetail"
                                                                ? widget
                                                                        .Refer
                                                                    .toString()
                                                                : reference!
                                                                    .text,
                                                            "",
                                                            dropdownvaluecat ==
                                                                    ""
                                                                ? ""
                                                                : dropdownvaluecat
                                                                    .toString(),
                                                            email!.text,
                                                            mnumber!.text,
                                                            phnumber == "null"
                                                                ? ""
                                                                : "",
                                                            whatsappNumber!
                                                                .text,
                                                            dropdownvaluelac ==
                                                                    ""
                                                                ? ""
                                                                : dropdownvaluelac
                                                                    .toString(),
                                                            dist.toString(),
                                                            ldname == "null"
                                                                ? ""
                                                                : "",
                                                            dropdownvaluesource ==
                                                                    "CUSTOMER"
                                                                ? dropdownvaluereference
                                                                    .toString()
                                                                : dropdownvaluesource ==
                                                                        "SHOPS"
                                                                    ? shopdropdownvalue
                                                                        .toString()
                                                                    : dropdownvaluesource ==
                                                                            "EMPLOYEE"
                                                                        ? employDropdownvalue1
                                                                            .toString()
                                                                        : dropdownvaluesource ==
                                                                                "ENGINEER / ARCHITECTS"
                                                                            ? engineerdownvalueArea
                                                                                .toString()
                                                                            : dropdownvaluesource ==
                                                                                    "CONTRACTORS / TRUSS WORKERS"
                                                                                ? contractordownvalueArea
                                                                                    .toString()
                                                                                     :dropdownvaluesource == "DEALER"
                                                                                    ? dealerdownvalueArea.toString() :
                                                                                    dropdownvaluesource == "SUB DEALER"
                                                                                    ? subdealerdownvalueArea.toString()
                                                                                : "",
                                                            refdropdownvalue ==
                                                                    null
                                                                ? ""
                                                                : dropdownvaluesource ==
                                                                        "CUSTOMER"
                                                                    ? 'a'
                                                                    : dropdownvaluesource ==
                                                                            "SHOPS"
                                                                        ? 'b'
                                                                        : dropdownvaluesource ==
                                                                                "EMPLOYEE"
                                                                            ? "c"
                                                                            : "d",
                                                            status == null
                                                                ? "Lead"
                                                                : status
                                                                    .toString(),
                                                            location.text,selectedStage.toString() ?? ' ');
                                                  } else {
                                                    log("123467");
                                                    log(status.toString() +
                                                        "jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj");
                                                    LeadaddController()
                                                        .leadedit(
                                                            widget.lid
                                                                .toString(),
                                                            refdropdownvalue == ""
                                                                ? ""
                                                                : refdropdownvalue
                                                                    .toString(),
                                                            fname!.text,
                                                            lname!.text,
                                                            // a
                                                            //     .toString()
                                                            //     .replaceAll("/", "-"),

                                                            datelll == null
                                                                ? ""
                                                                : datelll
                                                                    .toString(),
                                                            dropdownvalueArea ==
                                                                    ""
                                                                ? ""
                                                                : dropdownvalueArea
                                                                    .toString(),
                                                            dropdownvaluesource ==
                                                                    ""
                                                                ? ""
                                                                : dropdownvaluesource
                                                                    .toString(),
                                                            userID.toString(),
                                                            refdropdownvalue ==
                                                                    ""
                                                                ? ""
                                                                : dropdownvaluesource
                                                                    .toString(),
                                                            widget
                                                                        .status ==
                                                                    "isdetail"
                                                                ? widget
                                                                        .Refer
                                                                    .toString()
                                                                : reference!
                                                                    .text,
                                                            "",
                                                            dropdownvaluecat ==
                                                                    ""
                                                                ? ""
                                                                : dropdownvaluecat
                                                                    .toString(),
                                                            email!.text,
                                                            mnumber!.text,
                                                            phnumber == "null"
                                                                ? ""
                                                                : "",
                                                            whatsappNumber!
                                                                .text,
                                                            dropdownvaluelac ==
                                                                    ""
                                                                ? ""
                                                                : dropdownvaluelac
                                                                    .toString(),
                                                            dist.toString(),
                                                            ldname == "null"
                                                                ? ""
                                                                : "",
                                                            dropdownvaluesource ==
                                                                    "CUSTOMER"
                                                                ? dropdownvaluereference
                                                                    .toString()
                                                                : dropdownvaluesource ==
                                                                        "SHOPS"
                                                                    ? shopdropdownvalue
                                                                        .toString()
                                                                    : dropdownvaluesource ==
                                                                            "EMPLOYEE"
                                                                        ? employDropdownvalue1
                                                                            .toString()
                                                                        : dropdownvaluesource ==
                                                                                "ENGINEER / ARCHITECTS"
                                                                            ? engineerdownvalueArea
                                                                                .toString()
                                                                            : dropdownvaluesource ==
                                                                                    "CONTRACTORS / TRUSS WORKERS"
                                                                                ? contractordownvalueArea
                                                                                    .toString()
                                                                                     :dropdownvaluesource == "DEALER"
                                                                                    ? dealerdownvalueArea.toString() :
                                                                                    dropdownvaluesource == "SUB DEALER"
                                                                                    ? subdealerdownvalueArea.toString()
                                                                                : "",
                                                            refdropdownvalue ==
                                                                    null
                                                                ? ""
                                                                : dropdownvaluesource ==
                                                                        "CUSTOMER"
                                                                    ? 'a'
                                                                    : dropdownvaluesource ==
                                                                            "SHOPS"
                                                                        ? 'b'
                                                                        : dropdownvaluesource ==
                                                                                "EMPLOYEE"
                                                                            ? "c"
                                                                            : "d",
                                                            "Lead",
                                                            location.text,selectedStage.toString() ?? ' ');
                                                  }
                                                }
                                                log(widget.status.toString());
                                                if (widget.status ==
                                                        "isdetail" &&
                                                    widget.expectedpurchase !=
                                                        "") {
                                                  var m = datelll!.substring(
                                                      datelll!.length - 4,
                                                      datelll!.length - 3);
                                                  log(m.toString() +
                                                      "jnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
                                                  var ab = datelll!.length == 8
                                                      ? datelll!.substring(
                                                              0,
                                                              datelll!.length -
                                                                  4) +
                                                          "-" +
                                                          "0" +
                                                          (datelll!.substring(
                                                              datelll!.length -
                                                                  3,
                                                              datelll!
                                                                  .length)) +
                                                          "0"
                                                      : datelll!.length == 9
                                                          ? datelll!.substring(
                                                                  0,
                                                                  datelll!.length -
                                                                      5) +
                                                              "-" +
                                                              "0" +
                                                              m.toString() +
                                                              (datelll!.substring(
                                                                  datelll!.length -
                                                                      3,
                                                                  datelll!
                                                                      .length))
                                                          : datelll.toString();

                                                  log(widget.expectedpurchase
                                                      .toString());
                                                  DateTime b = DateTime.parse(
                                                      ab.toString());

                                                  DateTime c = DateTime.parse(
                                                      formattedDate);
                                                  ;
                                                  int d =
                                                      b.difference(c).inDays;
                                                  //String? stat;
                                                  if (d <= 30) {
                                                    status = "Hot";
                                                  } else {
                                                    status = "Lead";
                                                  }
                                                  log(status);
                                                  print("statusss" + status);

                                                  // var date2String =
                                                  //     outputformat.format(date1);
                                                  print(
                                                      mnumber!.text.toString());

                                                  isLoading = true;
                                                  log("12345");
                                                  log(employDropdownvalue1
                                                      .toString());
                                                  setState(() {
                                                    // log(shopdropdownvalue
                                                    //     .toString());
                                                    shopdropdownvalue =
                                                        shopdropdownvalue ==
                                                                null
                                                            ? widget.name
                                                            : widget.status ==
                                                                    "SHOPS"
                                                                ? widget.name
                                                                    .toString()
                                                                : shopdropdownvalue;
                                                    employDropdownvalue =
                                                        employDropdownvalue ==
                                                                null
                                                            ? widget.name
                                                            : widget.status ==
                                                                    "EMPLOYEE"
                                                                ? widget.name
                                                                : employDropdownvalue1;
                                                    dropdownvaluereference =
                                                        dropdownvaluereference ==
                                                                null
                                                            ? widget.name
                                                            : widget.status ==
                                                                    "CUSTOMER"
                                                                ? widget.name
                                                                : dropdownvaluereference;
                                                    engineerdownvalueArea =
                                                        engineerdownvalueArea ==
                                                                null
                                                            ? widget.name
                                                            : widget.status ==
                                                                    "ENGINEER / ARCHITECTS"
                                                                ? widget.name
                                                                : engineerdownvalueArea;
                                                    engineerdownvalueArea =
                                                        contractordownvalueArea ==
                                                                null
                                                            ? widget.name
                                                            : widget.status ==
                                                                    "CONTRACTORS / TRUSS WORKERS"
                                                                ? widget.name
                                                                : contractordownvalueArea;
                                                  });

                                                  //   log(date2String.toString());
                                                  LeadaddController().leadedit(
                                                      widget.lid.toString(),
                                                      refdropdownvalue == ""
                                                          ? ""
                                                          : refdropdownvalue
                                                              .toString(),
                                                      fname!.text,
                                                      lname!.text,
                                                      // a
                                                      //     .toString()
                                                      //     .replaceAll("/", "-"),

                                                      datelll == null
                                                          ? ""
                                                          : datelll.toString(),
                                                      dropdownvalueArea == ""
                                                          ? ""
                                                          : dropdownvalueArea
                                                              .toString(),
                                                      dropdownvaluesource ==
                                                              null
                                                          ? ""
                                                          : dropdownvaluesource
                                                              .toString(),
                                                      userID.toString(),
                                                      refdropdownvalue == ""
                                                          ? ""
                                                          : dropdownvaluesource
                                                              .toString(),
                                                      widget.status ==
                                                              "isdetail"
                                                          ? widget.Refer
                                                              .toString()
                                                          : reference!.text,
                                                      "",
                                                      dropdownvaluecat == ""
                                                          ? ""
                                                          : dropdownvaluecat
                                                              .toString(),
                                                      email!.text,
                                                      mnumber!.text,
                                                      phnumber == "null"
                                                          ? ""
                                                          : "",
                                                      whatsappNumber!.text,
                                                      dropdownvaluelac == ""
                                                          ? ""
                                                          : dropdownvaluelac
                                                              .toString(),
                                                      dist.toString(),
                                                      ldname == "null"
                                                          ? ""
                                                          : "",
                                                      dropdownvaluesource ==
                                                              "CUSTOMER"
                                                          ? dropdownvaluereference
                                                              .toString()
                                                          : dropdownvaluesource ==
                                                                  "SHOPS"
                                                              ? shopdropdownvalue
                                                                  .toString()
                                                              : dropdownvaluesource ==
                                                                      "EMPLOYEE"
                                                                  ? employDropdownvalue1
                                                                      .toString()
                                                                  : dropdownvaluesource ==
                                                                          "ENGINEER / ARCHITECTS"
                                                                      ? engineerdownvalueArea
                                                                          .toString()
                                                                      : dropdownvaluesource ==
                                                                              "CONTRACTORS / TRUSS WORKERS"
                                                                          ? contractordownvalueArea
                                                                              .toString()
                                                                               :dropdownvaluesource == "DEALER"
                                                                                    ? dealerdownvalueArea.toString() :
                                                                                    dropdownvaluesource == "SUB DEALER"
                                                                                    ? subdealerdownvalueArea.toString()
                                                                          : "",
                                                      refdropdownvalue == null
                                                          ? ""
                                                          : dropdownvaluesource ==
                                                                  "CUSTOMER"
                                                              ? 'a'
                                                              : dropdownvaluesource ==
                                                                      "SHOPS"
                                                                  ? 'b'
                                                                  : dropdownvaluesource ==
                                                                          "EMPLOYEE"
                                                                      ? "c"
                                                                      : "d",
                                                      status == null
                                                          ? "Lead"
                                                          : status.toString(),
                                                      location.text,selectedStage.toString() ?? ' ');
                                                } else {
                                                  log(shopdropdownvalue
                                                          .toString() +
                                                      "ggggggggggggggg");

                                                  setState(() {
                                                    // log(shopdropdownvalue
                                                    //     .toString());
                                                    shopdropdownvalue =
                                                        shopdropdownvalue ==
                                                                null
                                                            ? widget.name
                                                            : widget.status ==
                                                                    "SHOPS"
                                                                ? widget.name
                                                                    .toString()
                                                                : shopdropdownvalue;
                                                    employDropdownvalue =
                                                        employDropdownvalue ==
                                                                null
                                                            ? widget.name
                                                            : widget.status ==
                                                                    "EMPLOYEE"
                                                                ? widget.name
                                                                : employDropdownvalue1;
                                                    dropdownvaluereference =
                                                        dropdownvaluereference ==
                                                                null
                                                            ? widget.name
                                                            : widget.status ==
                                                                    "CUSTOMER"
                                                                ? widget.name
                                                                : dropdownvaluereference;
                                                    engineerdownvalueArea =
                                                        engineerdownvalueArea ==
                                                                null
                                                            ? widget.name
                                                            : widget.status ==
                                                                    "ENGINEER / ARCHITECTS"
                                                                ? widget.name
                                                                : engineerdownvalueArea;

                                                    contractordownvalueArea =
                                                        contractordownvalueArea ==
                                                                null
                                                            ? widget.name
                                                            : widget.status ==
                                                                    "CONTRACTORS / TRUSS WORKERS"
                                                                ? widget.name
                                                                : contractordownvalueArea;
                                                  });

                                                  log("123");
                                                  log(datelll.toString());

                                                  if (datelll == "" &&
                                                      datelll == null) {
                                                    LeadaddController()
                                                        .leadedit(
                                                            widget.lid
                                                                .toString(),
                                                            refdropdownvalue == ""
                                                                ? ""
                                                                : refdropdownvalue
                                                                    .toString(),
                                                            fname!.text,
                                                            lname!.text,
                                                            // a
                                                            //     .toString()
                                                            //     .replaceAll("/", "-"),

                                                            datelll == null
                                                                ? ""
                                                                : datelll
                                                                    .toString(),
                                                            dropdownvalueArea ==
                                                                    ""
                                                                ? ""
                                                                : dropdownvalueArea
                                                                    .toString(),
                                                            dropdownvaluesource ==
                                                                    ""
                                                                ? ""
                                                                : dropdownvaluesource
                                                                    .toString(),
                                                            userID.toString(),
                                                            refdropdownvalue ==
                                                                    ""
                                                                ? ""
                                                                : dropdownvaluesource
                                                                    .toString(),
                                                            widget
                                                                        .status ==
                                                                    "isdetail"
                                                                ? widget
                                                                        .Refer
                                                                    .toString()
                                                                : reference!
                                                                    .text,
                                                            "",
                                                            dropdownvaluecat ==
                                                                    ""
                                                                ? ""
                                                                : dropdownvaluecat
                                                                    .toString(),
                                                            email!.text,
                                                            mnumber!.text,
                                                            phnumber == "null"
                                                                ? ""
                                                                : "",
                                                            whatsappNumber!
                                                                .text,
                                                            dropdownvaluelac ==
                                                                    ""
                                                                ? ""
                                                                : dropdownvaluelac
                                                                    .toString(),
                                                            dist.toString(),
                                                            ldname == "null"
                                                                ? ""
                                                                : "",
                                                            dropdownvaluesource ==
                                                                    "CUSTOMER"
                                                                ? dropdownvaluereference
                                                                    .toString()
                                                                : dropdownvaluesource ==
                                                                        "SHOPS"
                                                                    ? shopdropdownvalue
                                                                        .toString()
                                                                    : dropdownvaluesource ==
                                                                            "EMPLOYEE"
                                                                        ? employDropdownvalue1
                                                                            .toString()
                                                                        : dropdownvaluesource ==
                                                                                "ENGINEER / ARCHITECTS"
                                                                            ? engineerdownvalueArea
                                                                                .toString()
                                                                            : dropdownvaluesource ==
                                                                                    "CONTRACTORS / TRUSS WORKERS"
                                                                                ? contractordownvalueArea
                                                                                    .toString()
                                                                                     :dropdownvaluesource == "DEALER"
                                                                                    ? dealerdownvalueArea.toString() :
                                                                                    dropdownvaluesource == "SUB DEALER"
                                                                                    ? subdealerdownvalueArea.toString()
                                                                                : ""
                                                                                    .toString(),
                                                            refdropdownvalue ==
                                                                    null
                                                                ? ""
                                                                : dropdownvaluesource ==
                                                                        "CUSTOMER"
                                                                    ? 'a'
                                                                    : dropdownvaluesource ==
                                                                            "SHOPS"
                                                                        ? 'b'
                                                                        : dropdownvaluesource ==
                                                                                "EMPLOYEE"
                                                                            ? "c"
                                                                            : "d",
                                                            "Lead",
                                                            location.text,selectedStage.toString() ?? ' ');
                                                  } else {
                                                    if (datelll != "") {
                                                      // log("hii");
                                                      log("datell" +
                                                          datelll.toString());
                                                      print(userID.toString());
                                                      log(a.toString() +
                                                          "mmmmmmmmmmm");
                                                      log(DateFormat(
                                                              'dd/MM/yyyy')
                                                          .format(now)
                                                          .toString());
                                                      log(DateTime.now()
                                                          .toString());
                                                      var inputformat =
                                                          DateFormat(
                                                              "dd/MM/yyyy");
                                                      var date1 = inputformat
                                                          .parse(datelll == ""
                                                              ? DateFormat(
                                                                      'dd/MM/yyyy')
                                                                  .format(
                                                                      DateTime
                                                                          .now())
                                                              : a.toString());
                                                      var outputformat =
                                                          DateFormat(
                                                              'yyy-MM-dd');
                                                      var date2 = outputformat
                                                          .format(date1);
                                                      print(date2.toString());

                                                      DateTime b =
                                                          DateTime.parse(
                                                              date1.toString());

                                                      DateTime c =
                                                          DateTime.parse(
                                                              formattedDate);
                                                      ;
                                                      int d = b
                                                          .difference(c)
                                                          .inDays;
                                                      //String? stat;
                                                      if (d <= 30) {
                                                        status = "Hot";
                                                      } else {
                                                        status = "Lead";
                                                      }
                                                      log(status);
                                                      print(
                                                          "statusss" + status);

                                                      var date2String =
                                                          outputformat
                                                              .format(date1);
                                                      print(mnumber!.text
                                                          .toString());
                                                      log(date2String
                                                          .toString());

                                                      isLoading = true;
                                                      isLoading = true;
                                                      log("2");
                                                      LeadaddController()
                                                          .leadedit(
                                                              widget.lid
                                                                  .toString(),
                                                              refdropdownvalue == ""
                                                                  ? ""
                                                                  : refdropdownvalue
                                                                      .toString(),
                                                              fname!.text,
                                                              lname!.text,
                                                              // a
                                                              //     .toString()
                                                              //     .replaceAll("/", "-"),

                                                              datelll == null
                                                                  ? ""
                                                                  : datelll
                                                                      .toString(),
                                                              dropdownvalueArea ==
                                                                      ""
                                                                  ? ""
                                                                  : dropdownvalueArea
                                                                      .toString(),
                                                              dropdownvaluesource ==
                                                                      ""
                                                                  ? ""
                                                                  : dropdownvaluesource
                                                                      .toString(),
                                                              userID.toString(),
                                                              refdropdownvalue ==
                                                                      ""
                                                                  ? ""
                                                                  : dropdownvaluesource
                                                                      .toString(),
                                                              widget.status ==
                                                                      "isdetail"
                                                                  ? widget.Refer
                                                                      .toString()
                                                                  : reference!
                                                                      .text,
                                                              "",
                                                              dropdownvaluecat ==
                                                                      ""
                                                                  ? ""
                                                                  : dropdownvaluecat
                                                                      .toString(),
                                                              email!.text,
                                                              mnumber!.text,
                                                              phnumber == "null"
                                                                  ? ""
                                                                  : "",
                                                              whatsappNumber!
                                                                  .text,
                                                              dropdownvaluelac ==
                                                                      ""
                                                                  ? ""
                                                                  : dropdownvaluelac
                                                                      .toString(),
                                                              dist.toString(),
                                                              ldname ==
                                                                      "null"
                                                                  ? ""
                                                                  : "",
                                                              dropdownvaluesource ==
                                                                      "CUSTOMER"
                                                                  ? dropdownvaluereference
                                                                      .toString()
                                                                  : dropdownvaluesource ==
                                                                          "SHOPS"
                                                                      ? shopdropdownvalue
                                                                          .toString()
                                                                      : dropdownvaluesource ==
                                                                              "EMPLOYEE"
                                                                          ? employDropdownvalue1
                                                                              .toString()
                                                                          : dropdownvaluesource ==
                                                                                  "ENGINEER / ARCHITECTS"
                                                                              ? engineerdownvalueArea
                                                                                  .toString()
                                                                              : dropdownvaluesource ==
                                                                                      "CONTRACTORS / TRUSS WORKERS"
                                                                                  ? contractordownvalueArea
                                                                                      .toString():dropdownvaluesource == "DEALER"
                                                                                    ? dealerdownvalueArea.toString() :
                                                                                    dropdownvaluesource == "SUB DEALER"
                                                                                    ? subdealerdownvalueArea.toString()
                                                                                      .toString()
                                                                                  : "" ,
                                                              refdropdownvalue ==
                                                                      null
                                                                  ? ""
                                                                  : dropdownvaluesource ==
                                                                          "CUSTOMER"
                                                                      ? 'a'
                                                                      : dropdownvaluesource ==
                                                                              "SHOPS"
                                                                          ? 'b'
                                                                          : dropdownvaluesource ==
                                                                                  "EMPLOYEE"
                                                                              ? "c"
                                                                              : "d",
                                                              status == null
                                                                  ? "Lead"
                                                                  : status
                                                                      .toString(),
                                                              location.text,selectedStage.toString() ?? ' ');
                                                    } else {
                                                      log("new");
                                                      log("3");
                                                      LeadaddController()
                                                          .leadedit(
                                                              widget.lid
                                                                  .toString(),
                                                              refdropdownvalue == ""
                                                                  ? ""
                                                                  : refdropdownvalue
                                                                      .toString(),
                                                              fname!.text,
                                                              lname!.text,
                                                              // a
                                                              //     .toString()
                                                              //     .replaceAll("/", "-"),

                                                              datelll == null
                                                                  ? ""
                                                                  : datelll
                                                                      .toString(),
                                                              dropdownvalueArea ==
                                                                      ""
                                                                  ? ""
                                                                  : dropdownvalueArea
                                                                      .toString(),
                                                              dropdownvaluesource ==
                                                                      ""
                                                                  ? ""
                                                                  : dropdownvaluesource
                                                                      .toString(),
                                                              userID.toString(),
                                                              refdropdownvalue ==
                                                                      ""
                                                                  ? ""
                                                                  : dropdownvaluesource
                                                                      .toString(),
                                                              widget.status ==
                                                                      "isdetail"
                                                                  ? widget.Refer
                                                                      .toString()
                                                                  : reference!
                                                                      .text,
                                                              "",
                                                              dropdownvaluecat ==
                                                                      ""
                                                                  ? ""
                                                                  : dropdownvaluecat
                                                                      .toString(),
                                                              email!.text,
                                                              mnumber!.text,
                                                              phnumber == "null"
                                                                  ? ""
                                                                  : "",
                                                              whatsappNumber!
                                                                  .text,
                                                              dropdownvaluelac ==
                                                                      ""
                                                                  ? ""
                                                                  : dropdownvaluelac
                                                                      .toString(),
                                                              dist.toString(),
                                                              ldname == "null"
                                                                  ? ""
                                                                  : "",
                                                              dropdownvaluesource ==
                                                                      "CUSTOMER"
                                                                  ? dropdownvaluereference
                                                                      .toString()
                                                                  : dropdownvaluesource ==
                                                                          "SHOPS"
                                                                      ? shopdropdownvalue
                                                                          .toString()
                                                                      : dropdownvaluesource ==
                                                                              "EMPLOYEE"
                                                                          ? employDropdownvalue1
                                                                              .toString()
                                                                          : dropdownvaluesource ==
                                                                                  "ENGINEER / ARCHITECTS"
                                                                              ? engineerdownvalueArea
                                                                                  .toString()
                                                                              : dropdownvaluesource ==
                                                                                      "CONTRACTORS / TRUSS WORKERS"
                                                                                  ? contractordownvalueArea
                                                                                      .toString() :dropdownvaluesource == "DEALER"
                                                                                    ? dealerdownvalueArea.toString() :
                                                                                    dropdownvaluesource == "SUB DEALER"
                                                                                    ? subdealerdownvalueArea.toString()
                                                                                  : "",
                                                              refdropdownvalue ==
                                                                      null
                                                                  ? ""
                                                                  : dropdownvaluesource ==
                                                                          "CUSTOMER"
                                                                      ? 'a'
                                                                      : dropdownvaluesource ==
                                                                              "SHOPS"
                                                                          ? 'b'
                                                                          : dropdownvaluesource == "EMPLOYEE"
                                                                              ? "c"
                                                                              : "d",
                                                              "Lead",
                                                              location.text,selectedStage.toString() ?? ' ');
                                                    }
                                                    var m = datelll!.substring(
                                                        datelll!.length - 4,
                                                        datelll!.length - 3);
                                                    log(m.toString() +
                                                        "jnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
                                                    var ab = datelll!.length ==
                                                            8
                                                        ? datelll!.substring(
                                                                0,
                                                                datelll!.length -
                                                                    4) +
                                                            "-" +
                                                            "0" +
                                                            (datelll!.substring(
                                                                datelll!.length -
                                                                    3,
                                                                datelll!
                                                                    .length)) +
                                                            "0"
                                                        : datelll!.length == 9
                                                            ? datelll!.substring(
                                                                    0,
                                                                    datelll!.length -
                                                                        5) +
                                                                "-" +
                                                                "0" +
                                                                m.toString() +
                                                                (datelll!.substring(
                                                                    datelll!.length -
                                                                        3,
                                                                    datelll!
                                                                        .length))
                                                            : datelll
                                                                .toString();

                                                    DateTime b = DateTime.parse(
                                                        ab.toString());

                                                    DateTime c = DateTime.parse(
                                                        formattedDate);
                                                    ;
                                                    int d =
                                                        b.difference(c).inDays;
                                                    //String? stat;
                                                    if (d <= 30) {
                                                      status = "Hot";
                                                    } else {
                                                      status = "Lead";
                                                    }
                                                    log(status);
                                                    print("statusss" + status);

                                                    // var date2String =
                                                    //     outputformat.format(date1);
                                                    print(mnumber!.text
                                                        .toString());
                                                    //   log(date2String.toString());

                                                    isLoading = true;

                                                    LeadaddController()
                                                        .leadedit(
                                                            widget.lid
                                                                .toString(),
                                                            refdropdownvalue == ""
                                                                ? ""
                                                                : refdropdownvalue
                                                                    .toString(),
                                                            fname!.text,
                                                            lname!.text,
                                                            // a
                                                            //     .toString()
                                                            //     .replaceAll("/", "-"),

                                                            datelll == null
                                                                ? ""
                                                                : datelll
                                                                    .toString(),
                                                            dropdownvalueArea ==
                                                                    ""
                                                                ? ""
                                                                : dropdownvalueArea
                                                                    .toString(),
                                                            dropdownvaluesource ==
                                                                    ""
                                                                ? ""
                                                                : dropdownvaluesource
                                                                    .toString(),
                                                            userID.toString(),
                                                            refdropdownvalue ==
                                                                    ""
                                                                ? ""
                                                                : dropdownvaluesource
                                                                    .toString(),
                                                            widget
                                                                        .status ==
                                                                    "isdetail"
                                                                ? widget
                                                                        .Refer
                                                                    .toString()
                                                                : reference!
                                                                    .text,
                                                            "",
                                                            dropdownvaluecat ==
                                                                    ""
                                                                ? ""
                                                                : dropdownvaluecat
                                                                    .toString(),
                                                            email!.text,
                                                            mnumber!.text,
                                                            phnumber == "null"
                                                                ? ""
                                                                : "",
                                                            whatsappNumber!
                                                                .text,
                                                            dropdownvaluelac ==
                                                                    ""
                                                                ? ""
                                                                : dropdownvaluelac
                                                                    .toString(),
                                                            dist.toString(),
                                                            ldname == "null"
                                                                ? ""
                                                                : "",
                                                            dropdownvaluesource ==
                                                                    "CUSTOMER"
                                                                ? dropdownvaluereference
                                                                    .toString()
                                                                : dropdownvaluesource ==
                                                                        "SHOPS"
                                                                    ? shopdropdownvalue
                                                                        .toString()
                                                                    : dropdownvaluesource ==
                                                                            "EMPLOYEE"
                                                                        ? employDropdownvalue1
                                                                            .toString()
                                                                        : dropdownvaluesource ==
                                                                                "ENGINEER / ARCHITECTS"
                                                                            ? engineerdownvalueArea
                                                                                .toString()
                                                                            : dropdownvaluesource ==
                                                                                    "CONTRACTORS / TRUSS WORKERS"
                                                                                ? contractordownvalueArea
                                                                                    .toString() :dropdownvaluesource == "DEALER"
                                                                                    ? dealerdownvalueArea.toString() :
                                                                                    dropdownvaluesource == "SUB DEALER"
                                                                                    ? subdealerdownvalueArea.toString()
                                                                                : "",
                                                            refdropdownvalue ==
                                                                    null
                                                                ? ""
                                                                : dropdownvaluesource ==
                                                                        "CUSTOMER"
                                                                    ? 'a'
                                                                    : dropdownvaluesource ==
                                                                            "SHOPS"
                                                                        ? 'b'
                                                                        : dropdownvaluesource ==
                                                                                "EMPLOYEE"
                                                                            ? "c"
                                                                            : "d",
                                                            status == null
                                                                ? "Lead"
                                                                : status
                                                                    .toString(),
                                                            location.text,selectedStage.toString() ?? ' ');
                                                  }
                                                }
                                              } else {
                                                String pattern =
                                                    r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                                RegExp regExp =
                                                    new RegExp(pattern);
                                                log(refdropdownvalue
                                                        .toString() +
                                                    "hlloooo");
                                                if (fname!.text.isEmpty) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "First Name is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                } else if (mnumber!
                                                    .text.isEmpty) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Mobile Number is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                }
                                                if (mnumber!.text.length == 0) {
                                                  valid = "";
                                                } else if (!regExp
                                                    .hasMatch(mnumber!.text)) {
                                                  setState(() {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            " 'Please enter valid mobile number'",
                                                        backgroundColor:
                                                            Colors.blue[100],
                                                        textColor:
                                                            Colors.black);
                                                    ;
                                                    mnumber!.clear();
                                                  });
                                                } else if (whatsappNumber!
                                                            .text !=
                                                        "" &&
                                                    !regExp.hasMatch(
                                                        whatsappNumber!.text)) {
                                                  setState(() {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Please enter valid whatsapp number",
                                                        backgroundColor:
                                                            Colors.blue[100],
                                                        textColor:
                                                            Colors.black);
                                                    ;
                                                    whatsappNumber!.clear();
                                                  });
                                                } else if (refdropdownvalue ==
                                                    null) {
                                                  Fluttertoast.showToast(
                                                      msg: "Gender is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                } else if (dropdownvaluecat ==
                                                    null) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Categories is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                } else if (dropdownvaluesource ==
                                                    null) {
                                                  Fluttertoast.showToast(
                                                      msg: "Source is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                } else if (dropdownvaluesource ==
                                                        "CUSTOMER" &&
                                                    refdropdownvalue == "") {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Customer name is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                } else if (dropdownvaluesource ==
                                                        "EMPLOYEE" &&
                                                    employDropdownvalue ==
                                                        null) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Employee name is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                } else if (dropdownvaluesource ==
                                                        "SHOPS" &&
                                                    shopdropdownvalue == null) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Shops name is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                } else if (dropdownvaluesource ==
                                                        "ENGINEER / ARCHITECTS" &&
                                                    engineerdownvalueArea ==
                                                        null) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Engineer name is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                }else if (dropdownvaluesource ==
                                                        "DEALER" &&
                                                    dealerdownvalueArea ==
                                                        null) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Dealer name is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                }else if (dropdownvaluesource ==
                                                        "SUB DEALER" &&
                                                    subdealerdownvalueArea ==
                                                        null) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "SubDealer name is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                } else if (dropdownvaluesource ==
                                                        "CONTRACTORS / TRUSS WORKERS" &&
                                                    contractordownvalueArea ==
                                                        null) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Contractor name is Required",
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black);
                                                } else if (dropdownvaluelac ==
                                                    null) {
                                                  Fluttertoast.showToast(
                                                      backgroundColor:
                                                          Colors.blue[100],
                                                      textColor: Colors.black,
                                                      msg:
                                                          "Customer Area Is Required");
                                                }
                                                // else if (phnumber.text.isEmpty) {
                                                //   Fluttertoast.showToast(
                                                //       msg: "Phon Number is Required",
                                                //       backgroundColor: Colors.blue[100],
                                                //       textColor: Colors.black);
                                                //   }
                                                else {
                                                  //  log("hii");
                                                  log(datelll.toString() +
                                                      "hiii");

                                                  log(datelll.toString());
                                                  if (datelll != null) {
                                                    print(userID.toString());
                                                    log(a.toString() +
                                                        "mmmmmmmmmmm");
                                                    log(DateFormat('dd/MM/yyyy')
                                                        .format(now)
                                                        .toString());
                                                    log(DateTime.now()
                                                        .toString());
                                                    var inputformat =
                                                        DateFormat(
                                                            "dd/MM/yyyy");
                                                    var date1 = inputformat
                                                        .parse(datelll == ""
                                                            ? DateFormat(
                                                                    'dd/MM/yyyy')
                                                                .format(DateTime
                                                                    .now())
                                                            : a.toString());
                                                    var outputformat =
                                                        DateFormat('yyy-MM-dd');
                                                    var date2 = outputformat
                                                        .format(date1);
                                                    print(date2.toString());

                                                    DateTime b = DateTime.parse(
                                                        date1.toString());

                                                    DateTime c = DateTime.parse(
                                                        formattedDate);
                                                    ;
                                                    int d =
                                                        b.difference(c).inDays;
                                                    //String? stat;
                                                    if (d <= 30) {
                                                      status = "Hot";
                                                    } else {
                                                      status = "Lead";
                                                    }
                                                    log(status);
                                                    print("statusss" + status);

                                                    var date2String =
                                                        outputformat
                                                            .format(date1);
                                                    print(mnumber!.text
                                                        .toString());
                                                    log(date2String.toString());

                                                    isLoading = true;
                                                    LeadaddController().leadadd(
                                                        refdropdownvalue == ""
                                                            ? ""
                                                            : refdropdownvalue
                                                                .toString(),
                                                        fname!.text,
                                                        lname!.text,
                                                        // a
                                                        //     .toString()
                                                        //     .replaceAll("/", "-"),

                                                        datelll == null
                                                            ? ""
                                                            : datelll
                                                                .toString(),
                                                        dropdownvalueArea == ""
                                                            ? ""
                                                            : dropdownvalueArea
                                                                .toString(),
                                                        dropdownvaluesource ==
                                                                ""
                                                            ? ""
                                                            : dropdownvaluesource
                                                                .toString(),
                                                        userID.toString(),
                                                        refdropdownvalue == ""
                                                            ? ""
                                                            : dropdownvaluesource
                                                                .toString(),
                                                        reference == ""
                                                            ? ""
                                                            : "",
                                                        "",
                                                        dropdownvaluecat == ""
                                                            ? ""
                                                            : dropdownvaluecat
                                                                .toString(),
                                                        email!.text,
                                                        mnumber!.text,
                                                        //  phnumber!.text,
                                                        "",
                                                        whatsappNumber!.text,
                                                        dropdownvaluelac == ""
                                                            ? ""
                                                            : dropdownvaluelac
                                                                .toString(),
                                                        dist.toString(),
                                                        // ldname!.text,
                                                        "",
                                                        dropdownvaluesource ==
                                                                "CUSTOMER"
                                                            ? dropdownvaluereference
                                                                .toString()
                                                            : dropdownvaluesource ==
                                                                    "SHOPS"
                                                                ? shopdropdownvalue
                                                                    .toString()
                                                                : dropdownvaluesource ==
                                                                        "EMPLOYEE"
                                                                    ? employDropdownvalue1
                                                                        .toString()
                                                                    : dropdownvaluesource ==
                                                                            "ENGINEER / ARCHITECTS"
                                                                        ? engineerdownvalueArea
                                                                            .toString()
                                                                        : dropdownvaluesource ==
                                                                                "CONTRACTORS / TRUSS WORKERS"
                                                                            ? contractordownvalueArea
                                                                                .toString()
                                                                            : dropdownvaluesource ==
                                                                                    ""
                                                                                ? ""
                                                                                    .toString() :dropdownvaluesource == "DEALER"
                                                                                    ? dealerdownvalueArea.toString() :
                                                                                    dropdownvaluesource == "SUB DEALER"
                                                                                    ? subdealerdownvalueArea.toString()
                                                                                : "",
                                                        refdropdownvalue == null
                                                            ? ""
                                                            : dropdownvaluesource ==
                                                                    "CUSTOMER"
                                                                ? 'a'
                                                                : dropdownvaluesource ==
                                                                        "SHOPS"
                                                                    ? 'b'
                                                                    : dropdownvaluesource ==
                                                                            "EMPLOYEE"
                                                                        ? "c"
                                                                        : "d",
                                                        status == null
                                                            ? "Lead"
                                                            : status.toString(),
                                                        location.text
                                                            .toString(),selectedStage.toString() ?? ' ');
                                                  } else {
                                                    log(a.toString());
                                                    log(status.toString());
                                                    isLoading = true;
                                                    LeadaddController().leadadd(
                                                        refdropdownvalue == ""
                                                            ? ""
                                                            : refdropdownvalue
                                                                .toString(),
                                                        fname!.text,
                                                        lname!.text,
                                                        // a
                                                        //     .toString()
                                                        //     .replaceAll("/", "-"),

                                                        datelll == null
                                                            ? ""
                                                            : datelll
                                                                .toString(),
                                                        dropdownvalueArea == ""
                                                            ? ""
                                                            : dropdownvalueArea
                                                                .toString(),
                                                        dropdownvaluesource ==
                                                                ""
                                                            ? ""
                                                            : dropdownvaluesource
                                                                .toString(),
                                                        userID.toString(),
                                                        refdropdownvalue == ""
                                                            ? ""
                                                            : dropdownvaluesource
                                                                .toString(),
                                                        reference == ""
                                                            ? ""
                                                            : "",
                                                        "",
                                                        dropdownvaluecat == ""
                                                            ? ""
                                                            : dropdownvaluecat
                                                                .toString(),
                                                        email!.text,
                                                        mnumber!.text,
                                                        //  phnumber!.text,
                                                        "",
                                                        whatsappNumber!.text,
                                                        dropdownvaluelac == ""
                                                            ? ""
                                                            : dropdownvaluelac
                                                                .toString(),
                                                        dist.toString(),
                                                        // ldname!.text,
                                                        "",
                                                        dropdownvaluesource ==
                                                                "CUSTOMER"
                                                            ? dropdownvaluereference
                                                                .toString()
                                                            : dropdownvaluesource ==
                                                                    "SHOPS"
                                                                ? shopdropdownvalue
                                                                    .toString()
                                                                : dropdownvaluesource ==
                                                                        "EMPLOYEE"
                                                                    ? employDropdownvalue1
                                                                        .toString()
                                                                    : dropdownvaluesource ==
                                                                            "ENGINEER / ARCHITECTS"
                                                                        ? engineerdownvalueArea
                                                                            .toString()
                                                                        : dropdownvaluesource ==
                                                                                "CONTRACTORS / TRUSS WORKERS"
                                                                            ? contractordownvalueArea
                                                                                .toString() :dropdownvaluesource == "DEALER"
                                                                                    ? dealerdownvalueArea.toString() :
                                                                                    dropdownvaluesource == "SUB DEALER"
                                                                                    ? subdealerdownvalueArea.toString()
                                                                            : "",
                                                        refdropdownvalue == null
                                                            ? ""
                                                            : dropdownvaluesource ==
                                                                    "CUSTOMER"
                                                                ? 'a'
                                                                : dropdownvaluesource ==
                                                                        "SHOPS"
                                                                    ? 'b'
                                                                    : dropdownvaluesource ==
                                                                            "EMPLOYEE"
                                                                        ? "c"
                                                                        : "d",
                                                        status ==
                                                                DateFormat(
                                                                        'dd/MM/yyyy')
                                                                    .format(
                                                                        DateTime
                                                                            .now())
                                                            ? "Lead"
                                                            : status.toString(),
                                                        location.text
                                                            .toString(),selectedStage.toString() ?? ' ');
                                                  }
                                                }
                                              }
                                            });
                                            Future.delayed(
                                                const Duration(seconds: 3), () {
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
                                            //  addlo();
                                            //  addlo();

                                            // Get.to(LeadaddView());
                                          }

                                          // Get.to(LeadaddView());

                                          ,
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Color.fromARGB(
                                                          255, 4, 7, 105)),
                                              padding:
                                                  MaterialStateProperty.all(
                                                      EdgeInsets.all(5)),
                                              textStyle:
                                                  MaterialStateProperty.all(
                                                      TextStyle(fontSize: 16))),
                                        ),
                                      ),
                                    ),
                                  // Row(
                                  //   children: [
                                  //     Expanded(
                                  //       flex: 2,
                                  //       child: Padding(
                                  //         padding: const EdgeInsets.all(8.0),
                                  //         child: Column(
                                  //           crossAxisAlignment:
                                  //               CrossAxisAlignment.start,
                                  //           children: [
                                  //             Padding(
                                  //               padding: const EdgeInsets.all(8.0),
                                  //               child: Padding(
                                  //                 padding: const EdgeInsets.only(
                                  //                     left: 8.0),
                                  //                 child: Text(
                                  //                   "Area",
                                  //                   style: TextStyle(
                                  //                     color: Colors.grey[700],
                                  //                     fontSize: 14,
                                  //                     //fontWeight: FontWeight.bold
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //             Container(
                                  //               decoration: BoxDecoration(
                                  //                 border: Border.all(
                                  //                     color: Colors
                                  //                         .grey, // Set border color
                                  //                     width: 1.0),
                                  //                 color: HexColor("#F9F9F9"),
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(5),
                                  //               ),
                                  //               height: 50,
                                  //               margin: EdgeInsets.all(5),
                                  //               child: Padding(
                                  //                 padding: const EdgeInsets.all(8.0),
                                  //                 child: Row(
                                  //                   children: [
                                  //                     DropdownButton(
                                  //                       icon: Icon(
                                  //                           Icons.arrow_drop_down),
                                  //                       underline: Container(),
                                  //                       // itemHeight: 60,
                                  //                       hint: Row(
                                  //                         children: [
                                  //                           Text('Area       '),
                                  //                           SizedBox(
                                  //                             width: MediaQuery.of(
                                  //                                         context)
                                  //                                     .size
                                  //                                     .width *
                                  //                                 0.47,
                                  //                           )
                                  //                         ],
                                  //                       ),
                                  //                       items: arealist.map((item) {
                                  //                         return DropdownMenuItem(
                                  //                           value: item['name']
                                  //                               .toString(),
                                  //                           child: Row(
                                  //                             children: [
                                  //                               Text(item['name']
                                  //                                   .toString()),
                                  //                             ],
                                  //                           ),
                                  //                         );
                                  //                       }).toList(),
                                  //                       onChanged: (newVal) {
                                  //                         setState(() {
                                  //                           dropdownvalueArea =
                                  //                               newVal.toString();
                                  //                         });
                                  //                       },
                                  //                       value: dropdownvalueArea,
                                  //                     ),
                                  //                   ],
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),

                                  // Row(
                                  //   children: [
                                  //     Expanded(
                                  //       flex: 2,
                                  //       child: Padding(
                                  //         padding: const EdgeInsets.all(8.0),
                                  //         child: Column(
                                  //           crossAxisAlignment:
                                  //               CrossAxisAlignment.start,
                                  //           children: [
                                  //             Padding(
                                  //               padding: const EdgeInsets.all(8.0),
                                  //               child: Padding(
                                  //                 padding: const EdgeInsets.only(
                                  //                     left: 8.0),
                                  //                 child: Text(
                                  //                   "Source",
                                  //                   style: TextStyle(
                                  //                     color: Colors.grey[700],
                                  //                     fontSize: 14,
                                  //                     //    fontWeight: FontWeight.bold
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //             Container(
                                  //               decoration: BoxDecoration(
                                  //                 border: Border.all(
                                  //                     color: Colors
                                  //                         .grey, // Set border color
                                  //                     width: 1.0),
                                  //                 color: HexColor("#F9F9F9"),
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(5),
                                  //               ),
                                  //               height: 50,
                                  //               margin: EdgeInsets.all(5),
                                  //               child: Padding(
                                  //                 padding: const EdgeInsets.all(8.0),
                                  //                 child: Row(
                                  //                   children: [
                                  //                     DropdownButton(
                                  //                       // alignment:
                                  //                       //     Alignment.topCenter,
                                  //                       underline: Container(),
                                  //                       menuMaxHeight: 200,

                                  //                       // itemHeight: 60,
                                  //                       hint: Row(
                                  //                         children: [
                                  //                           Text('Source   '),
                                  //                           SizedBox(
                                  //                               // width: MediaQuery.of(
                                  //                               //             context)
                                  //                               //         .size
                                  //                               //         .width *
                                  //                               //     0.45,
                                  //                               )
                                  //                         ],
                                  //                       ),
                                  //                       items: sourcelist.map((item) {
                                  //                         return DropdownMenuItem(
                                  //                           value: item['name']
                                  //                               .toString(),
                                  //                           child: Text(
                                  //                               item['name']
                                  //                                   .toString(),
                                  //                               style: TextStyle(
                                  //                                   fontSize: 12)),
                                  //                         );
                                  //                       }).toList(),
                                  //                       onChanged: (newVal) {
                                  //                         setState(() {
                                  //                           dropdownvaluesource =
                                  //                               newVal.toString();
                                  //                         });
                                  //                       },
                                  //                       value: dropdownvaluesource,
                                  //                     ),
                                  //                   ],
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),

                                  // if (position == null)
                                  //   Expanded(
                                  //       child: Center(
                                  //           child:
                                  //               CircularProgressIndicator())),
                                  // if (position != null)
                                  //   Expanded(
                                  //     child: GoogleMap(
                                  //       onTap: (value) async {
                                  //         latitude = value.latitude.toString();
                                  //         longitude =
                                  //             value.longitude.toString();
                                  //         log(value.latitude.toString());
                                  //         log(value.longitude.toString());
                                  //         _addMarker(value, 'selectedAddress',
                                  //             BitmapDescriptor.defaultMarker);
                                  //         List<Placemark> placemarks =
                                  //             await placemarkFromCoordinates(
                                  //                 value.latitude,
                                  //                 value.longitude);
                                  //         log(placemarks.toString());
                                  //         setState(() {
                                  //           // streetController!.text = placemarks[0].street!;

                                  //           // locality = placemarks[0].locality;

                                  //           // districtController!.text =
                                  //           //     placemarks[0].subAdministrativeArea!;

                                  //           // city.text =
                                  //           //     placemarks[0].administrativeArea!;

                                  //           // placemarks[0].postalCode!;
                                  //         });
                                  //       },
                                  //       onMapCreated: _onMapCreated,
                                  //       initialCameraPosition: CameraPosition(
                                  //       at    target: LatLng(position!.latitude,
                                  //               position!.longitude),
                                  //           zoom: 15),
                                  //       mapType: MapType.normal,
                                  //       myLocationEnabled: true,
                                  //       tiltGesturesEnabled: true,
                                  //       compassEnabled: true,
                                  //       scrollGesturesEnabled: true,
                                  //       zoomGesturesEnabled: true,
                                  //       markers: Set<Marker>.of(markers.values),
                                  //     ),
                                  //   ),
                                  // // if (street!.isNotEmpty)
                                  // Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: Container(
                                  //     width: Constants(context).scrnWidth,
                                  //     child: Column(
                                  //       crossAxisAlignment:
                                  //           CrossAxisAlignment.start,
                                  //       children: [
                                  //         // Text(
                                  //         //   nameController!.text,
                                  //         //   style: TextStyle(
                                  //         //       fontWeight: FontWeight.w600, fontSize: 16),
                                  //         // ),
                                  //         // Text(
                                  //         //   street!,
                                  //         //   style: TextStyle(color: Colors.grey),
                                  //         // ),
                                  //         // Text(
                                  //         //   locality! + ',' + '$district',
                                  //         //   style: TextStyle(color: Colors.grey),
                                  //         // ),
                                  //         // Text(
                                  //         //   state! + ' - $pincode',
                                  //         //   style: TextStyle(color: Colors.grey),
                                  //         // ),
                                  //         // Text(latLong!),
                                  //         SizedBox(
                                  //           height: 50,
                                  //         )
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  // Divider(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  getsf() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userID = preferences.getString("userid");
    log("userid" + userID.toString());
    getlac();
    getAllArea();
    getAllCat();
    getAllsource();
    getAllreference();

    //getAlldist();

    // print(
    //     userID.toString() + "laaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
  }

  void onTabTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  Future shopReference() async {
    var baseUrl = urlMain + 'api/resource/Shop?limit=100000';

    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    });
    print(response.body);
    print(response.statusCode);
    print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
    if (response.statusCode == 200) {
      print("dkjhbjhjchhchbffffhcjbhc" + response.body);
      print("haaaaaaaaaaaaaaaaaaaaaaaaa");
      String data = response.body;
      var jsonData;
      setState(() {
        jsonData = json.decode(data)["data"];
        shoplist = jsonData;
      });
      for (var i = 0; i < shoplist.length; i++) {
        shopname.add(shoplist[i]['name']);
        // offLineCustomersIdDropDown.add(offLineCustomers[i]['id'].toString());
        // customerDetails.add({
        //   "address": offLineCustomers[i]['address'],
        //   "vat": offLineCustomers[i]['vatnum'],
        //   "ob": offLineCustomers[i]['balance'].toString()
        // });
        array.add(i.toString());
      }

      //   print("cbhdddddddddddddddd" + jsonData.toString());
      // log(jsonData.toString());
      //setState(() {});
    }
  }

  Future employeeReference() async {
    log("ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff");
    var baseUrl = urlMain + 'api/resource/Employee?limit=100000';

    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    });
    print(response.body);
    print(response.statusCode);
    print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
    if (response.statusCode == 200) {
      print("dkjhbjhjchhchbffffhcjbhc" + response.body);
      print("haaaaaaaaaaaaaaaaaaaaaaaaa");
      String data = response.body;
      log(data + "vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv");
      var jsonData;
      setState(() {
        jsonData = json.decode(data)["data"];
        emloyeelist = jsonData;
      });
      log(jsonData.toString() +
          "emplooooooooooooooooooooooooooooooooooooooooyeeee");
      for (var i = 0; i < emloyeelist.length; i++) {
        offemployname.add(emloyeelist[i]['name']);
        // offLineCustomersIdDropDown.add(offLineCustomers[i]['id'].toString());
        // customerDetails.add({
        //   "address": offLineCustomers[i]['address'],
        //   "vat": offLineCustomers[i]['vatnum'],
        //   "ob": offLineCustomers[i]['balance'].toString()
        // });
        array.add(i.toString());
      }
      //   print("cbhdddddddddddddddd" + jsonData.toString());
      // log(jsonData.toString());
      //setState(() {});
    }
  }

  Future engineerReference() async {
    print('okko');
    var baseUrl = urlMain + 'api/resource/Engineer?limit=100000';

    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    });
    print(response.body);
    print(response.statusCode);
    print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
    if (response.statusCode == 200) {
      print("namelisttttttt" + response.body);
      print("jiiiii");
      String data = response.body;
      var jsonData;
      setState(() {
        jsonData = json.decode(data)["data"];
        engineerlist = jsonData;
      });
      for (var i = 0; i < engineerlist.length; i++) {
        engineername.add(engineerlist[i]['name']);
        // offLineCustomersIdDropDown.add(offLineCustomers[i]['id'].toString());
        // customerDetails.add({
        //   "address": offLineCustomers[i]['address'],
        //   "vat": offLineCustomers[i]['vatnum'],
        //   "ob": offLineCustomers[i]['balance'].toString()
        // });
        array.add(i.toString());
      }
      //   print("cbhdddddddddddddddd" + jsonData.toString());
      // log(jsonData.toString());
      //setState(() {});
    }
  }

  Future ContractorReference() async {
    print('okko');
    var baseUrl = urlMain + 'api/resource/Contractor?limit=100000';

    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    });
    print(response.body);
    print(response.statusCode);
    print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
    if (response.statusCode == 200) {
      print("Contractorlisttttttt" + response.body);
      print("jiiiii");
      String data = response.body;
      var jsonData;

      setState(() {
        jsonData = json.decode(data)["data"];
        contractorlist = jsonData;
      });
      for (var i = 0; i < contractorlist.length; i++) {
        contractorName.add(contractorlist[i]['name']);
        // offLineCustomersIdDropDown.add(offLineCustomers[i]['id'].toString());
        // customerDetails.add({
        //   "address": offLineCustomers[i]['address'],
        //   "vat": offLineCustomers[i]['vatnum'],
        //   "ob": offLineCustomers[i]['balance'].toString()
        // });
        array.add(i.toString());
      }
      //   print("cbhdddddddddddddddd" + jsonData.toString());
      // log(jsonData.toString());
      //setState(() {});
    }
  }
 Future FetchDealers() async {
    print('okkoty');
    var baseUrl = urlMain + 'api/resource/Dealer';

    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    });
    print('dealll'+response.body);
    print(response.statusCode);
    print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
    if (response.statusCode == 200) {
      print("deaaler" + response.body);
      print("jiiiii");
      String data = response.body;
      var jsonData;
      setState(() {
        jsonData = json.decode(data)["data"];
        dealerList = jsonData;
      });
      for (var i = 0; i < dealerList.length; i++) {
        dealerName.add(dealerList[i]['name']);
        // offLineCustomersIdDropDown.add(offLineCustomers[i]['id'].toString());
        // customerDetails.add({
        //   "address": offLineCustomers[i]['address'],
        //   "vat": offLineCustomers[i]['vatnum'],
        //   "ob": offLineCustomers[i]['balance'].toString()
        // });
        array.add(i.toString());
      }
      //   print("cbhdddddddddddddddd" + jsonData.toString());
      // log(jsonData.toString());
      //setState(() {});
    }
  }

 Future fetchSubDealers() async {
    print('okko');
    var baseUrl = urlMain + 'api/resource/Sub Dealer';

    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': Tocken,
    });
    print(response.body);
    print(response.statusCode);
    print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
    if (response.statusCode == 200) {
      print("subdeaaler" + response.body);
      print("jiiiii");
      String data = response.body;
      var jsonData;
      setState(() {
        jsonData = json.decode(data)["data"];
        subDealerList = jsonData;
      });
      for (var i = 0; i < subDealerList.length; i++) {
        subdealerName.add(subDealerList[i]['name']);
        // offLineCustomersIdDropDown.add(offLineCustomers[i]['id'].toString());
        // customerDetails.add({
        //   "address": offLineCustomers[i]['address'],
        //   "vat": offLineCustomers[i]['vatnum'],
        //   "ob": offLineCustomers[i]['balance'].toString()
        // });
        array.add(i.toString());
      }
      //   print("cbhdddddddddddddddd" + jsonData.toString());
      // log(jsonData.toString());
      //setState(() {});
    }
  }

  int daysToNextMonthDay(DateTime startDate, int day) {
    // Recreate `startDate` as a UTC `DateTime`.  We don't care about the
    // time.
    //
    // Note that this isn't the same as `startDate.toUtc()`.  We want a UTC
    // `DateTime` with specific values, not necessarily the UTC time
    // corresponding to same moment as `startDate`.
    startDate = DateTime.utc(startDate.year, startDate.month, startDate.day);
    var nextMonthDay = DateTime.utc(startDate.year, startDate.month + 1, day);

    // Verify that the requested day exists in the month.
    if (nextMonthDay.day != day) {
      throw ArgumentError(
        'Day $day does not exist for the month following ${startDate.month}',
      );
    }

    return nextMonthDay.difference(startDate).inDays;
  }

  //https://lamit.erpeaz.com/api/resource/Lead Source
  // https://lamit.erpeaz.com/api/resource/Districts

  // bool isMobileNumberValid(String phoneNumber) {
  //   String regexPattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
  //   var regExp = new RegExp(regexPattern);

  //   if (phoneNumber.length == 0) {
  //     return false;
  //   } else if (regExp.hasMatch(phoneNumber)) {
  //     return true;
  //   }
  //   return false;
  // }

  validateMobile(String value) {
    // return null;
  }
}
