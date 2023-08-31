import 'package:get/get.dart';

import '../controllers/addnote_controller.dart';

class AddnoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddnoteController>(
      () => AddnoteController(),
    );
  }
}
