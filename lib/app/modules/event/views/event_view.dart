import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:lamit/app/modules/event/controllers/event_controller.dart';
import 'package:lamit/app/routes/constants.dart';

import '../../leaddetails/views/leaddetails_view.dart';

class EventView extends StatefulWidget {
  final String? leadtok;
  final String name;
  final String restorationId = "main";

  const EventView(this.leadtok, this.name);
  //  var a = [];

  // AddnoteView(this.a);

  @override
  State<EventView> createState() => _EventViewState();
}

class _EventViewState extends State<EventView> with RestorationMixin {
  bool isLoading = false;
  String? get restorationId => widget.restorationId;
  String? a;
  TextEditingController controller = TextEditingController();
  TextEditingController eventcontroller = TextEditingController();
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
          lastDate: DateTime(2099),
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
        datelll =
            '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}';
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   title: const Text('EventView'),
        //   centerTitle: true,
        // ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
                color: HexColor("#F9F9F9"),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Container(
                        //       child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Text(
                        //       "Series Number : 1234",
                        //       style: TextStyle(fontWeight: FontWeight.bold),
                        //     ),
                        //   )),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Container(
                        //       child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Text(
                        //       "Role : admin username",
                        //       style: TextStyle(fontWeight: FontWeight.bold),
                        //     ),
                        //   )),
                        // ),
                        Container(
                          child: Container(
                            // height: Constants(context).scrnHeight,
                            // width: Constants(context).scrnWidth,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Container(
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              child: Icon(
                                                Icons.arrow_back,
                                                size: 18,
                                              ),
                                              onTap: () {
                                                Get.to(LeaddetailsView(
                                                    widget.name,
                                                    "",
                                                    0,
                                                    "",
                                                    "",
                                                    widget.leadtok));
                                              },
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "ADD A EVENT",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Color.fromARGB(
                                                        255, 1, 58, 104)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
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
                                            height: 60,
                                            margin: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextField(
                                                    controller: eventcontroller,
                                                    //  controller: desController,
                                                    // maxLines: 1,
                                                    decoration: InputDecoration(
                                                      hintText: "Event Name",
                                                      border: InputBorder.none,
                                                    )),
                                              ),
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
                                            height: 200,
                                            margin: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextField(
                                                    controller: controller,
                                                    //  controller: desController,
                                                    // maxLines: 6,
                                                    maxLines: 6,
                                                    maxLength: 140,
                                                    decoration: InputDecoration(
                                                      hintText: "Remark...",
                                                      border: InputBorder.none,
                                                    )),
                                              ),
                                            ),
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
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Container(
                                                      child: Text(
                                                        "Event date ",
                                                        style: TextStyle(
                                                          color:
                                                              Colors.grey[700],
                                                          fontSize: 14,
                                                          // fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
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
                                                            //_keyboardVisible = true;
                                                            _restorableDatePickerRouteFuture
                                                                .present();
                                                            a = "${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}";

                                                            setState(() {
                                                              a.toString();
                                                            });
                                                          },
                                                          child: datelll == null
                                                              ? Text(
                                                                  'Pick Event Date ',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          11,
                                                                      color: Colors
                                                                          .black),
                                                                )
                                                              : Text(
                                                                  datelll
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
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
                                                      isLoading = true;
                                                      log(datelll.toString() +
                                                          "nbnnbnnnn");

                                                      print(widget.leadtok
                                                          .toString());
                                                      if (datelll == null) {
                                                        if (eventcontroller
                                                            .text.isEmpty) {
                                                          Fluttertoast.showToast(
                                                              msg: "Add event");
                                                        } else {
                                                          // log(date2String);
                                                          // log(date1.toString() +
                                                          //     "zmmmmmmmmmmmmmmmmzzzzzzzzzzzzmxzzzzzzzxmxmmmxmmx");
                                                          EventController().addnote(
                                                              widget.name
                                                                  .toString(),
                                                              controller.text,
                                                              "",
                                                              widget.leadtok
                                                                  .toString(),
                                                              eventcontroller
                                                                  .text
                                                                  .toString());
                                                        }

                                                        setState(() {
                                                          controller.clear();
                                                        });
                                                      }
                                                      var inputformat =
                                                          DateFormat(
                                                              "dd/MM/yyyy");
                                                      var date1 = inputformat
                                                          .parse(datelll
                                                              .toString());
                                                      var outputformat =
                                                          DateFormat(
                                                              'yyy-MM-dd');
                                                      var date2 = outputformat
                                                          .format(date1);
                                                      print(date2.toString());
                                                      var date2String =
                                                          outputformat
                                                              .format(date1);
                                                      log(date1.toString() +
                                                          "date2");
                                                      print(date1);
                                                      log(inputformat
                                                              .toString() +
                                                          "njjhjhhhhhhhhhhhhhhhhh");
                                                      print("hhhhh");
                                                      if (eventcontroller
                                                          .text.isEmpty) {
                                                        Fluttertoast.showToast(
                                                            msg: "Add event");
                                                      } else if (controller
                                                          .text.isEmpty) {
                                                        Fluttertoast.showToast(
                                                            msg: "Add Remark");
                                                      } else {
                                                        log(date2String);
                                                        log(date1.toString() +
                                                            "zmmmmmmmmmmmmmmmmzzzzzzzzzzzzmxzzzzzzzxmxmmmxmmx");
                                                        EventController()
                                                            .addnote(
                                                                widget.name
                                                                    .toString(),
                                                                controller.text,
                                                                date1
                                                                    .toString(),
                                                                widget.leadtok
                                                                    .toString(),
                                                                eventcontroller
                                                                    .text
                                                                    .toString());
                                                      }

                                                      setState(() {
                                                        controller.clear();
                                                      });

                                                      Future.delayed(
                                                          const Duration(
                                                              seconds: 3), () {
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

                                                      log(datelll.toString() +
                                                          "nbnnbnnnn");

                                                      print(widget.leadtok
                                                          .toString());
                                                      if (datelll == null) {
                                                        if (eventcontroller
                                                            .text.isEmpty) {
                                                          Fluttertoast.showToast(
                                                              msg: "Add event");
                                                        } else {
                                                          // log(date2String);
                                                          // log(date1.toString() +
                                                          //     "zmmmmmmmmmmmmmmmmzzzzzzzzzzzzmxzzzzzzzxmxmmmxmmx");
                                                          EventController().addnote(
                                                              widget.name
                                                                  .toString(),
                                                              controller.text,
                                                              "",
                                                              widget.leadtok
                                                                  .toString(),
                                                              eventcontroller
                                                                  .text
                                                                  .toString());
                                                        }

                                                        setState(() {
                                                          controller.clear();
                                                        });
                                                      }

                                                      setState(() {
                                                        controller.clear();
                                                      });
                                                    },
                                                    child: Text(
                                                      'SAVE EVENT',
                                                      style: TextStyle(
                                                          color: Colors.white),
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
                        )
                      ],
                    ),
                  ),
                ),
              ));
  }
}
