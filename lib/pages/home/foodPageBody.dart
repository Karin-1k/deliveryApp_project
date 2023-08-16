import 'package:dlivery_app_project/utils/colors.dart';
import 'package:dlivery_app_project/utils/dimentionals.dart';
import 'package:dlivery_app_project/widgets/app_Column.dart';
import 'package:dlivery_app_project/widgets/bigText.dart';
import 'package:dlivery_app_project/widgets/icons_text.dart';
import 'package:dlivery_app_project/widgets/smallText.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  double _currentPageValue = 0.0;
  double _scaleFactor = 0.8;
  int _height = 220;

  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //* slide section
        Container(
          height: Dimentional.pageView,
          child: PageView.builder(
              controller: pageController,
              itemCount: 5,
              itemBuilder: (context, position) {
                return _buildPageItem(
                    position, _currentPageValue, _scaleFactor, _height);
              }),
        ),
        //* dots
        DotsIndicator(
          dotsCount: 5,
          position: _currentPageValue,
          decorator: DotsDecorator(
            activeColor: AppColors.mainColor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),

        //* popular section

        SizedBox(height: Dimentional.height30),
        Container(
          margin: EdgeInsets.only(left: Dimentional.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'popular'),
              SizedBox(width: Dimentional.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: '.', color: Colors.black26),
              ),
              SizedBox(width: Dimentional.width10),
              Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: SmallText(text: 'food pairing')),

              //! list view
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true, //* bcz of that properie u dont need container or
          //*expanded or flexible
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(
                  top: Dimentional.height10,
                  left: Dimentional.width20,
                  right: Dimentional.width20),
              child: Row(
                children: [
                  //* image section
                  Container(
                    height: Dimentional.listViewImgSize,
                    width: Dimentional.listViewImgSize,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimentional.radius15),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/food1.jpg'),
                      ),
                    ),
                  ),
                  //* text section
                  Expanded(
                    child: Container(
                      height: Dimentional.pageViewTextContainer,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimentional.radius20),
                          bottomRight: Radius.circular(Dimentional.radius20),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: Dimentional.width10,
                            right: Dimentional.width10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BigText(text: 'mase salamwn wajba'),
                              SizedBox(height: Dimentional.height10),
                              SmallText(text: 'xoshtren xwardn just try it!'),
                              SizedBox(height: Dimentional.height10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}

Widget _buildPageItem(
    int index, double currentPageVAlue, double scaleFactor, int height) {
  Matrix4 matrix = new Matrix4.identity();
  if (index == currentPageVAlue.floor()) {
    var currScall = 1 - (currentPageVAlue - index) * (1 - scaleFactor);
    var currTrans = height * (1 - currScall) / 2;
    matrix = Matrix4.diagonal3Values(1, currScall, 1)
      ..setTranslationRaw(0, currTrans, 0);
  } else if (index == currentPageVAlue.floor() + 1) {
    var currScall =
        scaleFactor + (currentPageVAlue - index + 1) * (1 - scaleFactor);
    var currTrans = height * (1 - currScall) / 2;
    matrix = Matrix4.diagonal3Values(1, currScall, 1)
      ..setTranslationRaw(0, currTrans, 0);
  } else if (index == currentPageVAlue.floor() - 1) {
    var currScall = 1 - (currentPageVAlue - index) * (1 - scaleFactor);

    var currTrans = height * (1 - currScall) / 2;
    matrix = Matrix4.diagonal3Values(1, currScall, 1)
      ..setTranslationRaw(0, currTrans, 0);
  } else {
    var currScall = 0.8;
    matrix = Matrix4.diagonal3Values(1, currScall, 1)
      ..setTranslationRaw(0, height * (1 - scaleFactor) / 2, 0);
  }

  return Transform(
    transform: matrix,
    child: Stack(
      children: [
        Container(
          height: Dimentional.pageViewContainer,
          margin: EdgeInsets.only(
              left: Dimentional.width10, right: Dimentional.width10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimentional.radius30),
            color: AppColors.mainColor,
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/food1.jpg"),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: Dimentional.pageViewTextContainer,
            margin: EdgeInsets.only(
                left: Dimentional.width30,
                right: Dimentional.width30,
                bottom: Dimentional.height30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimentional.radius20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Color(0xFFe8e8e8),
                      offset: Offset(0, 5),
                      blurRadius: 5),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  )
                ]),
            child: Container(
                padding: EdgeInsets.only(
                    left: Dimentional.width15,
                    right: Dimentional.width15,
                    top: Dimentional.height15),
                child: AppColumn(text: 'burger')),
          ),
        )
      ],
    ),
  );
}
