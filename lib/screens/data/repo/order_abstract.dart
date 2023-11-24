import 'package:flutter/cupertino.dart';
import '../model/delivery_model.dart';
import '../model/order_model.dart';

abstract class OrderRepoAbstract {
   Future<List<Order>> getOrderData(BuildContext context, String phone);
   Future<DeliveryOrder> sendOrderStatus(String status, int orderId, String notes, String phone);
}