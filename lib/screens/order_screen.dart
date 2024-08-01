import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totem/components/animated_filp_number.dart';
import 'package:totem/components/categories_bar.dart';
import 'package:totem/components/dialog_wrapper.dart';
import 'package:totem/components/header.dart';
import 'package:totem/components/inactivity_timer.dart';
import 'package:totem/components/kill_app_popup.dart';
import 'package:totem/components/product_list.dart';
import 'package:totem/components/semicircle.dart';
import 'package:totem/providers/accessibility_provider.dart';
import 'package:totem/providers/language_provider.dart';
import 'package:totem/providers/order_provider.dart';
import 'package:totem/screens/order_recap_screen.dart';
import 'package:totem/services/my_colors.dart';
import 'package:totem/services/text.dart';
import 'package:totem/services/utils.dart';

class OrderScreen extends ConsumerStatefulWidget {
  const OrderScreen({super.key});

  @override
  ConsumerState<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  int _touchCount = 0;
  late Timer _timer;

  void _resetTimer() {
    _timer.cancel();
    _timer = Timer(const Duration(seconds: 1), () {
      setState(() => _touchCount = 0);
    });
  }

  void initState() {
    _timer = Timer(const Duration(seconds: 1), () {
      setState(() => _touchCount = 0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final order = ref.watch(orderProvider);
    final language = Utils.languages[ref.watch(languageProvider)];
    final isAccessibilityOn = ref.watch(accessibilityProvider);

    return Scaffold(
      body: InactivityTimer(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            setState(() => _touchCount = 0);
          },
          child: Column(
            children: [
              Header(
                leading: isAccessibilityOn
                    ? SizedBox()
                    : GestureDetector(
                        onTap: () {
                          if (_touchCount < 5) {
                            setState(() => _touchCount++);
                          } else {
                            setState(() {
                              _resetTimer();
                              _touchCount = 0;
                            });
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                              color: MyColors.colorBackground,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(5),
                              )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AnimatedFlipCounter(
                                value: order.rows.length,
                                suffix:
                                    " ${language['orderScreen']['button_top_left']}",
                                textStyle: TextStyle(
                                    fontSize: ResponsiveText.medium(context)),
                              ),
                              AnimatedFlipCounter(
                                value: Utils.getTotalPrice(order.rows),
                                prefix: "€ ",
                                fractionDigits: 2,
                                textStyle: TextStyle(
                                    fontSize: ResponsiveText.medium(context),
                                    color: MyColors.colorText,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                trailing: isAccessibilityOn
                    ? SizedBox()
                    : GestureDetector(
                        onTap: () {
                          if (_touchCount == 5) {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) =>
                                    DialogWrapper(child: const KillAppPopup()));
                            setState(() {
                              _resetTimer();
                              _touchCount = 0;
                            });
                            return;
                          }
                          if (order.rows.isNotEmpty) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderRecapScreen()));
                          }
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(144, 118, 118,
                                  order.rows.isNotEmpty ? 1 : 0.7),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(20),
                              )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  language['orderScreen']['button_top_right_1'],
                                  style: TextStyle(
                                      color: MyColors.colorBackground,
                                      fontSize:
                                          ResponsiveText.medium(context))),
                              Text(
                                language['orderScreen']['button_top_right_2'],
                                style: TextStyle(
                                    color: MyColors.colorBackground,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ResponsiveText.medium(context)),
                              )
                            ],
                          ),
                        ),
                      ),
              ),
              Semicircle(),
              Expanded(
                child: Row(
                  children: [
                    Expanded(child: CategoriesBar()),
                    SizedBox(width: 10),
                    Expanded(flex: 5, child: ProductList()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
