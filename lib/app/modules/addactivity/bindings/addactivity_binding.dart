import 'package:get/get.dart';

import '../controllers/addactivity_controller.dart';

class AddactivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddactivityController>(
      () => AddactivityController(),
    );
  }
}
