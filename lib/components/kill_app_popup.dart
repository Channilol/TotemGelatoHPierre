import 'package:flutter/material.dart';

class KillAppPopup extends StatelessWidget {
  const KillAppPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        obscureText: true,
      ),
    );
  }
}
