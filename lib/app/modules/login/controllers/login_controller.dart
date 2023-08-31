import 'package:get/get.dart';

import '../providers/logapi_provider.dart';

class LoginController extends GetxController {
  final String? username;
  final String? password;

  LoginController(this.username, this.password);
  // Logapi? logapi;

  @override
  void onInit() {
    super.onInit();
    print(username);
    // login();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
