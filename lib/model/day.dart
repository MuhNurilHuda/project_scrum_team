import 'package:iterasi1/model/activity.dart';
import 'package:iterasi1/utilities/date_time_formatter.dart';

class Day {
  final String date;
  List<Activity> activities;

  Day({
    required this.date,
    this.activities = const []
  });

  Day.from(DateTime initialDate) :
    date = DateTimeFormatter.toDMY(initialDate , separator: "/"),
    activities = [];

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

  Day copy({
    String? date,
    List<Activity>? activities
  }) =>
      Day(
          date: date ?? this.date,
          activities: activities ?? this.activities.map((e) => e.copy()).toList()
      );

  DateTime getDatetime(){
    final dateStringSplitted = date.split("/");
    final day = int.parse(dateStringSplitted[0]);
    final month = int.parse(dateStringSplitted[1]);
    final year = int.parse(dateStringSplitted[2]);

    return DateTime(year , month , day);
  }
}
