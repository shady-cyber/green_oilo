
import '../model/order_model.dart';

abstract class OrderRepoAbstract {
   Future<Order> getOrderData(String phone);
}