import 'package:iterasi1/model/activity.dart';

class Day {
  final String id;
  final String idItinerary;
  final String date;
  List<Activity> activities = [];

  Day({
    required this.date,
    required this.idItinerary,
    required this.id
  });

  Map<String , dynamic> toMap(){
    return {
      'id' : id,
      'id_itinerary' : idItinerary,
      'date' : date
    };
  }
}