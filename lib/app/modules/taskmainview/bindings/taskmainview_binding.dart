import 'package:get/get.dart';

import '../controllers/taskmainview_controller.dart';

class TaskmainviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskmainviewController>(
      () => TaskmainviewController(),
    );
  }
}
