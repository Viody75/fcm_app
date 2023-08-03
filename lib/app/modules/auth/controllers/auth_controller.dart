import 'dart:developer';

import 'package:fcm_mobile/app/services/apis/auth_api_provider.dart';
import 'package:fcm_mobile/app/services/storages/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  //TODO: Implement AuthController

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();

    // Controller
    usernameTec.clear();
    passwordTec.clear();
  }

  final authFormKey = GlobalKey<FormState>();
  TextEditingController usernameTec = TextEditingController();
  TextEditingController passwordTec = TextEditingController();

  void authUser() async {
    log(usernameTec.text.toString());
    log(passwordTec.text.toString());
    Response response = await AuthAPIsProvider().signInUser(body: {
      "username": usernameTec.text,
      "password": passwordTec.text,
    });
    if (response.statusCode == 200) {
      log(response.body[0]["name"]);
      LocalStorage().setUser(response.body[0]["name"]);
      Get.offNamed("/home");
    }
  }
}
