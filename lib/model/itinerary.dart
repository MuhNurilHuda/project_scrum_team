import 'day.dart';

class Itinerary{
  String id;
  String title;
  List<Day> days = [];

  Itinerary({
    required this.id,
    required this.title
  });

  Map<String , dynamic> toMap(){
    return {
      "id" : id,
      "title" : title
    };
  }
}