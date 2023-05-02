import 'package:flutter/material.dart';
import 'package:iterasi1/model/activity.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import '../../provider/itinerary_provider.dart';
import 'activity_form.dart';

class AddActivities extends StatelessWidget {
  final int dayIndex;

  AddActivities({Key? key, required this.dayIndex}) : super(key: key);

  late ItineraryProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Plan'),
        backgroundColor: const Color(0xFF1C3131),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ActivityForm(dayIndex: dayIndex);
              }));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: buildDataTable(context),
        ),
      ),
    );
  }

  Widget buildDataTable(BuildContext context) {
    final columns = ['Waktu Aktivitas', 'Nama Aktivitas', ""];

    return Column(children: [
      DataTable(
        columns: getColumns(columns),
        rows: getRows(
            provider.itinerary.days[dayIndex].activities,
            context
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
  List<DataRow> getRows(List<Activity> activities , BuildContext context) =>
      activities.mapIndexed((int activityIndex , Activity activity) {
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
                  provider.removeActivity(dayIndex, activityIndex);
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
