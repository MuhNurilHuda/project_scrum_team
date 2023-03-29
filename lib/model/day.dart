import 'package:iterasi1/model/activity.dart';

class Day {
  final String date;
  List<Activity> activities;

  Day({
    required this.date,
    this.activities = const []
  });

  Map<String , dynamic> toJson(){
    return {
      'date' : date,
      'activities' : activities.map((activity) => activity.toJson()).toList()
    };
  }

  factory Day.fromJson(Map<String , dynamic> json){
    return Day(
        date: json['date'],
        activities: json['activities']
                .map((activity) => Activity.fromJson(activity))
                .cast<Activity>()
                .toList()
    );
  }
}