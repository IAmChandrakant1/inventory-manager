import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/authentication_controller.dart';
import '../controller/dashboard_controller.dart';
import '../controller/theme_controller.dart';
import '../utils/app_colors.dart';
import '../utils/app_theme_style.dart';

class Dashboard extends StatelessWidget {
  final DashboardController dashboardController = Get.put(DashboardController());

  Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeController.to.currentTheme == ThemeMode.light
          ? Colors.grey[100]
          : kDark,
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (dashboardController.selectedIndex.value == 0) {
            return Future.value(true);
          } else {
            dashboardController.selectedIndex.value = 0;
            return Future.value(false);
          }
        },
        child: GetBuilder<DashboardController>(
            init: DashboardController(),
            builder: (_) => Scaffold(
              backgroundColor:
              ThemeController.to.currentTheme == ThemeMode.light
                  ? kWhite
                  : kDark,
              bottomNavigationBar: bottomNavigation(),
              //bottomNavigationBar: BottomNavBar(),
              body: Obx(
                    () => Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: ThemeController.to.currentTheme == ThemeMode.light
                        ? kWhite
                        : null,
                  ),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    topLeft: Radius.circular(30)),
                                color: ThemeController.to.currentTheme ==
                                    ThemeMode.light
                                    ? kWhite
                                    : Colors.black12,
                              ),
                              child: dashboardController.dashboardService.currentScreen,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }

  Widget bottomNavigation() {
    return GetBuilder<AuthenticationController>(
      init: AuthenticationController(),
      builder: (_) => Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 0),
        child: BottomNavigationBar(
          items: bottomBarItem(
              dashboardController.dashboardService.selectedIndex.value),
          backgroundColor: ThemeController.to.currentTheme == ThemeMode.light
              ? kWhite
              : null,
          type: BottomNavigationBarType.fixed,
          currentIndex:
          dashboardController.dashboardService.selectedIndex.value,
          selectedItemColor: ThemeController.to.currentTheme == ThemeMode.light
              ? backgroundColor
              : kWhite,
          unselectedItemColor:
          ThemeController.to.currentTheme == ThemeMode.light
              ? kBlack
              : kWhite,
          iconSize: 25.sp,
          selectedFontSize: 12.sp,
          unselectedLabelStyle: mediumTextStyle(
              size: 12.sp, fontWeight: FontWeight.w500, color: kBlack),
          selectedLabelStyle: mediumTextStyle(
              size: 12.sp, fontWeight: FontWeight.w500, color: kBlack),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (value) {
            if (dashboardController.dashboardService.authServices.userID != null) {
              dashboardController.updateSelectedIndex(value);
            }
          },
          elevation: 10,
        ),
      ),
    );
  }

  bottomBarItem(int page) {
    var bottomBarItem = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          label: "home".tr,
          icon: page == 0
              ? Icon(Icons.home, color: backgroundColor)
              : Icon(
            Icons.home,
            color: ThemeController.to.currentTheme == ThemeMode.light
                ? kBlack
                : kWhite,
          )),
      BottomNavigationBarItem(
          label: "favorite".tr,
          icon: page == 1
              ? Icon(Icons.favorite_rounded, color: backgroundColor)
              : Icon(
            Icons.favorite_rounded,
            color: ThemeController.to.currentTheme == ThemeMode.light
                ? kBlack
                : kWhite,
          )),
      BottomNavigationBarItem(
          label: "profile".tr,
          icon: page == 2
              ? Container(
            width: 25.sp,
            height: 25.sp,
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: dashboardController.authServices.userModel.value.photoUrl != null &&
                    dashboardController.authServices.userModel.value.photoUrl!.isNotEmpty
                    ? NetworkImage(dashboardController.authServices.userModel.value.photoUrl ?? '')
                    : const AssetImage('assets/images/user_image.jpg') as ImageProvider,
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(50.0)),
            ),
          )
              : Container(
            width: 25.sp,
            height: 25.sp,
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: dashboardController
                    .authServices.userModel.value.photoUrl !=
                    null &&
                    dashboardController.authServices.userModel.value
                        .photoUrl!.isNotEmpty
                    ? NetworkImage(dashboardController
                    .authServices.userModel.value.photoUrl ??
                    '')
                    : const AssetImage('assets/images/user_image.jpg')
                as ImageProvider,
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(50.0)),
            ),
          )
      ),
    ].obs;
    return bottomBarItem;
  }


}