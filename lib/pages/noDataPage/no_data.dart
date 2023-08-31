import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/dimentionals.dart';
import '../../widgets/bigText.dart';

class NoData extends StatelessWidget {
  final String text;
  final String imgPas;
  final double heightPosition;
  const NoData(
      {super.key,
      required this.text,
      required this.imgPas,
      this.heightPosition = 1.7});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimentional.height120 * heightPosition),
      child: Column(
        children: [
          Image.asset(imgPas, width: 130),
          BigText(
              text: text, size: Dimentional.font24, color: AppColors.signColor),
        ],
      ),
    );
  }
}
