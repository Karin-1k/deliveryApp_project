import 'package:dlivery_app_project/pages/food/popular_food_detail.dart';
import 'package:dlivery_app_project/pages/food/recommended_food_detail.dart';
import 'package:dlivery_app_project/pages/home/homePage.dart';
import 'package:dlivery_app_project/pages/home/main_food_page.dart';
import 'package:dlivery_app_project/stateManagment/blocs/bloc/addCart_bloc/bloc/add_cart_bloc.dart';
import 'package:dlivery_app_project/utils/colors.dart';
import 'package:dlivery_app_project/utils/dimentionals.dart';
import 'package:dlivery_app_project/utils/enums.dart';
import 'package:dlivery_app_project/widgets/appIcon.dart';
import 'package:dlivery_app_project/widgets/bigText.dart';
import 'package:dlivery_app_project/widgets/smallText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../stateManagment/blocs/bloc/products_bloc.dart';
import '../../stateManagment/cubit/cubit/quantity_cubit.dart';
import '../../utils/enums.dart';
import '../noDataPage/no_data.dart';

class CartPage extends StatelessWidget {
  final int pageId;

  const CartPage({super.key, required this.pageId});

  @override
  Widget build(BuildContext context) {
    final _productsDataModel = context.watch<ProductsBloc>().state;
    final _addCartBloc = context.read<AddCartBloc>().state;
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: Dimentional.height20 * 3,
                left: Dimentional.width20,
                right: Dimentional.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: AppIcon(
                        icon: Icons.arrow_back_ios,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimentional.font24,
                      ),
                    ),
                    SizedBox(width: Dimentional.width20 * 5),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          )),
                      child: AppIcon(
                        icon: Icons.home_outlined,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimentional.font24,
                      ),
                    ),
                    Stack(
                      children: [
                        AppIcon(
                          icon: Icons.shopping_cart_outlined,
                          iconColor: Colors.white,
                          backgroundColor: AppColors.mainColor,
                          iconSize: Dimentional.font24,
                        ),
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
                                  style: TextStyle(color: Colors.black),
                                  textAlign: TextAlign.center),
                            ))
                      ],
                    ),
                  ],
                )),
            BlocBuilder<AddCartBloc, AddCartState>(
              builder: (context, state) {
                if (state is AddCartInitial) {
                  return Positioned(
                      left: Dimentional.width20,
                      right: Dimentional.width20,
                      top: Dimentional.height20 * 5,
                      bottom: 0,
                      child: state.getCarts.isNotEmpty
                          ? Container(
                              margin:
                                  EdgeInsets.only(top: Dimentional.height30),
                              child: MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                child: ListView.builder(
                                    itemCount: state.getCarts.length,
                                    itemBuilder: (_, index) {
                                      //!setting quantity to the each page individualy
                                      return Container(
                                        height: Dimentional.height20 * 5,
                                        width: double.maxFinite,
                                        child: Row(
                                          children: [
                                            //* img container
                                            GestureDetector(
                                              onTap: () {
                                                if (state.getCarts[index]
                                                        .wichPage ==
                                                    ToWichPage
                                                        .popularFoodPage) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => _productsDataModel
                                                                  is ProductsDatasState
                                                              ? PopularFoodDetail(
                                                                  productsInfo:
                                                                      _productsDataModel
                                                                              .products[
                                                                          0],
                                                                  pageId: state
                                                                          .getCarts[
                                                                              index]
                                                                          .id! -
                                                                      1)
                                                              : Container()));
                                                } else if (state.getCarts[index]
                                                        .wichPage ==
                                                    ToWichPage
                                                        .recommendedFoodPage) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => _productsDataModel
                                                                  is ProductsDatasState
                                                              ? RecommendedFoodDetail(
                                                                  productsInfo:
                                                                      _productsDataModel
                                                                              .products[
                                                                          0],
                                                                  pageId: state
                                                                          .getCarts[
                                                                              index]
                                                                          .id! -
                                                                      1)
                                                              : Container()));
                                                } else if (state.getCarts[index]
                                                        .wichPage ==
                                                    ToWichPage.productHistory) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      backgroundColor:
                                                          AppColors.mainColor,
                                                      content: const Text(
                                                        'Product review is not availible for history products',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 22),
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    bottom:
                                                        Dimentional.height10),
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      filterQuality:
                                                          FilterQuality.high,
                                                      fit: BoxFit.cover,
                                                      image: AssetImage(
                                                          'assets/images/${state.getCarts[index].img}')),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimentional.radius20),
                                                  color: Colors.white,
                                                ),
                                                height: Dimentional.width20 * 5,
                                                width: Dimentional.height20 * 5,
                                              ),
                                            ),
                                            //* text container
                                            SizedBox(
                                                width: Dimentional.width10),
                                            Expanded(
                                              child: Container(
                                                height:
                                                    Dimentional.height20 * 5,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    BigText(
                                                        text: state
                                                            .getCarts[index]
                                                            .name
                                                            .toString(),
                                                        color: Colors.black54),
                                                    SmallText(text: 'spice'),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        BigText(
                                                            text:
                                                                '${state.getCarts[index].price}\$',
                                                            color: Colors
                                                                .redAccent),
                                                        Container(
                                                          padding: EdgeInsets.only(
                                                              left: Dimentional
                                                                  .width10,
                                                              right: Dimentional
                                                                  .width10,
                                                              bottom: Dimentional
                                                                      .height10 /
                                                                  2),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimentional
                                                                        .radius20),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              GestureDetector(
                                                                  onTap: () {
                                                                    context.read<AddCartBloc>().add(ModifieAddCartMap(
                                                                        id: state
                                                                            .getCarts[
                                                                                index]
                                                                            .id!,
                                                                        isIncreament:
                                                                            false));
                                                                  },
                                                                  child: Icon(
                                                                      Icons
                                                                          .remove,
                                                                      color: AppColors
                                                                          .signColor)),
                                                              SizedBox(
                                                                  width: Dimentional
                                                                          .width10 /
                                                                      2),
                                                              BigText(
                                                                  text: state
                                                                      .getCarts[
                                                                          index]
                                                                      .quantity
                                                                      .toString()),
                                                              SizedBox(
                                                                  width: Dimentional
                                                                          .width10 /
                                                                      2),
                                                              GestureDetector(
                                                                  onTap: () {
                                                                    context.read<AddCartBloc>().add(ModifieAddCartMap(
                                                                        id: state
                                                                            .getCarts[
                                                                                index]
                                                                            .id!,
                                                                        isIncreament:
                                                                            true));
                                                                  },
                                                                  child: Icon(
                                                                      Icons.add,
                                                                      color: AppColors
                                                                          .signColor)),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            )
                          : NoData(
                              text: 'Empty carts list!',
                              imgPas: 'assets/images/emptyCart.png',
                            ));
                }
                return Container();
              },
            )
          ],
        ),
        bottomNavigationBar: context
                .watch<AddCartBloc>()
                .state
                .getCarts
                .isNotEmpty
            ? Container(
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
                        borderRadius:
                            BorderRadius.circular(Dimentional.radius20),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: Dimentional.width10 / 2),
                          BigText(text: '\$ ${_addCartBloc.getTotallPrice}'),
                          SizedBox(width: Dimentional.width10 / 2),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(Dimentional.width20),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius:
                            BorderRadius.circular(Dimentional.radius20),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          try {
                            context
                                .read<AddCartBloc>()
                                .add(AddHistoryStorage());
                          } catch (e) {
                            print('this is a fucking err $e');
                          }
                        },
                        child: Row(
                          children: [
                            BigText(text: 'Check Out', color: Colors.white),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Text(''));
  }
}
