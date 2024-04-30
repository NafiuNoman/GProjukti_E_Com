class ProductTitles {
  final String name;
  final String slug;

  ProductTitles({required this.name, required this.slug});

  factory ProductTitles.fromJson(Map<String, dynamic> json) =>
      ProductTitles(name: json['name'], slug: json['slug']);
}
