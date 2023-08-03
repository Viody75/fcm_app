import 'package:fcm_mobile/app/services/handler/api_handler.dart';
// import 'package:fcm_mobile/app/services/storages/local_storage.dart';
import 'package:fcm_mobile/config.dart';
import 'package:get/get_connect.dart';

class AuthAPIsProvider extends GetConnect {
  Future<Response> signInUser({required Map body}) async {
    // String? token = await LocalStorage().getAccessToken();
    String url = '${AppConfig.API_HOST}/auth';
    Response<dynamic> response =
        // await get(url, headers: {'Authorization': 'Bearer $token'});
        await post(url, body);

    API().handleResponse(url, response);
    return response;
  }
}
