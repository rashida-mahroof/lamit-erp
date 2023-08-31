import 'package:get/get.dart';

import '../controllers/meentingupdateview_controller.dart';

class MeentingupdateviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MeentingupdateviewController>(
      () => MeentingupdateviewController(),
    );
  }
}
