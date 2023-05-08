import 'package:flutter/cupertino.dart';
import 'package:iterasi1/model/activity.dart';
import 'package:iterasi1/model/day.dart';
import 'package:iterasi1/model/itinerary.dart';
import 'dart:developer' as developer;



class ItineraryProvider extends ChangeNotifier{
  late Itinerary _itinerary;
  late Itinerary initialItinerary;
  Itinerary get itinerary => _itinerary;


  void initItinerary(Itinerary newItinerary){
    _itinerary = newItinerary.copy();
    initialItinerary = newItinerary.copy();
    notifyListeners();
  }

  void setNewItineraryTitle(String newTitle){
    _itinerary.title = newTitle;
  }

  void addDay(Day newDay){
    try {
      _itinerary.days = [..._itinerary.days , newDay];
    } catch (e) {
      developer.log("$e" , name : 'qqq');
    }
    notifyListeners();
  }

  void initializeDays(List<DateTime> dates){
    List<DateTime> sortedDates = dates
        ..sort();

    _itinerary.days = sortedDates.map((date) => Day.from(date)).toList();
    developer.log(_itinerary.days.hashCode.toString() , name : "qqqInitializeDays");

    notifyListeners();
  }

  String convertDateTimeToString({required DateTime dateTime}) =>
    "${dateTime.day}/" "${dateTime.month}/" "${dateTime.year}";


  void updateActivity({
    required Activity oldActivity,
    required Activity newActivity
  }){
    oldActivity.startActivityTime = newActivity.startActivityTime;
    oldActivity.activityName = newActivity.activityName;
    oldActivity.endActivityTime = newActivity.endActivityTime;
    oldActivity.keterangan = newActivity.keterangan;
    notifyListeners();
  }

  void insertNewActivity({
    required List<Activity> activities,
    required Activity newActivity
  }){
    activities.add(newActivity);
    notifyListeners();
  }

  void removeActivity({
    required List<Activity> activities,
    required int removedIndex
  }){
    activities.removeAt(removedIndex);
    notifyListeners();
  }

  Future<List<Activity>> getSortedActivity(List<Activity> activities) async{
    return activities..sort(
        (a , b){
          return a.startDateTime.compareTo(b.startDateTime);
        }
    );
  }
}