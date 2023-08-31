import 'package:get/get.dart';

import '../controllers/salesinvoicevieeeeeeeeeeeeeeeeeeew_controller.dart';

class SalesinvoicevieeeeeeeeeeeeeeeeeeewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesinvoicevieeeeeeeeeeeeeeeeeeewController>(
      () => SalesinvoicevieeeeeeeeeeeeeeeeeeewController(),
    );
  }
}
