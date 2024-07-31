import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totem/components/clear_order_popup.dart';
import 'package:totem/models/order_item.dart';
import 'package:totem/providers/order_provider.dart';
import 'package:totem/services/my_colors.dart';
import 'package:totem/services/text.dart';

class ClearButton extends ConsumerWidget {
  const ClearButton({
    super.key,
    required this.language,
  });

  final Map language;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: FilledButton(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(5))),
          backgroundColor: MyColors.colorText,
        ),
        onPressed: () {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => ClearOrderPopup()).then((value) {
            if (value == null) return;
            ref.read(orderProvider.notifier).setOrder(OrderItem(rows: []));
            Navigator.pop(context);
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FaIcon(
              FontAwesomeIcons.xmark,
              color: MyColors.colorBackground,
              size: 18,
            ),
            Text(language['orderRecapScreen']['clear'],
                style: TextStyle(
                    color: MyColors.colorBackground,
                    fontFamily: GoogleFonts.nunito().fontFamily,
                    fontSize: ResponsiveText.large(context)))
          ],
        ),
      ),
    );
  }
}
