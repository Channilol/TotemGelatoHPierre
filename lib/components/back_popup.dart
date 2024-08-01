import 'package:flutter/material.dart';
import 'package:totem/services/text.dart';

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
      title: Text('Vuoi rimanere qui?',
          style: TextStyle(fontSize: ResponsiveText.large(context))),
      content: Text('Hai ancora tempo per ordinare',
          style: TextStyle(fontSize: ResponsiveText.large(context))),
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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
            child: Text('Si ti prego',
                style: TextStyle(fontSize: ResponsiveText.medium(context))),
          ),
        ),
      ],
    );
  }
}
