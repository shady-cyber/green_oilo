class State {
  String stateName;

  State({
    required this.stateName,
  });

  factory State.fromJson(Map<String, dynamic> json) {
    return State(
      stateName: json['state_name'],
    );
  }
}