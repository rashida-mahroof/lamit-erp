import 'package:get/get.dart';

import '../controllers/baisicdetail_controller.dart';

class BaisicdetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BaisicdetailController>(
      () => BaisicdetailController(),
    );
  }
}
