import 'package:flutter/cupertino.dart';
import '../model/delivery_model.dart';
import '../model/order_main_model.dart';
import '../model/order_model.dart';

abstract class OrderRepoAbstract {
   Future<List<OrdersMain>> getOrderData(BuildContext context, String phone);
   Future<DeliveryOrder> sendOrderStatus(String status, String? image, int orderId, String? notes, String phone);
}