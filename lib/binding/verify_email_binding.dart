import 'package:get/get.dart';
import '../controller/verify_email_controller.dart';

class VerifyEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyEmailController>(() => VerifyEmailController(), fenix: true);
  }
}