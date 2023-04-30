import 'package:flutter/cupertino.dart';
import 'package:iterasi1/model/activity.dart';
import 'package:iterasi1/model/day.dart';
import 'package:iterasi1/model/itinerary.dart';
import 'dart:developer' as developer;

import 'package:syncfusion_flutter_datepicker/datepicker.dart';


class ItineraryProvider extends ChangeNotifier{
  late Itinerary itinerary;

  void initItinerary(Itinerary newItinerary){
    itinerary = newItinerary.copy();
    notifyListeners();
  }

  void addDay(Day newDay){
    try {
      itinerary.days = [...itinerary.days , newDay];
    } catch (e) {
      developer.log("$e" , name : 'qqq');
    }
    notifyListeners();
  }

  void initializeDays(List<DateTime> dates){
    List<DateTime> sortedDates = dates
        ..sort();

    itinerary.days = sortedDates.map((date) => Day.from(date)).toList();

    notifyListeners();
  }

  String convertDateTimeToString({required DateTime dateTime}) =>
    "${dateTime.day}/" "${dateTime.month}/" "${dateTime.year}";


  void addNewActivity(Activity newActivity , int index){
    try {
      itinerary.days[index].activities = [
        ...itinerary.days[index].activities,
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
    final newActivity = itinerary.days[dayIndex].activities[activityIndex].copy(
      activityName: activityName,
      activityTime: activityTime
    );

    try{
      itinerary.days[dayIndex].activities[activityIndex] = newActivity;
    }catch (e){
      developer.log("$e" , name : 'qqq');
    }
    notifyListeners();
  }

  void removeActivity(int dayIndex , int activityIndex){
    final currentActivities = List<Activity>.from(
        itinerary.days[dayIndex].activities
    );

    itinerary.days[dayIndex].activities = currentActivities
        ..removeAt(activityIndex);

    notifyListeners();
  }

  void editActivity({
    required int dayIndex,
    required int activityIndex,
    required Activity newActivity
  }){
    itinerary.days[dayIndex].activities[activityIndex] = newActivity;

    notifyListeners();
  }
}