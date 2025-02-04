import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/verify_email_services.dart';

class VerifyEmailController extends GetxController {
  final VerifyEmailService verifyEmailService = Get.find<VerifyEmailService>();

  GlobalKey<FormState> get verifyEmailFormKey => verifyEmailService.verifyEmailFormKey;

  bool isEmailValid() => verifyEmailService.isEmailValid.value;

  void validateUserInput() {
    verifyEmailService.validateFields();
  }
}