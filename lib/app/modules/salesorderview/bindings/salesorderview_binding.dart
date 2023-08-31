import 'package:get/get.dart';

import '../controllers/salesorderview_controller.dart';

class SalesorderviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesorderviewController>(
      () => SalesorderviewController(),
    );
  }
}
