import 'package:flutter/material.dart';
import 'package:get/get.dart';

class API {
  void handleResponse(String endpoint, Response response) {
    switch (response.statusCode) {
      case 200:
        debugPrint('200 OK : $endpoint');
        break;
      case 201:
        debugPrint('201 OK CREATED : $endpoint');
        break;
      case 204:
        debugPrint('204 OK : $endpoint');
        break;
      case 400:
        debugPrint('400 NOT OK : $endpoint');
        Get.snackbar(
            "API Failed", "Kode Error 400 Invalid saat mengambil data");
        break;
      case 401:
        debugPrint('401 NOT OK : $endpoint');
        Get.snackbar(
            "API Failed", "Kode Error 401 Invalid saat mengambil data");
        break;
      case 404:
        debugPrint('404 DATA NOT FOUND BUT OK : $endpoint');
        break;
      case 429:
        debugPrint('429 NOT OK : $endpoint');
        Get.snackbar(
            "API Failed", "Kode Error 429 Invalid saat mengambil data");
        break;
      default:
        debugPrint(
            'API Response NOT OK : $endpoint : ${response.statusCode} ~ ${response.body}');
        debugPrint(response.statusCode.toString());
        debugPrint(response.body.toString());
        Get.snackbar("API Failed",
            "Kode Error ${response.statusCode} Ada masalah di server");
    }
  }
}
