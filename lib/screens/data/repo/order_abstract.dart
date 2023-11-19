import 'package:flutter/cupertino.dart';
import '../model/order_model.dart';

abstract class OrderRepoAbstract {
   Future<List<Order>> getOrderData(BuildContext context, String phone);
}