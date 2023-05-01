import 'package:flutter/cupertino.dart';
import 'package:iterasi1/model/activity.dart';
import 'package:iterasi1/model/day.dart';
import 'package:iterasi1/model/itinerary.dart';
import 'dart:developer' as developer;



class ItineraryProvider extends ChangeNotifier{
  late Itinerary _itinerary;
  Itinerary get itinerary => _itinerary;


  void initItinerary(Itinerary newItinerary){
    _itinerary = newItinerary.copy();
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

    notifyListeners();
  }

  String convertDateTimeToString({required DateTime dateTime}) =>
    "${dateTime.day}/" "${dateTime.month}/" "${dateTime.year}";


  void addNewActivity(Activity newActivity , int index){
    try {
      _itinerary.days[index].activities = [
        ..._itinerary.days[index].activities,
        newActivity
      ];
    } catch (e) {
      developer.log("$e" , name : 'qqq');
    }
    notifyListeners();
  }

  void updateActivity(
      int dayIndex ,
      int activityIndex,
      {
        String? activityName,
        String? activityTime
      }
  ){
    final newActivity = _itinerary.days[dayIndex].activities[activityIndex].copy(
      activityName: activityName,
      activityTime: activityTime
    );

    try{
      _itinerary.days[dayIndex].activities[activityIndex] = newActivity;
    }catch (e){
      developer.log("$e" , name : 'qqq');
    }
    notifyListeners();
  }

  void removeActivity(int dayIndex , int activityIndex){
    final currentActivities = List<Activity>.from(
        _itinerary.days[dayIndex].activities
    );

    _itinerary.days[dayIndex].activities = currentActivities
        ..removeAt(activityIndex);

    notifyListeners();
  }

  void editActivity({
    required int dayIndex,
    required int activityIndex,
    required Activity newActivity
  }){
    _itinerary.days[dayIndex].activities[activityIndex] = newActivity;

    notifyListeners();
  }
}