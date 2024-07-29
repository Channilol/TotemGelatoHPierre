class OrderItem {
  List<OrderRowItem> rows;

  OrderItem({required this.rows});

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
        rows: (json['rows'] as List<dynamic>?)
                ?.map((e) => OrderRowItem.fromJson(e as Map<String, dynamic>))
                .toList() ??
            []);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['rows'] = rows.map((e) => e.toJson()).toList();
    return data;
  }

  OrderItem clone() {
    return OrderItem.fromJson(toJson());
  }
}

class OrderRowItem {
  String rowId;
  double qty;
  String productId;
  List<OrderExtraItem>? extras;

  OrderRowItem(
      {required this.rowId,
      this.qty = 1,
      required this.productId,
      required this.extras});

  factory OrderRowItem.fromJson(Map<String, dynamic> json) {
    return OrderRowItem(
      rowId: json['rowId'] as String,
      qty: json['qty'] as double,
      productId: json['productId'] as String,
      extras: (json['extras'] as List<dynamic>?)
          ?.map((e) => OrderExtraItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rowId'] = rowId;
    data['qty'] = qty;
    data['productId'] = productId;
    data['extras'] = extras?.map((e) => e.toJson()).toList();
    return data;
  }
}

class OrderExtraItem {
  String extraId;
  double qty;

  OrderExtraItem({required this.extraId, required this.qty});

  factory OrderExtraItem.fromJson(Map<String, dynamic> json) {
    return OrderExtraItem(
      extraId: json['extraId'] as String,
      qty: json['qty'] as double,
    );
  }

  @override
  // ignore: hash_and_equals
  bool operator ==(covariant OrderExtraItem other) {
    if (identical(this, other)) return true;
    return extraId == other.extraId;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['extraId'] = extraId;
    data['qty'] = qty;
    return data;
  }
}
