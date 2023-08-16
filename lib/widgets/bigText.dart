// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dlivery_app_project/utils/dimentionals.dart';
import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final Color? color;
  double size;
  TextOverflow overFlow;
  final String text;

  BigText({
    Key? key,
    this.color = const Color(0xFF332d2b),
    this.size = 0,
    this.overFlow = TextOverflow.ellipsis,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overFlow,
      maxLines: 1,
      style: TextStyle(
        fontSize: size == 0 ? Dimentional.font20 : size,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        color: color,
      ),
    );
  }
}
