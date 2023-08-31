import 'package:get/get.dart';

import '../controllers/meetingupdatesadd_controller.dart';

class MeetingupdatesaddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MeetingupdatesaddController>(
      () => MeetingupdatesaddController(),
    );
  }
}
