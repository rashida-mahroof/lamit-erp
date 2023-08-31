import 'package:get/get.dart';

import '../controllers/salesorder_controller.dart';

class SalesorderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesorderController>(
      () => SalesorderController(),
    );
  }
}
