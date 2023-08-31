import 'dart:convert';
import 'dart:developer';
import 'package:lamit/globals.dart' as globals;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:http/http.dart' as http;
import 'package:lamit/app/modules/home/views/home_view.dart';

import 'package:lamit/app/routes/constants.dart';
import 'package:lamit/main.dart';
import 'package:lamit/tocken/config/url.dart';

import 'package:lamit/tocken/tockn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse(urlMain + '#forgot');

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? token;
  String? token1;
  getToken() async {
    token1 = await FirebaseMessaging.instance.getToken();
    log(token1!);
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController username1 = TextEditingController();
  TextEditingController password1 = TextEditingController();
  var array;
  var emaild;
  String? userid;
  String a = "";
  bool _isHidden = true;

  //final LoginController _loginController = Get.put(LoginController(username1.text,password1.text));
  @override
  void initState() {
    super.initState();

    var initialzationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initialzationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;

      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              color: Colors.blue,
              icon: "@mipmap/ic_launcher",
              styleInformation: BigTextStyleInformation(""),
            ),
          ));
      //}
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      Navigator.push(
        this.context,
        MaterialPageRoute(
          builder: (ctx) => HomeView(""),
        ),
      );
    });
    //initDynamicLinks(context);
    getToken();
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Do you want to exit an App?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),

                style: ElevatedButton.styleFrom(primary: Colors.blue),
                //return false when click on "NO"
                child: Text('No'),
              ),
              ElevatedButton(
                onPressed: () => SystemNavigator.pop(),

                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                //return true when click on "Yes"
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: HexColor("#EEf3f9"),

          // appBar: AppBar(
          //    backgroundColor: Colors.blue,
          //   title: const Text('LoginView'),
          //   centerTitle: true,
          // ),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // SizedBox(
                      //   height: 80,
                      // ),
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/l.png'),
                            fit: BoxFit.fill,
                          ),
                          //  shape: BoxShape.circle,
                        ),
                      ),
                      Center(
                        child: Text(
                          "Login to ERP",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: username1,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Username',
                                  labelStyle: TextStyle(
                                      fontSize: 13, color: Colors.black45),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade200),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400, width: 1),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Username is required';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              TextFormField(
                                controller: password1,
                                obscureText: _isHidden,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password is required';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                      fontSize: 13, color: Colors.black45),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade200),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400, width: 1),
                                  ),
                                  // label: Text('Password'),
                                  suffix: InkWell(
                                    onTap: _togglePasswordView,
                                    child: Icon(
                                        size: 19,
                                        _isHidden
                                            ? Icons.visibility_off
                                            : Icons.visibility),
                                  ),
                                ),
                              ),
                              // a == ""
                              //     ? Text("")
                              //     : Padding(
                              //         padding: const EdgeInsets.all(8.0),
                              //         child: Row(
                              //           children: [
                              //             Padding(
                              //               padding:
                              //                   const EdgeInsets.only(
                              //                       left: 8, right: 8),
                              //               child: Icon(
                              //                 Icons.error,
                              //                 color: Colors.red,
                              //               ),
                              //             ),
                              //             Text(
                              //               a.toString(),
                              //               style: TextStyle(
                              //                   color: Colors.red),
                              //             ),
                              //           ],
                              //         ),
                              //       ),

                              // SizedBox(
                              //   height: 10,
                              // ),
                              SizedBox(
                                height: 40,
                              ),

                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      child: Text(
                                        'Login',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          login();
                                        }
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color.fromARGB(
                                                      255, 3, 74, 132))),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              style:
                                  TextButton.styleFrom(primary: Colors.black54),
                              onPressed: () {
                                _launchUrl();
                              },
                              child: Text("Forgot Your password ?")),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  login() async {
    var username = username1.text;
    var password = password1.text;
    http.Response response = await http.get(
        Uri.parse(
          urlMain + 'api/method/erpnext.api.login?usr=$username&pwd=$password',
        ),
        // body: {"usr": "shinilshinu97@gmail.com", "pwd": "shinilshinu22"},
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': Tocken
        });
    String data = response.body;

    log(response.body.toString() + '-----logooo');
    print(data);
    log(response.body);
    if (response.statusCode == 200) {
      setState(() {
        array = jsonDecode(data)["message"];
        // emaild = jsonDecode(data);
      });

      // print("array$array");

      if (jsonDecode(data)["message"]["message"] != "Authentication success") {
        setState(() {
          Fluttertoast.showToast(msg: "Invalid username or password ");
        });

        // Fluttertoast.showToast(
        //   msg: "invalid user name and password",
        //   backgroundColor: Colors.blue[100],
        //   textColor: Colors.black,
        // );
      } else {
        log(emaild.toString());
        savesf(jsonDecode(data)["full_name"], array["email"]);

        // savesf(
        //     jsonDecode(data)["message"]["api_key"],
        //     jsonDecode(data)["message"]["api_secret"],
        //     jsonDecode(data)["message"]["email"]);
        loguserdetails(jsonDecode(data)["full_name"].toString());
        // savesf("", jsonDecode(data)["message"]["email"]);

        // loguserdetails(jsonDecode(data)["message"]["api_key"],
        //     jsonDecode(data)["message"]["api_secret"]);

        // Get.to(HomeView());
      }
    } else {}
  }

  savesf(String Name, String email) async {
    print(email + "jjhjhhjjh");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("isLogin", true);
    preferences.setString("fullname", Name);
    //preferences.setString("name",jsonDecode(data)["name"]);
    // preferences.setString("userid", array["userid"]);
    preferences.setString("emailid", email);

    preferences.setString("email", email);

    //preferences.setString("name", email);

    //print(array["email"]);
  }

  loguserdetails(String username) async {
    print(username + "hdnnncccccccccccccc");
    // print(email + "mmmm");

    var email1 = array["email"];
    print(email1 + "mmmmmmmm");
    var api = 'api/resource/User?fields=["*"]&filters=[["name","=","$email1"]]';
    http.Response response = await http.get(
        Uri.parse(urlMain +
            // 'api/resource/User?fields=["*"]&filters=[["full_name","=","$username"]]'),
            api),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': Tocken,
        });

    String data = response.body;
    log(api.toString() + 'iammmm');
    if (response.statusCode == 200) {
      print(response.statusCode);
      log(data + "dddddddddddddddddddddddddddddddddddddddddddddd");
      // setState(() {
      //   userid = jsonDecode(data)["data"][0]["user_id"];
      // });

      savesd(
        jsonDecode(data)["data"][0]["name"].toString(),
        jsonDecode(data)["data"][0]["user_id"].toString(),
        jsonDecode(data)["data"][0]["designation"],
      );
      firbaseinsert(jsonDecode(data)["data"][0]["name"].toString());

      Navigator.of(context).pushReplacement(new PageRouteBuilder(
          pageBuilder: (BuildContext context, _, __) {
        // return new Register();
        return new HomeView(
          userid,
        );
      }, transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) {
        return new FadeTransition(opacity: animation, child: child);
      }));
      // log("ussssssssssssssssssssssssssssssssser" +
      //     jsonDecode(data)["data"][0]["user_id"].toString());
      // print( + "bbbbbbbbbbbbb");

      // LeadView();

      // //print(jsonDecode(data)["data"]["name"]);

      // savesf(jsonDecode(data)["data"]["name"], "");

      // setState(() {
      //   array = jsonDecode(data)["data"];
      // });
      // savesf(jsonDecode(data)["data"]["full_name"]);

      print(response.statusCode);
      // log(data);
    } else if (response.statusCode == 403) {
      print(response.reasonPhrase.toString());
    } else {
      print(response.statusCode);
      Fluttertoast.showToast(msg: response.reasonPhrase.toString());
    }
  }

  firbaseinsert(String username) async {
    log("hiiiiii");
    log(token1.toString() + "nnnnnnnnnnnnnn");
    log(username.toString() + "userrrrrrrrrrrrrrrhdnnncccccccccccccc");
    // var email1 = array["email"];
    // print(email1);
    final msg = jsonEncode({"fcm_token": token1});
    // var name = "";
    http.Response response = await http.put(
        Uri.parse(urlMain + 'api/resource/User/$username'),
        body: msg,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': Tocken,
        });

    String data = response.body;
    if (response.statusCode == 200) {
      print(response.statusCode);
      log(response.statusCode.toString());
      log(data.toString() +
          "svvvvvvvvvvvvvvxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxssssssss");
      //  log(data + "dddddddddddddddddddddddddddddddddddddddddddddd");
      // setState(() {
      //   userid = jsonDecode(data)["data"][0]["user_id"];
      // });

      // savesd(jsonDecode(data)["data"][0]["name"].toString(),
      //     jsonDecode(data)["data"][0]["user_id"].toString());

      // Navigator.of(context).pushReplacement(new PageRouteBuilder(
      //     pageBuilder: (BuildContext context, _, __) {
      //   // return new Register();
      //   return new HomeView(
      //     userid,
      //   );
      // }, transitionsBuilder:
      //         (_, Animation<double> animation, __, Widget child) {
      //   return new FadeTransition(opacity: animation, child: child);
      // }));
      // // log("ussssssssssssssssssssssssssssssssser" +
      // //     jsonDecode(data)["data"][0]["user_id"].toString());
      // // print( + "bbbbbbbbbbbbb");

      // // LeadView();

      // // //print(jsonDecode(data)["data"]["name"]);

      // // savesf(jsonDecode(data)["data"]["name"], "");

      // // setState(() {
      // //   array = jsonDecode(data)["data"];
      // // });
      // // savesf(jsonDecode(data)["data"]["full_name"]);

      print(response.statusCode);
      log(data);
    } else {
      print(response.statusCode);
    }
  }

  savesd(String name, String user_id, String role) async {
    print('newrole' + role);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("isLogin", true);
    preferences.setString("role", role);
    preferences.setString("name", name);
    globals.role = role;
    globals.name = name;
    globals.loginId = user_id.toString();
    globals.fullName = preferences.getString("fullname").toString();
    preferences.setString("userid", user_id);
    // preferences.setString("name", email);
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

//https://lamit.erpeaz.com/#forgot

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}

