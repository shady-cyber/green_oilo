class Gift {
  String giftName;
  String giftDescription;

  Gift({
    required this.giftName,
    required this.giftDescription,
  });

  factory Gift.fromJson(Map<String, dynamic> json) {
    return Gift(
      giftName: json['name'] ?? "",
      giftDescription: json['description'] ?? "",
    );
  }
}