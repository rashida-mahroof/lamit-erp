import 'package:get/get.dart';

import '../controllers/collectionreport_controller.dart';

class CollectionreportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CollectionreportController>(
      () => CollectionreportController(),
    );
  }
}
