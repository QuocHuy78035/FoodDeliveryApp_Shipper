import 'dart:convert';

import 'package:ddnangcao_project/api_services.dart';
import 'package:ddnangcao_project/features/order/controllers/i_order.dart';
import 'package:ddnangcao_project/models/order.dart';

class OrderController implements IOrder{
  final ApiServiceImpl apiServiceImpl = ApiServiceImpl();
  @override
  Future<List<Orders>> getAllOrders(String status, double latitude, double longtitude) async{
    List<Orders> listOrder = [];
    final response = await apiServiceImpl.get(url: "order/shipper?coordinate=$latitude,$longtitude&status=$status");
    final Map<String, dynamic> data = jsonDecode(response.body);
    if (data['status'] == 200) {
      listOrder = (data['metadata']['orders'] as List<dynamic>)
          .map((item) => Orders.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to get all food by storeId');
    }

    return listOrder;
  }

  @override
  Future<void> updatedStatusOrder(String orderId, String status) async{
    final response = await apiServiceImpl.patch(url: "order/$orderId", params: {
      'status' : status
    }, );
    final Map<String, dynamic> data = jsonDecode(response.body);
    print(data);
    if(data['status'] != 200){
      print("Fail to update status order");
    }
  }
}