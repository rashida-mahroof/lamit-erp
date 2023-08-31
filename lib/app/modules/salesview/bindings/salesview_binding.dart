import 'package:get/get.dart';

import '../controllers/salesview_controller.dart';

class SalesviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesviewController>(
      () => SalesviewController(),
    );
  }
}
