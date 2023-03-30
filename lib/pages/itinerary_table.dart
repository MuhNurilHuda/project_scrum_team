import 'package:flutter/material.dart';
import 'package:iterasi1/widget/text_dialog.dart';
import 'package:iterasi1/model/day.dart';
import 'package:uuid/uuid.dart';

import '../form.dart';
import '../model/activity.dart';

class ItineraryTable extends StatefulWidget {
  const ItineraryTable(
      {Key? key, required this.add_day, required this.updateNewActivities})
      : super(key: key);
  final Day add_day;
  final Function(List<Activity> newActivities) updateNewActivities;

  @override
  _ItineraryTableState createState() => _ItineraryTableState(
      updateNewActivities: updateNewActivities, activities: add_day.activities);
}

class _ItineraryTableState extends State<ItineraryTable> {
  final Function(List<Activity> newActivities) updateNewActivities;
  _ItineraryTableState(
      {required this.updateNewActivities, required this.activities});

  final uuid = Uuid();
  List<Activity> activities;
  // late DatabaseHelper databaseHelper;

  @override
  void dispose() {
    updateNewActivities(activities);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        // backgroundColor: Color(0xFF1C3131),
        appBar: AppBar(
          title: Text('Activity Plan'),
          backgroundColor: Color(0xFF1C3131),
          elevation: 0,
          actions: [
            // saveActivities(),
          ],
        ),
        body: ListView(scrollDirection: Axis.vertical, children: [
          buildDataTable(),
        ]),
      );
  Widget buildDataTable() {
    final columns = ['Waktu Aktivitas', 'Nama Aktivitas', ''];
    print("Back To old Screen");
    return Column(children: [
      DataTable(
        columns: getColumns(columns),
        rows: getRows(activities),
      ),
      InkWell(
        onTap: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ActivityForm(
              setParentState: (newActivity) {
                setState(() {
                  activities.add(newActivity);
                });
              },
            );
          }));
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
                    "Tambah Aktivitas",
                  ),
                ],
              ),
            ),
          ),
        ),
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

  List<DataRow> getRows(List<Activity> activities) =>
      activities.map((Activity activity) {
        // final showEditIcon = index == 2;
        final cells = [
          activity.activityTime,
          activity.activityName,
          const Icon(Icons.edit),
        ];
        // final cells = [
        //   DataCell(
        //     Text(
        //       activity.activity_time.toString(),
        //       textAlign: TextAlign.left,
        //     ),
        //   ),
        //   DataCell(Text(
        //     activity.activity_name.toString(),
        //     textAlign: TextAlign.start,
        //   )),
        //   DataCell(showEditIcon: showE)
        // ];

        return DataRow(

          cells: [
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
                  onTap: () {},
                  child: const Icon(Icons.edit)),
              // const SizedBox(width: 5),
              // Text("Edit"),
            ],
          ))
        ]
            // cells: Utils.modelBuilder(cells, (index, cell) {
            //   final showEditIcon = index == 2;

            //   return DataCell(
            //       Text(
            //         '$cell',
            //         textAlign: TextAlign.left,
            //       ),
            //       showEditIcon: showEditIcon,
            //       onTap: () {
            //     // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //     //   return ActivityForm(setParentState: (newState) {
            //     //     setState(() {
            //     //        = newState;
            //     //     });
            //     //   })
            //     // }));
            //     switch (index) {
            //       case 0:
            //         editActivityTime(activity);
            //         break;
            //       case 1:
            //         editActivityName(activity);
            //         break;
            //     }
            //   });
            // }),
            );
      }).toList();

  Future editActivityName(Activity editActivity) async {
    final activityName = await showTextDialog(
      context,
      title: 'Nama Aktivitas',
      value: editActivity.activityName,
    );

    setState(() => activities = activities.map((activity) {
          final isEditActivity = activity == editActivity;

          return isEditActivity
              ? activity.copy(activityName: activityName)
              : activity;
        }).toList());
  }

  Future editActivityTime(Activity editActivity) async {
    final activityTime = await showTextDialog(
      context,
      title: 'Waktu Aktivitas',
      value: editActivity.activityTime,
    );

    setState(() => activities = activities.map((activity) {
          final isEditActivity = activity == editActivity;

          return isEditActivity
              ? activity.copy(activityTime: activityTime)
              : activity;
        }).toList());
  }
}
