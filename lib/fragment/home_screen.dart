import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inventory/controller/home_controller.dart';
import '../controller/dashboard_controller.dart';
import '../controller/theme_controller.dart';
import '../model/product_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_theme_style.dart';
import '../widget/search_product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DashboardController dashboardController =
      Get.find<DashboardController>();
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeController.to.currentTheme == ThemeMode.light
          ? Colors.grey[100]
          : kDark,
      appBar: AppBar(
        title: Text.rich(
          TextSpan(
            text: 'Inventory',
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
            onTap: () async {
              await showSearch(
                  context: context, delegate: SearchProductDelegate());
            },
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
        builder: (_) => Obx(
          () {
            return homeController.isLoading.value
                ? Center(
              child: CircularProgressIndicator(
                color: backgroundColor,
              ),
            )
                : SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Container(
                        padding: EdgeInsets.all(10.0.sp),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: homeController.productList.length,
                          itemBuilder: (context, index) {
                            final product =
                            homeController.productList[index];
                            return Card(
                              elevation: 5,
                              margin: EdgeInsets.symmetric(
                                  vertical: 8.0.sp, horizontal: 8.0.sp),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.all(10.0.sp),
                                title: Text(
                                  product.name,
                                  style: largeTextStyle(size: 16.sp, color: ThemeController.to.currentTheme ==
                                      ThemeMode.light
                                      ? kBlack
                                      : kWhite,),
                                ),
                                subtitle: Text(
                                  'Quantity: ${product.quantity}, Price: \$${product.price}',
                                  style: smallTextStyle(size: 14.sp, color: ThemeController.to.currentTheme ==
                                      ThemeMode.light
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
                                      onPressed: () {
                                        homeController.toggleFavorite(
                                            product.id, product.favorite);
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
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        size: 24.sp,
                                      ),
                                      onPressed: () async{
                                        await homeController.deleteProduct(product.id);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                    ),
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddProductDialog,
        backgroundColor: backgroundColor,
        child: const Icon(Icons.add),
      ),
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
