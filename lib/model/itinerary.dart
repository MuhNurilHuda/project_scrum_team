import 'day.dart';

class Itinerary{
  String id;
  String title;
  List<Day> days;

  Itinerary({
    required this.id,
    required this.title,
    this.days = const []
  });

  Map<String , dynamic> toJson(){
    return {
      "id" : id,
      "title" : title,
      "days" : days.map((day) => day.toJson()).toList()
    };
  }

  factory Itinerary.fromJson(Map<String , dynamic> json) => Itinerary(
    id: json['id'],
    title: json['title'],
    days: json['days'].map((day) => day.fromJson()).toList()
  );

  Itinerary copy() => Itinerary(
      id: id,
      title: title ,
      days: days
  );
}