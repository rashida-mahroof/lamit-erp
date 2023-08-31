import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lamit/app/modules/home/views/home_view.dart';
import 'package:lamit/app/modules/login/views/login_view.dart';
import 'package:lamit/app/routes/constants.dart';
import 'package:lamit/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  double h = 0;
  bool isLogin = false;
  animateOut() async {
    await Future.delayed(Duration(milliseconds: 50));
    setState(() {
      h = Constants(context).scrnWidth;
    });
  }

  @override
  void initState() {
    animateOut();
    Timer(Duration(seconds: 4), () {
      setState(() {
        h = 0;
      });
    });
    checkLogin();
    super.initState();
  }

  checkLogin() async {
    // final db = await database;
    // db.execute(
    //   'CREATE TABLE IF NOT EXISTS bills(id INTEGER PRIMARY KEY AUTOINCREMENT,shopName TEXT,oldBalance TEXT,todayBillAmount TEXT,discount TEXT,totalAmount TEXT,receivedAmount TEXT,balanceAmount TEXT,vehicleID TEXT,status TEXT,billNo TEXT,ledger TEXT,vatAmount TEXT,prefix TEXT,prefixNo INTEGER,chequeNo TEXT,date INTEGER,shopid TEXT)',
    // );

    // db.execute(
    //   'CREATE TABLE IF NOT EXISTS returnBills(id INTEGER PRIMARY KEY AUTOINCREMENT,shopName TEXT,oldBalance TEXT,todayBillAmount TEXT,discount TEXT,totalAmount TEXT,receivedAmount TEXT,balanceAmount TEXT,vehicleID TEXT,status TEXT,billNo TEXT,ledger TEXT,vatAmount TEXT,prefix TEXT,prefixNo TEXT,chequeNo TEXT,date INTEGER,shopid TEXT,returnBillNo TEXT)',
    // );

    // db.execute(
    //     'CREATE TABLE IF NOT EXISTS billItems(id INTEGER PRIMARY KEY AUTOINCREMENT,itemName TEXT,qty TEXT,price TEXT,total TEXT,refID TEXT,unit TEXT,unitID TEXT,itemId TEXT)');

    // db.execute(
    //     'CREATE TABLE IF NOT EXISTS returnBillItems(id INTEGER PRIMARY KEY AUTOINCREMENT,itemName TEXT,p_qty INTEGER,qty INTEGER,price TEXT,total TEXT,refID TEXT,unit TEXT,unitID TEXT,itemId TEXT,returnBillNo TEXT)');

    // db.execute(
    //     'CREATE TABLE IF NOT EXISTS collections(id INTEGER PRIMARY KEY AUTOINCREMENT,cDate INTEGER,cShop TEXT,totalAmount TEXT,discount TEXT,received TEXT,balance TEXT,vehicleID TEXT,shopID TEXT)');
    // db.execute(
    //     'CREATE TABLE IF NOT EXISTS ProductAd(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,price TEXT, saleprice TEXT, pprice TEXT, unit TEXT,percentage TEXT,des TEXT)');
    // db.execute(
    //   'CREATE TABLE IF NOT EXISTS customers(id INTEGER PRIMARY KEY,vehicle1 TEXT,vehicle2 TEXT,shopname TEXT,shopaddress TEXT,shop_contact_number TEXT,shop_opening_balance REAL,vat_num TEXT,description TEXT,assign TEXT,type TEXT)',
    // );
    // db.execute(
    //     'CREATE TABLE IF NOT EXISTS  CustCre(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,mobile TEXT, address TEXT, ob TEXT, vatnum TEXT,balance REAL)');
    // db.execute(
    //     'CREATE TABLE IF NOT EXISTS  LedCre(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT, grou TEXT, balance TEXT, des TEXT)');
    // db.execute(
    //     'CREATE TABLE IF NOT EXISTS units(id INTEGER PRIMARY KEY,itemID TEXT,unit TEXT,unitAbre TEXT,qty TEXT,price TEXT,purchasePrice TEXT)');
    // db.execute(
    //     'CREATE TABLE IF NOT EXISTS setting(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,nameArabi TEXT,address TEXT, addressArabic TEXT, vatnum TEXT,vatnumArabic TEXT,vat TEXT,print TEXT,logo TEXT,prefixa TEXT)');

    // db.execute(
    //     'CREATE TABLE IF NOT EXISTS vendors(id INTEGER PRIMARY KEY AUTOINCREMENT,vName TEXT,vAddress TEXT,vPhone TEXT,vVATnum TEXT,vBalance TEXT,desc TEXT)');
    // db.execute(
    //     'CREATE TABLE IF NOT EXISTS purchases(id INTEGER PRIMARY KEY AUTOINCREMENT,date INTEGER,billno TEXT,ledger TEXT,ledgername TEXT,vendor TEXT,vendorname TEXT,todaybill REAL,discount REAL,vatamount REAL,totalamount REAL,received REAL,balance REAL,prebalance REAL)');

    // db.execute(
    //     'CREATE TABLE IF NOT EXISTS purchaseItems(id INTEGER PRIMARY KEY AUTOINCREMENT,itemName TEXT,qty TEXT,price TEXT,total TEXT,refID TEXT,unit TEXT,unitID TEXT,itemID TEXT)');
    // db.execute(
    //     'CREATE TABLE IF NOT EXISTS expenses(id INTEGER PRIMARY KEY AUTOINCREMENT,date INTEGER,category TEXT,amount REAL,remarks TEXT)');

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('isLogin') != null) {
      isLogin = prefs.getBool('isLogin')!;
    }
    if (isLogin) {
      Timer(Duration(milliseconds: 4350), () {
        if (prefs.getString('lastReturnBill') == null) {
          prefs.setString('lastReturnBill', '0');
        } else {
          prefs.setString('lastReturnBill', prefs.getString('lastReturnBill')!);
        }
        Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
                builder: (builder) => HomeView(
                      "",
                    )));
      });

      globals.role = prefs.getString("role").toString();
      globals.name = prefs.getString("email").toString();
      globals.loginId = prefs.getString("userid").toString();
     globals.fullName = prefs.getString("fullName").toString();
      print('prefids' + globals.role + globals.name);
    } else {
      Timer(Duration(milliseconds: 4350), () {
        Navigator.pushReplacement(
            context, CupertinoPageRoute(builder: (builder) => LoginView()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#EEf3f9"),
      body: Stack(
        children: [
          Center(
            child: Container(
              // curve: Curves.easeInOut,
              // duration: Duration(milliseconds: 400),
              height: 100,
              width: 100,
              decoration: BoxDecoration(

                  ///shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage('assets/l.png'))),
            ),
          ),
          Container(
            height: Constants(context).scrnHeight,
            width: Constants(context).scrnWidth,
            decoration: BoxDecoration(),
          )
        ],
      ),
    );
  }
}
