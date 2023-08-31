import 'dart:convert';

import 'package:dlivery_app_project/pages/cart/cart_page.dart';
import 'package:dlivery_app_project/stateManagment/blocs/bloc/addCart_bloc/bloc/add_cart_bloc.dart';
import 'package:dlivery_app_project/utils/colors.dart';
import 'package:dlivery_app_project/utils/dimentionals.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../widgets/appIcon.dart';
import '../../widgets/bigText.dart';
import '../../widgets/smallText.dart';
import '../noDataPage/no_data.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    var gitcartListHistory =
        context.watch<AddCartBloc>().state.histroyDatas.reversed.toList();

    Map<String, int> cartItemsPerOrder = Map();
    for (int i = 0; i < gitcartListHistory.length; i++) {
      if (cartItemsPerOrder.containsKey(gitcartListHistory[i].time)) {
        cartItemsPerOrder.update(
            gitcartListHistory[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(gitcartListHistory[i].time!, () => 1);
      }
    }

    List<int> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> timeFromCartOrderPerTime() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> orderTimes = cartOrderTimeToList();
    int listCounter = 0;
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppColors.mainColor,
            width: double.maxFinite,
            height: 100,
            padding: const EdgeInsets.only(top: 45),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BigText(text: 'Cart history', color: Colors.white),
                  AppIcon(
                      icon: Icons.shopping_cart_checkout_outlined,
                      iconColor: AppColors.mainColor)
                ]),
          ),
          gitcartListHistory.isNotEmpty
              ? Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: Dimentional.height20,
                        right: Dimentional.width20,
                        left: Dimentional.width20),
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView(
                        children: [
                          for (int i = 0; i < cartItemsPerOrder.length; i++)
                            Container(
                              margin:
                                  EdgeInsets.only(bottom: Dimentional.height20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //!imidiatly invocked method for writing dart code bwtween the widgets
                                  (() {
                                    DateTime parseData =
                                        DateFormat("yyyy-MM-dd HH:mm:ss").parse(
                                            timeFromCartOrderPerTime()[i]);

                                    var inputData =
                                        DateTime.parse(parseData.toString());
                                    var outputFormat =
                                        DateFormat("MM-dd-yyyy hh:mm a");
                                    var outputData =
                                        outputFormat.format(inputData);
                                    return BigText(text: outputData);
                                  }()),

                                  SizedBox(height: Dimentional.height10 / 2),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              right: Dimentional.width20 + 5),
                                          // color: Colors.amber,
                                          height: Dimentional.height20 * 4,
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: [
                                              Container(
                                                child: Wrap(
                                                  direction: Axis.horizontal,
                                                  children: List.generate(
                                                    orderTimes[i],
                                                    (index) {
                                                      if (listCounter <
                                                          gitcartListHistory
                                                              .length) {
                                                        listCounter++;
                                                      }
                                                      return Container(
                                                        height: Dimentional
                                                                .height20 *
                                                            4,
                                                        width: Dimentional
                                                                .height20 *
                                                            4,
                                                        margin: EdgeInsets.only(
                                                            right: Dimentional
                                                                    .width10 /
                                                                2),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimentional
                                                                            .radius15 /
                                                                        2),
                                                            image: DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: AssetImage(
                                                                    'assets/images/${gitcartListHistory[listCounter - 1].img}'))),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            SmallText(
                                                text: 'Total',
                                                color: AppColors.titleColor),
                                            SizedBox(
                                                height:
                                                    Dimentional.height10 / 2.5),
                                            BigText(
                                                text: orderTimes[i].toString() +
                                                    ' Items',
                                                color: AppColors.titleColor),
                                            GestureDetector(
                                              onTap: () {
                                                context.read<AddCartBloc>().add(
                                                    AddHistroyForCartPage(
                                                        time:
                                                            timeFromCartOrderPerTime()[
                                                                i]));
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CartPage(
                                                                pageId: 0)));
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        Dimentional.width10,
                                                    vertical:
                                                        Dimentional.height10 /
                                                            2),
                                                child: SmallText(
                                                    text: 'one more',
                                                    color: AppColors.mainColor),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimentional.radius5),
                                                  border: Border.all(
                                                      width: 1,
                                                      color:
                                                          AppColors.mainColor),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                )
              : NoData(
                  text: 'Empty Cart List History!',
                  imgPas: 'assets/images/emptyCart.png',
                )
        ],
      ),
    );
  }
}
