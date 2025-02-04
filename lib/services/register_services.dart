import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterService extends GetxService{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conformPasswordController = TextEditingController();
  RxBool isChecked = false.obs;
  RxBool showPassword = false.obs;
  RxBool isEmailValid = true.obs;
  RxBool isPasswordValid = true.obs;
  RxBool isConformPasswordValid = true.obs;
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  RxBool obscureText = true.obs;
  final RxBool isValid = true.obs;

  validateFields() {
    isEmailValid.value = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailController.text);
    isPasswordValid.value = passwordController.text.length >= 6;
    isConformPasswordValid.value = conformPasswordController.text.length >= 6;

    if (passwordController.text != conformPasswordController.text) {
      isConformPasswordValid.value = false;
    }
  }

  Future<RegisterService> init() async {
    return this;
  }
}