import 'dart:convert';
import 'dart:typed_data';

import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:dlivery_app_project/pages/cart/cart_page.dart';
import 'package:dlivery_app_project/stateManagment/blocs/bloc/addCart_bloc/bloc/add_cart_bloc.dart';
import 'package:dlivery_app_project/stateManagment/blocs/bloc/products_bloc.dart';
import 'package:dlivery_app_project/stateManagment/cubit/cubit/quantity_cubit.dart';
import 'package:dlivery_app_project/stateManagment/data/moduls/products_modul.dart';
import 'package:dlivery_app_project/utils/dimentionals.dart';
import 'package:dlivery_app_project/utils/enums.dart';
import 'package:dlivery_app_project/widgets/appIcon.dart';
import 'package:dlivery_app_project/widgets/app_Column.dart';
import 'package:dlivery_app_project/widgets/expandable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../widgets/bigText.dart';

class PopularFoodDetail extends StatelessWidget {
  final int? pageId;
  final ProductsModul? productsInfo;
  const PopularFoodDetail({super.key, this.pageId, this.productsInfo});

  @override
  Widget build(BuildContext context) {
    print('popular food page');
    // String jsonString = productsInfo!.products![pageId!].img!;
    // List<dynamic> dynamicList = jsonDecode(jsonString);
    // List<int> intListImg = dynamicList.cast<int>();


    //!setting quantity to the each page individualy
    final isexist = context.watch<AddCartBloc>().state.addCart[pageId! + 1];
    if (isexist != null && isexist.isExist == true) {
      context.read<QuantityCubit>().zeroQuantity(isexist.quantity!);
    } else {
      context.read<QuantityCubit>().zeroQuantity(0);
    }
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
                // image: DecorationImage(
                //     fit: BoxFit.cover,
                //     image: MemoryImage(Uint8List.fromList(productsInfo!.products![pageId!].img!))

                //     // AssetImage(
                //     //     'assets/images/${productsInfo!.products![pageId!].img}'),
                //     ),
              ),
              child: CachedMemoryImage(
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
                uniqueKey: productsInfo!.products![pageId!].id!.toString(),
                bytes: Uint8List.fromList(productsInfo!.products![pageId!].img!),
              ),
            ),
          ),
          //* body infos
          Positioned(
              top: Dimentional.height45,
              left: Dimentional.width20,
              right: Dimentional.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: AppIcon(
                      icon: Icons.arrow_back_ios,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CartPage(
                                    pageId: pageId!,
                                  )));
                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),
                        Positioned(
                            right: 0,
                            child: Container(
                              width: Dimentional.width20,
                              height: Dimentional.height20,
                              decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius:
                                    BorderRadius.circular(Dimentional.width10),
                              ),
                              child: Text(
                                  context
                                      .watch<AddCartBloc>()
                                      .state
                                      .totlalQuantity
                                      .toString(),
                                  textAlign: TextAlign.center),
                            ))
                      ],
                    ),
                  )
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
                    AppColumn(
                        text: productsInfo!.products![pageId!].name.toString()),
                    SizedBox(height: Dimentional.height10),
                    BigText(text: 'introduce'),
                    SizedBox(height: Dimentional.height10),
                    Expanded(
                        child: ExpandableText(
                            text: productsInfo!.products![pageId!].description
                                .toString()))
                  ],
                )),
          ),
          //* expandable widget
        ],
      ),
      bottomNavigationBar: BlocConsumer<QuantityCubit, QuantityState>(
        listener: (context, state) {
          if (state.isInScope == true) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: AppColors.mainColor,
                content: const Text(
                    'can\'t set more or less than 20 and 0 number(s)',
                    style: TextStyle(color: Colors.white, fontSize: 22))));
          }
        },
        builder: (context, state) {
          return Container(
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
                      GestureDetector(
                          onTap: () {
                            context.read<QuantityCubit>().decrement();
                          },
                          child:
                              Icon(Icons.remove, color: AppColors.signColor)),
                      SizedBox(width: Dimentional.width10 / 2),
                      BigText(text: state.quantity.toString()),
                      SizedBox(width: Dimentional.width10 / 2),
                      GestureDetector(
                          onTap: () {
                            context.read<QuantityCubit>().increment();
                          },
                          child: Icon(Icons.add, color: AppColors.signColor)),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(Dimentional.width20),
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimentional.radius20),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      try {
                        context.read<AddCartBloc>().add(AddCartEvent(
                            quantity: state.quantity,
                            products: productsInfo!.products![pageId!],
                            wichPage: ToWichPage.popularFoodPage));
                      } catch (e) {
                        print('this is a fucking err $e');
                      }
                    },
                    child: Row(
                      children: [
                        BigText(
                            text:
                                '\$${productsInfo!.products![pageId!].price}|Add to cart',
                            color: Colors.white),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
