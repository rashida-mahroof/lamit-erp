import 'package:get/get.dart';

import '../controllers/addbaisicdetail_controller.dart';

class AddbaisicdetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddbaisicdetailController>(
      () => AddbaisicdetailController(),
    );
  }
}
