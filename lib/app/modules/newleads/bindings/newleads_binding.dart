import 'package:get/get.dart';

import '../controllers/newleads_controller.dart';

class NewleadsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewleadsController>(
      () => NewleadsController(),
    );
  }
}
