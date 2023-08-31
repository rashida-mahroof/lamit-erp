import 'package:get/get.dart';
import 'package:lamit/tocken/config/url.dart';

import '../leadapi_model.dart';

class LeadapiProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Leadapi.fromJson(map);
      if (map is List)
        return map.map((item) => Leadapi.fromJson(item)).toList();
    };
  }

  Future<Response> getPosts() =>
      get(urlMain + 'api/resource/Lead', headers: {});

  Future<Leadapi?> getLeadapi() async {
    final response = await get('leadapi/');
    return response.body;
  }

  Future<Response<Leadapi>> postLeadapi(Leadapi leadapi) async =>
      await post('leadapi', leadapi);
  Future<Response> deleteLeadapi(int id) async => await delete('leadapi/$id');
}
