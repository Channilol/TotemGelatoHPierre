import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totem/providers/password_provider.dart';
import 'package:totem/services/text.dart';

class KeyboardDelete extends ConsumerStatefulWidget {
  const KeyboardDelete({super.key});

  @override
  ConsumerState<KeyboardDelete> createState() => _KeyboardDeleteState();
}

class _KeyboardDeleteState extends ConsumerState<KeyboardDelete> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        elevation: 0,
      ),
      onPressed: () {
        ref.read(passwordProvider.notifier).deletePassword();
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Icon(
          CupertinoIcons.delete_left_fill,
          size: ResponsiveText.huge(context),
        ),
      ),
    );
  }
}
