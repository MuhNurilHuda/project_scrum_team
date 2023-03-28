import 'package:flutter/material.dart';
import 'package:iterasi1/database/database_service.dart';
import 'package:iterasi1/model/day.dart';
import 'package:iterasi1/pages/add_activities.dart';
import 'package:iterasi1/pages/pdf/preview_pdf_page.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:uuid/uuid.dart';

import '../model/activity.dart';
import '../model/itinerary.dart';

class AddItinerary extends StatefulWidget {
  @override
  State<AddItinerary> createState() => _AddItineraryState();
}

class _AddItineraryState extends State<AddItinerary> {
  // int _currentIndex = 1;
  final idItinerary = Uuid().v1();
  final List<Day> days = [];
  var isAddingData = false;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: LoaderOverlay(
        child: Scaffold(
            backgroundColor: Color(0xFF1C3131),
            floatingActionButton: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  onPressed: (){
                    context.loaderOverlay.show();

                    final dbService = DatabaseService();

                    final List<void Function()> batchOperations = [];
                    batchOperations.add(() {
                      dbService.insertItinerary(
                          Itinerary(id: idItinerary, title: "Contoh Judul")
                      );
                    });
                    for (var day in days) {
                      batchOperations.add(() {
                        dbService.insertDay(day);
                      });
                      for (var activity in day.activities){
                        batchOperations.add(() {
                          dbService.insertActivity(activity);
                        });
                      }
                    }

                    dbService.executeNewBatch(batchOperations).whenComplete((){
                      context.loaderOverlay.hide();
                    });
                    
                  },
                  child: Icon(Icons.save),
                ),
                FloatingActionButton(
                  child: Icon(Icons.print),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (builder) => PdfPreviewPage(days: days),
                      ),
                    );
                  },
                )
              ]
            ),
            appBar: AppBar(
              title: const Text(
                'Add Itinerary',
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Color(0xFF1C3131),
              elevation: 0,
            ),
            body: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return index == days.length
                    ? addNewDayButton()
                    : listItem(index);
              },
              itemCount: days.length + 1,
            ),
        ),
      ),
    );
  }

  Widget listItem(int index) {
    return SizedBox(
      height: 80,
      child: Container(
        padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
        child: Card(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(days[index].date),
                InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (builder) {
                        return ItineraryTable(
                            addDay: days[index],
                            updateNewActivities: (newActivities){
                              setState(() {
                                days[index].activities = newActivities;
                              });
                            },
                        );
                      }));
                    },
                    child: Card(
                      // color: Color(0x1C3131),
                      color: Colors.grey,
                      elevation: 0,
                      child: Row(mainAxisSize: MainAxisSize.min, children: const [
                        Card(
                          child: const Icon(Icons.add),
                        ),
                        Text(
                          "Tambah Aktivitas",
                          style: TextStyle(color: Colors.white),
                        ),
                      ]),
                    )),
              ],
            )),
      ),
    );
  }

  Widget addNewDayButton() => InkWell(
        onTap: () async {
          final choosenDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2023),
              lastDate: DateTime(2100)
          );

          if (choosenDate != null) {
            setState(() {
              days.add(
                  Day(
                    idItinerary: idItinerary,
                    id: const Uuid().v1(),
                    date: formatDate(choosenDate)
                  )
              );
            });
          }
        },
        child: SizedBox(
          height: 50,
          child: Container(
            padding: EdgeInsets.fromLTRB(75, 5, 75, 5),
            child: Card(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Card(
                    child: Icon(Icons.add),
                  ),
                  Text(
                      "Tambah Hari",
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  String getMonthString(int intMonth) {
    switch (intMonth) {
      case 1:
        return "Januari";
      default:
        return "Desember";
    }
  }

  void updateActivitiesDay(int index , List<Activity> newActivities){
    setState(() {
      days[index].activities = newActivities;
    });
  }
}
