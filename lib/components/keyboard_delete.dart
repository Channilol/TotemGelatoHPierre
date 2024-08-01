import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totem/providers/password_provider.dart';

class KeyboardDelete extends ConsumerStatefulWidget {
  const KeyboardDelete({super.key});

  @override
  ConsumerState<KeyboardDelete> createState() => _KeyboardDeleteState();
}

class _KeyboardDeleteState extends ConsumerState<KeyboardDelete> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          ref.read(passwordProvider.notifier).deletePassword();
        },
        child: Icon(CupertinoIcons.delete_left_fill));
  }
}
