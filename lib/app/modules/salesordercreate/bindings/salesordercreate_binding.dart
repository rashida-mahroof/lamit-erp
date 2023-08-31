import 'package:get/get.dart';

import '../controllers/salesordercreate_controller.dart';

class SalesordercreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesordercreateController>(
      () => SalesordercreateController(),
    );
  }
}
