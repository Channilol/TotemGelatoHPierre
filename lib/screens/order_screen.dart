import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totem/components/animated_filp_number.dart';
import 'package:totem/components/categories_bar.dart';
import 'package:totem/components/header.dart';
import 'package:totem/components/language_popup.dart';
import 'package:totem/components/product_list.dart';
import 'package:totem/providers/language_provider.dart';

import 'package:totem/providers/order_provider.dart';
import 'package:totem/screens/order_recap_screen.dart';
import 'package:totem/services/utils.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(orderProvider);
    final language = Utils.languages[ref.watch(languageProvider)];
    // final dir = Directory('path/to/directory');
    // final List<FileSystemEntity> entities = await dir.list().toList();

    return Scaffold(
      body: Column(
        children: [
          Header(
            leading: Container(
                margin: const EdgeInsets.all(10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(5),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedFlipCounter(
                      value: order.rows.length,
                      suffix: " ${language['orderScreen']['button_top_left']}",
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                    AnimatedFlipCounter(
                      value: Utils.getTotalPrice(order.rows),
                      prefix: "€ ",
                      fractionDigits: 2,
                      textStyle: const TextStyle(
                          color: Color(0xFF907676),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )),
            trailing: GestureDetector(
              onTap: () => order.rows.isNotEmpty
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OrderRecapScreen()))
                  : null,
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  margin: const EdgeInsets.all(10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(
                          144, 118, 118, order.rows.isNotEmpty ? 1 : 0.7),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(20),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(language['orderScreen']['button_top_right_1'],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              letterSpacing: 0)),
                      Text(
                        language['orderScreen']['button_top_right_2'],
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0,
                            fontSize: 12),
                      )
                    ],
                  )),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Transform.translate(
                offset: const Offset(0, -10),
                child: Column(children: [
                  Container(
                      width: 120,
                      height: 60,
                      decoration: const BoxDecoration(
                          color: Color(0xFFF1EAE2),
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(500)))),
                ]),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(10),
                      child: LanguagePopup()
              ))
            ],
          ),
          const Expanded(
            child: Row(
              children: [
                CategoriesBar(),
                SizedBox(width: 10),
                Expanded(child: ProductList()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