// import 'dart:convert';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:http/http.dart' as http;


// class LoginView extends StatefulWidget {
//   const LoginView({Key? key}) : super(key: key);
//   @override
//   State<LoginView> createState() => _LoginViewState();
// }

// Future<User?> submitData(String username, String pwd) async {}

// class _LoginViewState extends State<LoginView> {
//   final FirebaseMessaging _fcm = FirebaseMessaging.instance;
//   final _usernameController = TextEditingController();
//   bool _passhideshow = true;
//   final _passwordController = TextEditingController();
//   bool ckeboxvalue = false;
//   final _formKey = GlobalKey<FormState>();
//   // User user = User();
//   bool _isDataMatched = true;
//   int isActive = 0;
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     var height = size.height;
//     var width = size.width;
//     return Scaffold(
//         // backgroundColor:Colors.orange[50],
//         body: SafeArea(
//       child: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // SizedBox(
//               //   height: 120,
//               // ),
//               Container(
//                   // height: 235,
//                   alignment: Alignment.bottomCenter,
//                   child:
//                       //Image(image: AssetImage('assets/img/tiptop.png')),
//                       Column(
//                     children: [
//                       Center(
//                           child: Image.asset(
//                         'assets/img/keybot.png',
//                         width: 200,
//                       )),
//                       // Text(
//                       //   'KeyBot',
//                       //   style: GoogleFonts.poppins(
//                       //       color: Colors.orange.shade900,
//                       //       fontSize: 40,
//                       //       fontWeight: FontWeight.bold),
//                       // ),
//                       // Text(
//                       //   'Biz Manager',
//                       //   style: GoogleFonts.poppins(
//                       //     color: Colors.black87,
//                       //     fontSize: 12,
//                       //   ),
//                       // ),
//                     ],
//                   )),
//               //Text('Login with Your Employee Code and Registered Password'),
//               Container(
//                 width: (width > 900) ? width / 2 : width / .8,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20.0),
//                     color: const Color(0xFFffff).withOpacity(0.1),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Color.fromARGB(255, 255, 255, 255),
//                         offset: const Offset(
//                           5.0,
//                           5.0,
//                         ),
//                         blurRadius: 10.0,
//                         spreadRadius: 2.0,
//                       )
//                     ]),
//                 // color: Colors.white,
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                       left: 20, right: 20, top: 40, bottom: 40),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       //crossAxisAlignment:  CrossAxisAlignment.end,
//                       children: [
//                         TextFormField(
//                           controller: _usernameController,
//                           autofocus: true,
//                           decoration: const InputDecoration(
//                             // border: OutlineInputBorder(
//                             //     borderRadius:
//                             //         BorderRadius.all(Radius.circular(10))),
//                             hintText: 'Member ID',
//                             focusColor: Colors.white,
//                             hintStyle: TextStyle(
//                                 color: Color.fromARGB(255, 161, 161, 161)),
//                             prefixIcon: Icon(
//                               Icons.account_box,
//                               color: Color.fromARGB(106, 143, 143, 143),
//                             ),
//                             // filled: true,
//                             // fillColor: Color.fromARGB(255, 255, 251, 250),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'This field is Required';
//                             } else {
//                               return null;
//                             }
//                           },
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         TextFormField(
//                           controller: _passwordController,
//                           obscureText: _passhideshow,
//                           decoration: const InputDecoration(
//                             // border: OutlineInputBorder(
//                             //     borderRadius:
//                             //         BorderRadius.all(Radius.circular(10))),
//                             hintText: 'Password',
//                             hintStyle: TextStyle(
//                                 color: Color.fromARGB(255, 161, 161, 161)),
//                             prefixIcon: Icon(
//                               Icons.lock,
//                               color: Color.fromARGB(106, 143, 143, 143),
//                             ),

//                             // filled: true,
//                             // fillColor: Color.fromARGB(255, 255, 251, 250),
//                           ),
//                           validator: (value) {
//                             // if (_isDataMatched)
//                             // {
//                             //   return null;
//                             // }
//                             // else{
//                             //   return 'error';
//                             // }
//                             if (value == null || value.isEmpty) {
//                               return 'This field is required';
//                             } else {
//                               return null;
//                             }
//                           },
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Row(
//                           children: [
//                             Visibility(
//                               visible: !_isDataMatched,
//                               child: Text(
//                                 'Invalid Username or Password',
//                                 style: TextStyle(color: Colors.red),
//                               ),
//                             ),
//                           ],
//                         ),
//                         CheckboxListTile(
//                           title: Text(
//                             "Show Password",
//                             style: GoogleFonts.poppins(fontSize: 13),
//                           ),
//                           value: ckeboxvalue,

//                           controlAffinity: ListTileControlAffinity.leading,
//                           onChanged: (bool? value) {
//                             setState(() {
//                               ckeboxvalue = !ckeboxvalue;
//                               _passhideshow = !_passhideshow;
//                             });
//                           }, //  <-- leading Checkbox
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         TextButton(
//                             onPressed: () {
//                               // Navigator.push(
//                               //     context,
//                               //     MaterialPageRoute(
//                               //         builder: (context) =>
//                               //             const ChangePassword()));
//                             },
//                             child: Text(
//                               'Forgot Password',
//                               style: TextStyle(
//                                   color: Color.fromARGB(255, 105, 185, 250)),
//                             )),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: ElevatedButton(
//                                 onPressed: () async {
//                                   String username = _usernameController.text;
//                                   String pwd = _passwordController.text;
//                                   String? token = await _fcm.getToken();
//                                   if (_formKey.currentState!.validate()) {
//                                     var response2 = await http.post(
//                                         Uri.parse(
//                                             'https://www.hokybo.com/tms/api/User/Post1'),
//                                         headers: {
//                                           "Content-Type":
//                                               "application/x-www-form-urlencoded",
//                                         },
//                                         encoding: Encoding.getByName('utf-8'),
//                                         body: ({
//                                           'UserName': username,
//                                           'Password': pwd,
//                                           'tok':token
//                                         }));

//                                     if (response2.statusCode == 200) {
//                                       var json = jsonDecode(response2.body);
                                      
                                     
                                    
//                                     }
//                                   }
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                     primary: Colors.orange.shade700),
//                                 child: Padding(
//                                     padding:
//                                         const EdgeInsets.symmetric(vertical: 8),
//                                     child: Text(
//                                       'Login',
//                                       style: GoogleFonts.poppins(
//                                           color: Colors.white,
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.w600),
//                                     )),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 30,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Not have an account?',
//                               style: TextStyle(color: Colors.grey),
//                             ),
//                             TextButton(
//                                 onPressed: () {
//                                   // Navigator.push(
//                                   //     context,
//                                   //     MaterialPageRoute(
//                                   //         builder: (context) =>
//                                   //             const Register()));
//                                 },
//                                 child: Text(
//                                   'Register Now',
//                                   style: TextStyle(
//                                       color:
//                                           Color.fromARGB(255, 105, 185, 250)),
//                                 )),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ));
//   }

//   void checkLogin(BuildContext ctx) async {
//     final _username = _usernameController.text;
//     final _password = _passwordController.text;
//     if (_username == _password) {
//       //goto home

//       ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
//           behavior: SnackBarBehavior.floating,
//           margin: EdgeInsets.all(10),
//           backgroundColor: Colors.green,
//           duration: Duration(seconds: 5),
//           content: Text('Login Success')));
//       // String name = _usernameController.text;
//       //       String job = _passwordController.text;

//       //       DataModel? data = await submitData(name, job);

//     } else {
//       //snackbar
//       // ignore: prefer_const_declarations
//       final _errormsg = _username + ' and ' + _password + ' does not match';
//       ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
//           behavior: SnackBarBehavior.floating,
//           margin: const EdgeInsets.all(10),
//           backgroundColor: Colors.red,
//           duration: const Duration(seconds: 5),
//           content: Text(_errormsg)));

//       setState(() {
//         _isDataMatched = false;
//       });
//     }
//   }
// }