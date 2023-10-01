import 'package:dlivery_app_project/utils/dimentionals.dart';
import 'package:dlivery_app_project/widgets/appIcon.dart';
import 'package:dlivery_app_project/widgets/bigText.dart';
import 'package:flutter/material.dart';

class AccountWiget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  AccountWiget({super.key, required this.appIcon, required this.bigText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: Dimentional.width20,
          top: Dimentional.height10,
          bottom: Dimentional.height10),
      child: Row(
        children: [appIcon, SizedBox(width: Dimentional.width20), bigText],
      ),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            blurRadius: 1,
            offset: const Offset(0, 2),
            color: Colors.grey.withOpacity(0.2)),
      ]),
    );
  }
}
