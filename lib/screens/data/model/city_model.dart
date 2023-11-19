class City {
  String cityName;

  City({
    required this.cityName,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      cityName: json['city_name'] ?? "",
    );
  }
}