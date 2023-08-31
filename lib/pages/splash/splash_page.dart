import 'dart:async';

import 'package:dlivery_app_project/stateManagment/data/repos/cart_repo.dart';
import 'package:dlivery_app_project/utils/dimentionals.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(Duration(seconds: 3), () {
      Navigator.pushNamed(context, '/homepage');
    });
   
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
              scale: animation,
              child: Center(
                  child: Image.asset('assets/images/pngegg.png',
                      width: Dimentional.soplashImage))),
          Center(
            child: Image.asset('assets/images/text1.png',
                width: Dimentional.soplashImage),
          ),
        ],
      ),
    );
  }
}
