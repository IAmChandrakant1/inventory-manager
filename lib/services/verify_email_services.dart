import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailService extends GetxService{
  TextEditingController emailController = TextEditingController();
  RxBool isEmailValid = true.obs;
  final GlobalKey<FormState> verifyEmailFormKey = GlobalKey<FormState>();

  validateFields() {
    isEmailValid.value = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailController.text);
  }

  Future<VerifyEmailService> init() async {
    return this;
  }
}