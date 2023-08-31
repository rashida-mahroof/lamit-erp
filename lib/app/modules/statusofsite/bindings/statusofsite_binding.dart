import 'package:get/get.dart';

import '../controllers/statusofsite_controller.dart';

class StatusofsiteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatusofsiteController>(
      () => StatusofsiteController(),
    );
  }
}
