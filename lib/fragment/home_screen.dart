import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inventory/controller/home_controller.dart';
import 'package:inventory/model/product_model.dart';
import 'package:inventory/utils/style_const.dart';
import 'package:shimmer/shimmer.dart';
import '../controller/dashboard_controller.dart';
import '../controller/theme_controller.dart';
import '../utils/app_colors.dart';
import '../utils/app_theme_style.dart';
import '../widget/search_product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DashboardController dashboardController = Get.find<DashboardController>();
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.fetchProducts();
  }

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
                            return homeController.isLoading.value
                                ? Center(
                              child: CircularProgressIndicator(
                                color: backgroundColor,
                              ),
                            )
                                : ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: homeController.productList.length,
                              itemBuilder: (context, index) {
                                final product = homeController.productList[index];
                                return Dismissible(
                                  key: Key(product.id.toString()),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (direction) async {
                                    await homeController.deleteProduct(product.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('${product.name} deleted')),
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
                                    margin: EdgeInsets.symmetric(vertical: 8.0.sp, horizontal: 8.0.sp),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.all(10.0.sp),
                                      title: Text(
                                        product.name,
                                        style: largeTextStyle(size: 16.sp, color: ThemeController.to.currentTheme == ThemeMode.light
                                            ? kBlack
                                            : kWhite,),
                                      ),
                                      subtitle: Text(
                                        'Quantity: ${product.quantity}, Price: \$${product.price}',
                                        style: smallTextStyle(size: 14.sp, color: ThemeController.to.currentTheme == ThemeMode.light
                                            ? kBlack
                                            : kWhite,),
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.favorite,
                                              color: product.favorite
                                                  ? Colors.red
                                                  : null,
                                              size: 24.sp,
                                            ),
                                            onPressed: () async {
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
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              size: 24.sp,
                                            ),
                                            onPressed: () {
                                              showEditProductDialog(product);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddProductDialog,
        backgroundColor: backgroundColor,
        child: const Icon(Icons.add),
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
                    'Inventory',
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

  void showAddProductDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: homeController.nameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
              ),
              TextField(
                controller: homeController.quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Quantity'),
              ),
              TextField(
                controller: homeController.priceController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Price'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final name = homeController.nameController.text;
                final quantity =
                    int.tryParse(homeController.quantityController.text) ?? 0;
                final price =
                    double.tryParse(homeController.priceController.text) ?? 0.0;

                if (name.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a product name')),
                  );
                } else if (quantity == null || quantity <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid quantity')),
                  );
                } else if (price == null || price <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid price')),
                  );
                } else {
                  homeController.addProduct(name, quantity, price);
                  homeController.nameController.clear();
                  homeController.quantityController.clear();
                  homeController.priceController.clear();
                  Get.back();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void showEditProductDialog(ProductModel product) {
    homeController.nameController.text = product.name;
    homeController.quantityController.text = product.quantity.toString();
    homeController.priceController.text = product.price.toString();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: homeController.nameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
              ),
              TextField(
                controller: homeController.quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Quantity'),
              ),
              TextField(
                controller: homeController.priceController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Price'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final name = homeController.nameController.text;
                final quantity =
                    int.tryParse(homeController.quantityController.text) ?? 0;
                final price =
                    double.tryParse(homeController.priceController.text) ?? 0.0;

                if (name.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a product name')),
                  );
                } else if (quantity <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid quantity')),
                  );
                } else if (price <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid price')),
                  );
                } else {
                  homeController.editProduct(product.id, name, quantity, price);
                  homeController.nameController.clear();
                  homeController.quantityController.clear();
                  homeController.priceController.clear();
                  Get.back();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}