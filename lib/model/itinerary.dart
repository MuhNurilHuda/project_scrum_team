import 'package:uuid/uuid.dart';

import 'day.dart';

class Itinerary{
  late String id;
  String title;
  List<Day> days;

  Itinerary({
    String? id,
    required this.title,
    List<Day>? days
  }) :
      this.id = id ?? const Uuid().v1(),
      this.days = days ?? [];

  Map<String , dynamic> toJson(){
    return {
      "id" : id,
      "title" : title,
      "days" : days.map((day) => day.toJson()).toList()
    };
  }

  factory Itinerary.fromJson(Map<String , dynamic> json){
    return Itinerary(
        id: json['id'],
        title: json['title'],
        days: json['days'].map((day) => Day.fromJson(day))
            .toList()
            .cast<Day>()
    );
  }

  Itinerary copy({
    String? id,
    String? title,
    List<Day>? days
  }) =>
      Itinerary(
        id : id ?? this.id,
        title : title ?? this.title,
        days : days ?? this.days
      );
}