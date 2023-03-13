import 'package:iterasi1/model/activity_list.dart';

class Day {
  final String date;
  final List<Activity> activities;

  Day({
    required this.date,
    required this.activities
  });
}

var dayList = [
  Day(
    date: '',
    activities: [
      Activity(id: 1, activity_name: '', activity_time: ''),
    ]
  )
];