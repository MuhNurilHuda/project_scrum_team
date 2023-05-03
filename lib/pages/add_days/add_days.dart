import 'package:flutter/material.dart';
import 'package:iterasi1/model/alert_save_dialog_result.dart';
import 'package:iterasi1/model/day.dart';
import 'package:iterasi1/pages/add_days/app_bar_itinerary_title.dart';
import 'package:iterasi1/pages/add_days/search_field.dart';
import 'package:iterasi1/pages/datepicker/select_date.dart';
import 'package:iterasi1/pages/itinerary_list.dart';
import 'package:iterasi1/pages/pdf/preview_pdf_page.dart';
import 'package:iterasi1/provider/database_provider.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as dev;

import '../../model/activity.dart';
import '../../provider/itinerary_provider.dart';
import 'package:collection/collection.dart';

import '../activity/activity_form.dart';

class AddDays extends StatefulWidget {
  AddDays({Key? key}) : super(key: key);

  @override
  State<AddDays> createState() => _AddDaysState();
}

class _AddDaysState extends State<AddDays> {
  // Provider
  late ItineraryProvider itineraryProvider;
  late DatabaseProvider databaseProvider;

  // State
  int selectedDayIndex = 0;
  bool isEditing = false;
  late Widget appBarTitle;
  late List<Widget> actionIcon;

  @override
  Widget build(BuildContext context) {
    itineraryProvider = Provider.of(context, listen: true);
    databaseProvider = Provider.of(context, listen: true);

    if (isEditing) {
      appBarTitle = SearchField(
        initialText: itineraryProvider.itinerary.title,
        onSubmit: (String newTitle) {
          setState(() {
            itineraryProvider.setNewItineraryTitle(newTitle);
            isEditing = false;
          });
        },
        onValueChange: (newTitle) {
          itineraryProvider.setNewItineraryTitle(newTitle);
        },
      );

      actionIcon = [];
    } else {
      appBarTitle =
          AppBarItineraryTitle(title: itineraryProvider.itinerary.title);

      actionIcon = [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            setState(() {
              isEditing = true;
            });
          },
        )
      ];
    }

    return LoaderOverlay(
      child: WillPopScope(
        onWillPop: handleBackBehaviour,
        child: Scaffold(
          backgroundColor: const Color(0xFF1C3131),
          appBar: AppBar(
            title: appBarTitle,
            actions: actionIcon,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                handleBackBehaviour();
              },
            ),
            backgroundColor: const Color(0xFF1C3131),
            elevation: 0,
          ),
          body: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(children: [
                          SizedBox(
                            height: 60,
                            child: ListView.separated(
                              padding: EdgeInsets.only(right: 24),
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return KartuTanggal(
                                    index,
                                    itineraryProvider
                                        .itinerary.days[index].date);
                              },
                              itemCount:
                                  itineraryProvider.itinerary.days.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  width: 48,
                                );
                              },
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context){
                                      return SelectDate(
                                        initialDates: itineraryProvider.itinerary.days.map(
                                                (e) => e.getDatetime()
                                        ).toList(),
                                      );
                                    }
                                  )
                                );
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFF8A700),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: const Icon(Icons.add),
                                ),
                              ),
                            ),
                          )
                        ]),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        // Expanded(
                        //     child: Padding(
                          //   padding: const EdgeInsets.only(bottom: 65),
                          //   child: SingleChildScrollView(
                          //     scrollDirection: Axis.horizontal,
                          //     physics: const BouncingScrollPhysics(),
                          //     child: SingleChildScrollView(
                          //         physics: const BouncingScrollPhysics(),
                          //         child:
                          //             buildDataTable(context, selectedDayIndex)),
                          //   ),
                        //  )
                        // )
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(bottom: 65),
                          child: ListView.separated(
                            padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return buildActivityCard(
                                  context,
                                  itineraryProvider.itinerary.days[selectedDayIndex].activities[index]
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: 24,
                              );
                            },
                            itemCount: itineraryProvider.itinerary.days[selectedDayIndex].activities.length,
                          ),
                        ))
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 15),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(children: [
                    Expanded(
                      child: Container(
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
                            height: 60,
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
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
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
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor: const MaterialStatePropertyAll(
                                Color.fromARGB(255, 255, 185, 33))),
                        onPressed: saveCurrentItinerary,
                        child: const Icon(Icons.save),
                      ),
                    ),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget KartuTanggal(int index, String tanggal) {
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
    final columns = ['Time', 'Activity', ""];

    return Column(children: [
      DataTable(
        columns: getColumns(columns),
        rows: getRows(
            itineraryProvider.itinerary.days[index].activities, index, context),
      ),
    ]);
  }

  Widget buildActivityCard(BuildContext context, Activity activity) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xFFFFB252),
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              activity.activityName,
              textAlign: TextAlign.left,
              style: TextStyle(fontFamily: 'poppins_bold', fontSize: 24),
            ),
            Row(
              children: [
                Icon(Icons.timer),
                Text(
                  activity.activityTime,
                  style: TextStyle(
                    fontFamily: 'poppins_bold',
                    fontSize: 15,
                  ),
                )
              ],
            ),
            Text(
              'Raincoat, 2 layer jackets, Gloves, Mask, Medication (optional)',
              style: TextStyle(
                fontFamily: 'poppins_regular',
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }

  String formatTime(TimeOfDay time) {
    return "${time.hour}:${time.minute}";
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {
      final id = column == columns[0];

      return DataColumn(
        label: SizedBox(width: 100, child: Text(column)),
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

  Future<AlertSaveDialogResult?> showAlertSaveDialog(BuildContext context) {
    return showDialog<AlertSaveDialogResult?>(
        // Nilai yang direturn adalah Future<HasilPop>
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text("Yakin ingin kembali?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(AlertSaveDialogResult.cancel);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(AlertSaveDialogResult.saveAndQuit);
                  },
                  child: const Text("Save and Quit")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(AlertSaveDialogResult.saveWithoutQuit);
                  },
                  child: const Text("Quit Without Saving"))
            ],
          );
        });
  }

  Future<void> saveCurrentItinerary() {
    context.loaderOverlay.show();
    return databaseProvider
        .insertItinerary(itinerary: itineraryProvider.itinerary)
        .whenComplete(() {
      Navigator.popUntil(context, ModalRoute.withName(ItineraryList.route));
      context.loaderOverlay.hide();
    });
  }

  Future<bool> handleBackBehaviour() async {
    final resultSaveDialog = await showAlertSaveDialog(context);

    late bool shouldPop;

    if (resultSaveDialog == AlertSaveDialogResult.saveWithoutQuit) {
      dev.log("save without quit");
      shouldPop = true;
    } else if (resultSaveDialog == AlertSaveDialogResult.saveAndQuit) {
      await saveCurrentItinerary();
      shouldPop = true;
    } else {
      shouldPop = false;
    }
    if (shouldPop)
      Navigator.popUntil(context, ModalRoute.withName(ItineraryList.route));
    return false;
  }
}
