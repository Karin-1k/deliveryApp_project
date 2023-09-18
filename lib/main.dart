import 'package:dlivery_app_project/pages/cart/cart_page.dart';
import 'package:dlivery_app_project/pages/splash/splash_page.dart';
import 'package:dlivery_app_project/stateManagment/blocs/bloc/addCart_bloc/bloc/add_cart_bloc.dart';
import 'package:dlivery_app_project/stateManagment/cubit/cubit/quantity_cubit.dart';
import 'package:dlivery_app_project/stateManagment/data/moduls/cart_model.dart';
import 'package:dlivery_app_project/stateManagment/data/repos/cart_repo.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SharedPreferences sharedPreferences;

  void InitialSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    InitialSharedPreferences(); //*here is in providers ,it's initializing the sharedprefereces as well
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => ProductsRepo()),
        RepositoryProvider(create: (context) => CartRepo(sharedPreferences))
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<QuantityCubit>(create: ((context) => QuantityCubit())),
          BlocProvider<ProductsBloc>(create: (context) => ProductsBloc()),
          BlocProvider<AddCartBloc>(
              create: (context) => AddCartBloc(CartRepo(sharedPreferences))),
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
