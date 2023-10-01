import 'package:dlivery_app_project/pages/auth/sign_in_page.dart';
import 'package:dlivery_app_project/pages/auth/sign_up_page.dart';
import 'package:dlivery_app_project/pages/cart/cart_page.dart';
import 'package:dlivery_app_project/pages/splash/splash_page.dart';
import 'package:dlivery_app_project/stateManagment/blocs/bloc/addCart_bloc/bloc/add_cart_bloc.dart';
import 'package:dlivery_app_project/stateManagment/blocs/bloc/authBloc/bloc/auth_bloc.dart';
import 'package:dlivery_app_project/stateManagment/blocs/bloc/user_bloc/bloc/user_bloc.dart';
import 'package:dlivery_app_project/stateManagment/cubit/cubit/quantity_cubit.dart';
import 'package:dlivery_app_project/stateManagment/data/moduls/cart_model.dart';
import 'package:dlivery_app_project/stateManagment/data/repos/auth_repo.dart';
import 'package:dlivery_app_project/stateManagment/data/repos/cart_repo.dart';
import 'package:dlivery_app_project/stateManagment/data/repos/user_repo.dart';
import 'package:dlivery_app_project/utils/constants.dart';
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
    // sharedPreferences.clear();
    // print('all removed');
    // print(sharedPreferences.getString(Constants.tokenKey));
    // print(sharedPreferences.getStringList(Constants.cartListKey));
    // print(sharedPreferences.getStringList(Constants.cartListhistoryKey));
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
          BlocProvider<AuthBloc>(
            create: (context) =>
                AuthBloc(AuthRepo(sharedPreferences: sharedPreferences)),
          ),
          BlocProvider<UserBloc>(
              create: (context) => UserBloc(
                  userRepo: UserRepo(sharedPreferences: sharedPreferences)))
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
