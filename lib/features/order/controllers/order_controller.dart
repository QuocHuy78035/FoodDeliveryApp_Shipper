import 'dart:convert';

import 'package:ddnangcao_project/api_services.dart';
import 'package:ddnangcao_project/features/order/controllers/i_order.dart';
import 'package:ddnangcao_project/models/order.dart';

class OrderController implements IOrder{
  final ApiServiceImpl apiServiceImpl = ApiServiceImpl();
  @override
  Future<List<Orders>> getAllOrders(String status) async{
    List<Orders> listOrderPending = [];
    final response = await apiServiceImpl.get(url: "order/vendor?status=$status&sort=createdAt");
    final Map<String, dynamic> data = jsonDecode(response.body);
    if(data['status'] == 200){
      final List<dynamic> ordersData = data['metadata']['orders'];
      listOrderPending = ordersData.map((orderJson) => Orders.fromJson(orderJson)).toList();
    }else{
      print("Fail to get all order");
    }return listOrderPending;
  }

  @override
  Future<void> updatedStatusOrder(String orderId, String status) async{
    final response = await apiServiceImpl.patch(url: "order/$orderId", params: {
      'status' : status
    }, );
    final Map<String, dynamic> data = jsonDecode(response.body);
    if(data['status'] != 200){
      print("Fail to update status order");
    }
  }
}