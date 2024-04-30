import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moible_app/data/remote/api_service.dart';
import 'package:moible_app/data/remote/model/product_by_category.dart';

import '../data/remote/model/product_group_List_model.dart';

class ProductCtr extends GetxController {
  int selectedCategoryIndex = 0;
  int selectedProductIndex = 0;

  List<ProductCategory> categories = [];
  List<ProductSubCategories> subCategories = [];
  final List<Product> products = [];

  Future<List<ProductCategory>> getProductCategories() async {
    if (await checkInternet()) {
      ProductGroupList? model = await ApiService.getProductCategories();
      if (model != null) {
        List<ProductGroup> groups = model.data;
        for (var group in groups) {
          if (group.categories.isNotEmpty) {
            for (var category in group.categories) {
              categories.add(category);
            }
          }
        }
      }
    }

    return categories;
  }

  Future<List<Product>> getProductListByCategories() async {
    String categorySlug = categories.elementAt(selectedCategoryIndex).slug;

    ProductByCategory? model =
        await ApiService.getProductListByCategory(categorySlug);
    if (model != null) {
      products.clear();
      DataClass dataModel = model.data;

      for (var product in dataModel.data) {
        products.add(product);
      }
    }
    return products;
  }

  List<ProductSubCategories> loadSubCategoriesProduct() {
    subCategories.clear();

    ProductCategory category = categories.elementAt(selectedCategoryIndex);

    if (category.subcategories != null && category.subcategories!.isNotEmpty) {
      for (var subCategory in category.subcategories!) {
        subCategories.add(subCategory);
      }
    }

    return subCategories;
  }

  Product loadProduct() {
    return products.elementAt(selectedProductIndex);
  }

  Future<bool> checkInternet() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else {
      Get.rawSnackbar(
          backgroundColor: Colors.redAccent,
          message: "Internet connection is not available",
          icon: const Icon(
            Icons.wifi_off,
            color: Colors.white,
          ),
          snackPosition: SnackPosition.TOP);
      return false;
    }
  }
}
