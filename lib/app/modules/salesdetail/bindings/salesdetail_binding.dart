import 'package:get/get.dart';

import '../controllers/salesdetail_controller.dart';

class SalesdetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesdetailController>(
      () => SalesdetailController(),
    );
  }
}
