import 'dart:convert';
import 'dart:io';

import 'package:ddnangcao_project/api_services.dart';
import 'package:ddnangcao_project/features/menu/controllers/i_menu_controller.dart';
import 'package:ddnangcao_project/models/category.dart';
import 'package:ddnangcao_project/models/food.dart';

class MenuController implements IMenuController {
  final ApiServiceImpl apiService = ApiServiceImpl();

  @override
  Future<List<Category>> getAllCategory() async {
    List<Category> category = [];
    final response = await apiService.get(url: "category");
    final Map<String, dynamic> data = jsonDecode(response.body);
    if (data['status'] == 200) {
      category = (data['metadata'] as List<dynamic>)
          .map((item) => Category.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
    return category;
  }

  @override
  Future<int> upLoadFood(String foodName, String cateId, String resId,
      String price, String quantity, File image) async{
    final response = await apiService.postFormData(
      url: "food",
      params: {
        "name" :  foodName,
        "category" : cateId ,
        "store" : resId,
        "price" :price,
        "left" : quantity,
        "image" :image
      },
      nameFieldImage: "image",
    );
    final Map<String, dynamic> data = jsonDecode(response.body);
    return data['status'];
  }

  @override
  Future<List<Food>> getAllFoodByStoreId(String storeId) async{
    List<Food> listFood = [];
    final response = await apiService.get(url: "food?store=$storeId");
    final Map<String, dynamic> data = jsonDecode(response.body);
    if (data['status'] == 200) {
      listFood = (data['metadata'] as List<dynamic>)
          .map((item) => Food.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to get all food by storeId');
    }
    return listFood;
  }

  @override
  Future<int> editFood(String foodId, String foodName, String categoryId, String price, String left, File? file) async{
    final response = await apiService.patchFormData(url: "food/$foodId", params: {
      "name" : foodName,
      "category" : categoryId,
      "price" : price,
      "left" : left,
      "image" : file
    }, nameFieldImage: 'image');
    final Map<String, dynamic> data = jsonDecode(response.body);
    print(data);
    return data['status'];
  }
}
