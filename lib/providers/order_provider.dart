import 'package:ddnangcao_project/features/order/controllers/order_controller.dart';
import 'package:flutter/material.dart';

import '../models/order.dart';

class OrderProvider extends ChangeNotifier{
  late List<Orders> listOrderScheduled = [];
  late List<Orders> listOrderConfirmed = [];
  late List<Orders> listOrderNewed = [];
  late bool isLoading = false;
  final OrderController orderController = OrderController();

  void getAllOrderPending() async {
    isLoading = true;
    try{
      listOrderScheduled = await orderController.getAllOrders("pending");
    }catch(e){
      print("fail to get all order scheduled provider");
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }

  getAllOrderNew() async{
    isLoading = true;
    try{
      listOrderNewed = await orderController.getAllOrders("new");
    }catch(e){
      print("fail to get all order confirm provider");
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }

  void getAllOrderConfirmed() async {
    isLoading = true;
    try{
      listOrderConfirmed = await orderController.getAllOrders("confirmed");
    }catch(e){
      print("fail to get all order confirm provider");
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }

  changeStatusToConfirmed(String orderId, String status, int index) async{
    try{
      await orderController.updatedStatusOrder(orderId, status);
      if(status == "confirmed"){
        listOrderScheduled.removeAt(index);
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