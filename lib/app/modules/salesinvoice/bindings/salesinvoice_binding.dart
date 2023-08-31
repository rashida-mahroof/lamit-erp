import 'package:get/get.dart';

import '../controllers/salesinvoice_controller.dart';

class SalesinvoiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesinvoiceController>(
      () => SalesinvoiceController(),
    );
  }
}
