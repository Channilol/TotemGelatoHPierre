import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totem/components/product_card.dart';
import 'package:totem/providers/category_provider.dart';
import 'package:totem/services/utils.dart';

class ProductList extends ConsumerWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentCategory = Utils.categories[ref.watch(categoryProvider)];
    return Stack(
      children: [
        ListView(
          children: [
            ...Utils.products
              .where((product) =>
                  product.categoryId ==
                  currentCategory.categoryId)
              .map((product) => ProductCard(product: product)), 
              const SizedBox(height: 50,)
              ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 100.0, // Altezza della sfumatura
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(0, 255, 255, 255),
                  Colors.white, // Colore di sfondo
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
