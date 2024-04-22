import 'dart:io';

import 'package:ddnangcao_project/features/menu/controllers/menu_controller.dart';
import 'package:flutter/cupertino.dart';

import '../models/food.dart';

class MenuProvider extends ChangeNotifier {
  final MenuController menuController = MenuController();
  List<Food> listFood = [];
  bool isLoading = false;

  getAllFoodByStoreId(String storeId) async {
    try {
      isLoading = true;
      listFood = await menuController.getAllFoodByStoreId(storeId);
    } catch (e) {
      print("Fail to get all food menu provider");
      throw Exception(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  editFood(
    String foodId,
    String foodName,
    String categoryId,
    String price,
    String left,
    File image,
  ) async {
    try {
      await menuController.editFood(
          foodId, foodName, categoryId, price, left, image);
    } catch (e) {
      throw Exception(e.toString());
    } finally {}
  }
}
