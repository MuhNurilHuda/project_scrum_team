import 'package:flutter/material.dart';
import 'package:iterasi1/model/alert_save_dialog_result.dart';
import 'package:iterasi1/model/day.dart';
import 'package:iterasi1/pages/add_activities/add_activities.dart';
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

  late ScaffoldMessengerState snackbarHandler;


  @override
  Widget build(BuildContext context) {
    snackbarHandler = ScaffoldMessenger.of(context);

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
          backgroundColor: const Color(0xFFE5BA73),
          appBar: AppBar(
            title: appBarTitle,
            actions: actionIcon,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                handleBackBehaviour().whenComplete(
                  () => Navigator
                          .popUntil(
                            context,
                            ModalRoute.withName(ItineraryList.route)
                          )
                );
              },
            ),
            backgroundColor: const Color(0xFFE5BA73),
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
                          child: FutureBuilder<List<Activity>>(
                            future : itineraryProvider.getSortedActivity(
                              itineraryProvider
                                  .itinerary
                                  .days[selectedDayIndex]
                                  .activities
                            ),
                            builder : (context , snapshot) {
                              final data = snapshot.data;
                              if (data != null) {
                                return ListView.separated(
                                  padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
                                  scrollDirection: Axis.vertical,
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final currentActivity = data[index].copy();
                                    return buildActivityCard(
                                      context,
                                      data[index],
                                      onDismiss: (){
                                        itineraryProvider.removeActivity(
                                            activities: data,
                                            removedHashCode: data[index].hashCode
                                        );
                                      },
                                      onUndo: (){
                                        itineraryProvider.insertNewActivity(
                                            activities: data,
                                            newActivity: currentActivity
                                        );
                                      }
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(
                                      height: 24,
                                    );
                                  },
                                  itemCount : data.length,
                                );
                              }
                              else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }
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
                              return AddActivities(
                                onSubmit: (newActivity){
                                  itineraryProvider.insertNewActivity(
                                      activities: itineraryProvider.itinerary.days[selectedDayIndex].activities,
                                      newActivity: newActivity
                                  );
                                  dev.log("${itineraryProvider.itinerary.days[selectedDayIndex].activities.length}");
                                },
                              );
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


  Widget buildActivityCard(
      BuildContext context,
      Activity activity,
      {
        required void Function() onDismiss,
        required void Function() onUndo,
      }
  ) {
    return Dismissible(
      onDismissed: (DismissDirection direction){
        snackbarHandler.removeCurrentSnackBar();
        onDismiss();

        snackbarHandler.showSnackBar(
          SnackBar(
            content: const Text("Item dihapus!"),
            action: SnackBarAction(
                label: "Undo",
                onPressed: (){
                  onUndo();
                  snackbarHandler.removeCurrentSnackBar();
                }
            ),
          ),
        );
      },
      key: Key(activity.hashCode.toString()),
      child: InkWell(
        onTap: (){
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context){
                  return AddActivities(
                      initialActivity: activity,
                      onSubmit: (newActivity){
                        itineraryProvider.updateActivity(
                            oldActivity: activity,
                            newActivity: newActivity
                        );
                      },
                    );
                }
            )
          );
        },
        child: Container(
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
                      "${activity.startActivityTime} - ${activity.endActivityTime}",
                      style: TextStyle(
                        fontFamily: 'poppins_bold',
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
                Text(
                  activity.keterangan,
                  style: TextStyle(
                    fontFamily: 'poppins_regular',
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


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
                  child: const Text("Batal")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(AlertSaveDialogResult.saveAndQuit);
                  },
                  child: const Text("Keluar dan Simpan")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(AlertSaveDialogResult.saveWithoutQuit);
                  },
                  child: const Text(
                      "Keluar Tanpa Simpan",
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          );
        });
  }

  Future<void> saveCurrentItinerary() {
    context.loaderOverlay.show();
    return databaseProvider
        .insertItinerary(itinerary: itineraryProvider.itinerary)
        .whenComplete(() {
      Navigator.popUntil(
          context,
          ModalRoute.withName(ItineraryList.route)
      );
      context.loaderOverlay.hide();
    });
  }

  Future<bool> handleBackBehaviour() async {
    if (itineraryProvider.isDateChanged) {
      final resultSaveDialog = await showAlertSaveDialog(context);

      late bool shouldPop;

      if (resultSaveDialog == AlertSaveDialogResult.saveWithoutQuit) {
        shouldPop = true;
      } else if (resultSaveDialog == AlertSaveDialogResult.saveAndQuit) {
        await saveCurrentItinerary();
        shouldPop = true;
      } else {
        shouldPop = false;
      }
      if (shouldPop)
        snackbarHandler.removeCurrentSnackBar();
      return shouldPop;
    }
    else {
      snackbarHandler.removeCurrentSnackBar();
      return true;
    }
  }
}
