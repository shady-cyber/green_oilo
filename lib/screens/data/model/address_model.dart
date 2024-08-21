import 'package:reni/screens/data/model/state_model.dart';

import 'city_model.dart';

class Address {
  String addressLine1;
  String? addressLine2;
  int stateId;
  int cityId;
  City city;
  State state;

  Address({
    required this.addressLine1,
    required this.addressLine2,
    required this.stateId,
    required this.cityId,
    required this.city,
    required this.state,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressLine1: json['address_line_1'] ?? "",
      addressLine2: json['address_line_2'] ?? "",
      stateId: json['state_id'] ?? 0,
      cityId: json['city_id'] ?? 0,
      city: City.fromJson(json['city']),
      state: State.fromJson(json['state']),
    );
  }
}