import 'package:flutter/material.dart';
import 'package:iterasi1/database/database_service.dart';
import '../model/itinerary.dart';

class DatabaseProvider extends ChangeNotifier{

  final _dbService = DatabaseService();

  late Future<List<Itinerary>> _itineraryDatas;
  Future<List<Itinerary>> get itineraryDatas{
    return _itineraryDatas;
  }
  DatabaseProvider(){
    refreshData();
  }

  void refreshData({
    String filterItineraryName = ""
  }){
    _itineraryDatas = _dbService.fetchItineraries(
      filterItineraryName: filterItineraryName
    );
    notifyListeners();
  }

  Future<void> deleteItinerary({required Itinerary itinerary}) async{
    await _dbService.deleteItinerary(itinerary.id);
    refreshData();
  }

  Future<void> insertItinerary({required Itinerary itinerary}) async {
    await _dbService.insertItinerary(itinerary);
    refreshData();
  }
}