
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Activity {
  String activityName;
  String startActivityTime;
  String endActivityTime;
  String keterangan;

  static final _formatter = DateFormat.Hm();


  Activity({
    required this.activityName,
    required this.startActivityTime,
    required this.endActivityTime,
    required this.keterangan
  });


  Map<String, dynamic> toJson() {
    return {
      'activity_name': activityName,
      'start_activity_time': startActivityTime,
      'end_activity_time': endActivityTime,
      'keterangan': keterangan
    };
  }

  factory Activity.fromJson(Map<String, dynamic> json) =>
      Activity(
          activityName: json['activity_name'],
          startActivityTime: json['start_activity_time'],
          endActivityTime: json['end_activity_time'],
          keterangan: json['keterangan']
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Activity &&
              runtimeType == other.runtimeType &&
              activityName == other.activityName &&
              startActivityTime == other.startActivityTime &&
              endActivityTime == other.endActivityTime;

  Activity copy({
    String? activityName,
    String? startActivityTime,
    String? endActivityTime,
    String? keterangan
  }) =>
      Activity(
          activityName: activityName ?? this.activityName,
          startActivityTime: startActivityTime ?? this.startActivityTime,
          endActivityTime: endActivityTime ?? this.endActivityTime,
          keterangan: keterangan ?? this.keterangan
      );

  TimeOfDay get startTimeOfDay =>
    TimeOfDay.fromDateTime(startDateTime);

  TimeOfDay get endTimeOfDay =>
      TimeOfDay.fromDateTime(endDateTime);

  DateTime get startDateTime =>
      _formatter.parse(startActivityTime);

  DateTime get endDateTime =>
      _formatter.parse(endActivityTime);
}


