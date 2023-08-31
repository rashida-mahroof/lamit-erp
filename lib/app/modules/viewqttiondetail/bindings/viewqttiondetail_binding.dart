import 'package:get/get.dart';

import '../controllers/viewqttiondetail_controller.dart';

class ViewqttiondetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewqttiondetailController>(
      () => ViewqttiondetailController(),
    );
  }
}
