import 'package:get/get.dart';

import '../controllers/salesinvoiceview_controller.dart';

class SalesinvoiceviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesinvoiceviewController>(
      () => SalesinvoiceviewController(),
    );
  }
}
