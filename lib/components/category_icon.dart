import 'package:flutter/material.dart';

class CategoryIcon extends StatelessWidget {
  final String label;
  final Widget icon;
  const CategoryIcon({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        icon,
        Text(label, style: const TextStyle(color: Color(0xFF907677), fontSize: 20),)
      ],),
    );
  }
}
