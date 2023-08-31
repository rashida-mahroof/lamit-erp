import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:lamit/app/modules/lead/api_model.dart';
import 'package:lamit/app/modules/login/views/login_view.dart';
import 'package:lamit/tocken/config/url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LeadController extends GetxController {
  final String email;
  // final String email;
  var leadArray;
  // final String ?username;
  LoginView? loginView;
  var productList = [{}].obs;
  var name = [].obs;
  // LeadAPI? leadapi;
  // var user = LeadAPI("", "").leadArray.obs;
  final count = 0.obs;
  var posts = <Api>[].obs;
  var loading = false.obs;
  // var leadArray = LeadAPI("", "").leadArray;
  var namess;
  var isLoading = true.obs;
//  String names = namess.obs;

  String? em;
  String? skey;

  LeadController(this.email);

  //LeadController(this.username);
  // ApiProvider _provider = ApiProvider();
  @override
  void onInit() async {
    super.onInit();
    // getsf();
    //  login();
    // login();
    // leadDetails();
    // leadArray;
  }

  @override
  void onReady() {
    super.onReady();
  }

  // getPosts() async {
  //   loading(true);
  //   var response = await _provider.getPosts();
  //   if (!response.status.hasError) {
  //     String data = response.body;
  //     log(data);
  //   }
  //   loading(false);
  // }

  @override
  void onClose() {
    super.onClose();
  }

  getsf() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    em = preferences.getString("fullname");
    skey = preferences.getString("skey");

    print("haai");
    login();
    // LeadAPI(akey, skey).login();
    // email = preferences.getString("emailid");
  }

  // leadDetails() {
  //   var i;
  //   for (i = 0; i <= leadArray; i++);
  //   {
  //     name = leadArray[i]["name"];
  //   }
  // }

  // login() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();

  //   var a = preferences.getString("akey");
  //   var b = preferences.getString("skey");
  //   // var a = this.akey;
  //   // var b = this.skey;
  //   // print(a);
  //   // print("$b bbzbxb");
  //   // var email = this.email;
  //   http.Response response = await http.get(
  //       Uri.parse(
  //           'https://lamit.erpeaz.com/api/resource/Lead?filters=[["email","=","adminwebeaz@gmail.com"]]'),
  //       headers: {
  //         'Content-type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': 'Token $a:$b',
  //       });
  //   String data = response.body;
  //   print(data);

  //   return null;
  // }

  login() async {
    // var a = email;
    // var b = skey;
    // print(a);
    // print("$b bbzbxb");
    var email = this.email;
    log(email + "hhhhh");
    http.Response response = await http.get(
        Uri.parse(urlMain +
            'api/resource/User?fields=["name","email"]&filters=[["full_name","=","$em"]]'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token f623e318d6be1f4:1961b7886dd26c7',
        });
    String data = response.body;
    log(data);

    productList = jsonDecode(data)["data"];
    for (var i = 0; i < productList.length; i++) {
      name = productList[i]["name"];
    }
    print("object");
    // print(leadArray);

    // print("laedarray" + leadArray);

    return null;
  }

  // try {
  //   isLoading(true);
  //   var products = await leadArray;
  //   if (products != null) {
  //     productList.value = products;
  //   }
  // } finally {
  //   isLoading(false);
  // }
}
