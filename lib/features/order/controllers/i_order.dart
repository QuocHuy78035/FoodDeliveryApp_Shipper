import 'package:ddnangcao_project/models/order.dart';

abstract class IOrder{
  Future<List<Orders>> getAllOrders(String status, double latitude, double longtitude);
  Future<void> updatedStatusOrder(String orderId, String status);
}