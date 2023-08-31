import 'package:get/get.dart';

import '../controllers/viewrequirement_controller.dart';

class ViewrequirementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewrequirementController>(
      () => ViewrequirementController(),
    );
  }
}
