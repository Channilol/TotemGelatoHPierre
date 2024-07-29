import 'package:flutter/material.dart';
import 'package:totem/components/inactivity_timer.dart';
import 'package:totem/models/order_item.dart';
import 'package:totem/models/product_item.dart';
import 'package:totem/services/utils.dart';

class ExtraPopup extends StatefulWidget {
  final int startIndex;
  final List<OrderRowItem> rows;
  const ExtraPopup({super.key, required this.rows, this.startIndex = 0});

  @override
  State<ExtraPopup> createState() => _ExtraPopupState();
}

class _ExtraPopupState extends State<ExtraPopup> {
  int currentItem = 0;
  List<OrderRowItem> rows = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      rows = widget.rows;
      currentItem = widget.startIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentProduct = Utils.products.firstWhere(
        (element) => element.productId == rows[currentItem].productId);
    return InactivityTimer(
      child: Dialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(50),
            topLeft: Radius.circular(50),
            topRight: Radius.circular(20),
          )),
          insetPadding:
              const EdgeInsets.symmetric(vertical: 80, horizontal: 60),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                IconButton(
                    style: IconButton.styleFrom(
                        backgroundColor: const Color(0x77C3ABA4)),
                    onPressed: currentItem > 0
                        ? () => setState(() => currentItem--)
                        : null,
                    icon: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: Color(0xFF907676))),
                Column(
                  children: [
                    if (currentProduct.image != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: Image.asset(
                          currentProduct.image!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    Text("${currentProduct.name} ${currentItem + 1}"),
                  ],
                ),
                IconButton(
                    style: IconButton.styleFrom(
                        backgroundColor: const Color(0x77C3ABA4)),
                    onPressed: currentItem < rows.length - 1
                        ? () => setState(() => currentItem++)
                        : null,
                    icon: const Icon(Icons.arrow_forward_ios_rounded,
                        color: Color(0xFF907676))),
              ]),
              Expanded(
                  child: currentProduct.extras == null
                      ? const Center(
                          child:
                              Text("Non ci sono varianti per questo prodotto"))
                      : ListView(
                          children: [
                            for (int i = 0;
                                i < currentProduct.extras!.length;
                                i++)
                              row(i, currentProduct)
                          ],
                        )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilledButton(
                      style: FilledButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(5))),
                          backgroundColor: const Color(0x66C3ABA4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10)),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "ANNULLA",
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFF907676)),
                      )),
                  const SizedBox(width: 20),
                  FilledButton(
                      style: FilledButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(5))),
                          backgroundColor: const Color(0xFF907676),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10)),
                      onPressed: () => Navigator.pop(context, rows),
                      child: const Text(
                        "AGGIUNGI",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      )),
                ],
              )
            ]),
          )),
    );
  }

  Widget row(int index, ProductItem product) {
    final extra = Utils.extras
        .firstWhere((e) => product.extras![index].extraId == e.extraId);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: ListTile(
          title: Text(Utils.extras[index].description),
          leading: Text("+${extra.price} €"),
          trailing: Switch(
              autofocus: true,
              inactiveThumbColor: const Color(0xFFC3ABA4),
              inactiveTrackColor: const Color(0xFFF1EAE2),
              activeColor: const Color(0xFF907676),
              value: rows[currentItem]
                  .extras!
                  .any((element) => element.extraId == extra.extraId),
              onChanged: (value) {
                setState(() {
                  if (rows[currentItem]
                      .extras!
                      .where((element) => element.extraId == extra.extraId)
                      .isEmpty) {
                    rows[currentItem]
                        .extras!
                        .add(OrderExtraItem(extraId: extra.extraId, qty: 1));
                  } else {
                    rows[currentItem]
                        .extras!
                        .remove(OrderExtraItem(extraId: extra.extraId, qty: 1));
                  }
                });
              })),
    );
  }
}
