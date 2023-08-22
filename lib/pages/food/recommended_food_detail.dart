import 'package:dlivery_app_project/pages/cart/cart_page.dart';
import 'package:dlivery_app_project/stateManagment/cubit/cubit/quantity_cubit.dart';
import 'package:dlivery_app_project/stateManagment/data/moduls/products_modul.dart';
import 'package:dlivery_app_project/utils/colors.dart';
import 'package:dlivery_app_project/utils/dimentionals.dart';
import 'package:dlivery_app_project/widgets/appIcon.dart';
import 'package:dlivery_app_project/widgets/bigText.dart';
import 'package:dlivery_app_project/widgets/expandable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../stateManagment/blocs/bloc/addCart_bloc/bloc/add_cart_bloc.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final ProductsModul? productsInfo;
  final int? pageId;
  const RecommendedFoodDetail({super.key, this.pageId, this.productsInfo});
  @override
  Widget build(BuildContext context) {
    //!setting quantity to the each page individualy
    final isexist = context.watch<AddCartBloc>().state.addCart[pageId! + 1];
    if (isexist != null && isexist.isExist == true) {
      context.read<QuantityCubit>().zeroQuantity(isexist.quantity!);
    } else {
      context.read<QuantityCubit>().zeroQuantity(0);
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: AppIcon(icon: Icons.clear)),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(pageId: pageId!),
                      )),
                  child: Stack(
                    children: [
                      const AppIcon(icon: Icons.shopping_cart_outlined),
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
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: Dimentional.font16 - 1),
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                padding: EdgeInsets.only(top: 3, bottom: 3),
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          Dimentional.radius20,
                        ),
                        topRight: Radius.circular(Dimentional.radius20))),
                child: Center(
                    child: BigText(
                        text: productsInfo!.products![pageId!].name.toString(),
                        size: Dimentional.font26)),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/images/${productsInfo!.products![pageId!].img}',
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                    child: ExpandableText(
                        text: productsInfo!.products![pageId!].description
                            .toString()),
                    margin: EdgeInsets.only(
                        left: Dimentional.width20, right: Dimentional.width20))
              ],
            ),
          ),
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
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: Dimentional.width20 * 2.5,
                    right: Dimentional.width20 * 2.5,
                    top: Dimentional.height10,
                    bottom: Dimentional.height10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<QuantityCubit>().decrement();
                        },
                        child: AppIcon(
                            iconSize: Dimentional.font24,
                            icon: Icons.remove,
                            iconColor: Colors.white,
                            backgroundColor: AppColors.mainColor),
                      ),
                      BigText(
                          text:
                              '\$${productsInfo!.products![pageId!].price} X ${state.quantity}',
                          size: Dimentional.font26,
                          color: AppColors.mainBlackColor),
                      GestureDetector(
                        onTap: () {
                          context.read<QuantityCubit>().increment();
                        },
                        child: AppIcon(
                            iconSize: Dimentional.font24,
                            icon: Icons.add,
                            iconColor: Colors.white,
                            backgroundColor: AppColors.mainColor),
                      ),
                    ]),
              ),
              Container(
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
                        child:
                            Icon(Icons.favorite, color: AppColors.mainColor)),
                    Container(
                      padding: EdgeInsets.all(Dimentional.width20),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius:
                            BorderRadius.circular(Dimentional.radius20),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          context.read<AddCartBloc>().add(AddCartEvent(
                              quantity: state.quantity,
                              products: productsInfo!.products![pageId!]));
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
              ),
            ],
          );
        },
      ),
    );
  }
}
