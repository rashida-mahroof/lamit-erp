import 'package:get/get.dart';

import '../controllers/addnotes_controller.dart';

class AddnotesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddnotesController>(
      () => AddnotesController(),
    );
  }
}
