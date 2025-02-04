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

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final AuthenticationController authenticationController =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Form(
          key: authenticationController.verifyEmailService.verifyEmailFormKey,
          child: SingleChildScrollView(
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
                  heightWidget(10),
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      'Forget password?',
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
                      'Don\'t worry about your account. Enter your email to recover password.',
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
                          authenticationController
                              .verifyEmailService.emailController,
                          'email',
                          Icons.email,
                          authenticationController
                              .verifyEmailService.isEmailValid,
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
                        authenticationController.verifyEmailService
                            .validateFields();
                        if (authenticationController
                            .verifyEmailService.isEmailValid.value) {
                          authenticationController
                              .resetPassword(
                                  email: authenticationController
                                      .verifyEmailService.emailController.text)
                              .then((value) {
                            if (value == null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Text(
                                'forget password link shared to ${authenticationController.verifyEmailService.emailController.text}',
                                style: smallTextStyle(
                                  size: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: kWhite,
                                ),
                              )));
                              Get.offAllNamed(Routes.login);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Text(
                                value,
                                style: smallTextStyle(
                                  size: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: kWhite,
                                ),
                              )));
                            }
                          });
                        } else if (authenticationController
                            .verifyEmailService.emailController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                            'Please enter valid email',
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
                  heightWidget(5),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Resend link',
                            style: FlutterFlowTheme.of(context).title3.override(
                                  fontFamily: 'Poppins',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                authenticationController.resetPassword(
                                    email: authenticationController
                                        .verifyEmailService
                                        .emailController
                                        .text);
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
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                          TextSpan(
                            text: 'Login',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryColor,
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
    String label,
    IconData? icon,
    RxBool isValid, {
    bool isPassword = false,
  }) {
    RxBool obscureText = isPassword.obs;

    return ClipRRect(
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
          //fillColor: primarySanctumTextBg,
          fillColor: FlutterFlowTheme.of(context).primarySanctumTextBg,
          contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 15, 15, 15),
          hintStyle: smallTextStyle(
            size: 14.sp,
            fontWeight: FontWeight.w600,
            color: textHintColor,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText.value ? Icons.visibility : Icons.visibility_off,
                    color: kBlack,
                    size: 20.sp,
                  ),
                  onPressed: () {
                    obscureText.value = !obscureText.value;
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
    );
  }
}
