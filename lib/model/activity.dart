
class Activity {
  final String activityName;
  final String activityTime;


  Activity({
    required this.activityName,
    required this.activityTime,
  });


  Map<String, dynamic> toJson() {
    return {
      'activity_name': activityName,
      'activity_time': activityTime,
    };
  }
  factory Activity.fromJson(Map<String , dynamic> json) => Activity(
    activityName: json['activity_name'],
    activityTime: json['activity_time'],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Activity &&
              runtimeType == other.runtimeType &&
              activityName == other.activityName &&
              activityTime == other.activityTime;

  Activity copy({
    String? activityName,
    String? activityTime,
  }) =>
      Activity(
        activityName: activityName ?? this.activityName,
        activityTime: activityTime ?? this.activityTime,
      );
}


