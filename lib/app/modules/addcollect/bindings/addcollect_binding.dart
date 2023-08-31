import 'package:get/get.dart';

import '../controllers/addcollect_controller.dart';

class AddcollectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddcollectController>(
      () => AddcollectController(),
    );
  }
}
