class ProductByCategory {
  final bool success;
  final DataClass data;

  ProductByCategory({required this.success, required this.data});

  factory ProductByCategory.fromJson(Map<String, dynamic> json) =>
      ProductByCategory(
        success: json['success'],
        data: DataClass.fromJson(json['data']),
      );
}

class DataClass {
  final List<Product> data;

  DataClass({required this.data});

  factory DataClass.fromJson(Map<String, dynamic> json) => DataClass(
      data: List.from(json['data']).map((e) => Product.fromJson(e)).toList());
}

class Product {
  final int id;
  final String? images;
  final String name;
  final String slug;
  final MetaModel meta;
  final bool stock_available;
  final double updated_selling_price;
  final double? selling_price;

  Product(
      {required this.id,
      required this.images,
      required this.meta,
      required this.name,
      required this.slug,
      required this.stock_available,
      required this.updated_selling_price,
      required this.selling_price});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json['id'],
      images: json['images'],
      name: json['name'],
      slug: json['slug'],
      meta: MetaModel.fromJson(json['meta']),
      stock_available: json['stock_available'],
      updated_selling_price: json['updated_selling_price'],
      selling_price: json['selling_price']);
}

class MetaModel {
  final String? description;
  final String? short_description;

  MetaModel({this.description, this.short_description});

  factory MetaModel.fromJson(Map<String, dynamic> json) => MetaModel(
        description: json['description'],
        short_description: json['short_description'],
      );
}
