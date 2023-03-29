import 'package:flutter/cupertino.dart';
import 'package:iterasi1/model/activity.dart';
import 'package:iterasi1/model/day.dart';
import 'package:iterasi1/model/itinerary.dart';
import 'dart:developer' as developer;

class ItineraryProvider extends ChangeNotifier{
  Itinerary itinerary;

  ItineraryProvider({required this.itinerary});

  void addDay(Day newDay){
    try {
      itinerary.days = [...itinerary.days , newDay];
    } catch (e) {
      developer.log("$e" , name : 'qqq');
    }
    notifyListeners();
  }

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
        String? activityName = null,
        String? activityTime = null
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

  // void updateActivityName(Activity newActivity , int dayIndex , int activityIndex){
  //   try{
  //     itinerary.days[dayIndex].activities[activityIndex] = newActivity;
  //   }catch (e){
  //     developer.log("$e" , name : 'qqq');
  //   }
  //   notifyListeners();
  // }
  //
  // void updateActivityTime(Activity newActivity , int dayIndex , int activityIndex){
  //   try{
  //     itinerary.days[dayIndex].activities[activityIndex] = newActivity;
  //   }catch (e){
  //     developer.log("$e" , name : 'qqq');
  //   }
  //   notifyListeners();
  // }
}