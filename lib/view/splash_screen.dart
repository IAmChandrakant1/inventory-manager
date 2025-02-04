import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/authentication_controller.dart';
import '../routes/routes.dart';
import '../utils/app_colors.dart';
import '../utils/app_theme_style.dart';
import '../utils/style_const.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthenticationController authController = Get.find<AuthenticationController>();

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 1),
          () {
        if (authController.isLoggedIn()) {
          Get.toNamed(Routes.dashboard);
        }
        else {
          Get.toNamed(Routes.login);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightWidget(180),
            Align(
              alignment: const AlignmentDirectional(0, -1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/invertery-transprate.png',
                        width: MediaQuery.of(context).size.width * 0.4,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}