import 'delivery_boy_model.dart';
import 'order_model.dart';

class OrdersMain {
  DeliveryBoyOrder deliveryBoy;
  List<Order> orders;

  OrdersMain({
    required this.deliveryBoy,
    required this.orders,
  });

  factory OrdersMain.fromJson(Map<String, dynamic> json) {
    return OrdersMain(
      deliveryBoy: DeliveryBoyOrder.fromJson(json['deliveryBoy']),
      orders: List<Order>.from(json['orders'].map((x) => Order.fromJson(x))),
    );
  }
}