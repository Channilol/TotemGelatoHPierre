class CategoryItem {
  String categoryId;
  String name;
  String? image;

  CategoryItem({required this.categoryId, required this.name, this.image});

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
        categoryId: json['categoryId'] as String,
        name: json['name'] as String,
        image: json['image'] as String?);
  }

  Map<String, dynamic> toJson() =>
      {"categoryId": categoryId, "name": name, "image": image};
}
