
class Activity {
  final String id;
  final String idDay;
  final String activityName;
  final String activityTime;


  Activity({
    required this.idDay,
    required this.activityName,
    required this.activityTime,
    required this.id
  });


  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'id_day' : idDay,
      'name': activityName,
      'time': activityTime,
    };
  }
  // factory Activity.fromJson(Map<String , dynamic>) => Activity(
  //  idDay: idDay,
  //   activityName: activityName,
  //   activityTime: activityTime,
  //   id: id
  // );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Activity &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              activityName == other.activityName &&
              activityTime == other.activityTime;

  Activity copy({
    String? idDay,
    String? id,
    String? activityName,
    String? activityTime,
  }) =>
      Activity(
        idDay: idDay ?? this.idDay,
        id: id ?? this.id,
        activityName: activityName ?? this.activityName,
        activityTime: activityTime ?? this.activityTime,
      );
}


