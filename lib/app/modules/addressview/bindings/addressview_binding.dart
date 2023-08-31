import 'package:get/get.dart';

import '../controllers/addressview_controller.dart';

class AddressviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressviewController>(
      () => AddressviewController(),
    );
  }
}
