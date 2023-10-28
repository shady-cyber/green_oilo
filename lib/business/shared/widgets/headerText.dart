import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  HeaderText(
      {super.key, required this.headerText, required this.headerTextStyle});
  String headerText;
  TextStyle headerTextStyle;
  @override
  Widget build(BuildContext context) {
    return Text(
      headerText,
      style: headerTextStyle,
      textAlign: TextAlign.center,
    );
  }
}
