import 'package:moible_app/data/remote/model/product_title_model.dart';

class ProductGroupList {
  final bool success;
  final String message;
  final List<ProductGroup> data;

  ProductGroupList(
      {required this.success, required this.message, required this.data});

  factory ProductGroupList.fromJson(Map<String, dynamic> json) =>
      ProductGroupList(
          success: json['success'],
          message: json['message'],
          data: List.from(json['data'])
              .map((e) => ProductGroup.fromJson(e))
              .toList());
}

class ProductGroup extends ProductTitles {
  final List<ProductCategory> categories;

  ProductGroup(
      {required super.name, required super.slug, required this.categories});

  factory ProductGroup.fromJson(Map<String, dynamic> json) => ProductGroup(
        name: json['name'],
        slug: json['slug'],
        categories:  List.from(json['categories']).map((e) => ProductCategory.fromJson(e)).toList()
  );
}

class ProductCategory extends ProductTitles {
  final String? logo;
  final List<ProductSubCategories>? subcategories;

  ProductCategory(
      {required super.name,
      required super.slug,
      required this.logo,
      this.subcategories});

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
          name: json['name'],
          slug: json['slug'],
          logo: json['logo'],
          subcategories: List.from(json['subcategories']).map((e) => ProductSubCategories.fromJson(e)).toList());
}

class ProductSubCategories extends ProductTitles {
  final String? logo;

  ProductSubCategories(
      {required super.name, required super.slug, required this.logo});

  factory ProductSubCategories.fromJson(Map<String, dynamic> json) =>
      ProductSubCategories(
        name: json['name'],
        slug: json['slug'],
        logo: json['logo'],
      );
}
