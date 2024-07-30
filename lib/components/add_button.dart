import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:totem/models/product_item.dart';
import 'package:totem/providers/order_provider.dart';
import 'package:badges/badges.dart' as badges;

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    required this.productCount,
    required this.orderNotifier,
    required this.product,
  });

  final int productCount;
  final OrderProvider orderNotifier;
  final ProductItem product;

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      badgeAnimation: const badges.BadgeAnimation.rotation(
          animationDuration: Duration(milliseconds: 200)),
      badgeStyle: const badges.BadgeStyle(
        padding: EdgeInsets.all(7),
        borderSide: BorderSide(color: Colors.white, width: 2),
        badgeColor: Color.fromARGB(255, 0, 178, 6),
      ),
      badgeContent: Text(
        productCount.toString(),
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      showBadge: productCount > 0,
      child: FilledButton(
          style: FilledButton.styleFrom(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(5))),
              backgroundColor: const Color(0xFF907676),
              padding: const EdgeInsets.all(15)),
          onPressed: () => orderNotifier.addItem(product.productId),
          child: Column(
            children: [
              Text(
                "€ ${product.price.toStringAsFixed(2)}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const Text(
                "AGGIUNGI",
                style: TextStyle(color: Colors.white),
              )
            ],
          )),
    );
  }
}
