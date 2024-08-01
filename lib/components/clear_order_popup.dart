import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totem/components/inactivity_timer.dart';
import 'package:totem/providers/language_provider.dart';
import 'package:totem/services/my_colors.dart';
import 'package:totem/services/text.dart';
import 'package:totem/services/utils.dart';

class ClearOrderPopup extends ConsumerWidget {
  const ClearOrderPopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = Utils.languages[ref.watch(languageProvider)];
    return InactivityTimer(
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(40),
                topLeft: Radius.circular(40),
                topRight: Radius.circular(20))),
        title: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 30,
          ),
          child: Text(
            language['orderRecapScreen']['cancelDialog']['description'],
            style: TextStyle(
              fontSize: ResponsiveText.huge(context),
            ),
          ),
        ),
        actions: [
          FilledButton(
            style: FilledButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(5))),
                backgroundColor: const Color(0x66C3ABA4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10)),
            onPressed: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                language['orderRecapScreen']['cancelDialog']['cancel'],
                style: TextStyle(
                  fontSize: ResponsiveText.huge(context),
                ),
              ),
            ),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(5))),
                backgroundColor: MyColors.colorText,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10)),
            onPressed: () => Navigator.pop(context, true),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                language['orderRecapScreen']['cancelDialog']['confirm'],
                style: TextStyle(
                  color: MyColors.colorBackground,
                  fontSize: ResponsiveText.huge(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
