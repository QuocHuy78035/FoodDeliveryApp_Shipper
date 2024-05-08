import 'package:ddnangcao_project/features/order/controllers/order_controller.dart';
import 'package:flutter/material.dart';

import '../models/order.dart';

class OrderProvider extends ChangeNotifier{
  late List<Orders> listOrder = [];
  late List<Orders> listOrderOutGoing = [];

  late bool isLoading = false;
  final OrderController orderController = OrderController();


  void getAllOrderConfirm(double latitude, double longtitude) async {
    isLoading = true;
    try {
      listOrder = await orderController.getAllOrders("confirmed", latitude, longtitude);
    } catch (e) {
      print("fail to get all order confirmed provider");
      throw Exception(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void getAllOrderOutGoing(double latitude, double longtitude) async {
    isLoading = true;
    try {
      listOrderOutGoing = await orderController.getAllOrders("outgoing", latitude, longtitude);
    } catch (e) {
      print("fail to get all order outgoing provider");
      throw Exception(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  changeStatusToNew(String orderId, String status, int index) async{
    try{
      await orderController.updatedStatusOrder(orderId, status);
      if(status == "new"){
        listOrder.removeAt(index);
      }else if(status == "delivered"){
        listOrderOutGoing.removeAt(index);
      }
    }catch(e){
      print("Fail to change status");
      throw Exception(e.toString());
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }
}