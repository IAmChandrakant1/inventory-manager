import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_services.dart';

class LoginService extends GetxService{
  final AuthServices authServices = Get.find<AuthServices>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conformPasswordController = TextEditingController();
  RxBool isEmailValid = true.obs;
  RxBool isPasswordValid = true.obs;
  RxBool isConformPasswordValid = true.obs;
  final loginFormKey = GlobalKey<FormState>();
  final RxBool isValid = true.obs;

  validateFields() {
    isEmailValid.value = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailController.text);
    isPasswordValid.value = passwordController.text.length >= 6;
    isConformPasswordValid.value = conformPasswordController.text.length >= 6;
  }

  Future<LoginService> init() async {
    return this;
  }

}