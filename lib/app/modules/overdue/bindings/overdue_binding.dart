import 'package:get/get.dart';

import '../controllers/overdue_controller.dart';

class OverdueBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OverdueController>(
      () => OverdueController(),
    );
  }
}
