import 'package:reni/screens/data/model/timeslot_order.dart';

import 'address_model.dart';
import 'customer_model.dart';
import 'gift_model.dart';

class Order {
  int id;
  String orderNumber;
  int quantity;
  int timeslotId;
  String status;
  String? notes;
  String createdAt;
  String updatedAt;
  Timeslot timeslot;
  Customer customer;
  Address address;
  Gift gift;
  List<Order> orderData;
  List<Order> orderDeliveredData;

  String OrderNum = "Order Number";
  String Quantity = "Quantity";
  String OrderStatus = "status";
  String OrderAddress = "Address";
  String CustomerName = "Customer Name";
  String CustomerNumberFull = "Customer Number";
  String CustomerNumber = "Customer Number";
  String CustomerGift = "Gift";
  String address2 = "";

  Order({
    required this.id,
    required this.orderNumber,
    required this.quantity,
    required this.timeslotId,
    required this.status,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.timeslot,
    required this.customer,
    required this.address,
    required this.gift,
    required this.orderData,
    required this.orderDeliveredData
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? 0,
      orderNumber: json['order_number'] ?? "",
      quantity: json['quantity'] ?? 0,
      timeslotId: json['timeslot_id'] ?? 0,
      status: json['status'] ?? "",
      notes: json['notes'] ?? "",
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      timeslot: Timeslot.fromJson(json['timeslot']),
      customer: Customer.fromJson(json['customer']),
      address: Address.fromJson(json['address']),
      gift: Gift.fromJson(json['gift']),
      orderData: [],
      orderDeliveredData: [],
    );
  }

  fetchOrderData(){
    OrderNum = orderNumber;
    Quantity = quantity.toString();
    if(address.addressLine2 == null){
      OrderAddress = address.addressLine1 + " " + address2 + " " + address.state.stateName + " " + address.city.cityName;
    } else {
      address2 = address.addressLine2!;
      OrderAddress = address.addressLine1 + " " + address2 + " " + address.state.stateName + " " + address.city.cityName;
    }
    CustomerName = customer.fullName;
    CustomerNumberFull = customer.mobileNumber;
    CustomerNumber = CustomerNumberFull.substring(2);
    CustomerGift = gift.giftName;
    OrderStatus = status;
  }
}


