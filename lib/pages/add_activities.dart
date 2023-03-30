import 'package:flutter/material.dart';
import 'package:iterasi1/model/activity.dart';
import 'package:iterasi1/pages/provider/itinerary_provider.dart';
import 'package:provider/provider.dart';
import 'activity_form.dart';

class ItineraryTable extends StatelessWidget {
  final int dayIndex;

  ItineraryTable({
    Key? key,
    required this.dayIndex
  }) : super(key: key);


  late ItineraryProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context , listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Plan'),
        backgroundColor: const Color(0xFF1C3131),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) {
                        return ActivityForm(dayIndex: dayIndex);
                      }
                  )
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView(children: [buildDataTable()]),
    );
  }

  Widget buildDataTable() {
    final columns = ['Waktu Aktivitas', 'Nama Aktivitas' , ""];

    return Column(
        children: [
          DataTable(
            columns: getColumns(columns),
            rows: getRows(provider.itinerary.days[dayIndex].activities),
          ),
        ]
    );
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
        final cells = [
          activity.activityTime,
          activity.activityName,
          const Icon(Icons.edit),
        ];

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
                ],
              ))
            ]
        );
      }).toList();
}
