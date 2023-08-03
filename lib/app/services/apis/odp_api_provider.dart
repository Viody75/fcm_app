import 'package:fcm_mobile/app/services/handler/api_handler.dart';
import 'package:fcm_mobile/app/services/storages/local_storage.dart';
// import 'package:fcm_mobile/app/services/storages/local_storage.dart';
import 'package:fcm_mobile/config.dart';
import 'package:get/get_connect.dart';

class OdpAPIsProvider extends GetConnect {
  Future<Response> getOdp({
    required String day,
    required String kec,
    required String kab,
  }) async {
    String? name = await LocalStorage().getUser();
    String url =
        '${AppConfig.API_HOST}/schedules/?auth=$name&day=$day&kec=$kec&kab=$kab';
    Response<dynamic> response = await get(url);

    API().handleResponse(url, response);
    return response;
  }

  Future<Response> getKab() async {
    String url = '${AppConfig.API_HOST}/get-kab';
    Response<dynamic> response = await get(url);
    API().handleResponse(url, response);
    return response;
  }

  Future<Response> getKec() async {
    String url = '${AppConfig.API_HOST}/get-kec';
    Response<dynamic> response = await get(url);
    API().handleResponse(url, response);
    return response;
  }
}
