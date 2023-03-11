class Activity {
  final int id;
  final String activity_name;
  final String activity_time;

  Activity({
    required this.id,
    required this.activity_name,
    required this.activity_time,
  });

  Activity copy({
    int? id,
    String? activity_name,
    String? activity_time,
  }) =>
      Activity(
        id: id ?? this.id,
        activity_name: activity_name ?? this.activity_name,
        activity_time: activity_time ?? this.activity_time,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'activity_name': activity_name,
      'activity_time': activity_time,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Activity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          activity_name == other.activity_name &&
          activity_time == other.activity_time;

  @override
  int get hashCode => id.hashCode ^ activity_name.hashCode ^ activity_time.hashCode;
}
