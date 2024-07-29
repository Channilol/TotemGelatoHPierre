import 'package:flutter/material.dart';

class BackPopup extends StatelessWidget {
  const BackPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(40),
              topLeft: Radius.circular(40),
              topRight: Radius.circular(20))),
      title: const Text('Vuoi rimanere qui?'),
      content: const Text('Hai ancora tempo per ordinare'),
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
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Si ti prego'),
        ),
      ],
    );
  }
}
