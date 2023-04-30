import 'package:flutter/material.dart';
import 'package:iterasi1/model/day.dart';
import 'package:iterasi1/pages/activity/add_activities.dart';
import 'package:iterasi1/pages/pdf/preview_pdf_page.dart';
import 'package:iterasi1/provider/database_provider.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:iterasi1/model/itinerary.dart';

import '../model/activity.dart';
import '../provider/itinerary_provider.dart';
import 'package:collection/collection.dart';

import 'activity/activity_form.dart';

class AddDays extends StatefulWidget {
  AddDays({Key? key}) : super(key: key);

  @override
  State<AddDays> createState() => _AddDaysState();
}

class _AddDaysState extends State<AddDays> {
  late ItineraryProvider itineraryProvider;

  late DatabaseProvider databaseProvider;

  int selectedDayIndex = 0;

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    itineraryProvider = Provider.of(context, listen: true);
    databaseProvider = Provider.of(context, listen: true);

    return LoaderOverlay(
      child: Scaffold(
        backgroundColor: const Color(0xFF1C3131),
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
        body: Stack(
          children: [
            ClipRRect(
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
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return kartuTanggal(index,
                                itineraryProvider.itinerary.days[index].date);
                          },
                          itemCount: itineraryProvider.itinerary.days.length,
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Expanded(
                          flex: 10,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 65.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: buildDataTable(
                                      context, selectedDayIndex)),
                            ),
                          ))
                    ]),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 185, 33),
                        borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ActivityForm(dayIndex: selectedDayIndex);
                        }));
                      },
                      child: SizedBox(
                        height: 45,
                        width: 200,
                        child: Card(
                          color: const Color.fromARGB(255, 255, 185, 33),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 0,
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text('Add New Activity',
                                style: TextStyle(
                                    fontFamily: 'poppins_bold',
                                    fontSize: 16,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 55,
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: const MaterialStatePropertyAll(
                            Color.fromARGB(255, 255, 185, 33))),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (builder) => PdfPreviewPage(
                              itinerary: itineraryProvider.itinerary),
                        ),
                      );
                    },
                    child: const Icon(Icons.print),
                  ),
                ),
                Container(
                  height: 55,
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor: const MaterialStatePropertyAll(
                            Color.fromARGB(255, 255, 185, 33))),
                    onPressed: () {
                      context.loaderOverlay.show();
                      databaseProvider
                          .insertItinerary(
                              itinerary: Itinerary(
                                  id: itineraryProvider.itinerary.id,
                                  title: itineraryProvider.itinerary.title,
                                  days: itineraryProvider.itinerary.days))
                          .whenComplete(() {
                        context.loaderOverlay.hide();
                        // refreshPreviousPage();
                        // Navigator.pop(context);
                        Navigator.popUntil(context, ModalRoute.withName('/next'));
                      });
                    },
                    child: const Icon(Icons.save),
                  ),
                ),
              ]),
            )
          ],
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
                        return AddActivities(dayIndex: index);
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

  Widget kartuTanggal(int index, String tanggal) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedDayIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: index == selectedDayIndex
              ? const Border(
                  bottom: BorderSide(
                  width: 2.0,
                  color: Color(0xFFF8A700),
                ))
              : null,
        ),
        child: Card(
          // color: index == selectedDayIndex ? Color(0xFF00FF46) : Colors.white,
          margin: const EdgeInsets.all(5),
          elevation: 0,
          child: SizedBox(
            height: 100,
            width: 100,
            child: Column(
              children: [
                Text(
                  'Day ${index + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'poppins_bold',
                    color: index == selectedDayIndex
                        ? const Color(0xFFF8A700)
                        : Colors.black,
                  ),
                ),
                Text(
                  tanggal,
                  style: TextStyle(
                    fontFamily: 'poppins_regular',
                    color: index == selectedDayIndex
                        ? const Color(0xFFF8A700)
                        : Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
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

  Widget buildDataTable(BuildContext context, index) {
    final columns = ['Waktu Aktivitas', 'Nama Aktivitas', ""];

    return Column(children: [
      DataTable(
        columns: getColumns(columns),
        rows: getRows(
            itineraryProvider.itinerary.days[index].activities, index, context),
      ),
    ]);
  }

  String formatTime(TimeOfDay time) {
    return "${time.hour}:${time.minute}";
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {
      final id = column == columns[0];

      return DataColumn(
        label: Text(column),
        numeric: id,
      );
    }).toList();
  }

  List<DataRow> getRows(
          List<Activity> activities, int dayIndex, BuildContext context) =>
      activities.mapIndexed((int activityIndex, Activity activity) {
        return DataRow(cells: [
          DataCell(SizedBox(
            width: double.infinity,
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.activityTime,
                ),
              ],
            ),
          )),
          DataCell(SizedBox(
            width: 100,
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  activity.activityName,
                ),
              ],
            ),
          )),
          DataCell(Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ActivityForm(
                      dayIndex: dayIndex,
                      initialActivity: activity,
                      activityIndex: activityIndex,
                    );
                  }));
                },
                child: const Icon(Icons.edit),
              ),
              InkWell(
                onTap: () {
                  itineraryProvider.removeActivity(dayIndex, activityIndex);
                },
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              )
            ],
          )),
        ]);
      }).toList();
}
