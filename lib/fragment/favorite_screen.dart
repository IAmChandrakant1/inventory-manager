import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/dashboard_controller.dart';
import '../controller/home_controller.dart';
import '../controller/theme_controller.dart';
import '../utils/app_colors.dart';
import '../utils/app_theme_style.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeController.to.currentTheme == ThemeMode.light
          ? Colors.grey[100]
          : kDark,
      appBar: AppBar(
        title: Text.rich(
          TextSpan(
            text: 'Favorite',
            style: TextStyle(
                shadows: [
                  Shadow(
                      color: Colors.grey.withOpacity(0.3),
                      offset: const Offset(1, 1),
                      blurRadius: 2)
                ],
                fontFamily: poppinsMedium,
                fontSize: 28.sp,
                color: const Color.fromARGB(255, 255, 119, 0),
                fontWeight: FontWeight.w500,
                letterSpacing: 0),
          ),
        ),
        backgroundColor: ThemeController.to.currentTheme == ThemeMode.light
            ? Colors.grey[100]
            : kDark,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 60.sp,
        actions: [
          InkWell(
            onTap: () async {},
            child: Container(
              padding: EdgeInsets.all(10.0.sp),
              child: Icon(
                Icons.search,
                color: ThemeController.to.currentTheme == ThemeMode.light
                    ? textHintColor
                    : kWhite,
                size: 25.sp,
              ),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        centerTitle: false,
      ),
      body: GetBuilder<DashboardController>(
          init: DashboardController(),
          builder: (_) => Container(
                padding: EdgeInsets.all(10.0.sp),
                child: Obx(() {
                  var favoriteProducts = homeController.favoriteProducts;
                  return homeController.favoriteProducts.isEmpty
                      ? Center(
                          child: Text(
                            'Favorite list is empty',
                            textAlign: TextAlign.center,
                            style: smallTextStyle(
                              size: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: ThemeController.to.currentTheme == ThemeMode.light
                                  ? kBlack
                                  : kWhite,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: favoriteProducts.length,
                          itemBuilder: (context, index) {
                            final product = favoriteProducts[index];
                            return Card(
                              child: ListTile(
                                title: Text(
                                  product.name,
                                  style: largeTextStyle(size: 16.sp, color: ThemeController.to.currentTheme ==
                                      ThemeMode.light
                                      ? kBlack
                                      : kWhite,),
                                ),
                                subtitle: Text(
                                  'Price: \$${product.price}, Quantity: ${product.quantity}',
                                  style: smallTextStyle(size: 14.sp, color: ThemeController.to.currentTheme ==
                                      ThemeMode.light
                                      ? kBlack
                                      : kWhite,),
                                ),
                              ),
                            );
                          },
                        );
                }),
              )),
    );
  }
}
