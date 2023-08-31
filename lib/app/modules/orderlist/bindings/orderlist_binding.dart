import 'package:get/get.dart';

import '../controllers/orderlist_controller.dart';

class OrderlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderlistController>(
      () => OrderlistController(),
    );
  }
}
