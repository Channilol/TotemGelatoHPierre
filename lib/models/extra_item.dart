class ExtraItem {
  String extraId;
  String description;
  num? price;

  ExtraItem({required this.extraId, required this.description, this.price});

  factory ExtraItem.fromJson(Map<String, dynamic> json) {
    return ExtraItem(
        extraId: json['extraId'] as String,
        description: json['description'] as String,
        price: json['price'] as num?);
  }

  Map<String, dynamic> toJson() =>
      {"extraId": extraId, "description": description, "price": price};
}
