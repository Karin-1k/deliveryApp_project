import 'dart:convert';

import 'package:dlivery_app_project/pages/auth/sign_up_page.dart';
import 'package:dlivery_app_project/pages/home/homePage.dart';
import 'package:dlivery_app_project/utils/colors.dart';
import 'package:dlivery_app_project/utils/dimentionals.dart';
import 'package:dlivery_app_project/widgets/bigText.dart';
import 'package:dlivery_app_project/widgets/text_field_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';

import '../../stateManagment/blocs/bloc/authBloc/bloc/auth_bloc.dart';
import '../../stateManagment/blocs/bloc/user_bloc/bloc/user_bloc.dart';
import '../noDataPage/show_custom_snackbar.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();
  void _registration() {
    String _checkemail = email.text.trim();
    String _checkpassword = password.text.trim();
    if (_checkemail.isEmpty && _checkpassword.isEmpty) {
      showCustomScackBar('please fill the field out', title: 'credintials');
    } else if (_checkemail.isEmpty) {
      showCustomScackBar('type in your email address', title: 'Email Address');
    } else if (!GetUtils.isEmail(_checkemail)) {
      showCustomScackBar('type in a valid email address',
          title: 'Valid Email Address');
    } else if (_checkpassword.isEmpty) {
      showCustomScackBar('type in your password', title: 'Password');
    } else if (_checkpassword.length < 6) {
      showCustomScackBar('password can not bet less than six characters',
          title: 'Password');
    } else {
      context.read<AuthBloc>().add(LoginUser(
          credintial:
              json.encode({"email": _checkemail, "password": _checkpassword})));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SuccessLogin) {
            showCustomScackBar(state.body,
                title: 'Perfect', color: AppColors.mainColor);

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          } else if (state is FailedLogin) {
            showCustomScackBar(state.err, title: 'failed');
          }
        },
        builder: (context, state) => SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimentional.screenHight * 0.05),
              //App logo
              Container(
                height: Dimentional.screenHight * 0.25,
                // color: Colors.amber,
                child: const Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    backgroundImage: AssetImage('assets/images/pngegg.png'),
                  ),
                ),
              ),
              //welcom
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(left: Dimentional.width20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hello',
                        style: TextStyle(
                            fontSize:
                                Dimentional.font20 * 3 + Dimentional.font20 / 2,
                            fontWeight: FontWeight.bold)),
                    Text('Sign into your account',
                        style: TextStyle(
                            fontSize: Dimentional.font20,
                            color: Colors.grey[500]))
                  ],
                ),
              ),
              SizedBox(height: Dimentional.height20),
              //your email
              AppTextField(
                  controller: email, icon: Icons.email, hintText: 'Email'),
              SizedBox(height: Dimentional.height20),
              //your password
              AppTextField(
                  controller: password,
                  icon: Icons.password_sharp,
                  hintText: 'password',
                  letVisibleSuficIcon: true),
              SizedBox(height: Dimentional.height20),
              //sign into your account
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: 'Sign into your account',
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimentional.font20)),
                    ),
                    SizedBox(width: Dimentional.width20),
                  ],
                ),
              ),
              SizedBox(height: Dimentional.screenHight * 0.05),
              //sign in button
              state is Loading
                  ? CircularProgressIndicator(color: AppColors.mainColor)
                  : GestureDetector(
                      onTap: () {
                        _registration();
                      },
                      child: Container(
                        width: Dimentional.screenWidth / 2,
                        height: Dimentional.screenHight / 13,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimentional.radius30),
                            color: AppColors.mainColor),
                        child: Center(
                            child: BigText(
                                text: 'Sign In',
                                size:
                                    Dimentional.font20 + Dimentional.font20 / 2,
                                color: Colors.white)),
                      ),
                    ),
              SizedBox(height: Dimentional.height10),
              //if u want clickable text you should use richText ..

              SizedBox(height: Dimentional.screenHight * 0.05),
              RichText(
                text: TextSpan(
                  text: 'Don\'t have an account? ',
                  style: TextStyle(
                      color: Colors.grey[500], fontSize: Dimentional.font20),
                  children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage())),
                        text: 'Create',
                        style: TextStyle(
                            color: AppColors.mainBlackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: Dimentional.font20)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
