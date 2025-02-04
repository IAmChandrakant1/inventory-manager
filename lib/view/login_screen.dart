import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/authentication_controller.dart';
import '../routes/routes.dart';
import '../utils/app_colors.dart';
import '../utils/app_theme_style.dart';
import '../utils/flutter_flow_theme.dart';
import '../utils/style_const.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthenticationController authenticationController = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Form(
          key: authenticationController.loginService.loginFormKey,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 15),
              color: backgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(0, -1),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
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
                  heightWidget(20),
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      'Welcome back!',
                      style: FlutterFlowTheme.of(context).title1.override(
                        fontFamily: 'Poppins',
                        color: FlutterFlowTheme.of(context).secondaryColor,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      'Sign in with your Email and Password or Social media to continue',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: FlutterFlowTheme.of(context).secondaryColor,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  heightWidget(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        customTextWidget(
                          authenticationController.loginService.emailController,
                          'email',
                          Icons.email,
                          authenticationController.loginService.isEmailValid,
                        ),
                        heightWidget(10),
                        customTextWidget(
                          authenticationController.loginService.passwordController,
                          'password',
                          Icons.lock,
                          isPassword: true,
                          authenticationController.loginService.isPasswordValid,
                        ),
                      ],
                    ),
                  ),
                  heightWidget(10),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 15,
                    decoration: BoxDecoration(
                      color: btnBgColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        authenticationController.loginService.validateFields();
                        if (authenticationController.loginService.isEmailValid.value && authenticationController.loginService.isPasswordValid.value) {
                          authenticationController.authServices.signIn(email: authenticationController.loginService.emailController.text, password: authenticationController.loginService.passwordController.text).then((result) {
                            if (result == null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text(
                                '${authenticationController.loginService.emailController.text} is login successfully.',
                                style: smallTextStyle(
                                  size: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: kWhite,
                                ),
                              )));
                              authenticationController.setLoggedIn(true);
                              Get.toNamed(Routes.dashboard);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
                                result,
                                style: smallTextStyle(
                                  size: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: kWhite,
                                ),
                              )));
                            }
                          });
                        } else if (authenticationController.loginService.emailController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                'Please enter valid email',
                                style: smallTextStyle(
                                  size: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: kWhite,
                                ),
                              )));
                        } else if (authenticationController.loginService.passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                'Please enter valid password',
                                style: smallTextStyle(
                                  size: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: kWhite,
                                ),
                              )));
                        }
                      },
                      child: Text(
                        'Continue',
                        style: FlutterFlowTheme.of(context).title1.override(
                          fontFamily: 'Poppins',
                          color: FlutterFlowTheme.of(context).tertiaryColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  heightWidget(20),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      '- Or sign in with -',
                      style: smallTextStyle(size: 14.sp, color: textColor),
                    ),
                  ),
                  heightWidget(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: CircleAvatar(
                          radius: 22.r,
                          backgroundColor: btnBgColor,
                          child: Image.asset(
                            'assets/images/apple.png',
                            width: 20.sp,
                            height: 20.sp,
                          ),
                        ),
                      ),
                      widthWidget(25),
                      InkWell(
                        onTap: () {},
                        child: CircleAvatar(
                          radius: 22.r,
                          backgroundColor: btnBgColor,
                          child: Image.asset(
                            'assets/images/facebook.png',
                            width: 20.sp,
                            height: 20.sp,
                          ),
                        ),
                      ),
                      widthWidget(25),
                      InkWell(
                          onTap: () {
                            authenticationController.signInWithGoogle().then((value) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
                                '${value!.user!.displayName} is login successfully.',
                                style: smallTextStyle(
                                  size: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: kWhite,
                                ),
                              )));
                            });
                          },
                          child: CircleAvatar(
                            radius: 22.r,
                            backgroundColor: btnBgColor,
                            child: Image.asset(
                              'assets/images/google.png',
                              width: 20.sp,
                              height: 20.sp,
                            ),
                          )),
                    ],
                  ),
                  heightWidget(20),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Don\'t have an account? ',
                            style: FlutterFlowTheme.of(context).title3.override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context)
                                  .secondaryColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextSpan(
                            text: 'Signup',
                            style:
                            FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: 16.sp,
                              color: FlutterFlowTheme.of(context)
                                  .secondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('Register Text Clicked');
                                Get.toNamed(Routes.register);
                              },
                          ),
                        ]),
                      ),
                    ),
                  ),

                  heightWidget(10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customTextWidget(
      TextEditingController controller,
      String? label,
      IconData? icon,
      RxBool isValid, {
        bool isPassword = false,
      }) {
    RxBool obscureText = isPassword.obs;

    return GetBuilder<AuthenticationController>(
      init: AuthenticationController(),
      builder: (_) => ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: TextFormField(
          controller: controller,
          obscureText: isPassword ? obscureText.value : false,
          style: FlutterFlowTheme.of(context).title2.override(
            fontFamily: 'Poppins',
            color: FlutterFlowTheme.of(context).secondaryColor,
            fontSize: 18.sp,
          ),
          cursorColor: textHintColor,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            filled: true,
            hintText: label,
            fillColor: FlutterFlowTheme.of(context).primarySanctumTextBg,
            hintStyle: smallTextStyle(
              size: 14.sp,
              fontWeight: FontWeight.w600,
              color: textHintColor,
            ),
            contentPadding:
            const EdgeInsetsDirectional.fromSTEB(20, 15, 15, 15),
            suffixIcon: isPassword
                ? IconButton(
              icon: Icon(
                obscureText.value
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: kBlack,
                size: 20.sp,
              ),
              onPressed: () {
                obscureText.value = !obscureText.value;
                authenticationController.update();
              },
            )
                : null,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
        ),
      ),
    );
  }


}