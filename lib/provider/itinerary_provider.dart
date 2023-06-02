import 'package:flutter/cupertino.dart';
import 'package:iterasi1/model/activity.dart';
import 'package:iterasi1/model/day.dart';
import 'package:iterasi1/model/itinerary.dart';
import 'dart:developer' as developer;



class ItineraryProvider extends ChangeNotifier{
  late Itinerary _itinerary;
  late Itinerary initialItinerary;
  Itinerary get itinerary => _itinerary;

  bool get isDataChanged => _itinerary.toJsonString() != initialItinerary.toJsonString();

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
    List<DateTime> sortedNewDates = dates
        ..sort();

    List<DateTime> currentDates = _itinerary.days.map((e) => e.getDatetime()).toList();

    List<Day> finalDays = [];

    var i = 0;
    var j = 0;
    // Push semua currentDates yang gak ada di sortedNewDates
    while (i < sortedNewDates.length && j < currentDates.length){
      if (currentDates[j].isBefore(sortedNewDates[i]))
        j++;
      else if (currentDates[j].isAfter(sortedNewDates[i]))
        finalDays.add(Day.from(sortedNewDates[i++]));
      else {
        finalDays.add(_itinerary.days[j].copy());
        j++;
        i++;
      }
    }
    while (i < sortedNewDates.length)
      finalDays.add(Day.from(sortedNewDates[i++]));

    _itinerary.days = finalDays;

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
    required int removedHashCode
  }){
    activities.removeWhere(
      (element) => element.hashCode == removedHashCode
    );
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