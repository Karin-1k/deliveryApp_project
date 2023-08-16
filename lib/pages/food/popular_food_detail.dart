import 'package:dlivery_app_project/utils/dimentionals.dart';
import 'package:dlivery_app_project/widgets/appIcon.dart';
import 'package:dlivery_app_project/widgets/app_Column.dart';
import 'package:dlivery_app_project/widgets/expandable_text_widget.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../widgets/bigText.dart';
import '../../widgets/icons_text.dart';
import '../../widgets/smallText.dart';

class PopularFoodDetail extends StatelessWidget {
  const PopularFoodDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //*background img
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              height: Dimentional.popularcontimgsize,
              width: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/food1.jpg'),
                ),
              ),
            ),
          ),
          //* body infos
          Positioned(
              top: Dimentional.height45,
              left: Dimentional.width20,
              right: Dimentional.width20,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    icon: Icons.arrow_back_ios,
                  ),
                  AppIcon(icon: Icons.shopping_cart_outlined)
                ],
              )),
          //* introduce
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimentional.popularcontimgsize - Dimentional.height45,
            child: Container(
                padding: EdgeInsets.only(
                    left: Dimentional.width20,
                    right: Dimentional.width20,
                    top: Dimentional.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimentional.radius20),
                      topRight: Radius.circular(Dimentional.radius20)),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: 'burger pasha'),
                    SizedBox(height: Dimentional.height10),
                    BigText(text: 'introduce'),
                    SizedBox(height: Dimentional.height10),
                    Expanded(
                      child: ExpandableText(
                          text:
                              'asdfuhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhddkjldaaafjdaasdfjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjiiiiiiiiiiweiofahi;ehaiowfho;helskfherioughrihierugheuhohguashguonqouerbvoqweuboqdfadhfaoossssssssssssadofhssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssswey88888888888anvdjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjasdfgyiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiib'),
                    )
                  ],
                )),
          ),
          //* expandable widget
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
            left: Dimentional.width20,
            right: Dimentional.width20,
            top: Dimentional.height30,
            bottom: Dimentional.height20),
        height: Dimentional.height120,
        decoration: BoxDecoration(
          color: AppColors.buttonBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimentional.radius20 * 2),
            topRight: Radius.circular(Dimentional.radius20 * 2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(Dimentional.width20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimentional.radius20),
              ),
              child: Row(
                children: [
                  Icon(Icons.remove, color: AppColors.signColor),
                  SizedBox(width: Dimentional.width10 / 2),
                  BigText(text: '0'),
                  SizedBox(width: Dimentional.width10 / 2),
                  Icon(Icons.add, color: AppColors.signColor),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(Dimentional.width20),
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(Dimentional.radius20),
              ),
              child: Row(
                children: [
                  BigText(text: '\$10|Add to cart', color: Colors.white),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
