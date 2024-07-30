import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totem/providers/accessibility_provider.dart';
import 'package:totem/services/my_colors.dart';

class AccessibilityDropdown extends ConsumerWidget {
  const AccessibilityDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accessibility = ref.watch(accessibilityProvider);
    return DropdownButton<bool>(
      value: accessibility,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: MyColors.colorText),
      underline: Container(
        height: 2,
      ),
      onChanged: (bool? value) {
        if (value == null) return;
        ref.read(accessibilityProvider.notifier).changeAccessibility(value);
      },
      items: const [
        DropdownMenuItem<bool>(
          value: true,
          child: Text('On'),
        ),
        DropdownMenuItem<bool>(
          value: false,
          child: Text('Off'),
        ),
      ],
    );
  }
}
