import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory/routes/routes.dart';
import 'package:inventory/services/auth_services.dart';
import 'package:inventory/services/login_services.dart';
import 'package:inventory/services/register_services.dart';
import 'package:inventory/services/theme_services.dart';
import 'package:inventory/services/verify_email_services.dart';
import 'package:inventory/services/dashboard_services.dart';
import 'controller/theme_controller.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCkugdqvmavYSP7M2EDoEXAn6jT6ttsudM",
          authDomain: "inventory-c357a.firebaseapp.com",
          projectId: "inventory-c357a",
          storageBucket: "inventory-c357a.firebasestorage.app",
          messagingSenderId: "49055365800",
          appId: "1:49055365800:web:e1a622fcbeebc51092e09d",
          measurementId: "G-3PVGS3JVHV"
      ),
    );
  } else if (Platform.isIOS) {
    await Firebase.initializeApp();
  }
  await ScreenUtil.ensureScreenSize();
  HttpOverrides.global = MyHttpOverrides();

  await Future.wait([
    Get.put(AuthServices()).init(),
    Get.put(ThemeService()).init(),
    Get.put(RegisterService()).init(),
    Get.put(LoginService()).init(),
    Get.put(VerifyEmailService()).init(),
    Get.put(DashboardService()).init(),
  ]);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) async {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: _getDesignSize(MediaQuery.of(context).size.width,  MediaQuery.of(context).size.height, Platform.isAndroid, Platform.isIOS),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_,
          ctx,
          ) {
        return GetMaterialApp(
          title: 'Inventory',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          defaultTransition: Transition.downToUp,
          themeMode: ThemeController().theme.value,
          initialRoute: Routes.splash,
          getPages: getPages,
          // home: LoginScreen(),
        );
      },
    );
  }

  Size _getDesignSize(double screenWidth, double screenHeight, bool isAndroid, bool isIOS) {
    if (isAndroid) {
      if (screenWidth < 600) {
        return const Size(393, 872);
      } else if(screenWidth >= 600 && screenWidth <= 1200) {
        return const Size(1280, 844);
      }
    }

    if (isIOS) {
      if (screenWidth < 600) {
        return const Size(393, 872);
      } else if(screenWidth >= 600) {
        return const Size(580, 690);
      }
    }

    return const Size(360, 690);
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..maxConnectionsPerHost = 100;
  }
}

