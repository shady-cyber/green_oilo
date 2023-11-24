
class DeliveryOrder {
  int orderId;
  String status;
  String notes;

  DeliveryOrder({
    required this.orderId,
    required this.status,
    required this.notes,
  });

  factory DeliveryOrder.fromJson(Map<String, dynamic> json) {
    return DeliveryOrder(
      orderId: json['id'] ?? 0,
      status: json['status'] ?? "",
      notes: json['notes'] ?? "",
    );
  }
}


