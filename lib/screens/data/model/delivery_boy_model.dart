
class DeliveryBoyOrder {
  String name;
  String mobile;
  String totalCommission;

  DeliveryBoyOrder({
    required this.name,
    required this.mobile,
    required this.totalCommission,
  });

  factory DeliveryBoyOrder.fromJson(Map<String, dynamic> json) {
    return DeliveryBoyOrder(
      name: json['name'] ?? "",
      mobile: json['mobile'] ?? "",
      totalCommission: json['totalCommission'] ?? 0,
    );
  }
}


