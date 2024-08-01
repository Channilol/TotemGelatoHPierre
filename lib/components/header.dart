import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:totem/services/my_colors.dart';

class Header extends StatelessWidget {
  final Widget leading;
  final Widget trailing;
  const Header(
      {super.key,
      this.leading = const SizedBox(),
      this.trailing = const SizedBox()});

  @override
  Widget build(BuildContext context) {
    final maxWidth = (MediaQuery.of(context).size.width - 120) / 2;
    return Container(
        decoration: BoxDecoration(
          color: MyColors.colorContainer,
        ),
        padding: const EdgeInsets.only(bottom: 5),
        //width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.07,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: SizedBox(width: maxWidth, child: leading)),
                Expanded(child: SizedBox()),
                Expanded(child: SizedBox(width: maxWidth, child: trailing)),
              ],
            ),
          ],
        ));
  }
}
