import 'package:get/get.dart';

import '../controllers/requirement_controller.dart';

class RequirementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequirementController>(
      () => RequirementController(),
    );
  }
}
