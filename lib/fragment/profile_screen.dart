import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/authentication_controller.dart';
import '../controller/theme_controller.dart';
import '../model/user_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_theme_style.dart';
import '../utils/style_const.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthenticationController authController =
      Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthenticationController>(
        init: AuthenticationController(),
        builder: (_) => Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/user_image.jpg')
                      as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                children: [
                  headerView(),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color:
                            ThemeController.to.currentTheme == ThemeMode.light
                                ? Colors.grey[100]
                                : kDark,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Obx(() {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    heightWidget(50),
                                    profileViewSection(),
                                    heightWidget(10),
                                    preferencesViewSection(),
                                    heightWidget(10),
                                    otherViewSection(),
                                  ],
                                );
                              })),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 95,
              left: 10,
              right: 10,
              child: profileViewBtn(),
            ),
          ],
        ),
      ),
    );
  }

  headerView() {
    return Container(
      color: Colors.transparent,
      child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              heightWidget(45),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Settings',
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: largeTextStyle(
                      size: 28.sp,
                      color: ThemeController.to.currentTheme == ThemeMode.light
                          ? kWhite
                          : kWhite,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      authController.signOut();
                    },
                    label: Text(
                      'Sign out',
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                      style: mediumTextStyle(
                        size: 18.sp,
                        color:
                            ThemeController.to.currentTheme == ThemeMode.light
                                ? kWhite
                                : kWhite,
                      ),
                    ),
                    icon: Icon(
                      Icons.logout,
                      size: 22.sp,
                      color: ThemeController.to.currentTheme == ThemeMode.light
                          ? kWhite
                          : kWhite,
                    ),
                  ),
                ],
              ),
              heightWidget(40),
            ],
          )),
    );
  }

  Future<dynamic> showDialogView() {
    return Get.bottomSheet(
      Wrap(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: kBlack.withOpacity(0.1),
                  spreadRadius: 10,
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                )
              ],
            ),
            child: Wrap(
              spacing: 10,
              runSpacing: 15,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Choose Source',
                        style: mediumTextStyle(size: 20.sp, color: kBlack),
                      ),
                      Divider(
                        color: grayColor,
                        thickness: 2.sp,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.camera,
                          size: 28.sp,
                          color: kBlack,
                        ),
                        title: Text(
                          'Camera',
                          style: smallTextStyle(
                            size: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: kBlack,
                          ),
                        ),
                        onTap: () async {
                          Get.back();
                          final pickedFile = await authController
                              .themeService.picker
                              .pickImage(source: ImageSource.camera);
                          authController.themeService.file =
                              File(pickedFile!.path);
                          //print('File: ${controller.file}');
                          if (pickedFile != null) {
                            var imageName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();
                            //print('imageName: ${imageName}');
                            var storageRef = FirebaseStorage.instance
                                .ref()
                                .child('images/$imageName.jpg');
                            var uploadTask =
                                storageRef.putFile(ThemeController.to.file!);
                            var downloadUrl =
                                await (await uploadTask).ref.getDownloadURL();
                            print('downloadUrl: ${downloadUrl}');

                            await authController
                                .updateUserProfileUrl(downloadUrl);
                            //controller.update();
                          }
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.photo,
                          size: 28.sp,
                          color: kBlack,
                        ),
                        title: Text(
                          'Gallery',
                          style: smallTextStyle(
                            size: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: kBlack,
                          ),
                        ),
                        onTap: () async {
                          Get.back();
                          final pickedFile = await authController
                              .themeService.picker
                              .pickImage(source: ImageSource.gallery);
                          authController.themeService.file =
                              File(pickedFile!.path);
                          if (pickedFile != null) {
                            var imageName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();
                            var storageRef = FirebaseStorage.instance
                                .ref()
                                .child('images/$imageName.jpg');
                            var uploadTask =
                                storageRef.putFile(ThemeController.to.file!);
                            var downloadUrl =
                                await (await uploadTask).ref.getDownloadURL();
                            await authController
                                .updateUserProfileUrl(downloadUrl);

                            //controller.update();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      persistent: true,
      useRootNavigator: false,
      isScrollControlled: true,
      enableDrag: true,
      enterBottomSheetDuration: const Duration(milliseconds: 500),
      exitBottomSheetDuration: const Duration(seconds: 1),
    );
  }

  Widget profileViewBtn() {
    return Stack(
      alignment: const AlignmentDirectional(1, 1),
      children: [
        Container(
            width: 100.0,
            height: 100.0,
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(50.0)),
              border: Border.all(
                color: kWhite,
                width: 4.0,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/user_image.jpg',
                fit: BoxFit.cover,
              ),
            )),
      ],
    );
  }

  Widget profileViewSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'profile'.tr,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: mediumTextStyle(
            size: 18.sp,
            family: poppinsBold,
            color: ThemeController.to.currentTheme == ThemeMode.light
                ? kBlack
                : kWhite,
          ),
        ),
        ListTile(
          onTap: () {},
          visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
          contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
          title: Text(
            '@ ${authController.authServices.userEmail ?? "NA"}',
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: smallTextStyle(
              size: 16.sp,
              color: ThemeController.to.currentTheme == ThemeMode.light
                  ? kBlack
                  : kWhite,
            ),
          ),
        ),
      ],
    );
  }

  Widget preferencesViewSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'preferences'.tr,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: mediumTextStyle(
            size: 18.sp,
            family: poppinsBold,
            color: ThemeController.to.currentTheme == ThemeMode.light
                ? kBlack
                : kWhite,
          ),
        ),
        SwitchListTile(
          title: Text(
            authController.themeService.currentTheme == ThemeMode.light
                ? 'lightMode'.tr
                : 'darkMode'.tr,
            style: smallTextStyle(
              size: 16.sp,
              color: ThemeController.to.currentTheme == ThemeMode.light
                  ? kBlack
                  : kWhite,
            ),
          ),
          visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
          contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
          activeColor: backgroundColor,
          inactiveThumbColor: kWhite,
          inactiveTrackColor: kWhite.withOpacity(0.5),
          value: authController.themeService.currentTheme == ThemeMode.light,
          onChanged: (bool value) {
            authController
                .switchTheme(value ? ThemeMode.light : ThemeMode.dark);
          },
          secondary: Icon(
            ThemeController.to.currentTheme == ThemeMode.light
                ? Icons.wb_sunny
                : Icons.nightlight_round,
            size: 22.sp,
            color: ThemeController.to.currentTheme == ThemeMode.light
                ? kBlack
                : kWhite,
          ),
        ),
        SwitchListTile(
          title: Text(
            'notification'.tr,
            style: smallTextStyle(
              size: 16.sp,
              color: ThemeController.to.currentTheme == ThemeMode.light
                  ? kBlack
                  : kWhite,
            ),
          ),
          visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
          contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
          activeColor: backgroundColor,
          inactiveThumbColor: ThemeController.to.currentTheme == ThemeMode.light
              ? kWhite
              : kWhite,
          inactiveTrackColor: ThemeController.to.currentTheme == ThemeMode.light
              ? kBlack.withOpacity(0.5)
              : kWhite.withOpacity(0.5),
          value: authController.themeService.notificationToggle.value,
          onChanged: (bool value) {
            authController.themeService.notificationToggle.value = value;
            authController.update();
          },
          secondary: Icon(
            Icons.notifications_none_outlined,
            size: 22.sp,
            color: ThemeController.to.currentTheme == ThemeMode.light
                ? kBlack
                : kWhite,
          ),
        ),
      ],
    );
  }

  Widget otherViewSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'other'.tr,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: mediumTextStyle(
            size: 18.sp,
            family: poppinsBold,
            color: ThemeController.to.currentTheme == ThemeMode.light
                ? kBlack
                : kWhite,
          ),
        ),
        ListTile(
          onTap: () {
            /*Get.toNamed(
              Routes.feedback,
            );*/
          },
          visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
          contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
          title: Text(
            'feedback'.tr,
            style: smallTextStyle(
              size: 16.sp,
              color: ThemeController.to.currentTheme == ThemeMode.light
                  ? kBlack
                  : kWhite,
            ),
          ),
          leading: Icon(
            Icons.feedback_outlined,
            size: 22.sp,
            color: ThemeController.to.currentTheme == ThemeMode.light
                ? kBlack
                : kWhite,
          ),
        ),
      ],
    );
  }
}
