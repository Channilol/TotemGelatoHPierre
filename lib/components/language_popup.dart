import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totem/providers/language_provider.dart';
import 'package:totem/services/utils.dart';

class LanguagePopup extends ConsumerStatefulWidget {
  const LanguagePopup({super.key});

  @override
  ConsumerState<LanguagePopup> createState() => _LanguagePopupState();
}

class _LanguagePopupState extends ConsumerState<LanguagePopup> {
  @override
  Widget build(BuildContext context) {
    final languageNotifier = ref.read(languageProvider.notifier);
    final languageIndex = ref.watch(languageProvider);
    return DropdownButton<int>(
      value: languageIndex,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
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
              value: i, child: Text(Utils.languages[i]['name']))
      ],
    );
  }
}
