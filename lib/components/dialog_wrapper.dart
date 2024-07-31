import 'package:flutter/material.dart';

class DialogWrapper extends StatelessWidget {
  final Widget child;
  const DialogWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        alignment: Alignment.center,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(50),
          topLeft: Radius.circular(50),
          topRight: Radius.circular(20),
        )),
        insetPadding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * .2,
            horizontal: MediaQuery.of(context).size.width * .2),
        child: child);
  }
}
