import 'package:get/get.dart';

import '../controllers/addqoutationadd_controller.dart';

class AddqoutationaddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddqoutationaddController>(
      () => AddqoutationaddController(),
    );
  }
}
