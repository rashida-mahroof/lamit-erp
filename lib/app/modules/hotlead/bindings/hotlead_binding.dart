import 'package:get/get.dart';

import '../controllers/hotlead_controller.dart';

class HotleadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HotleadController>(
      () => HotleadController(),
    );
  }
}
