import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totem/services/my_colors.dart';
import 'package:totem/services/text.dart';

class BackBtn extends ConsumerWidget {
  const BackBtn({
    super.key,
    required this.language,
  });

  final Map language;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: FilledButton(
        style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(5))),
            backgroundColor: MyColors.colorBackground),
        onPressed: () => Navigator.pop(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.arrow_back_ios_new_rounded,
              color: MyColors.colorText,
              size: 18,
            ),
            Text(language['orderRecapScreen']['back'],
                style: TextStyle(
                    color: MyColors.colorText,
                    fontFamily: GoogleFonts.nunito().fontFamily,
                    fontSize: ResponsiveText.large(context)))
          ],
        ),
      ),
    );
  }
}
