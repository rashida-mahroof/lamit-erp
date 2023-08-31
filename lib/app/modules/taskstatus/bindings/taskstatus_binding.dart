import 'package:get/get.dart';

import '../controllers/taskstatus_controller.dart';

class TaskstatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskstatusController>(
      () => TaskstatusController(),
    );
  }
}
