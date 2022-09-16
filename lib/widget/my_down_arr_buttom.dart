import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// кнопка возврата (на homePage)
myButtomDown(
    BuildContext context, String route, Color color, Color backgroundColor) {
  String downArrow = 'assets/icons/down_arrow.svg';
  return CircleAvatar(
    backgroundColor: backgroundColor,
    radius: 19,
    child: IconButton(
      onPressed: () {
        Navigator.pop(
          context,
          route,
        );
      },
      icon: SvgPicture.asset(
        downArrow,
        color: color,
      ),
    ),
  );
}
