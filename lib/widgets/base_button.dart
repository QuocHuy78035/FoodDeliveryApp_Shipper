import 'package:flutter/material.dart';
import '../utils/color_lib.dart';

class BaseButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget titleRow;
  final Color? backgroundColor;
  final Color? borderColor;

  const BaseButton(
      {super.key,
      required this.onPressed,
      required this.titleRow,
      this.backgroundColor,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: backgroundColor ?? ColorLib.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(
            color: borderColor ?? ColorLib.whiteColor,
          ),
        ),
      ),
      onPressed: onPressed,
      child: titleRow,
    );
  }
}
