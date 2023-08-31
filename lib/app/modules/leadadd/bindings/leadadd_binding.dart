import 'package:get/get.dart';

import '../controllers/leadadd_controller.dart';

class LeadaddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeadaddController>(
      () => LeadaddController(),
    );
  }
}
