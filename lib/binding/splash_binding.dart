import 'package:get/get.dart';
import '../controller/authentication_controller.dart';

class SplashBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AuthenticationController>(() => AuthenticationController(), fenix: true);
  }
}