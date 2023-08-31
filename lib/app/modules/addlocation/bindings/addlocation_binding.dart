import 'package:get/get.dart';

import '../controllers/addlocation_controller.dart';

class AddlocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddlocationController>(
      () => AddlocationController(),
    );
  }
}
