import 'package:flutter/material.dart';
import 'package:iterasi1/model/day.dart';
import 'package:iterasi1/pages/itinerary_table.dart';
import 'package:iterasi1/pages/pdf/preview_pdf_page.dart';
import 'package:iterasi1/pages/paket_wisata.dart';

import '../model/activity_list.dart';

class AddItinerary extends StatefulWidget {
  @override
  State<AddItinerary> createState() => _AddItineraryState();
}

class _AddItineraryState extends State<AddItinerary> {
  // int _currentIndex = 1;
  final List<Day> days = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: const Color(0xFF1C3131),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                child: const Icon(Icons.save),
                onPressed: () {

                },
              ),
              const SizedBox(height: 16,),
              FloatingActionButton(
                child: const Icon(Icons.print),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (builder) => PdfPreviewPage(days: days),
                    ),
                  );
                },
              ),
            ],
          ),
          appBar: AppBar(
            title: const Text(
              'Add Itinerary',
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: const Color(0xFF1C3131),
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
    );
  }

  Widget listItem(int index) {
    return SizedBox(
      width: 200,
      height: 100,
      child: Container(
        padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
        child: Card(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 5.0, 0, 3.0),
                  child: Text(
                    days[index].date,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ),
                InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (builder) {
                        return ItineraryTable(
                            add_day: days[index],
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
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        const Card(
                          child: Icon(Icons.add),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 4.0, 0),
                          child: const Text(
                            "Tambah Aktivitas",
                            style: TextStyle(color: Colors.white),
                          ),
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
              days.add(Day(date: formatDate(choosenDate)));
            });
          }
        },
        child: SizedBox(
          height: 50,
          child: Container(
            padding: const EdgeInsets.fromLTRB(75, 5, 75, 5),
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
