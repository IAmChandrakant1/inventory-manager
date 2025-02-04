import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inventory/model/product_model.dart';
import '../controller/dashboard_controller.dart';
import '../controller/home_controller.dart';
import '../controller/theme_controller.dart';
import '../utils/app_colors.dart';
import '../utils/app_theme_style.dart';

class SearchProductDelegate extends SearchDelegate<String> {
  final DashboardController dashboardController =
      Get.put(DashboardController());
  final HomeController homeController = Get.find<HomeController>();

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
          appBarTheme: AppBarTheme(
            surfaceTintColor: Colors.transparent,
            backgroundColor: ThemeController.to.currentTheme == ThemeMode.light
                ? Colors.grey[100]
                : kDark,
            toolbarTextStyle: mediumTextStyle(
              size: 10.sp,
              fontWeight: FontWeight.bold,
              color: ThemeController.to.currentTheme == ThemeMode.light
                  ? kBlack
                  : kWhite,
            ),
            titleTextStyle: mediumTextStyle(
              size: 10.sp,
              fontWeight: FontWeight.bold,
              color: ThemeController.to.currentTheme == ThemeMode.light
                  ? kBlack
                  : kWhite,
            ),
            elevation: 10,
            toolbarHeight: 40.sp,
            shadowColor: Colors.black.withOpacity(0.4),
          ),
        );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(
            Icons.clear,
            size: 14.sp,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
          size: 14.sp,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
   /* List<ProductModel> results = homeController.productList;
    if (query.isNotEmpty) {
      results = results
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }*/

    List<ProductModel> results = homeController.productList;

    if (query.isNotEmpty) {
      results = results
          .where((product) =>
          product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    return Material(
      type: MaterialType.transparency,
      child: results.isEmpty
          ? Center(
        child: Text(
          'No product found!',
          style: smallTextStyle(
              color: ThemeController.to.currentTheme == ThemeMode.light
                  ? kBlack
                  : kWhite,
              size: 16.sp),
        ),
      )
          : ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final ProductModel model = results[index];
          return ListTile(
            onTap: () {
              // Handle tap, if needed
            },
            title: Text(
              model.name,
              textAlign: TextAlign.start,
              maxLines: 1,
              style: mediumTextStyle(
                size: 15.sp,
                family: poppinsBold,
                color: ThemeController.to.currentTheme == ThemeMode.light
                    ? kBlack
                    : kWhite,
              ),
            ),
            subtitle: Text(
              'Quantity: ${model.quantity}, Price: \$${model.price}',
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: mediumTextStyle(
                size: 14.sp,
                family: poppinsLight,
                color: ThemeController.to.currentTheme == ThemeMode.light
                    ? textHintColor
                    : kWhite,
              ),
            ),
          );
        },
      ),
    );

    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          Container(
            color: ThemeController.to.currentTheme == ThemeMode.light
                ? Colors.grey[100]
                : kDark,
            child: results.isEmpty
                ? Center(
                    child: Text(
                      'No product found!',
                      style: smallTextStyle(
                          color:
                              ThemeController.to.currentTheme == ThemeMode.light
                                  ? kBlack
                                  : kWhite,
                          size: 16.sp),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text.rich(
                          TextSpan(
                            text: 'Recently added product',
                            style: mediumTextStyle(
                              size: 14.sp,
                              family: poppinsBold,
                              color: ThemeController.to.currentTheme ==
                                      ThemeMode.light
                                  ? grayColor
                                  : kWhite,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: results.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            final ProductModel model = results[index];
                            return ListTile(
                              onTap: () {},
                              title: Text(
                                model.name,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                style: mediumTextStyle(
                                  size: 15.sp,
                                  family: poppinsBold,
                                  color: ThemeController.to.currentTheme ==
                                          ThemeMode.light
                                      ? kBlack
                                      : kWhite,
                                ),
                              ),
                              subtitle: Text(
                                'Quantity: ${model.quantity}, Price: \$${model.price}',
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: mediumTextStyle(
                                  size: 14.sp,
                                  family: poppinsLight,
                                  color: ThemeController.to.currentTheme ==
                                          ThemeMode.light
                                      ? textHintColor
                                      : kWhite,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
