import 'package:get/get.dart';

import '../controllers/ledgerlist_controller.dart';

class LedgerlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LedgerlistController>(
      () => LedgerlistController(),
    );
  }
}
