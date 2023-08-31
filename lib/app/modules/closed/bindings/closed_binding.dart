import 'package:get/get.dart';

import '../controllers/closed_controller.dart';

class ClosedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClosedController>(
      () => ClosedController(),
    );
  }
}
