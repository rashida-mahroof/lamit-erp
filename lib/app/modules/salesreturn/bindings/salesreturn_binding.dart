import 'package:get/get.dart';

import '../controllers/salesreturn_controller.dart';

class SalesreturnBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesreturnController>(
      () => SalesreturnController(),
    );
  }
}
