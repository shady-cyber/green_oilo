class Customer {
  String mobileNumber;
  String fullName;

  Customer({
    required this.mobileNumber,
    required this.fullName,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      mobileNumber: json['mobile_number'],
      fullName: json['full_name'],
    );
  }
}