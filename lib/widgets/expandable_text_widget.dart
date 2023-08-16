// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dlivery_app_project/utils/colors.dart';
import 'package:dlivery_app_project/utils/dimentionals.dart';
import 'package:dlivery_app_project/widgets/smallText.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firsthalf;
  late String secondhalf;
  bool hidenText = true;
  final double textHeight = Dimentional.screenHight / 7.81;

  void initState() {
    if (widget.text.length > textHeight.toInt()) {
      firsthalf = widget.text.substring(0, textHeight.toInt());
      secondhalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firsthalf = widget.text;
      //* the late keyword should be initialized if not
      //* it will be coused null
      secondhalf = '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return secondhalf.isEmpty
        ? SmallText(
            height: 1.8,
            text: firsthalf,
            size: Dimentional.font16,
            color: AppColors.paraColor,
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                SmallText(
                  height: 1.8,
                  color: AppColors.paraColor,
                  size: Dimentional.font16,
                  text:
                      hidenText ? ('$firsthalf...') : (firsthalf + secondhalf),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hidenText = !hidenText;
                    });
                  },
                  child: Row(
                    children: [
                      SmallText(
                          size: Dimentional.font16,
                          text: hidenText ? 'show more' : 'show less',
                          color: AppColors.mainColor),
                      Icon(
                          hidenText
                              ? Icons.arrow_drop_down
                              : Icons.arrow_drop_up,
                          color: AppColors.mainColor),
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
