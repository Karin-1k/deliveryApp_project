import 'package:dlivery_app_project/pages/cart/cart_page.dart';
import 'package:dlivery_app_project/stateManagment/blocs/bloc/addCart_bloc/bloc/add_cart_bloc.dart';
import 'package:dlivery_app_project/stateManagment/cubit/cubit/quantity_cubit.dart';
import 'package:dlivery_app_project/utils/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:dlivery_app_project/pages/food/popular_food_detail.dart';
import 'package:dlivery_app_project/pages/food/recommended_food_detail.dart';
import 'package:dlivery_app_project/pages/home/foodPageBody.dart';
import 'package:dlivery_app_project/pages/home/main_food_page.dart';
import 'package:dlivery_app_project/stateManagment/blocs/bloc/products_bloc.dart';
import 'package:dlivery_app_project/stateManagment/data/repos/products_repo.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (context) => ProductsRepo())],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<QuantityCubit>(create: ((context) => QuantityCubit())),
          BlocProvider<ProductsBloc>(create: (context) => ProductsBloc()),
          BlocProvider<AddCartBloc>(create: (context) => AddCartBloc()),
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          onGenerateRoute: Routers.onGeneratedRoute,
        ),
      ),
    );
  }
}
