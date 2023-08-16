// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:dlivery_app_project/widgets/smallText.dart';

import '../utils/colors.dart';
import '../utils/dimentionals.dart';
import 'bigText.dart';
import 'icons_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text, size: Dimentional.font26),
        SizedBox(height: Dimentional.height10),
        Row(
          children: [
            Wrap(
                children: List.generate(5, (index) {
              return Icon(
                Icons.star,
                color: AppColors.mainColor,
                size: 15,
              );
            })),
            const SizedBox(width: 10),
            SmallText(text: '4.5'),
            const SizedBox(width: 10),
            SmallText(text: '123'),
            const SizedBox(width: 10),
            SmallText(text: 'comment')
          ],
        ),
        SizedBox(height: Dimentional.height20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconsAndTextWidget(
                text: 'normal',
                icon: Icons.circle_sharp,
                iconColor: AppColors.iconColor1),
            IconsAndTextWidget(
                text: '1.7km',
                icon: Icons.location_on,
                iconColor: AppColors.mainColor),
            IconsAndTextWidget(
                text: '32min',
                icon: Icons.access_time_rounded,
                iconColor: AppColors.iconColor2),
          ],
        ),
      ],
    );
  }
}
