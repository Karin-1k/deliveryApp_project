import 'package:dlivery_app_project/pages/home/foodPageBody.dart';
import 'package:dlivery_app_project/utils/colors.dart';
import 'package:dlivery_app_project/utils/dimentionals.dart';
import 'package:dlivery_app_project/widgets/bigText.dart';
import 'package:dlivery_app_project/widgets/smallText.dart';
import 'package:flutter/material.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              child: Container(
            margin: EdgeInsets.only(
                top: Dimentional.height45, bottom: Dimentional.width15),
            padding: EdgeInsets.only(
                left: Dimentional.width20, right: Dimentional.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(
                      text: 'Kurdistan',
                      color: AppColors.mainColor,
                    ),
                    Row(
                      children: [
                        SmallText(
                          text: 'slemany',
                          color: Colors.black54,
                        ),
                        const Icon(Icons.arrow_drop_down_rounded)
                      ],
                    )
                  ],
                ),
                Center(
                  child: Container(
                    width: Dimentional.width45,
                    height: Dimentional.height45,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimentional.radius15),
                    ),
                    child: Icon(
                      Icons.search,
                      size: Dimentional.font24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )),
          const Expanded(child: SingleChildScrollView(child: FoodPageBody())),
        ],
      ),
    );
  }
}
