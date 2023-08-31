import 'package:get/get.dart';

import '../controllers/addtaskdash_controller.dart';

class AddtaskdashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddtaskdashController>(
      () => AddtaskdashController(),
    );
  }
}
