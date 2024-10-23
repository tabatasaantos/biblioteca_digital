import 'package:biblioteca_digital/until/theme_until.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DisplayTextWidget extends StatelessWidget {
  const DisplayTextWidget(this.text, {super.key});
  final String text;
  final String asset = "assets/images/star_icon.svg";

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: SvgPicture.asset(asset),
        ),
        Text(
          text,
          style: DisplayTextProperties.textStyle,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: SvgPicture.asset(asset),
        )
      ],
    );
  }
}
