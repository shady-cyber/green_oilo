class Day {
  String name;
  String dayDate;

  Day({
    required this.name,
    required this.dayDate,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      name: json['name'],
      dayDate: json['day_date'],
    );
  }
}