import 'package:get/get.dart';

import '../controllers/leadsubprofile_controller.dart';

class LeadsubprofileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeadsubprofileController>(
      () => LeadsubprofileController(),
    );
  }
}
