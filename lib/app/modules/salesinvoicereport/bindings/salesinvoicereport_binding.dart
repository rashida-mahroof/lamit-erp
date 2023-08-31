import 'package:get/get.dart';

import '../controllers/salesinvoicereport_controller.dart';

class SalesinvoicereportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesinvoicereportController>(
      () => SalesinvoicereportController(),
    );
  }
}
