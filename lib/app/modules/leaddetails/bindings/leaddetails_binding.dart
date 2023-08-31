import 'package:get/get.dart';
import 'package:lamit/app/modules/leaddetails/providers/leadapi_provider.dart';

import '../controllers/leaddetails_controller.dart';

class LeaddetailsBinding extends Bindings {
  late final LeadapiProvider cityProvider;

  @override
  void dependencies() {
    Get.lazyPut<LeaddetailsController>(
      () => LeaddetailsController(),
    );
  }
}
