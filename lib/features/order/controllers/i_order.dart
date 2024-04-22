import 'package:ddnangcao_project/models/order.dart';

abstract class IOrder{
  Future<List<Orders>> getAllOrders(String status);
  Future<void> updatedStatusOrder(String orderId, String status);
}