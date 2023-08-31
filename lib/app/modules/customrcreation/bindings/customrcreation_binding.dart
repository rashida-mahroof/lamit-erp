import 'package:get/get.dart';

import '../controllers/customrcreation_controller.dart';

class CustomrcreationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomrcreationController>(
      () => CustomrcreationController(),
    );
  }
}
