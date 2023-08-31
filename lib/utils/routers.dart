import 'package:dlivery_app_project/pages/food/popular_food_detail.dart';
import 'package:dlivery_app_project/pages/home/homePage.dart';
import 'package:dlivery_app_project/pages/home/main_food_page.dart';
import 'package:dlivery_app_project/pages/splash/splash_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routers {
  static Route? onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => SplashPage());
      case '/homepage':
        return MaterialPageRoute(builder: (context) => HomePage());
      case '/mainhomepage':
        return MaterialPageRoute(builder: (context) => MainFoodPage());
      case '/popular':
        return MaterialPageRoute(builder: (context) => PopularFoodDetail());
    }
    return null;
  }
}
