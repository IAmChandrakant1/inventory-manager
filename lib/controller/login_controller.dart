import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../services/login_services.dart';

class LoginController extends GetxController {
  final LoginService loginService = Get.find<LoginService>();

  GlobalKey<FormState> get loginFormKey => loginService.loginFormKey;

  bool isEmailValid() => loginService.isEmailValid.value;

  bool isPasswordValid() => loginService.isPasswordValid.value;

  bool isConformPasswordValid() => loginService.isConformPasswordValid.value;

  void validateUserInput() {
    loginService.validateFields();
  }
}
