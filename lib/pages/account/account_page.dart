import 'package:dlivery_app_project/pages/auth/sign_in_page.dart';
import 'package:dlivery_app_project/pages/auth/sign_up_page.dart';
import 'package:dlivery_app_project/pages/home/homePage.dart';
import 'package:dlivery_app_project/pages/noDataPage/show_custom_snackbar.dart';
import 'package:dlivery_app_project/stateManagment/blocs/bloc/addCart_bloc/bloc/add_cart_bloc.dart';
import 'package:dlivery_app_project/stateManagment/blocs/bloc/authBloc/bloc/auth_bloc.dart';
import 'package:dlivery_app_project/stateManagment/blocs/bloc/user_bloc/bloc/user_bloc.dart';
import 'package:dlivery_app_project/utils/colors.dart';
import 'package:dlivery_app_project/utils/dimentionals.dart';
import 'package:dlivery_app_project/widgets/account_widget.dart';
import 'package:dlivery_app_project/widgets/appIcon.dart';
import 'package:dlivery_app_project/widgets/bigText.dart';
import 'package:dlivery_app_project/widgets/smallText.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../stateManagment/blocs/bloc/products_bloc.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(UserInfoEvent());
  }

  @override
  Widget build(BuildContext context) {
    final _authBloc = context.watch<AuthBloc>().state;
    final _isLoggedIn = context.watch<AuthBloc>().state;

    return Scaffold(
      appBar: AppBar(
          shadowColor: Colors.grey.withOpacity(0.3),
          elevation: 0.0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.mainColor,
          title: BigText(
            text: 'profile',
            size: 24,
            color: Colors.white,
          )),
      body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        if (state is GetUserInfoState) {
          // request to know is logged in or not
          context.read<AuthBloc>().add(IsLoggedin());
          if (_isLoggedIn is LogginState) {
            if (_isLoggedIn.isLoggedin) {
              return Container(
                margin: EdgeInsets.only(top: Dimentional.font20),
                width: double.maxFinite,
                child: Column(
                  children: [
                    AppIcon(
                      icon: Icons.person,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimentional.height45 + Dimentional.height30,
                      size: Dimentional.height15 * 10,
                    ),
                    SizedBox(height: Dimentional.height30),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            //person
                            AccountWiget(
                                appIcon: AppIcon(
                                  icon: Icons.person,
                                  iconColor: Colors.white,
                                  backgroundColor: AppColors.mainColor,
                                  iconSize: Dimentional.height10 * 5 / 2,
                                  size: Dimentional.height10 * 5,
                                ),
                                bigText: BigText(text: state.userDatas.name)),
                            SizedBox(height: Dimentional.height20),
                            //phone
                            AccountWiget(
                                appIcon: AppIcon(
                                  icon: Icons.phone,
                                  iconColor: Colors.white,
                                  backgroundColor: AppColors.yellowColor,
                                  iconSize: Dimentional.height10 * 5 / 2,
                                  size: Dimentional.height10 * 5,
                                ),
                                bigText: BigText(text: state.userDatas.phone)),
                            SizedBox(height: Dimentional.height20),
                            //email
                            AccountWiget(
                                appIcon: AppIcon(
                                  icon: Icons.email,
                                  iconColor: Colors.white,
                                  backgroundColor: AppColors.yellowColor,
                                  iconSize: Dimentional.height10 * 5 / 2,
                                  size: Dimentional.height10 * 5,
                                ),
                                bigText: BigText(text: state.userDatas.email)),
                            SizedBox(height: Dimentional.height20),
                            //location
                            AccountWiget(
                                appIcon: AppIcon(
                                  icon: Icons.location_on,
                                  iconColor: Colors.white,
                                  backgroundColor: AppColors.yellowColor,
                                  iconSize: Dimentional.height10 * 5 / 2,
                                  size: Dimentional.height10 * 5,
                                ),
                                bigText: BigText(text: 'location')),
                            SizedBox(height: Dimentional.height20),
                            //message
                            AccountWiget(
                                appIcon: AppIcon(
                                  icon: Icons.message_outlined,
                                  iconColor: Colors.white,
                                  backgroundColor: Colors.redAccent,
                                  iconSize: Dimentional.height10 * 5 / 2,
                                  size: Dimentional.height10 * 5,
                                ),
                                bigText: BigText(text: 'Messages')),
                            SizedBox(height: Dimentional.height20),
                            GestureDetector(
                              onTap: () {
                                context.read<AuthBloc>().add(IsLoggedin());
                                if (_isLoggedIn is LogginState) {
                                  if (_isLoggedIn.isLoggedin) {
                                    // this is for remove local storage
                                    context
                                        .read<AuthBloc>()
                                        .add(RemovelocalStorage());
                                    // this is for emiting the removed dats!
                                    context
                                        .read<AddCartBloc>()
                                        .add(RemoveHistoryDatasEvent());

                                    //UPDATEING THE USER INFO
                                    context
                                        .read<UserBloc>()
                                        .add(UserInfoEvent());
                                    showCustomScackBar('successfuly logged out',
                                        color: AppColors.mainColor,
                                        title: 'Logout');

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()));
                                  } else {
                                    showCustomScackBar(
                                        title: 'failed',
                                        'you don\'t have any account yet to log out');
                                  }
                                }
                              },
                              child: AccountWiget(
                                  appIcon: AppIcon(
                                    icon: Icons.logout,
                                    iconColor: Colors.white,
                                    backgroundColor: Colors.redAccent,
                                    iconSize: Dimentional.height10 * 5 / 2,
                                    size: Dimentional.height10 * 5,
                                  ),
                                  bigText: BigText(text: 'Logout')),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          }
        } else if (state is ExpiredTokenState) {
          // this is for remove local storage
          context.read<AuthBloc>().add(RemovelocalStorage());
          // this is for emiting the removed dats!
          context.read<AddCartBloc>().add(RemoveHistoryDatasEvent());
          return AlertDialog(
            backgroundColor: AppColors.mainColor,
            title: BigText(
                text: 'expired account time',
                size: Dimentional.font24,
                color: AppColors.mainBlackColor),
            content: SmallText(
                text: 'your account has been expired you should sign in again',
                size: Dimentional.font20,
                color: Colors.black54),
            actions: [
              // Add buttons to the dialog box
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.read<UserBloc>().add(UserInfoEvent());

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: BigText(text: 'Ok', size: Dimentional.font20),
              ),
            ],
          );
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: Dimentional.height10 * 20,
                  width: Dimentional.height10 * 20,
                  child: Image.asset(
                    'assets/images/pngegg.png',
                  )),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.mainColor)),
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignInPage()),
                      ),
                  child: Text('Sign in to your account',
                      style: TextStyle(
                          fontSize: Dimentional.font26,
                          color: AppColors.mainBlackColor)))
            ],
          ),
        );
      }),
    );
  }
}
