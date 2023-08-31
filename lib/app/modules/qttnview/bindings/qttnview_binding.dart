import 'package:get/get.dart';

import '../controllers/qttnview_controller.dart';

class QttnviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QttnviewController>(
      () => QttnviewController(),
    );
  }
}
