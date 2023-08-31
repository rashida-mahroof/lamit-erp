import 'package:get/get.dart';

import '../controllers/opentask_controller.dart';

class OpentaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OpentaskController>(
      () => OpentaskController(),
    );
  }
}
