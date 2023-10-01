import 'package:dlivery_app_project/pages/auth/sign_in_page.dart';
import 'package:dlivery_app_project/pages/home/homePage.dart';
import 'package:dlivery_app_project/stateManagment/blocs/bloc/authBloc/bloc/auth_bloc.dart';
import 'package:dlivery_app_project/stateManagment/data/moduls/auth_module.dart';
import 'package:dlivery_app_project/utils/colors.dart';
import 'package:dlivery_app_project/utils/dimentionals.dart';
import 'package:dlivery_app_project/widgets/bigText.dart';
import 'package:dlivery_app_project/pages/noDataPage/show_custom_snackbar.dart';
import 'package:dlivery_app_project/widgets/text_field_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../stateManagment/blocs/bloc/user_bloc/bloc/user_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController personController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  List iconImages = ['x.png', 'facebook.png', 'google.png'];
  void _registration() {
    String _checkemail = emailController.text.trim();
    String _checkpassword = passwordController.text.trim();
    String _checkname = personController.text.trim();
    String _checkphone = phoneController.text.trim();
    if (_checkname.isEmpty &&
        _checkpassword.isEmpty &&
        _checkname.isEmpty &&
        _checkphone.isEmpty) {
      showCustomScackBar('please fill the field out', title: 'Name');
    } else if (_checkname.isEmpty) {
      showCustomScackBar('type in your name', title: 'Name');
    } else if (_checkphone.isEmpty) {
      showCustomScackBar('type in your phone number', title: 'Phone number');
    } else if (_checkphone.length != 11) {
      showCustomScackBar('your phone number should be 11 number ',
          title: 'Phone number');
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
      AuthModule signUpBody = AuthModule(
          name: _checkname,
          phone: _checkphone,
          email: _checkemail,
          password: _checkpassword);

      context.read<AuthBloc>().add(RegesterUser(user: signUpBody.toJson));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SuccessReg) {
            showCustomScackBar(state.body,
                title: 'Perfect', color: AppColors.mainColor);
           
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          } else if (state is FailedReg) {
            showCustomScackBar(state.err, title: 'failed');
          }
        },
        builder: (context, state) => SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimentional.screenHight * 0.05),

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
              AppTextField(
                  controller: personController,
                  icon: Icons.person,
                  hintText: 'Name'),
              SizedBox(height: Dimentional.height20),
              //your phone
              AppTextField(
                  controller: phoneController,
                  icon: Icons.phone,
                  hintText: 'phone',
                  typeInput: TextInputType.phone),
              SizedBox(height: Dimentional.height20),
              AppTextField(
                  controller: emailController,
                  icon: Icons.email,
                  hintText: 'Email'),
              SizedBox(height: Dimentional.height20),
              //your password
              AppTextField(
                  controller: passwordController,
                  icon: Icons.password_sharp,
                  hintText: 'password',
                  letVisibleSuficIcon: true),
              //your name
              SizedBox(height: Dimentional.height20),

              // sign up button
              state is Loading
                  ? CircularProgressIndicator(
                      color: AppColors.mainColor,
                    )
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
                                text: 'Sign Up',
                                size:
                                    Dimentional.font20 + Dimentional.font20 / 2,
                                color: Colors.white)),
                      ),
                    ),
              SizedBox(height: Dimentional.height10),
              //if u want clickable text you should use richText ..
              RichText(
                text: TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInPage())),
                    text: 'Have an account already?',
                    style: TextStyle(
                        color: AppColors.mainBlackColor,
                        fontSize: Dimentional.font20)),
              ),
              // SizedBox(height: Dimentional.screenHight * 0.02),
              SizedBox(height: Dimentional.height20),
              RichText(
                text: TextSpan(
                    text: 'Sign Up using one of the following methods',
                    style: TextStyle(
                        color: Colors.grey[500], fontSize: Dimentional.font16)),
              ),
              // sign up with other methods

              Padding(
                padding: EdgeInsets.all(Dimentional.height15),
                child: Wrap(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset('assets/images/x.png', width: 50)),
                    SizedBox(width: Dimentional.font16),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset('assets/images/facebook.png',
                            width: 55)),
                    SizedBox(width: Dimentional.font16),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child:
                            Image.asset('assets/images/google.png', width: 50)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
