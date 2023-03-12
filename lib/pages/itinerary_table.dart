import 'package:flutter/material.dart';
import 'package:iterasi1/database/database.dart';
import 'package:iterasi1/model/activity_list.dart';
import 'package:iterasi1/utilities/utils.dart';
import 'package:iterasi1/widget/scrollable_widget.dart';
import 'package:iterasi1/widget/text_dialog.dart';
import 'package:iterasi1/database/activities.dart';

class ItineraryTable extends StatefulWidget {
  @override
  _ItineraryTableState createState() => _ItineraryTableState();
}

class _ItineraryTableState extends State<ItineraryTable> {
  late List<Activity> activities;
  // late DatabaseHelper databaseHelper;

  get isEditActivity => null;

  @override
  void initState() {
    super.initState();

    this.activities = List.of(allActivities);
    // this.databaseHelper = databaseHelper;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Activity Plan'),
      backgroundColor: Colors.deepPurpleAccent,
      actions: [
        // saveActivities(),
      ],
    ),
    body: ScrollableWidget(child: buildDataTable()),
  );
  Widget buildDataTable(){
    final columns = ['id', 'Waktu Aktivitas', 'Nama Aktivitas'];

    return DataTable(
      columns: getColumns(columns),
      rows: getRows(activities),
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
    final cells = [activity.id, activity.activity_time, activity.activity_name];
    
    return DataRow(
      cells: Utils.modelBuilder(cells, (index, cell) {
        final showEditIcon = index == 1 || index == 2;

        return DataCell(
          Text('$cell'),
          showEditIcon: showEditIcon,
          onTap: () {
            switch (index) {
              case 1:
                editActivityTime(activity);
                break;
              case 2:
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
      value: editActivity.activity_name,
    );

    setState(() => activities = activities.map((activity) {
      final isEditActivity = activity == editActivity;

      return isEditActivity ? activity.copy(activity_name: activity_name) : activity;
    }).toList());
  }

  Future editActivityTime(Activity editActivity) async {
    final activity_time = await showTextDialog(
      context,
      title: 'Waktu Aktivitas',
      value: editActivity.activity_time,
    );

    setState(() => activities = activities.map((activity) {
      final isEditActivity = activity == editActivity;

      return isEditActivity ? activity.copy(activity_time: activity_time) : activity;
    }).toList());
  }

  // void initializeDatabaseHelper() {
  //   databaseHelper = DatabaseHelper();
  //
  //   if(databaseHelper == null){
  //     initializeDatabaseHelper();
  //   }
  // }
  //
  // void _saveActivities() async {
  //   for (var activity in activities) {
  //     if(activity.id == null){
  //       await DatabaseHelper.insertActivity(activity);
  //     }
  //     else {
  //       await DatabaseHelper.updateActivity(activity);
  //     }
  //   }
  // }
  //
  // Widget saveActivities() => TextButton(
  //   onPressed: _saveActivities,
  //   child: Text(
  //     'Save'
  //   ),
  // );
}
