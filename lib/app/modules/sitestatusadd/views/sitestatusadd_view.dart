import 'dart:convert';
import 'dart:developer';

import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lamit/app/modules/leaddetails/views/leaddetails_view.dart';
import 'package:lamit/app/routes/constants.dart';
import 'package:http/http.dart' as http;
import 'package:lamit/tocken/config/url.dart';
import 'package:lamit/tocken/tockn.dart';

class SitestatusaddView extends StatefulWidget {
  // const SitestatusaddView({Key? key}) : super(key: key);
  final String? leadtok;
  final String? name;
  final String restorationId = "main";

  const SitestatusaddView(this.leadtok, this.name);
  @override
  State<SitestatusaddView> createState() => _SitestatusaddViewState();
}

class _SitestatusaddViewState extends State<SitestatusaddView>
    with RestorationMixin {
  File? imageFile;
  String? _chosenValue;
  bool isLoading = false;
//  pickedFile;
  String? get restorationId => widget.restorationId;
  String? a;
  String? b = "false";
  String? base64Image;
  String? productListview;
  var refitems = [
    "Site Preparation",
    "Floor Slab",
    "Walls & Roof Structure",
    "Main Slab",
    "External Finishes",
    "Windows & Doors",
    "Internal Finishes"
  ];
  TextEditingController textEditingController = new TextEditingController();

  TextEditingController controller = TextEditingController();
  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime(2021, 7, 25));
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
          firstDate: DateTime(2022),
          lastDate: DateTime(2044),
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

  var c;
  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        c = ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#F9F9F9"),
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: GestureDetector(
              child: Icon(Icons.arrow_back),
              onTap: () {
                Get.to(LeaddetailsView(
                    widget.name, "issitestatus", 0, "", "", widget.leadtok));
              },
            ),
          ),
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              "ADD  SITE STATUS",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color.fromARGB(255, 1, 58, 104)),
            ),
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  color: HexColor("#F9F9F9"),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Container(
                            // height: Constants(context).scrnHeight,
                            // width: Constants(context).scrnWidth,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Container(
                                    //     child: Row(
                                    //       children: [

                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                    // SizedBox(
                                    //   height: 8,
                                    // ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Container(
                                              color: Colors.white,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Container(
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child: DropdownButton2(
                                                      isExpanded: true,
                                                      hint: Text(
                                                        'Current Status',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              Theme.of(context)
                                                                  .hintColor,
                                                        ),
                                                      ),
                                                      items: refitems
                                                          .map((item) =>
                                                              DropdownMenuItem<
                                                                  String>(
                                                                value: item,
                                                                child: Text(
                                                                  item,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                ),
                                                              ))
                                                          .toList(),
                                                      value: _chosenValue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _chosenValue =
                                                              value as String;
                                                        });
                                                      },
                                                      searchInnerWidgetHeight:
                                                          20,
                                                      buttonHeight: 20,
                                                      buttonWidth: 100,
                                                      itemHeight: 40,
                                                      dropdownMaxHeight: 200,
                                                      searchController:
                                                          textEditingController,
                                                      searchInnerWidget:
                                                          Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          top: 8,
                                                          bottom: 4,
                                                          right: 8,
                                                          left: 8,
                                                        ),
                                                        child: TextFormField(
                                                          controller:
                                                              textEditingController,
                                                          decoration:
                                                              InputDecoration(
                                                            isDense: true,
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              horizontal: 10,
                                                              vertical: 8,
                                                            ),
                                                            hintText:
                                                                'Search for an item...',
                                                            hintStyle:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        12),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      searchMatchFn:
                                                          (item, searchValue) {
                                                        return (item.value
                                                            .toString()
                                                            .contains(
                                                                searchValue));
                                                      },
                                                      //This to clear the search value when you close the menu
                                                      onMenuStateChange:
                                                          (isOpen) {
                                                        if (!isOpen) {
                                                          textEditingController
                                                              .clear();
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          // Padding(
                                          //   padding: const EdgeInsets.all(8.0),
                                          //   child: Padding(
                                          //     padding: const EdgeInsets.all(8.0),
                                          //     child: Container(
                                          //       child: Column(
                                          //         crossAxisAlignment: CrossAxisAlignment.start,
                                          //         children: [
                                          //           Padding(
                                          //             padding: const EdgeInsets.only(
                                          //                 right: 8, left: 6),
                                          //             child: Container(
                                          //               decoration: BoxDecoration(
                                          //                 color: Colors.grey[100],
                                          //                 // border: Border.all(
                                          //                 //     color: Colors.grey, // Set border color
                                          //                 //     width: 1.0),
                                          //                 //   color: HexColor("#F9F9F9"),
                                          //                 borderRadius:
                                          //                     BorderRadius.circular(5),
                                          //               ),
                                          //               height: 40,
                                          //               // width: 200,
                                          //               child: SingleChildScrollView(
                                          //                 child: Container(
                                          //                   child: DropdownButton(
                                          //                     menuMaxHeight: 200,
                                          //                     // hint: "Reference",
                                          //                     hint: Padding(
                                          //                       padding:
                                          //                           const EdgeInsets.all(8.0),
                                          //                       child: Text("Meridiem"),
                                          //                     ),
                                          //                     underline: Container(),
                                          //                     // Initial Value
                                          //                     value: perdium,

                                          //                     // Down Arrow Icon
                                          //                     // icon: const Icon(
                                          //                     //     Icons.keyboard_arrow_down),

                                          //                     // Array list of items
                                          //                     items:
                                          //                         refitems.map((String items) {
                                          //                       return DropdownMenuItem(
                                          //                         value: items,
                                          //                         child: Row(
                                          //                           children: [
                                          //                             Row(
                                          //                               children: [
                                          //                                 Padding(
                                          //                                   padding:
                                          //                                       const EdgeInsets
                                          //                                           .all(8.0),
                                          //                                   child: Container(
                                          //                                       child: Text(
                                          //                                           items)),
                                          //                                 ),
                                          //                               ],
                                          //                             ),
                                          //                             Container()
                                          //                           ],
                                          //                         ),
                                          //                       );
                                          //                     }).toList(),
                                          //                     // After selecting the desired option,it will
                                          //                     // change button value to selected value
                                          //                     onChanged: (String? newValue) {
                                          //                       setState(() {
                                          //                         perdium = newValue!;
                                          //                       });
                                          //                     },
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //             ),
                                          //           ),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width:
                                                  Constants(context).scrnWidth,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Container(
                                                  //   height: 50,
                                                  //   margin: EdgeInsets.all(5),
                                                  //   decoration: BoxDecoration(
                                                  //     // border: Border.all(
                                                  //     //     color: Colors.blue, // Set border color
                                                  //     //     width: 1.0
                                                  //     //     ),
                                                  //     color: Colors.white,
                                                  //     // borderRadius: BorderRadius.circular(20)
                                                  //   ),
                                                  //   child: Padding(
                                                  //     padding: const EdgeInsets.only(
                                                  //         left: 8.0, right: 8.0),
                                                  //     child: Align(
                                                  //       alignment: Alignment.centerLeft,
                                                  //       child: Container(
                                                  //         width: Constants(context)
                                                  //             .scrnWidth,
                                                  //         child: TextButton(
                                                  //           onPressed: () {
                                                  //             _restorableDatePickerRouteFuture
                                                  //                 .present();
                                                  //             var b =
                                                  //                 "${_selectedDate.value.year}-${_selectedDate.value.month}-${_selectedDate.value.day}";
                                                  //             a = "${_selectedDate.value.year}-${_selectedDate.value.month}-${_selectedDate.value.day}";
                                                  //           },
                                                  //           child: a == null
                                                  //               ? Text(
                                                  //                   'Pick a Date ',
                                                  //                   style: TextStyle(
                                                  //                       fontSize: 11,
                                                  //                       color: Colors
                                                  //                           .black),
                                                  //                 )
                                                  //               : Text(
                                                  //                   a.toString(),
                                                  //                   style: TextStyle(
                                                  //                       color: Colors
                                                  //                           .black),
                                                  //                 ),
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  // SizedBox(
                                                  //   height: 8,
                                                  // ),
                                                  Center(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          b = "true";
                                                        });

                                                        print("haai");
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          height: 50,
                                                          color: Colors.white,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    Container(
                                                                  child: Center(
                                                                      child:
                                                                          Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Container(
                                                                        child: Text(
                                                                      "Upload a photo",
                                                                      style: TextStyle(
                                                                          color: Colors.grey[
                                                                              800],
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              16),
                                                                    )),
                                                                  )),
                                                                ),
                                                              ),
                                                              Icon(Icons.upload)
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  b != "true"
                                                      ? Container()
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16.0),
                                                          child: Container(
                                                              child: imageFile ==
                                                                      null
                                                                  ? Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: <
                                                                            Widget>[
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Container(
                                                                              width: 100,
                                                                              child: ElevatedButton(
                                                                                // color: Colors
                                                                                //     .greenAccent,
                                                                                onPressed: () {
                                                                                  _getFromGallery();
                                                                                },
                                                                                child: Text("GALLERY"),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          // Container(
                                                                          //   height: 40.0,
                                                                          // ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Container(
                                                                              width: 100,
                                                                              child: ElevatedButton(
                                                                                // color: Colors.lightGreenAccent,
                                                                                onPressed: () {
                                                                                  print("cnnnmfgbnm");
                                                                                  _getFromCamera();
                                                                                },
                                                                                child: Text("CAMERA"),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : Container(
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Text(
                                                                              ""),
                                                                          Center(
                                                                            child:
                                                                                Image.file(
                                                                              imageFile!,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )),
                                                        )
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
                                        //   Icons.event_note_outlined,
                                        //   color: Colors.black,
                                        //   size: 17,
                                        // ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 160,
                                              margin: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0, right: 8.0),
                                                child: TextField(
                                                    controller: controller,
                                                    //  controller: desController,
                                                    maxLines: 6,
                                                    maxLength: 140,
                                                    decoration: InputDecoration(
                                                      hintText: "Remarks...",
                                                      border: InputBorder.none,
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        // Expanded(child: Container()),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: 50,
                                                  width: Constants(context)
                                                      .scrnWidth,
                                                  child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: Color.fromARGB(
                                                            255, 2, 73, 131),
                                                      ),
                                                      onPressed: () {
                                                        //  log(taxeasarrray.toString());
                                                        isLoading = true;
                                                        log(imageFile
                                                            .toString());
                                                        if (imageFile
                                                                .toString() ==
                                                            "null") {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "Upload a image");
                                                        } else {
                                                          uploadPhoto(
                                                              imageFile!.path);
                                                        }

                                                        Future.delayed(
                                                            const Duration(
                                                                seconds: 3),
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
                                                                        fontSize:
                                                                            20),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  const CircularProgressIndicator(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ],
                                                              )
                                                            : const Text(
                                                                'Submit');

                                                        // var inputformat =
                                                        //     DateFormat("dd/MM/yyyy");
                                                        // var date1 = inputformat
                                                        //     .parse(a.toString());
                                                        // var outputformat =
                                                        //     DateFormat('yyy-MM-dd');
                                                        // var date2 = outputformat
                                                        //     .format(date1);
                                                        // var date2String = outputformat
                                                        //     .format(date1);
                                                        // print("hhhhh");
                                                        // if (controller.text.isEmpty) {
                                                        //   Fluttertoast.showToast(
                                                        //       msg:
                                                        //           "Pleace add notes");
                                                        // } else {
                                                        //   EventController().addnote(
                                                        //     controller.text,
                                                        //     date2String
                                                        //       ..replaceAll("/", "-"),
                                                        //   );
                                                        // }

                                                        // setState(() {
                                                        //   controller.clear();
                                                        // });
                                                      },
                                                      child: Text(
                                                        'SAVE STATUS',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ));
  }

  /// Get from gallery
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: Constants(context).scrnWidth,
      maxHeight: 300,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);

        final bytes = File(pickedFile.path).readAsBytesSync();
        base64Image = "data:image/png;base64," + base64Encode(bytes);
        //  log(base64Image!);

        print("img_pan : $base64Image");
        // Explore the result

        log(pickedFile.path.toString());
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    print("object");
    // ignore: deprecated_member_use
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 300,
      maxHeight: 300,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);

        final bytes = File(pickedFile.path).readAsBytesSync();
        base64Image = "data:image/png;base64," + base64Encode(bytes);
        //  log(base64Image!);

        print("img_pan : $base64Image");
        // Explore the result

        log(pickedFile.path.toString());
      });
    }
  }

  // Future<void> uploadPhoto(photoPath) async {
  //   var a = widget.leadtok;
  //   var tocken = siteto;
  //   var url = Uri.parse("https://lamit.erpeaz.com/api/resource/UpdateTable");

  //   Map<String, String> reqHeaders = {
  //     HttpHeaders.contentTypeHeader: 'multipart/form-data',
  //     HttpHeaders.authorizationHeader:
  //         'tocken ${base64.encode(utf8.encode('$tocken'))}',
  //     HttpHeaders.acceptHeader: 'application/json',
  //   };

  //   // multipart upload
  //   var request = http.MultipartRequest('POST', url);
  //   Map<String, String> requestBody = <String, String>{
  //     "doc_type": "Lead",
  //     "reference_doc": a.toString(),
  //     "table_name": "site_status",
  //     "current_status": "completed",
  //     "date": "2022-11-24",
  //     "remark": "hhhhhhhh",
  //     "upload_photo": imageFile!.path,
  //   };
  //   request.headers.addAll(reqHeaders);
  //   request.fields.addAll(requestBody);
  //   request.files.add(http.MultipartFile.fromBytes(
  //     'file',
  //     File(photoPath.toString()).readAsBytesSync(),
  //     filename: imageFile!.path,
  //   ));
  //   var response = await request.send();
  //   final respStr = await response.stream.bytesToString();

  //   print(
  //     jsonDecode(respStr),
  //   );

  //   if (response.statusCode == 200) {
  //     // return jsonDecode(response.body)['data'];
  //   } else {
  //     throw Exception('Failed to upload Photo');
  //   }
  // }

  // Future<void> uploadPhoto(photoPath) async {
  //   log(base64.toString());
  //   var tocken = siteto;

  //   var url = Uri.parse(
  //       "https://lamit.erpeaz.com/api/resource/api/method/uploadfile");

  //   // Map<String, String> reqHeaders = {
  //   //   HttpHeaders.contentTypeHeader: 'multipart/form-data',
  //   //   HttpHeaders.authorizationHeader:
  //   //       'Tockden ${base64.encode(utf8.encode(tocken))}',
  //   //   HttpHeaders.acceptHeader: 'application/json',
  //   // };

  //   // multipart upload
  //   var request = http.MultipartRequest('POST', url);
  //   Map<String, String> requestBody = <String, String>{
  //     "doc_type": "Lead",
  //     'cmd': 'uploadfile',
  //     'docname': "LMT-LEAD-2022-00368",
  //     "filename": imageFile!.path,
  //     "filedata": base64Image.toString() == "" ? "" : base64Image.toString(),
  //     "upload_photo": imageFile!.path,
  //     'from_form': '0'
  //   };
  //   // request.headers.addAll(reqHeaders);
  //   request.fields.addAll(requestBody);
  //   request.files.add(http.MultipartFile.fromBytes(
  //     'file',
  //     File(photoPath.toString()).readAsBytesSync(),
  //     filename: photoPath,
  //   ));
  //   var response = await request.send();
  //   final respStr = await response.stream.bytesToString();

  //   print(
  //     jsonDecode(respStr),
  //   );

  //   if (response.statusCode == 200) {
  //     // return jsonDecode(response.body)['data'];
  //   } else {
  //     throw Exception('Failed to upload Photo');
  //   }
  // }

  // Future<int> submitSubscription(
  //     {File? file, String? filename, String? token}) async {
  //   ///MultiPart request
  //   var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse("https://lamit.erpeaz.com/api/resource/UpdateTable"),
  //   );
  //   Map<String, String> headers = {
  //     "Authorization": "Tocken $token",
  //     "Content-type": "multipart/form-data"
  //   };
  //   request.files.add(
  //     http.MultipartFile(
  //       'file',
  //       file!.readAsBytes().asStream(),
  //       file.lengthSync(),
  //       filename: filename,
  //       contentType: MediaType('image', 'jpeg'),
  //     ),
  //   );
  //   request.headers.addAll(headers);
  //   request.fields.addAll({
  //     "doc_type": "Lead",
  //     "reference_doc": "LMT-LEAD-2022-00107",
  //     "table_name": "site_status",
  //     "current_status": "completed",
  //     "date": "2022-11-24",
  //     "remark": "hhhhhhhh",
  //     "upload_photo": "/files/$imageFile"
  //   });

  //   print("request: " + request.toString());
  //   var res = await request.send();
  //   var responseString = await res.stream.bytesToString();
  //   print(responseString + "kmkmkmmkmm");

  //   print("This is response:" + res.toString());
  //   return res.statusCode;
  // }

  // asd() async {
  //   try {
  //     ///[1] CREATING INSTANCE
  //     var dioRequest = dio.Dio();
  //     dioRequest.options.baseUrl = '<YOUR-URL>';

  //     //[2] ADDING TOKEN
  //     dioRequest.options.headers = {
  //       'Authorization': '<IF-YOU-NEED-ADD-TOKEN-HERE>',
  //       'Content-Type': 'application/x-www-form-urlencoded'
  //     };

  //     //[3] ADDING EXTRA INFO
  //     var formData = new dio.FormData.fromMap(
  //         {'<SOME-EXTRA-FIELD>': 'username-forexample'});

  //     //[4] ADD IMAGE TO UPLOAD
  //     var image = "/files/Screenshot from 2022-09-28 17-45-41.png";
  //     var file = await dio.MultipartFile.fromFile(image.path,
  //         filename: basename(image.path),
  //         contentType: MediaType("image", basename(image.path)));

  //     formData.files.add(MapEntry('photo', file));

  //     //[5] SEND TO SERVER
  //     var response = await dioRequest.post(
  //       url,
  //       data: formData,
  //     );
  //     final result = json.decode(response.toString())['result'];
  //   } catch (err) {
  //     print('ERROR  $err');
  //   }
  // }

  Future<void> uploadPhoto(photoPath) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    log(widget.leadtok.toString());
    // DateTime dateee = DateTime.parse(datel);
    // DateTime d = DateTime.parse(datel);
    // String formattedDate =
    //     DateFormat('yyyy-MM-dd').format(DateTime.parse(datel));
    // log(formattedDate
    //     .toString()); // String formated = DateFormat('yyyy-MM-dd').format(DateTime.parse(date));
    final msg = jsonEncode({
      "doc_type": "Lead",
      'cmd': 'uploadfile',
      "reference_doc": widget.leadtok,
      //"upload_photo":"",
      "table_name": "site_status",
      "date":
          formattedDate.toString() == "null" ? "" : formattedDate.toString(),
      'docname': widget.leadtok.toString(),
      "filename": urlMain + imageFile!.path == "null" ? "" : imageFile!.path,
      "filedata": base64Image.toString() == "" ? "" : base64Image.toString(),
      "upload_photo":
          urlMain + imageFile!.path == "null" ? "" : imageFile!.path,
      'from_form': '0',
      "attached_to_field": "attach",
      "remark": controller.text,
      "current_status":
          _chosenValue.toString() == "null" ? "" : _chosenValue.toString(),
      // "doc_type": "Lead",
      // "reference_doc": "LMT-LEAD-2022-00084",
      // "table_name": "notes",
      // "note": Notes,
      // "added_by": "admindemo@gmail.com"
    });

    http.Response response = await http.post(
        Uri.parse(urlMain + "api/resource/uploadfile"),
        body: msg,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': Tocken,
        });

    String data = response.body;
    print(data);
    if (data != "") {
      Fluttertoast.showToast(msg: "added");
      log("daaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaata" + data);
      String? pic;
      setState(() {
        pic = jsonDecode(data)["message"]["file_url"];
      });
      // eventsView();
      updatetableuploadPhoto(imageFile!.path, pic.toString());

      // Get.to(LeaddetailsView(
      //     widget.name, "issitestatus", 0, "", "", widget.leadtok));
    } else {
      Fluttertoast.showToast(msg: "Not added");
    }
  }

  Future<void> updatetableuploadPhoto(photoPath, phot) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    log(widget.leadtok.toString());
    var str = imageFile!.path;

    if (str.endsWith('/')) str = str.substring(0, str.length - 1);
    log("ccccccccccccccccccccccccccccccccccccccccc" + str.toString());
    // DateTime dateee = DateTime.parse(datel);
    // DateTime d = DateTime.parse(datel);
    // String formattedDate =
    //     DateFormat('yyyy-MM-dd').format(DateTime.parse(datel));
    // log(formattedDate
    //     .toString()); // String formated = DateFormat('yyyy-MM-dd').format(DateTime.parse(date));
    final msg = jsonEncode({
      "doc_type": "Lead",

      "reference_doc": widget.leadtok,
      //"upload_photo":"",
      "table_name": "site_status",
      //"date": a.toString() == "null" ? "" : a.toString(),
      "date":
          formattedDate.toString() == "null" ? "" : formattedDate.toString(),

      "upload_photo": phot == "null" ? "" : phot.toString(),

      "remark": controller.text == "null" ? "" : controller.text,
      "current_status":
          _chosenValue.toString() == "null" ? "" : _chosenValue.toString(),
      // "doc_type": "Lead",
      // "reference_doc": "LMT-LEAD-2022-00084",
      // "table_name": "notes",
      // "note": Notes,
      // "added_by": "admindemo@gmail.com"
    });

    http.Response response = await http.post(
        Uri.parse(urlMain + "api/resource/UpdateTable"),
        body: msg,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': Tocken,
        });

    String data = response.body;
    print(data);
    if (data != "") {
      Fluttertoast.showToast(msg: "added");
      Get.to(LeaddetailsView(
          widget.name, "issitestatus", 0, "", "", widget.leadtok));
    } else {
      Fluttertoast.showToast(msg: "Not added");
    }
  }

  eventsView() async {
    print("object");
    String filename = imageFile!.path == "null" ? "" : imageFile!.path;
    log(filename.toString());
    log("jjjjjj" + imageFile.toString());
    // var a = widget.leadtok;
    http.Response response = await http.get(
      Uri.parse(urlMain +
          'api/resource/File?fields=["file_name","file_url"]&filters=[["file_name","=","$filename'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Tocken,
      },
    );
    log("hiiiiiiiiiiiiiiii" + response.body);
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      String data = response.body;
      setState(() {
        productListview = jsonDecode(data)["data"];
      });
      log("imageviewwwwwwwwwwwwwwwwwwwwwwwwwwwwww " +
          productListview.toString());

      // log(productList[0]["note"]);
      print(data);
    } else {}
  }
}

MediaType(String s, String t) {}
