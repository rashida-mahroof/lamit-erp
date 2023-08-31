import 'package:get/get.dart';

import '../controllers/addquatat_controller.dart';

class AddquatatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddquatatController>(
      () => AddquatatController(),
    );
  }
}
