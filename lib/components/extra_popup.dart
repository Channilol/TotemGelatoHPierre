import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totem/components/inactivity_timer.dart';
import 'package:totem/models/order_item.dart';
import 'package:totem/models/product_item.dart';
import 'package:totem/providers/language_provider.dart';
import 'package:totem/services/my_colors.dart';
import 'package:totem/services/text.dart';
import 'package:totem/services/utils.dart';

class ExtraPopup extends ConsumerStatefulWidget {
  final int startIndex;
  final List<OrderRowItem> rows;
  const ExtraPopup({super.key, required this.rows, this.startIndex = 0});

  @override
  ConsumerState<ExtraPopup> createState() => _ExtraPopupState();
}

class _ExtraPopupState extends ConsumerState<ExtraPopup> {
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
    final language = Utils.languages[ref.watch(languageProvider)];
    final currentProduct = Utils.products.firstWhere(
        (element) => element.productId == rows[currentItem].productId);
    return InactivityTimer(
      child: LayoutBuilder(builder: (context, constraints) {
        double maxHeight = constraints.maxHeight;
        double maxWidth = constraints.maxWidth;

        return Container(
          height: maxHeight * 0.4,
          width: maxWidth * 0.6,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            style: IconButton.styleFrom(
                                backgroundColor: const Color(0x77C3ABA4)),
                            onPressed: currentItem > 0
                                ? () => setState(() => currentItem--)
                                : null,
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: MyColors.colorText,
                              size: ResponsiveText.huge(context),
                            )),
                        Column(
                          children: [
                            if (currentProduct.image != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: Image.asset(
                                  currentProduct.image!,
                                  width: ResponsiveText.title(context),
                                  height: ResponsiveText.title(context),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            Text("${currentProduct.name} ${currentItem + 1}",
                                style: TextStyle(
                                    color: MyColors.colorText,
                                    fontSize:
                                        ResponsiveText.huge(context) + 10)),
                          ],
                        ),
                        IconButton(
                            style: IconButton.styleFrom(
                                backgroundColor: const Color(0x77C3ABA4)),
                            onPressed: currentItem < rows.length - 1
                                ? () => setState(() => currentItem++)
                                : null,
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: MyColors.colorText,
                              size: ResponsiveText.huge(context),
                            )),
                      ]),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Container(
                        child: currentProduct.extras == null
                            ? const Center(
                                child: Text(
                                    "Non ci sono varianti per questo prodotto"))
                            : Column(
                                children: [
                                  for (int i = 0;
                                      i < currentProduct.extras!.length;
                                      i++)
                                    row(i, currentProduct)
                                ],
                              )),
                  ),
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
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
                            child: Text(
                              language['orderScreen']['modal_button_remove'],
                              style: TextStyle(
                                  fontSize: ResponsiveText.huge(context),
                                  color: MyColors.colorText),
                            ),
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
                              backgroundColor: MyColors.colorText,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10)),
                          onPressed: () => Navigator.pop(context, rows),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
                            child: Text(
                              language['orderScreen']['modal_button_add'],
                              style: TextStyle(
                                  fontSize: ResponsiveText.huge(context),
                                  color: MyColors.colorBackground),
                            ),
                          )),
                    ],
                  )
                ]),
          ),
        );
      }),
    );
  }

  Widget row(int index, ProductItem product) {
    final extra = Utils.extras
        .firstWhere((e) => product.extras![index].extraId == e.extraId);
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: 15, horizontal: ResponsiveText.huge(context)),
      child: Row(children: [
        Transform.scale(
          scale: 2,
          child: Switch(
              autofocus: true,
              inactiveThumbColor: MyColors.colorSecondary,
              inactiveTrackColor: MyColors.colorContainer,
              activeColor: MyColors.colorText,
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
              }),
        ),
        const SizedBox(width: 50),
        Text(
          "+${extra.price} € ${Utils.extras[index].description}",
          style: TextStyle(fontSize: ResponsiveText.huge(context)),
        ),
      ]),
    );
  }
}
