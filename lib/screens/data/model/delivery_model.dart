
class DeliveryOrder {
  int orderId;
  String status;
  String image;
  String notes;

  DeliveryOrder({
    required this.orderId,
    required this.status,
    required this.image,
    required this.notes,
  });

  factory DeliveryOrder.fromJson(Map<String, dynamic> json) {
    return DeliveryOrder(
      orderId: json['id'] ?? 0,
      status: json['status'] ?? "",
      image: json['order_image'] ?? "",
      notes: json['notes'] ?? "",
    );
  }
}


