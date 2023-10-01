import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';
import '../utils/dimentionals.dart';

class AppTextField extends StatefulWidget {
  const AppTextField(
      {super.key,
      required this.controller,
      required this.icon,
      required this.hintText,
      this.typeInput = TextInputType.text,
      this.letVisibleSuficIcon = false});
  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final TextInputType typeInput;
  final bool letVisibleSuficIcon;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  bool isVisible = false;

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: Dimentional.width20, right: Dimentional.width20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimentional.radius30),
          boxShadow: [
            BoxShadow(
                spreadRadius: 7,
                blurRadius: 10,
                offset: const Offset(1, 10),
                color: Colors.grey.withOpacity(0.2))
          ]),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.typeInput,
        obscureText: isVisible,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isVisible = !isVisible;
                });
              },
              child: isVisible
                  ? Visibility(
                      visible: widget.letVisibleSuficIcon,
                      child: Icon(Icons.visibility_off,
                          color: AppColors.yellowColor))
                  : Visibility(
                      visible: widget.letVisibleSuficIcon,
                      child: Icon(Icons.visibility,
                          color: AppColors.yellowColor))),
          //hint text
          hintText: widget.hintText,
          //prefix icon
          prefixIcon: Icon(widget.icon, color: AppColors.yellowColor),
          //focused border
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimentional.radius30),
              borderSide: const BorderSide(width: 1.0, color: Colors.white)),
          //enable border
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimentional.radius30),
              borderSide: const BorderSide(width: 1.0, color: Colors.white)),
          //border
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimentional.radius30),
          ),
        ),
      ),
    );
  }
}
