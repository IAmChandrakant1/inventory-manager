import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_model.dart';
import '../services/auth_services.dart';
import '../services/login_services.dart';
import '../services/register_services.dart';
import '../services/theme_services.dart';
import '../services/verify_email_services.dart';

class AuthenticationController extends GetxController {
  final AuthServices authServices = Get.find<AuthServices>();
  final LoginService loginService = Get.find<LoginService>();
  final RegisterService registerService = Get.find<RegisterService>();
  final ThemeService themeService = Get.put(ThemeService());
  final VerifyEmailService verifyEmailService = Get.find<VerifyEmailService>();

  @override
  void onInit() async {
    super.onInit();
    authServices.initPrefs();
  }

  Future<UserCredential?> signInWithGoogle() {
    var response = authServices.signInWithGoogle();
    update();
    return response;
  }

  Future signUp({required String email, required String password}) {
    var signUp = authServices.signUp(email: email, password: password);
    update();
    return signUp;
  }

  Future signIn({required String email, required String password}) {
    var signIn = authServices.signIn(email: email, password: password);
    update();
    return signIn;
  }

  Future resetPassword({required String email}) {
    var resetPassowrd = authServices.resetPassword(email: email);
    update();
    return resetPassowrd;
  }

  Future<void> signOut() {
    var signOut = authServices.signOut();
    update();
    return signOut;
  }

  Future<UserModel?> getUserData(String uid) {
    var getUserData = authServices.getUserData(uid);
    return getUserData;
  }

  bool isLoggedIn() {
    return authServices.isLoggedIn();
  }

  Future<void> setLoggedIn(bool value) {
    return authServices.setLoggedIn(value);
  }

  /*Future<void> storeUserInfo(String email, String password, String photo,
      String phoneNo, String displayName) async {
    var storeUserInfo = authServices.storeUserInfo(
        email, password, photo, phoneNo, displayName);
    update();
    return storeUserInfo;
  }*/

  switchTheme(ThemeMode mode) {
    themeService.switchTheme(mode);
    update();
  }

  Future<void> updateUserProfileUrl(String url) async {
    print('Url: $url');
    await authServices.firestore
        .collection('users')
        .doc('${authServices.auth.currentUser!.uid}')
        .update({
      'photoUrl': url,
    });
    await authServices.auth.currentUser!.updatePhotoURL(url);
    authServices.userModel.value.photoUrl = url;
    update();
  }
}
