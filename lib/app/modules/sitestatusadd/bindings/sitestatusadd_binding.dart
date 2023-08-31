import 'package:get/get.dart';

import '../controllers/sitestatusadd_controller.dart';

class SitestatusaddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SitestatusaddController>(
      () => SitestatusaddController(),
    );
  }
}
