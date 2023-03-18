import 'package:flutter/material.dart';
import 'package:iterasi1/model/activity_list.dart';
import 'package:iterasi1/utilities/utils.dart';
import 'package:iterasi1/widget/scrollable_widget.dart';
import 'package:iterasi1/widget/text_dialog.dart';
import 'package:iterasi1/model/day.dart';
import 'package:uuid/uuid.dart';

class ItineraryTable extends StatefulWidget {
  const ItineraryTable({Key? key, required this.add_day , required this.updateNewActivities}) : super(key: key);
  final Day add_day;
  final Function(List<Activity> newActivities) updateNewActivities;


  @override
  _ItineraryTableState createState() => _ItineraryTableState(
      updateNewActivities: updateNewActivities,
      activities: add_day.activities
  );
}

class _ItineraryTableState extends State<ItineraryTable> {
  final Function(List<Activity> newActivities) updateNewActivities;
  _ItineraryTableState({required this.updateNewActivities , required this.activities});

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
    appBar: AppBar(
      title: Text('Activity Plan'),
      backgroundColor: Colors.lightBlue[900],
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
              activities.add(Activity(
                  id: uuid.v1(),
                  activity_name: "",
                  activity_time: ""
              ));
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
                      "Tambah Hari",
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
    final cells = [activity.activity_time, activity.activity_name];
    
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
