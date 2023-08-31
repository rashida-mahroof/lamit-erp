import 'dart:developer';

import 'package:get/get.dart';
import 'package:lamit/app/modules/leaddetails/leadapi_model.dart';
import 'package:lamit/app/modules/leaddetails/providers/leadapi_provider.dart';

class LeaddetailsController extends GetxController {
  final count = 0.obs;
  var posts = <Leadapi>[].obs;
  var loading = false.obs;

  LeadapiProvider _provider = LeadapiProvider();

  @override
  void onInit() {
    getPosts();

    super.onInit();
  }

  getPosts() async {
    loading(true);
    var response = await _provider.getPosts();
    if (!response.status.hasError) {
      String data = response.body;
      log(data);
    }
    loading(false);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
