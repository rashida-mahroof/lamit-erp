import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lamit/app/modules/home/views/home_view.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

import 'app/modules/splash/views/splash_view.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  database = openDatabase(path.join(await getDatabasesPath(), 'e_commerce.db'),
      onCreate: (db, version) {
    db.execute(
      'CREATE TABLE IF NOT EXISTS products(id INTEGER PRIMARY KEY,name TEXT,price TEXT,sp_vat TEXT,i_quantity TEXT,i_stock TEXT,i_description TEXT,i_purchase_price TEXT,pp_vat TEXT)',
    );
  }, version: 1);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  /// please comment this in production
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent));
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  // 'This channel is used for important notifications.', // description
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

late final database;

const int _primaryValue = 0xFF90caf9;
const MaterialColor primaryColor = MaterialColor(
  _primaryValue,
  <int, Color>{
    50: Color(0xFF5cdb95),
    100: Color(0xFF5cdb95),
    200: Color(0xFF5cdb95),
    300: Color(0xFF5cdb95),
    400: Color(0xFF5cdb95),
    500: Color(_primaryValue),
    600: Color(0xFF5cdb95),
    700: Color(0xFF5cdb95),
    800: Color(0xFF5cdb95),
    900: Color(0xFF5cdb95),
  },
);

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? token;
  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    log(token!);
  }

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
    MyHttpOverrides();
    //initDynamicLinks(context);
    getToken();
  }

  // Future<void> initDynamicLinks(BuildContext ctx) async {
  //   FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  //   dynamicLinks.onLink.listen((dynamicLinkData) {
  //     log(dynamicLinkData.link.queryParameters.toString());
  //     Navigator.pushNamed(ctx, dynamicLinkData.link.queryParameters['path']!);
  //   }).onError((error) {
  //     print('onLink error');
  //     print(error.message);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lamit',
      theme: ThemeData(
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
            color: Colors.white,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontSize: 18,
            ),
            iconTheme: IconThemeData(color: Colors.black)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25))))),
        hintColor: Color.fromARGB(255, 3, 2, 2),
        textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.black),
            bodyText2: TextStyle(color: Colors.black)),
        textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.black,
            selectionHandleColor: Colors.blue[200],
            selectionColor: Colors.blue[200]),
        primarySwatch: primaryColor,
        scaffoldBackgroundColor: Colors.white,
        cardColor: Color(0xFFFAFAFA),
        // fontFamily: GoogleFonts.raleway().fontFamily
      ),
      // darkTheme: ThemeData(
      //     brightness: Brightness.dark,
      //     appBarTheme: AppBarTheme(
      //         color: Colors.black,
      //         titleTextStyle: TextStyle(
      //           fontWeight: FontWeight.w700,
      //           color: Colors.white,
      //           fontSize: 18,
      //         ),
      //         iconTheme: IconThemeData(color: Colors.white)),
      //     elevatedButtonTheme: ElevatedButtonThemeData(
      //         style: ButtonStyle(
      //             shape: MaterialStateProperty.all(RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(25))))),
      //     hintColor: Colors.black,
      //     textTheme: TextTheme(
      //       bodyText2: TextStyle(color: Colors.white),
      //       caption: TextStyle(color: Colors.white),
      //       bodyText1: TextStyle(color: Colors.white),
      //       subtitle1: TextStyle(color: Colors.white),
      //       subtitle2: TextStyle(color: Colors.white),
      //     ),
      //     iconTheme: IconThemeData(color: Colors.black),
      //     listTileTheme: ListTileThemeData(
      //         iconColor: Colors.black, textColor: Colors.white),
      //     backgroundColor: Colors.black,
      //     cardTheme: CardTheme(
      //       color: Colors.white,
      //     ),
      //     dialogTheme: DialogTheme(
      //         backgroundColor: Colors.grey[700],
      //         titleTextStyle: TextStyle(color: Colors.black)),
      //     textSelectionTheme: TextSelectionThemeData(
      //         cursorColor: Colors.blue[200],
      //         selectionHandleColor: Colors.black,
      //         selectionColor: Colors.black),
      //     primarySwatch: primaryColor,
      //     scaffoldBackgroundColor: Colors.black),

      home: Splash(),
      // home: SalesInvoice("","",""),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
