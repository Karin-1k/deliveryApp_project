import 'package:dlivery_app_project/pages/account/account_page.dart';
import 'package:dlivery_app_project/pages/auth/sign_up_page.dart';
import 'package:dlivery_app_project/pages/cart/history_page.dart';
import 'package:dlivery_app_project/pages/home/main_food_page.dart';
import 'package:dlivery_app_project/utils/colors.dart';
import 'package:dlivery_app_project/utils/dimentionals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../stateManagment/blocs/bloc/products_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late PersistentTabController _controller;
  List<Widget> _buildScreens() {
    return [
      MainFoodPage(),
      Container(child: Center(child: Text('page two'))),
      HistoryPage(),
      AccountPage()
    ];
  }

  // List<PersistentBottomNavBarItem> _navBarsItems() {
  //   return [
  //     PersistentBottomNavBarItem(
  //       icon: Icon(Icons.home, size: Dimentional.height30),
  //       // title: ("Home"),
  //       activeColorPrimary: Colors.black,
  //       inactiveColorPrimary: const Color(0xFF332d2b),
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(CupertinoIcons.archivebox_fill, size: Dimentional.height30),
  //       // title: ("archive"),
  //       activeColorPrimary: Colors.black,
  //       inactiveColorPrimary: const Color(0xFF332d2b),
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(
  //         Icons.shopping_cart_outlined,
  //         size: Dimentional.height30,
  //       ),
  //       // title: ("shop"),
  //       activeColorPrimary: Colors.black,
  //       inactiveColorPrimary: const Color(0xFF332d2b),
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(CupertinoIcons.person, size: Dimentional.height30),
  //       // title: ("person"),
  //       activeColorPrimary: Colors.black,
  //       inactiveColorPrimary: const Color(0xFF332d2b),
  //     ),
  //   ];
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = PersistentTabController(initialIndex: 0);
  // }

  int changeScreen = 0;

  @override
  void initState() {
    super.initState();
    // here is for fetching all products from database we set it here for not emit in all
    //the time whenever we move from a page to another here is once be emiting
    final _products = context.read<ProductsBloc>().state;
    //this help us to not asking for fetching datas every time when we come to home page
    // and home page created
    if (_products is! ProductsDatasState) {
      context.read<ProductsBloc>().add(GetProductsEvent());
    }

    print('la home pagawa ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _buildScreens()[changeScreen],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              changeScreen = value;
            });
          },
          currentIndex: changeScreen,
          backgroundColor: Colors.white,
          selectedItemColor:
              AppColors.mainColor, // Color of the selected icon and label
          unselectedItemColor:
              AppColors.yellowColor, // Color of the unselected icon and label
          selectedFontSize: 0,
          unselectedFontSize: 0,
          // type: BottomNavigationBarType.fixed, // Ensures all labels are visible
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: Dimentional.height30,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.archivebox_fill,
                  size: Dimentional.height30),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined,
                  size: Dimentional.height30),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: Dimentional.height30),
              label: '',
            ),
          ],
        )

        //--------------------
        //
        //
        // PersistentTabView(
        //   context, navBarHeight: 60,
        //   controller: _controller,
        //   screens: _buildScreens(),
        //   items: _navBarsItems(),
        //   confineInSafeArea: true,
        //   backgroundColor: AppColors.mainColor, // Default is Colors.white.
        //   handleAndroidBackButtonPress: true, // Default is true.
        //   resizeToAvoidBottomInset:
        //       true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        //   stateManagement: true, // Default is true.
        //   hideNavigationBarWhenKeyboardShows:
        //       true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        //   decoration: NavBarDecoration(
        //     borderRadius: BorderRadius.only(
        //         topLeft: Radius.circular(Dimentional.font26),
        //         topRight: Radius.circular(Dimentional.font26)),
        //     colorBehindNavBar: Colors.white,
        //   ),
        //   popAllScreensOnTapOfSelectedTab: true,
        //   popActionScreens: PopActionScreensType.all,
        //   itemAnimationProperties: const ItemAnimationProperties(
        //     // Navigation Bar's items animation properties.
        //     duration: Duration(milliseconds: 200),
        //     curve: Curves.ease,
        //   ),
        //   screenTransitionAnimation: const ScreenTransitionAnimation(
        //     // Screen transition animation on change of selected tab.
        //     animateTabTransition: true,
        //     curve: Curves.ease,
        //     duration: Duration(milliseconds: 200),
        //   ),
        //   navBarStyle:
        //       NavBarStyle.style6, // Choose the nav bar style with this property.
        // )
        );
  }
}
