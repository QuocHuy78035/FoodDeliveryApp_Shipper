import 'dart:io';

import 'package:ddnangcao_project/features/menu/controllers/menu_controller.dart';
import 'package:flutter/cupertino.dart';

class AddFoodProvider extends ChangeNotifier{
  final MenuController menuController = MenuController();
  addFood(String foodName, String cateId, String resId, String price, String quantity, File image) async{
    try{
      await menuController.upLoadFood(foodName, cateId, resId, price, quantity, image);
    }catch(e){
      print("fail to upload food provider $e");
    }finally{
      notifyListeners();
    }
  }
}