class ProductItem {
  String productId;
  String description;
  String name;
  String categoryId;
  String? image;
  num price;

  List<ProductExtraItem>? extras = [];

  ProductItem(
      {required this.productId,
      required this.name,
      required this.description,
      required this.categoryId,
      required this.price,
      this.image,
      this.extras});

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      name: json["name"] as String,
      productId: json['productId'] as String,
      description: json['description'] as String,
      categoryId: json['categoryId'] as String,
      price: json['price'] as num,
      image: json['image'] as String?,
      extras: (json['extras'] as List<dynamic>?)
          ?.map((e) => ProductExtraItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "name": name,
        "description": description,
        "categoryId": categoryId,
        "price": price,
        "image": image,
        "extras": extras?.map((e) => e.toJson()).toList(),
      };
}

class ProductExtraItem {
  String extraId;
  int? order;

  ProductExtraItem({required this.extraId, this.order});

  factory ProductExtraItem.fromJson(Map<String, dynamic> json) {
    return ProductExtraItem(
      extraId: json['extraId'] as String,
      order: json['order'] != null ? int.parse(json['order'].toString()) : 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "extraId": extraId,
        "order": order,
      };
}
