import 'package:flutter/material.dart';
import 'package:totem/components/inactivity_timer.dart';
import 'package:totem/services/my_colors.dart';

class ClearOrderPopup extends StatelessWidget {
  const ClearOrderPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return InactivityTimer(
      child: AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(20))),
          title: const Text("Sicuro di voler cancellare l'ordine?"),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10)),
                onPressed: () => Navigator.pop(context),
                child: const Text("ANNULLA")),
            FilledButton(
                style: FilledButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(5))),
                    backgroundColor: MyColors.colorText,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10)),
                onPressed: () => Navigator.pop(context, true),
                child: Text("SI",
                    style: TextStyle(color: MyColors.colorBackground))),
          ]),
    );
  }
}
