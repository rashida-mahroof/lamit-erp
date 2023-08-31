import 'package:get/get.dart';

import '../controllers/ledger_controller.dart';

class LedgerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LedgerController>(
      () => LedgerController(),
    );
  }
}
