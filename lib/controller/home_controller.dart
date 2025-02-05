import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:inventory/model/product_model.dart';


class HomeController extends GetxController{
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  var productList = <ProductModel>[].obs;
  var isLoading = false.obs;

  Future<void> addProduct(String name, int quantity, double price) async {
    try {
      var docRef = await FirebaseFirestore.instance.collection('products').add({
        'name': name,
        'quantity': quantity,
        'price': price,
        'favorite': false,
      });
      fetchProducts();
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  Future<void> editProduct(String productId, String name, int quantity, double price) async {
    try {
      await FirebaseFirestore.instance.collection('products').doc(productId).update({
        'name': name,
        'quantity': quantity,
        'price': price,
      });
      fetchProducts();
    } catch (e) {
      print('Error editing product: $e');
    }
  }

  Future<void> toggleFavorite(String productId, bool currentFavoriteStatus) async {
    try {
      await FirebaseFirestore.instance.collection('products').doc(productId).update({
        'favorite': !currentFavoriteStatus,
      });
      fetchProducts();
    } catch (e) {
      print('Error updating favorite status: $e');
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .delete();
      productList.removeWhere((product) => product.id == productId);
    } catch (e) {
      print("Error deleting product: $e");
    }
  }


  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      var snapshot = await FirebaseFirestore.instance.collection('products').get();
      productList.value = snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data(), doc.id)) // Include the document ID
          .toList();

    } catch (e) {
      print('Error fetching products: $e');
    } finally{
      isLoading.value = false;
    }
  }

  List<ProductModel> get favoriteProducts {
    return productList.where((product) => product.favorite).toList();
  }

}