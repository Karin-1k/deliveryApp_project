import 'dart:async';

import 'package:dlivery_app_project/pages/food/recommended_food_detail.dart';
import 'package:dlivery_app_project/stateManagment/blocs/bloc/products_bloc.dart';
import 'package:dlivery_app_project/stateManagment/data/moduls/products_modul.dart';
import 'package:dlivery_app_project/utils/colors.dart';
import 'package:dlivery_app_project/utils/dimentionals.dart';
import 'package:dlivery_app_project/widgets/app_Column.dart';
import 'package:dlivery_app_project/widgets/bigText.dart';
import 'package:dlivery_app_project/widgets/icons_text.dart';
import 'package:dlivery_app_project/widgets/smallText.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../food/popular_food_detail.dart';

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
    //*getting the datas from the server
    context.watch<ProductsBloc>().add(GetProductsEvent());
    return Builder(builder: (context) {
      final _products = context.watch<ProductsBloc>().state;
      if (_products is ProductsInitialState) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: Dimentional.height10 * 30),
              child: CircularProgressIndicator(color: AppColors.mainColor),
            )
          ],
        );
      }
      if (_products is ProductsDatasState) {
        final _values = _products.products[0];

        return Column(
          children: [
            //* slide section

            Container(
              height: Dimentional.pageView,
              child: GestureDetector(
                child: PageView.builder(
                    controller: pageController,
                    itemCount: _values.totalSize,
                    itemBuilder: (context, position) {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PopularFoodDetail(
                                    pageId: position, productsInfo: _values))),
                        child: _buildPageItem(position, _currentPageValue,
                            _scaleFactor, _height, _values),
                      );
                    }),
              ),
            ),

            //* dots
            DotsIndicator(
              dotsCount: _products.products[0].totalSize!,
              position: _currentPageValue,
              decorator: DotsDecorator(
                activeColor: AppColors.mainColor,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),

            //* recommended section

            SizedBox(height: Dimentional.height30),
            Container(
              margin: EdgeInsets.only(left: Dimentional.width30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BigText(text: 'Recommended'),
                  SizedBox(width: Dimentional.width10),
                  Container(
                    margin: const EdgeInsets.only(bottom: 3),
                    child: BigText(text: '.', color: Colors.black26),
                  ),
                  SizedBox(width: Dimentional.width10),
                  Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: SmallText(text: 'food pairing')),
                ],
              ),
            ), //! list view
            ListView.builder(
              shrinkWrap:
                  true, //* bcz of that properie u dont need container or
              //*expanded or flexible
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _values.products!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecommendedFoodDetail(
                                pageId: index, productsInfo: _values)));
                  },
                  child: Container(
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
                            borderRadius:
                                BorderRadius.circular(Dimentional.radius15),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  'assets/images/${_values.products![index].img}'),
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
                                bottomRight:
                                    Radius.circular(Dimentional.radius20),
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
                                    BigText(
                                        text: _values.products![index].name!),
                                    SizedBox(height: Dimentional.height10),
                                    SmallText(
                                        text: 'xoshtren xwardn just try it!'),
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
                  ),
                );
              },
            )
          ],
        );
      }
      if (_products is ErrorState) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: Dimentional.height10 * 25, left: Dimentional.width15),
              child: Text(_products.err,
                  style: TextStyle(color: AppColors.mainColor, fontSize: 30)),
            ),
            Icon(
              Icons.report_off,
              size: 60,
              color: AppColors.mainColor,
            )
          ],
        );
      }
      return Container();
    });
  }
}

Widget _buildPageItem(
  int index,
  double currentPageVAlue,
  double scaleFactor,
  int height,
  ProductsModul product,
) {
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
            image: DecorationImage(
              fit: BoxFit.cover,
              image:
                  AssetImage('assets/images/${product.products![index].img}'),
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
                    top: Dimentional.height10),
                child: AppColumn(text: product.products![index].name!)),
          ),
        )
      ],
    ),
  );
}
