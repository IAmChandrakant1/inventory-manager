import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/register_services.dart';

class RegisterController extends GetxController {
  final RegisterService registerService = Get.find<RegisterService>();

  GlobalKey<FormState> get registerFormKey => registerService.registerFormKey;

  bool isEmailValid() => registerService.isEmailValid.value;

  bool isPasswordValid() => registerService.isPasswordValid.value;

  bool isConformPasswordValid() => registerService.isConformPasswordValid.value;

  void validateUserInput() {
    registerService.validateFields();
  }
}