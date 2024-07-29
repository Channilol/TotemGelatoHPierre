import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
      decoration: const BoxDecoration(
        color: Color(0xFFF1EAE2),
      ),
        padding: const EdgeInsets.only(bottom: 5),
        //width: double.infinity,
        height: 100,
        child: Column(
          children: [
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: maxWidth,
                    child: leading),
                SvgPicture.asset("assets/images/logo.svg",
                    width: 60, height: 60),
                SizedBox(
                    width: maxWidth,
                    child: trailing),
              ],
            ),
          ],
        ));
  }
}
