import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totem/providers/password_provider.dart';
import 'package:totem/services/text.dart';

class KeyboardKey extends ConsumerStatefulWidget {
  const KeyboardKey({
    super.key,
    required this.keyNum,
  });

  final int keyNum;

  @override
  ConsumerState<KeyboardKey> createState() => _KeyboardKeyState();
}

class _KeyboardKeyState extends ConsumerState<KeyboardKey> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        elevation: 0,
      ),
      onPressed: () {
        ref.read(passwordProvider.notifier).changePassword('${widget.keyNum}');
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          '${widget.keyNum}',
          style: TextStyle(
            fontSize: ResponsiveText.huge(
              context,
            ),
          ),
        ),
      ),
    );
  }
}
