// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dlivery_app_project/utils/dimentionals.dart';
import 'package:dlivery_app_project/widgets/smallText.dart';
import 'package:flutter/material.dart';

class IconsAndTextWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;
  const IconsAndTextWidget(
      {Key? key,
      required this.text,
      required this.icon,
      required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, color: iconColor, size: Dimentional.font24),
      SizedBox(width: Dimentional.radius5),
      SmallText(text: text)
    ]);
  }
}
