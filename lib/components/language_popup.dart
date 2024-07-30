import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totem/providers/language_provider.dart';
import 'package:totem/services/my_colors.dart';
import 'package:totem/services/utils.dart';

class LanguagePopup extends ConsumerWidget {
  const LanguagePopup({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageNotifier = ref.read(languageProvider.notifier);
    final languageIndex = ref.watch(languageProvider);
    return DropdownButton<int>(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(5),
        bottomRight: Radius.circular(20),
        topLeft: Radius.circular(20),
        topRight: Radius.circular(5),
      ),
      value: languageIndex,
      icon: const SizedBox(),
      elevation: 16,
      style: TextStyle(color: MyColors.colorText),
      underline: Container(
        height: 2,
      ),
      onChanged: (int? value) {
        if (value == null) return;
        languageNotifier.setLanguage(value);
      },
      items: [
        for (int i = 0; i < Utils.languages.length; i++)
          DropdownMenuItem<int>(
              alignment: Alignment.center,
              value: i,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(Utils.languages[i]['name']),
              ))
      ],
    );
  }
}
