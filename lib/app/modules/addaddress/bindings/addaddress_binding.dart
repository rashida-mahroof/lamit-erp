import 'package:get/get.dart';

import '../controllers/addaddress_controller.dart';

class AddaddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddaddressController>(
      () => AddaddressController(),
    );
  }
}
