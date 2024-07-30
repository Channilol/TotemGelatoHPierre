import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totem/components/animated_filp_number.dart';
import 'package:totem/components/clear_order_popup.dart';
import 'package:totem/components/header.dart';
import 'package:totem/components/inactivity_timer.dart';
import 'package:totem/components/order_recap_item.dart';
import 'package:totem/components/semicircle.dart';
import 'package:totem/models/order_item.dart';
import 'package:totem/providers/language_provider.dart';
import 'package:totem/providers/order_provider.dart';
import 'package:totem/screens/payment_screen.dart';
import 'package:totem/services/utils.dart';

class OrderRecapScreen extends ConsumerWidget {
  const OrderRecapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(orderProvider);
    final totalProducts = Utils.getTotalProduct(order);
    final language = Utils.languages[ref.watch(languageProvider)];
    ref.listen(orderProvider, (prev, next) {
      if (next.rows.isEmpty) {
        Navigator.pop(context);
      }
    });

    return InactivityTimer(
      child: Scaffold(body: LayoutBuilder(builder: (context, constraint) {
        return Column(children: [
          Header(
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: FilledButton(
                style: FilledButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(5))),
                    backgroundColor: Colors.white),
                onPressed: () => Navigator.pop(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Color(0xFF907676),
                      size: 18,
                    ),
                    Text(language['orderRecapScreen']['back'],
                        style: TextStyle(
                            color: const Color(0xFF907676),
                            fontFamily: GoogleFonts.nunito().fontFamily,
                            fontSize: 14))
                  ],
                ),
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: FilledButton(
                  style: FilledButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(5))),
                    backgroundColor: const Color(0xFF907676),
                  ),
                  onPressed: () {
                    showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => const ClearOrderPopup())
                        .then((value) {
                      if (value == null) return;
                      ref
                          .read(orderProvider.notifier)
                          .setOrder(OrderItem(rows: []));
                      Navigator.pop(context);
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.xmark,
                        color: Colors.white,
                        size: 18,
                      ),
                      Text(language['orderRecapScreen']['clear'],
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              fontSize: 14))
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
              const Spacer()
            ],
          ),
          const SizedBox(height: 20),
          Text(
            language['orderRecapScreen']['title'],
            style: TextStyle(
                fontFamily: GoogleFonts.courgette().fontFamily,
                fontSize: 25,
                color: const Color(0xFFC3ABA4),
                fontWeight: FontWeight.bold),
          ),
          Text(
            (language['orderRecapScreen']['description'] as String)
                .replaceAll("{}", order.rows.length.toString()),
            style: const TextStyle(
                fontSize: 30,
                color: Color(0xFF907676),
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 30,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 10),
                  itemCount: totalProducts.length,
                  itemBuilder: (context, index) =>
                      OrderRecapItem(product: totalProducts[index])),
            ),
          ),
          Text(
            language['orderRecapScreen']['total'],
            style: TextStyle(
                fontFamily: GoogleFonts.courgette().fontFamily,
                fontSize: 25,
                color: const Color(0xFFC3ABA4),
                fontWeight: FontWeight.bold),
          ),
          AnimatedFlipCounter(
            prefix: "€ ",
            fractionDigits: 2,
            value: Utils.getTotalPrice(order.rows),
            textStyle: const TextStyle(
                fontSize: 30,
                color: Color(0xFF907676),
                fontWeight: FontWeight.bold),
          ),
          FilledButton(
              style: FilledButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(10))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                  backgroundColor: const Color(0xFF907676)),
              onPressed: order.rows.isNotEmpty
                  ? () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const PaymentScreen(),
                      ))
                  : null,
              child: Text(language['orderRecapScreen']['payment'],
                  style: TextStyle(color: Colors.white, fontSize: 25))),
          const SizedBox(height: 20),
        ]);
      })),
    );
  }
}
