import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:totem/models/extra_item.dart';
import 'package:totem/models/order_item.dart';
import 'package:totem/models/product_item.dart';
import 'package:totem/providers/accessibility_provider.dart';
import 'package:totem/providers/order_provider.dart';
import 'package:totem/services/my_colors.dart';
import 'package:totem/services/text.dart';
import 'package:totem/services/utils.dart';

class DeletePopupItem extends ConsumerStatefulWidget {
  const DeletePopupItem(
      {super.key, required this.product, required this.orderRow});
  final ProductItem product;
  final OrderRowItem orderRow;

  @override
  ConsumerState<DeletePopupItem> createState() => _DeletePopupItemState();
}

class _DeletePopupItemState extends ConsumerState<DeletePopupItem> {
  @override
  Widget build(BuildContext context) {
    final isAccessibilityOn = ref.watch(accessibilityProvider);
    List<ExtraItem> extraItemsList = Utils.extras;
    String extrasString = "";
    if (widget.orderRow.extras!.isNotEmpty) {
      String extraString = "";
      for (var i = 0; i < widget.orderRow.extras!.length; i++) {
        var extra = extraItemsList
            .firstWhere((e) => e.extraId == widget.orderRow.extras![i].extraId);
        extraString += "${extra.description}, ";
      }
      extrasString = extraString.substring(0, extraString.length - 2);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Dismissible(
        key: Key(widget.orderRow.rowId),
        onDismissed: (direction) {
          ref.read(orderProvider.notifier).removeOrder(widget.orderRow.rowId);
        },
        background: Container(
          decoration: BoxDecoration(
            color: MyColors.colorSecondary,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
          ),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
            color: MyColors.colorContainer,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.125,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                      ),
                      child: Image.asset(
                        widget.product.image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style:
                            TextStyle(fontSize: ResponsiveText.huge(context)),
                      ),
                      Text(
                        'Extra: ${widget.orderRow.extras!.isEmpty ? 'No' : extrasString}',
                        style: TextStyle(
                            fontSize: isAccessibilityOn
                                ? ResponsiveText.medium(context)
                                : ResponsiveText.large(context)),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      ref
                          .read(orderProvider.notifier)
                          .removeOrder(widget.orderRow.rowId);
                    },
                    icon: Icon(
                      FontAwesomeIcons.trash,
                      color: MyColors.colorText,
                      size: ResponsiveText.huge(context),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
