import 'package:get/get.dart';

import '../controllers/qttnmainviewwww_controller.dart';

class QttnmainviewwwwBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QttnmainviewwwwController>(
      () => QttnmainviewwwwController(),
    );
  }
}
