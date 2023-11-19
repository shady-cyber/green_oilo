import 'day_model.dart';

class Timeslot {
  String startTime;
  String endTime;
  Day day;

  Timeslot({
    required this.startTime,
    required this.endTime,
    required this.day,
  });

  factory Timeslot.fromJson(Map<String, dynamic> json) {
    return Timeslot(
      startTime: json['start_time'] ?? "",
      endTime: json['end_time'] ?? "",
      day: Day.fromJson(json['day']),
    );
  }
}