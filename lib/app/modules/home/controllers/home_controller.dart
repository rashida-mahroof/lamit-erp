import 'dart:developer';

import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print("dhcdhchbbbbbbb");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  upgradeVersion() async {
    log("hooooi");
    // final newVersion =
    //     NewVersion(iOSId: "com.iosappid", androidId: "com.androidid");
    // newVersion.showAlertIfNecessary(context: Get.context!);
    // final status = await newVersion.getVersionStatus();
    // if (status != null) {
    //   log("hooooi");
    //   newVersion.showUpdateDialog(
    //       context: Get.context!,
    //       versionStatus: status,
    //       dialogTitle: "Update availabe",
    //       dialogText: "Update the app to continue",
    //       allowDismissal: true,
    //       updateButtonText: "Update",
    //       dismissAction: () {},
    //       dismissButtonText: "Cancel");
    // }
  }
}
