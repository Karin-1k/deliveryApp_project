import 'package:dlivery_app_project/widgets/bigText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomScackBar(String message,
    {bool isError = true,
    String title = 'Erorr',
    Color color = Colors.redAccent}) {
  Get.snackbar(title, message,
      titleText: BigText(text: title, color: Colors.white),
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      backgroundColor: color);
}
