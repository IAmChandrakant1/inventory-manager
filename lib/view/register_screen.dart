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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthenticationController authenticationController = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Form(
          key: authenticationController.registerService.registerFormKey,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 15),
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
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      'Register Account',
                      style: FlutterFlowTheme.of(context).title1.override(
                        fontFamily: 'Poppins',
                        color: FlutterFlowTheme.of(context).secondaryColor,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      'fill your details or continue with Social media',
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
                          authenticationController.registerService.emailController,
                          'email',
                          Icons.email,
                          authenticationController.registerService.isEmailValid,
                        ),
                        heightWidget(10),
                        customTextWidget(
                          authenticationController.registerService.passwordController,
                          'password',
                          Icons.lock,
                          isPassword: true,
                          authenticationController.registerService.isPasswordValid,
                        ),
                        heightWidget(10),
                        customTextWidget(
                          authenticationController.registerService.conformPasswordController,
                          'conformed password',
                          Icons.lock,
                          isPassword: true,
                          authenticationController.registerService.isConformPasswordValid,
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
                      onPressed: () {
                        authenticationController.registerService.validateFields();
                        if (authenticationController.registerService.isEmailValid.value &&
                            authenticationController.registerService.isPasswordValid.value &&
                            authenticationController.registerService.isConformPasswordValid.value) {
                          authenticationController.signUp(email: authenticationController.registerService.emailController.text, password: authenticationController.registerService.passwordController.text).then((result) {
                            if (result == null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                  content: Text(
                                    '${authenticationController.registerService.emailController.text} is register successfully.',
                                    style: smallTextStyle(
                                      size: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color: kWhite,
                                    ),
                                  )));
                              authenticationController.setLoggedIn(true);
                              Get.toNamed(Routes.dashboard);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                    result,
                                    style: smallTextStyle(
                                      size: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color: kWhite,
                                    ),
                                  )));
                            }
                          });
                        } else if (authenticationController.registerService.emailController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                'Please enter valid email',
                                style: smallTextStyle(
                                  size: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: kWhite,
                                ),
                              )));
                        } else if (authenticationController.registerService.passwordController.text !=
                            authenticationController.registerService.conformPasswordController.text) {
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
                  heightWidget(10),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Forget password?',
                            style: FlutterFlowTheme.of(context).title3.override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).secondaryColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                //Get.offAllNamed(Routes.verifyEmail);
                                Get.toNamed(Routes.verifyEmail);
                              },
                          ),
                        ]),
                      ),
                    ),
                  ),
                  heightWidget(10),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Already signed up? ',
                            style: FlutterFlowTheme.of(context).title3.override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).secondaryColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextSpan(
                            text: 'Login',
                            style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).secondaryColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.offAllNamed(Routes.login);
                              },
                          ),
                        ]),
                      ),
                    ),
                  ),
                  heightWidget(30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customTextWidget(
      TextEditingController controller1,
      String label,
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
          controller: controller1,
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
            //fillColor: primarySanctumTextBg,
            fillColor: FlutterFlowTheme.of(context).primarySanctumTextBg,
            contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 15, 15, 15),
            filled: true,
            hintText: label,
            hintStyle: smallTextStyle(
              size: 14.sp,
              fontWeight: FontWeight.w600,
              color: textHintColor,
            ),
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
            if (label == 'Conformed password' &&
                authenticationController.registerService.conformPasswordController.text != authenticationController.registerService.passwordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
        ),
      ),
    );
  }

}