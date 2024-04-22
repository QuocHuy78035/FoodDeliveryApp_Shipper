import 'package:flutter/material.dart';

import 'color_lib.dart';

class ShowSnackBar{
  void showSnackBar(String message, Color? colorBackground, Color? colorText, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 2000),
        backgroundColor: colorBackground ?? ColorLib.primaryColor,
        content: Text(
          message,
          style: TextStyle(
            fontSize: 18,
            color: colorText ?? ColorLib.blackColor,
          ),
        ),
      ),
    );
  }
}