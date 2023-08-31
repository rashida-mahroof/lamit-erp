import 'package:get/get.dart';

import '../controllers/customrlist_controller.dart';

class CustomrlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomrlistController>(
      () => CustomrlistController(),
    );
  }
}
