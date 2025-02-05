import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inventory/utils/style_const.dart';
import 'package:inventory/widget/search_product.dart';
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

  Color getRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (_) => Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/user_image.jpg') as ImageProvider,
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
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: ThemeController.to.currentTheme == ThemeMode.light
                                ? Colors.grey[100]
                                : kDark,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Container(
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
                                        color:
                                            ThemeController.to.currentTheme ==
                                                    ThemeMode.light
                                                ? kBlack
                                                : kWhite,
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: favoriteProducts.length,
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      final product = favoriteProducts[index];
                                      return Dismissible(
                                        key: Key(product.id.toString()),
                                        direction: DismissDirection.endToStart,
                                        onDismissed: (direction) async {
                                          await homeController.toggleFavorite(product.id, product.favorite);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                '${product.name} has been ${product.favorite ? "removed from" : "added to"} favorites.',
                                              ),
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                        },
                                        background: Container(
                                          color: Colors.red,
                                          alignment: Alignment.centerRight,
                                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                            size: 30.0,
                                          ),
                                        ),
                                        child: Card(
                                          elevation: 5,
                                          surfaceTintColor: kWhite,
                                          color: getRandomColor(),
                                          child: ListTile(
                                            title: Text(
                                              product.name,
                                              style: largeTextStyle(
                                                size: 16.sp,
                                                color: ThemeController
                                                    .to.currentTheme ==
                                                    ThemeMode.light
                                                    ? kBlack
                                                    : kWhite,
                                              ),
                                            ),
                                            subtitle: Text(
                                              'Price: \$${product.price}, Quantity: ${product.quantity}',
                                              style: smallTextStyle(
                                                size: 14.sp,
                                                color: ThemeController
                                                    .to.currentTheme ==
                                                    ThemeMode.light
                                                    ? kBlack
                                                    : kWhite,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                      return Card(
                                        elevation: 5,
                                        surfaceTintColor: kWhite,
                                        color: getRandomColor(),
                                        child: ListTile(
                                          title: Text(
                                            product.name,
                                            style: largeTextStyle(
                                              size: 16.sp,
                                              color: ThemeController
                                                          .to.currentTheme ==
                                                      ThemeMode.light
                                                  ? kBlack
                                                  : kWhite,
                                            ),
                                          ),
                                          subtitle: Text(
                                            'Price: \$${product.price}, Quantity: ${product.quantity}',
                                            style: smallTextStyle(
                                              size: 14.sp,
                                              color: ThemeController
                                                          .to.currentTheme ==
                                                      ThemeMode.light
                                                  ? kBlack
                                                  : kWhite,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                          }
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
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
                    'Favorite',
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: largeTextStyle(
                      size: 28.sp,
                      color: ThemeController.to.currentTheme == ThemeMode.light
                          ? kWhite
                          : kWhite,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await showSearch(
                          context: context, delegate: SearchProductDelegate());
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0.sp),
                      child: Icon(
                        Icons.search,
                        color:
                            ThemeController.to.currentTheme == ThemeMode.light
                                ? kWhite
                                : kWhite,
                        size: 25.sp,
                      ),
                    ),
                  ),
                ],
              ),
              heightWidget(25),
            ],
          )),
    );
  }
}
