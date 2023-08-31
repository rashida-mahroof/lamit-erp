import 'package:get/get.dart';

import '../controllers/customerdetail_controller.dart';

class CustomerdetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerdetailController>(
      () => CustomerdetailController(),
    );
  }
}
