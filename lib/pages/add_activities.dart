import 'package:flutter/material.dart';
import 'package:iterasi1/model/activity.dart';
import 'package:iterasi1/utilities/utils.dart';
import 'package:iterasi1/widget/scrollable_widget.dart';
import 'package:iterasi1/widget/text_dialog.dart';
import 'package:iterasi1/model/day.dart';
import 'package:uuid/uuid.dart';

class ItineraryTable extends StatefulWidget {
  const ItineraryTable({
    Key? key,
    required this.addDay ,
    required this.updateNewActivities
  }) : super(key: key);
  final Day addDay;
  final Function(List<Activity> newActivities) updateNewActivities;


  @override
  _ItineraryTableState createState() => _ItineraryTableState(
      updateNewActivities: updateNewActivities,
      activities: addDay.activities,
      idDay: addDay.id
  );
}

class _ItineraryTableState extends State<ItineraryTable> {
  final Function(List<Activity> newActivities) updateNewActivities;
  final String idDay;

  _ItineraryTableState({
    required this.updateNewActivities ,
    required this.activities,
    required this.idDay
  });

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
    body: ScrollableWidget(child: buildDataTable()),
  );
  Widget buildDataTable(){
    final columns = ['Waktu Aktivitas', 'Nama Aktivitas'];
    print("Back To old Screen");
    return Column(
      children: [
        DataTable(
          columns: getColumns(columns),
          rows: getRows(activities),
        ),
        InkWell(
          onTap: (){
            setState(() {
              activities.add(
                  Activity(
                      idDay: idDay,
                      id: uuid.v1(),
                      activityName: "",
                      activityTime: ""
                  )
              );
            });
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
        ]
    );
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

  List<DataRow> getRows(List<Activity> activities) => activities.map((Activity activity) {
    final cells = [activity.activityTime, activity.activityName];
    
    return DataRow(
      cells: Utils.modelBuilder(cells, (index, cell) {
        final showEditIcon = index == 0 || index == 1;

        return DataCell(
          Text('$cell'),
          showEditIcon: showEditIcon,
          onTap: () {
            switch (index) {
              case 0:
                editActivityTime(activity);
                break;
              case 1:
                editActivityName(activity);
                break;
            }
          }
        );
      }),
    );
  }).toList();

  Future editActivityName(Activity editActivity) async {
    final activity_name = await showTextDialog(
      context,
      title: 'Nama Aktivitas',
      value: editActivity.activityName,
    );

    setState(() => activities = activities.map((activity) {
      final isEditActivity = activity == editActivity;

      return isEditActivity ? activity.copy(activityName: activity_name) : activity;
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

      return isEditActivity ? activity.copy(activityTime: activityTime) : activity;
    }).toList());
  }
}
