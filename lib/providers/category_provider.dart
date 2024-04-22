import 'package:ddnangcao_project/features/menu/controllers/menu_controller.dart';
import 'package:ddnangcao_project/models/category.dart';
import 'package:flutter/cupertino.dart';

class CategoryProvider extends ChangeNotifier{
  List<Category> category = [];
  final MenuController menuController = MenuController();
  getAllCategory() async {
    try{
      category = await menuController.getAllCategory();
    }catch(e){
      print("fail to get all category provider $e");
    }finally{
      notifyListeners();
    }
    return category;
  }
}