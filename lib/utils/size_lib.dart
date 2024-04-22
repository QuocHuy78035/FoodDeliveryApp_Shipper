import 'package:flutter/material.dart';

class GetSize{
  static getHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }

  static getWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }
  static const double distance = 10;

  static const double symmetricPadding = 10;
  static const double horizontalPadding = 10;
}
