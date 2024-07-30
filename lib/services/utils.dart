import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:totem/models/category_item.dart';
import 'package:totem/models/extra_item.dart';
import 'package:totem/models/order_item.dart';
import 'package:totem/models/product_item.dart';
import 'package:uuid/uuid.dart';

class Utils {
  static List<CategoryItem> categories = [];
  static List<ExtraItem> extras = [];
  static List<ProductItem> products = [];
  static List<dynamic> languages = [];

  static Future<void> initCategories() async {
    final data = await rootBundle.loadString("assets/data/categorie.json");
    final jsonData = json.decode(data) as List<dynamic>;
    categories = jsonData.map((e) => CategoryItem.fromJson(e)).toList();
  }

  static Future<void> initExtras() async {
    final data = await rootBundle.loadString("assets/data/varianti.json");
    final jsonData = json.decode(data) as List<dynamic>;
    extras = jsonData.map((e) => ExtraItem.fromJson(e)).toList();
  }

  static Future<void> initProducts() async {
    final data = await rootBundle.loadString("assets/data/prodotti.json");
    final jsonData = json.decode(data) as List<dynamic>;
    products = jsonData.map((e) => ProductItem.fromJson(e)).toList();
  }

  static Future<void> init() async {
    await initCategories();
    await initExtras();
    await initProducts();
    await initLanguage();
  }

  static String getUUID() => const Uuid().v8();

  static double getTotalPrice(List<OrderRowItem> rows) {
    double total = 0;
    for (var element in rows) {
      final product =
          Utils.products.firstWhere((el) => el.productId == element.productId);

      total += element.qty * product.price + getExtraFromRow(element);
    }
    return total;
  }

  static List<ProductItem> getTotalProduct(OrderItem order) {
    List<ProductItem> orderProducts = [];
    for (int i = 0; i < order.rows.length; i++) {
      if (orderProducts.any(
        (element) => element.productId == order.rows[i].productId,
      )) {
        continue;
      }
      orderProducts.add(products.firstWhere(
          (element) => element.productId == order.rows[i].productId));
    }
    return orderProducts;
  }

  static double getExtraFromRow(OrderRowItem row) {
    if (row.extras == null) return 0;
    double total = 0;
    for (var element in row.extras!) {
      final el =
          Utils.extras.firstWhere((el) => el.extraId == element.extraId).price!;
      total += element.qty * el;
    }
    return total;
  }

  static double getRowPrice(OrderRowItem rowItem) {
    final product =
        products.firstWhere((el) => el.productId == rowItem.productId);
    return product.price * rowItem.qty + getExtraFromRow(rowItem);
  }

  static double getPriceFromProduct(OrderItem order, String productId) {
    double totalPrice = 0;
    for (final row in order.rows) {
      if (row.productId == productId) {
        totalPrice += getRowPrice(row);
      }
    }
    return totalPrice;
  }

  static Future<void> initLanguage() async {
    final data = await rootBundle.loadString("assets/languages.json");
    final jsonData = json.decode(data) as Map<String, dynamic>;
    languages = jsonData['languages'] as List<dynamic>;
  }
}
