import 'package:flutter/material.dart';
import 'package:iterasi1/database/database_service.dart';
import 'package:iterasi1/model/day.dart';
import 'package:iterasi1/pages/activity/add_activities.dart';
import 'package:iterasi1/pages/pdf/preview_pdf_page.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import '../model/itinerary.dart';
import '../provider/itinerary_provider.dart';

class AddItinerary extends StatelessWidget {
  late ItineraryProvider itineraryProvider;

  final Function() refreshPreviousPage;
  AddItinerary({required this.refreshPreviousPage});
  DateTimeRange dateRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  @override
  Widget build(BuildContext context) {
    itineraryProvider = Provider.of(context, listen: true);
    final start = dateRange.start;
    final end = dateRange.end;

    return MaterialApp(
      home: LoaderOverlay(
        child: Scaffold(
          backgroundColor: const Color(0xFF1C3131),
          floatingActionButton:
              Column(mainAxisSize: MainAxisSize.min, children: [
            FloatingActionButton(
              backgroundColor: const Color(0xFF39B400),
              onPressed: () {
                context.loaderOverlay.show();

                final dbService = DatabaseService();

                dbService
                    .insertItinerary(Itinerary(
                        id: itineraryProvider.itinerary.id,
                        title: itineraryProvider.itinerary.title,
                        days: itineraryProvider.itinerary.days))
                    .whenComplete(() {
                  context.loaderOverlay.hide();
                  refreshPreviousPage();
                  Navigator.pop(context);
                });
              },
              child: const Icon(Icons.save),
            ),
            const SizedBox(
              height: 16,
            ),
            FloatingActionButton(
              backgroundColor: const Color(0xFF39B400),
              child: const Icon(Icons.print),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (builder) =>
                        PdfPreviewPage(itinerary: itineraryProvider.itinerary),
                  ),
                );
              },
            )
          ]),
          appBar: AppBar(
            title: Text(
              'Itinerary to ${itineraryProvider.itinerary.title}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              // itineraryProvider.itinerary.title,
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: const Color(0xFF1C3131),
            elevation: 0,
          ),
          body: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(15.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Row(
                            children: [
                              // SizedBox(
                              //   height: 50,
                              //   child: Container(
                              //     padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                              //     child: Card(
                              //       color: Colors.white70,
                              //       child: Row(
                              //         mainAxisAlignment: MainAxisAlignment.center,
                              //         crossAxisAlignment: CrossAxisAlignment.center,
                              //         children: const[

                              //           Card(
                              //             child: Icon(Icons.add),
                              //           ),
                              //           Text(
                              //             'Pilih Tanggal',
                              //             style: TextStyle(
                              //               color: Colors.black,
                              //             ),
                              //           )
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // )
                              Card(
                                margin: EdgeInsets.all(5),
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Column(
                                    children: [
                                      Text(
                                        'Day 1',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text('16 Apr')
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                margin: EdgeInsets.all(5),
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Column(
                                    children: [
                                      Text(
                                        'Day 2',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text('17 Apr')
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                margin: const EdgeInsets.all(5),
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Column(
                                    children: [
                                      Text(
                                        'Day 3',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text('18 Apr')
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                margin: EdgeInsets.all(5),
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Column(
                                    children: [
                                      Text(
                                        'Day 5',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text('19 Apr')
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                margin: EdgeInsets.all(5),
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Column(
                                    children: [
                                      Text(
                                        'Day 5',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text('20 Apr')
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                margin: EdgeInsets.all(5),
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Column(
                                    children: [
                                      Text(
                                        'Day 6',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text('21 Apr')
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    Expanded(
                      flex: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return index ==
                                        itineraryProvider.itinerary.days.length
                                    ? addNewDayButton(context)
                                    : listItem(index, context);
                              },
                              itemCount:
                                  itineraryProvider.itinerary.days.length + 1,
                            ),
                          )
                        ],
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget listItem(int index, BuildContext context) {
    return SizedBox(
      height: 80,
      child: Container(
        padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
        child: Card(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(itineraryProvider.itinerary.days[index].date),
                InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (builder) {
                        return ItineraryTable(dayIndex: index);
                      }));
                    },
                    child: Card(
                      // color: Color(0x1C3131),
                      color: Colors.grey,
                      elevation: 0,
                      child:
                          Row(mainAxisSize: MainAxisSize.min, children: const [
                        Card(
                          child: Icon(Icons.add),
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

  Widget addNewDayButton(BuildContext context) => InkWell(
        onTap: () async {
          final choosenDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2023),
              lastDate: DateTime(2100));

          if (choosenDate != null) {
            itineraryProvider.addDay(Day(date: formatDate(choosenDate)));
          }
        },
        child: SizedBox(
          height: 70,          
          child: Container(
            padding: const EdgeInsets.fromLTRB(75, 5, 75, 5),
            child: Card(
              color: const Color(0xFFFFB252),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Card(
                    child: Icon(Icons.add),
                  ),
                  Text(
                    "Tambah Aktivitas",
                    style: TextStyle(
                      color: Colors.white,
                    ),
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
      case 2:
        return "Februari";
      default:
        return "Desember";
    }
  }
}
