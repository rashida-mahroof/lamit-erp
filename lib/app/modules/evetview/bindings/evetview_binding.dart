import 'package:get/get.dart';

import '../controllers/evetview_controller.dart';

class EvetviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EvetviewController>(
      () => EvetviewController(),
    );
  }
}
