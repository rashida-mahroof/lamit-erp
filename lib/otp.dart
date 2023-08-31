import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lamit/app/modules/home/views/home_view.dart';
import 'package:lamit/app/routes/constants.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? email;
  // getLocale() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   // Get.back();
  //  // Get.updateLocale(Locale(preferences.getString('language')!));
  // }

  var _districts = [
    'alappuzha'.tr,
    'ernakulam'.tr,
    'idukki'.tr,
    'kannur'.tr,
    'kasaragod'.tr,
    'kollam'.tr,
    'kottayam'.tr,
    'kozhikode'.tr,
    'malappuram'.tr,
    'palakkad'.tr,
    'pathanamthitta'.tr,
    'thiruvananthapuram'.tr,
    'thrissur'.tr,
    'wayanad'.tr
  ];

  var _districtsEng = [
    'Alappuzha',
    'Ernakulam',
    'Idukki',
    'Kannur',
    'Kasaragod',
    'Kollam',
    'Kottayam',
    'Kozhikode',
    'Malappuram',
    'Palakkad',
    'Pathanamthitta',
    'Thiruvananthapuram',
    'Thrissur',
    'Wayanad'
  ];

  String? selectedDistrict;
  var dropDownDistricts;

  @override
  void initState() {
    //  getLocale();
    getsf();
    log(email.toString());
    // dropDownDistricts = List.generate(
    //     _districts.length,
    //     (index) => DropdownMenuItem<String>(
    //           child: Text(_districts[index]),
    //           value: _districtsEng[index],
    //         ));
    super.initState();
  }

  TextEditingController nameController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController cPasswordController = new TextEditingController();

  bool isOTP = false;

  double timeout = 120;
  bool timeoutVisibility = false;
  Timer? timer;
  bool progressVisibility = false;

  String? verificationIDFromFirebase;

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? uid;
  bool isChecked = false;
  bool isVerified = false;
  String? otp;

  showOTPDialog() {
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      enableDrag: false,
      context: context,
      builder: (builder) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Card(
          color: Colors.blue[50],
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 8, 8),
                  child: Text(
                    'enter_otp'.tr,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 8, 8),
                  child: Text(
                    'enter_otp_sub'.tr,
                  ),
                ),
                //otp fields
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PinCodeTextField(
                    autoDismissKeyboard: true,
                    pinTheme: PinTheme(
                      selectedFillColor: Color.fromRGBO(0, 150, 136, 1),
                      inactiveFillColor: Colors.blue,
                      activeColor: Colors.teal,
                      inactiveColor: Colors.green,
                      selectedColor: Colors.teal,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(15),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                    ),
                    appContext: context,
                    length: 6,
                    onChanged: (value) {
                      otp = value;
                    },
                    onCompleted: (value) {
                      otp = value;
                      log(otp!);
                    },
                  ),
                ),
                Container(
                  height: 50,
                  width: Constants(context).scrnWidth,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 16, 5, 136)),
                      ),
                      onPressed: () {
                        if (otp != null) {
                          Navigator.pushReplacement<void, void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => HomeView(
                                "",
                              ),
                            ),
                          );
                        }
                      },
                      child: Text('verify_mobile'.tr)),
                ),
              ],
            ),
          ),
        ),
      ),
    ).whenComplete(() => FocusManager.instance.primaryFocus?.unfocus());
  }

  _verifyPhone() async {
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: '+91' + mobileController.text,
        verificationCompleted: (phoneAuthCredential) async {
          setState(() {
            timeoutVisibility = false;
            timer!.cancel();
            timeout = 120;
          });
          log('verified');
          isVerified = true;
          Get.back();
          // if (widget.from == 'reg') {
          // Navigator.push(
          //     context,
          //     CupertinoPageRoute(
          //         builder: (builder) =>
          //             UserDetails(mobileController.text, isChecked)));
          // } else {
          // Navigator.push(
          //     context,
          //     CupertinoPageRoute(
          //         builder: (builder) =>
          //             ResetPassword(mobile: mobileController.text)));
          //  }
        },
        timeout: Duration(minutes: 2),
        verificationFailed: (verificationFailed) async {
          setState(() {
            timeoutVisibility = false;
            // timer!.cancel();
            timeout = 120;
          });
          log("Verification Code Failed: ${verificationFailed.message}");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  "Verification Code Failed: ${verificationFailed.message}")));
        },
        codeSent: (verificationId, resendingToken) async {
          Fluttertoast.showToast(msg: 'OTP sent successfully');
          showOTPDialog();

          setState(() {
            isLoading = false;
            timeoutVisibility = true;
            timer = Timer.periodic(Duration(seconds: 1), (timer) {
              setState(() {
                timeout--;
              });
              Timer(Duration(seconds: 119), () {
                setState(() {
                  timer.cancel();
                  timeout = 120;
                  timeoutVisibility = false;
                });
              });
            });

            this.verificationIDFromFirebase = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (verificationId) async {});
  }

  registerUser() async {
    setState(() {
      progressVisibility = true;
    });
    if (isChecked) {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationIDFromFirebase!, smsCode: otp!);
      signInWithPhoneAuthCredential(phoneAuthCredential);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Accept TnC and Privacy Policy")));
    }
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredential =
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
      setState(() {
        timeoutVisibility = false;
        if (timer != null) {
          timer!.cancel();
        }
        timeout = 120;
        progressVisibility = false;
      });

      final User user = authCredential.user!;
      uid = user.uid;

      Get.back();
      isVerified = true;
      Fluttertoast.showToast(msg: 'Mobile Verified');
    } on FirebaseAuthException catch (e) {
      setState(() {
        timeoutVisibility = false;
        if (timer != null) {
          timer!.cancel();
        }
        timeout = 120;
        progressVisibility = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Verification Failed : " + e.message!)));
    }
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#EEf3f9"),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: Constants(context).scrnWidth,
              height: Constants(context).scrnHeight,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 75,
                        ),
                        Center(
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/33.png'),
                                fit: BoxFit.fill,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(20.0),
                        //   child: Container(
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: Text(
                        //         "Forgot your password",
                        //         style: TextStyle(
                        //             fontSize: 17, color: Colors.grey[900]),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Enter your mobile number"),
                          )),
                        ),
                        //     Text(
                        //       'create_new_account'.tr,
                        //       textAlign: TextAlign.center,
                        //       style: TextStyle(
                        //         fontSize: 28,
                        //       ),length
                        //     ),
                        //     Text(
                        //       'please_fill'.tr,
                        //       style: TextStyle(color: Colors.grey[700]),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 75,
                        // ),
                        // Column(
                        //   mainAxisSize: MainAxisSize.min,
                        //   children: [
                        //     CustomTextField(
                        //       controller: nameController,
                        //       hint: 'name'.tr,
                        //       iconData: CupertinoIcons.person,
                        //       type: TextInputType.name,
                        //     ),
                        // Divider(
                        //   indent: 20,
                        //   endIndent: 20,
                        // ),

                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Card(
                            color: Colors.white,
                            child: Row(
                              children: [
                                // Padding(
                                //   padding: const EdgeInsets.only(
                                //       left: 8.0, right: 16),
                                //   child: Icon(
                                //     CupertinoIcons.phone,
                                //     color: Colors.grey,
                                //   ),
                                // ),
                                Expanded(
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        controller: mobileController,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "",
                                            suffixIcon:
                                                mobileController.text.length ==
                                                        10
                                                    ? TextButton(
                                                        onPressed: () {
                                                          if (isVerified) {
                                                          } else {
                                                            setState(() {
                                                              isLoading = true;
                                                            });
                                                          }
                                                        },
                                                        child: isVerified
                                                            ? Text('Verified')
                                                            : Text('verify'.tr),
                                                      )
                                                    : null),
                                        onChanged: (value) {
                                          setState(() {});
                                          if (value.length > 10) {
                                            setState(() {
                                              mobileController.text =
                                                  value.substring(0, 10);
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Divider(
                        //   indent: 20,
                        //   endIndent: 20,
                        // ),
                        // Padding(
                        //   padding:
                        //       const EdgeInsets.only(left: 20.0, right: 20.0),
                        //   child: Card(
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(20),
                        //     ),
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: DropdownButton(
                        //         items: dropDownDistricts,
                        //         isExpanded: true,
                        //         hint: Text('choose_district'.tr),
                        //         underline: Container(),
                        //         onChanged: (String? value) {
                        //           setState(() {
                        //             selectedDistrict = value;
                        //           });
                        //           log(selectedDistrict!);
                        //         },
                        //         value: selectedDistrict,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // Divider(
                        //   indent: 20,
                        //   endIndent: 20,
                        // ),
                        // CustomTextField(
                        //   controller: passwordController,
                        //   hint: 'password'.tr,
                        //   iconData: CupertinoIcons.lock,
                        //   isPassword: true,
                        //   type: TextInputType.text,
                        // ),
                        // Divider(
                        //   indent: 20,
                        //   endIndent: 20,
                        // ),
                        // CustomTextField(
                        //   controller: cPasswordController,
                        //   hint: 'confirm_password'.tr,
                        //   iconData: CupertinoIcons.lock,
                        //   isPassword: true,
                        //   type: TextInputType.text,
                        // ),
                      ],
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       SizedBox(
                    //         height: 15,
                    //         width: 35,
                    //         child: Checkbox(
                    //             shape: RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(15)),
                    //             value: isChecked,
                    //             onChanged: (value) {
                    //               setState(() {
                    //                 isChecked = value!;
                    //               });
                    //             }),
                    //       ),
                    //       Expanded(
                    //         child: Wrap(
                    //           spacing: 4,
                    //           children: [
                    //             Text(
                    //               'i_accept_the'.tr,
                    //               style: TextStyle(
                    //                   fontSize: 16, color: Colors.grey),
                    //             ),
                    //             GestureDetector(
                    //               onTap: () async {
                    //                 // await FlutterWebBrowser.openWebPage(
                    //                 //     url: tncURL);
                    //               },
                    //               child: Text(
                    //                 'terms_and_conditions'.tr,
                    //                 style: TextStyle(
                    //                     color: Colors.teal,
                    //                     fontSize: 16,
                    //                     decoration: TextDecoration.underline),
                    //               ),
                    //             ),
                    //             Text(
                    //               'and'.tr,
                    //               style: TextStyle(
                    //                   fontSize: 16, color: Colors.grey),
                    //             ),
                    //             Text(
                    //               'agree_to_the'.tr,
                    //               style: TextStyle(
                    //                   fontSize: 16, color: Colors.grey),
                    //             ),
                    //             GestureDetector(
                    //               onTap: () async {
                    //                 // await FlutterWebBrowser.openWebPage(
                    //                 //     url: privacyURL);
                    //               },
                    //               child: Text(
                    //                 'privacy_policy'.tr,
                    //                 style: TextStyle(
                    //                     color: Colors.teal,
                    //                     fontSize: 16,
                    //                     decoration: TextDecoration.underline),
                    //               ),
                    //             ),
                    //             Text(
                    //               'accept'.tr,
                    //               style: TextStyle(
                    //                   fontSize: 16, color: Colors.grey),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 75,
                    // ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 25,
                            ),
                            Expanded(
                                child: Container(
                              height: 50,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromARGB(255, 16, 5, 136)),
                                  ),
                                  onPressed: () {
                                    if (mobileController.text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: "Enter Mobile Number");
                                    } else {
                                      _verifyPhone();
                                    }
                                  },
                                  child: Text("SEND OTP")),
                            )),
                            SizedBox(
                              width: 25,
                            ),
                          ],
                        ),
                        // Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Text(
                        //         'already_registered'.tr,
                        //         style: TextStyle(color: Colors.grey[700]),
                        //       ),
                        //       TextButton(
                        //           onPressed: () {
                        //             Get.back();
                        //           },
                        //           child: Text('login'.tr))
                        //     ])
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Container(
                              padding: const EdgeInsets.only(top: 5),
                              alignment: Alignment.center,
                              child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: 'Code didnot send ?',
                                      style: TextStyle(color: Colors.black)),
                                  // SizedBox(width: 5,),
                                  TextSpan(
                                      recognizer: new TapGestureRecognizer()
                                        ..onTap = () {
                                          // phoneSignIn();
                                        },
                                      text: '  Resend',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold)),
                                ]),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // if (isLoading)
            //   CustomProgress(
            //     message: 'please_wait'.tr,
            //   )
          ],
        ),
      ),
    );
  }

  // Future<void> insertUserDetails() async {
  //   // setState(() {
  //   //   isLoading = true;
  //   // });
  //   // var email;
  //   http.Response response = await http.get(
  //       Uri.parse(
  //           'https://lamit.erpeaz.com/api/resource/Employee?filters=[["user_id","=","test@gmail.com"]]'),
  //       headers: {
  //         'Content-type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': 'Token 7f450b2800474f6:39dcdedba395979',
  //       });
  //   log(response.body);

  //   if (response.statusCode == 200) {
  //     log('registered');
  //     String data = response.body;
  //     var json = jsonDecode(data);
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     // prefs.setString('uid', json['user_id'].toString());
  //     // prefs.setString('name', nameController.text);
  //     // prefs.setString('mobile', mobileController.text);
  //     // prefs.setString('password', passwordController.text);
  //     // prefs.setString('image', '');
  //     // prefs.setString('district', '');
  //     // prefs.setBool('isLogin', true);

  //     // Get.offUntil(
  //     //     MaterialPageRoute(builder: (builder) => HomeView()), (route) => false);
  //     // Fluttertoast.showToast(msg: 'register_success'.tr);
  //   } else {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     log('error');
  //   }
  // }

  getsf() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    email = preferences.getString("email");
    loguserdetails(email!);
    print(email.toString() + "bgvvvvvvvvvvvvvvvvvvvvvvv");
  }

  loguserdetails(String username) async {
    print(username + "hdnnncccccccccccccc");
    // var email1 = array["email"];
    // print(email1);
    http.Response response = await http.get(
        Uri.parse(
            'https://lamit.erpeaz.com/api/resource/User?fields=["*"]&filters=[["full_name","=","$username"]]'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token 7f450b2800474f6:39dcdedba395979',
        });

    String data = response.body;
    if (response.statusCode == 200) {
      print(response.statusCode);
      //log(data + "dddddddddddddddddddddddddddddddddddddddddddddd");
      savesd(jsonDecode(data)["data"][0]["name"].toString(),
          jsonDecode(data)["data"][0]["user_id"].toString());
      log("ussssssssssssssssssssssssssssssssser" +
          jsonDecode(data)["data"][0]["user_id"].toString());
      // print( + "bbbbbbbbbbbbb");

      // LeadView();

      // //print(jsonDecode(data)["data"]["name"]);

      // savesf(jsonDecode(data)["data"]["name"], "");

      // setState(() {
      //   array = jsonDecode(data)["data"];
      // });
      // savesf(jsonDecode(data)["data"]["full_name"]);

      print(response.statusCode);
      log(data);
    } else {
      print(response.statusCode);
    }
  }

  savesd(String name, String user_id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //preferences.setString("emailid", array["email"]);
    // preferences.setBool("isLogin", true);
    // setState(() {
    //   preferences.setString("userid", user_id);
    // });
    preferences.setString("name", name);

    // preferences.setString("name", email);
    // preferences.setBool("isLogin", true);
  }
}
