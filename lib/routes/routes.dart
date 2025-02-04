import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import '../binding/dashboard_binding.dart';
import '../binding/login_binding.dart';
import '../binding/register_binding.dart';
import '../binding/splash_binding.dart';
import '../binding/verify_email_binding.dart';
import '../view/dashboard.dart';
import '../view/login_screen.dart';
import '../view/register_screen.dart';
import '../view/splash_screen.dart';
import '../view/verify_email_screen.dart';

class Routes {
  static const init = '/';
  static const splash = '/splash_screen';
  static const login = '/login_screen';
  static const register = '/register_screen';
  static const verifyEmail = '/verify_email_screen';
  static const dashboard = '/dashboard';
}

final getPages = [
  GetPage(
    name: Routes.splash,
    transition: Transition.fadeIn,
    curve: Curves.easeInOut,
    transitionDuration: const Duration(milliseconds: 500),
    page: () => const SplashScreen(),
    binding: SplashBinding(),
  ),
  GetPage(
    name: Routes.login,
    transition: Transition.fadeIn,
    curve: Curves.easeInOut,
    transitionDuration: const Duration(milliseconds: 500),
    page: () => const LoginScreen(),
    binding: LoginBinding(),
  ),
  GetPage(
    name: Routes.dashboard,
    transition: Transition.fadeIn,
    curve: Curves.easeInOut,
    transitionDuration: const Duration(milliseconds: 500),
    page: () =>  Dashboard(),
    binding: DashboardBinding(),
  ),
  GetPage(
    name: Routes.register,
    transition: Transition.fadeIn,
    curve: Curves.easeInOut,
    transitionDuration: const Duration(milliseconds: 500),
    page: () => const RegisterScreen(),
    binding: RegisterBinding(),
  ),
  GetPage(
    name: Routes.verifyEmail,
    transition: Transition.fadeIn,
    curve: Curves.easeInOut,
    transitionDuration: const Duration(milliseconds: 500),
    page: () => const VerifyEmailScreen(),
    binding: VerifyEmailBinding(),
  ),
];
