import 'package:flutter/material.dart';
import 'package:iterasi1/model/activity.dart';
import 'package:iterasi1/pages/provider/itinerary_provider.dart';
import 'package:iterasi1/widget/scrollable_widget.dart';
import 'package:iterasi1/widget/text_dialog.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';

class ItineraryTable extends StatelessWidget {
  final int dayIndex;

  ItineraryTable({
    Key? key,
    required this.dayIndex
  }) : super(key: key);


  late ItineraryProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context , listen : true);

    return Scaffold(
      // backgroundColor: Color(0xFF1C3131),
      appBar: AppBar(
        title: Text('Activity Plan'),
        backgroundColor: Color(0xFF1C3131),
        elevation: 0,
      ),
      body: ScrollableWidget(
          child: buildDataTable(context)
      ),
    );
  }

    Widget buildDataTable(BuildContext context){
      final columns = ['Waktu Aktivitas', 'Nama Aktivitas'];

      return Column(
          children: [
            DataTable(
              columns: getColumns(columns),
              rows: getRows(
                provider.itinerary.days[dayIndex].activities,
                context
              ),
            ),
            InkWell(
              onTap: (){
                provider.addNewActivity(
                    Activity(activityName: "", activityTime: ""),
                    dayIndex
                );
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

    List<DataRow> getRows(
        List<Activity> activities,
        BuildContext context
    ) => activities.mapIndexed(
        (int activityIndex , Activity activity) {
          return DataRow(
              cells: [
                DataCell(
                    Text(activity.activityTime),
                    showEditIcon: true,
                    onTap: () {
                      editActivityTime(
                          activity.activityTime,
                          activityIndex,
                          context
                      );
                    }
                ),
                DataCell(
                    Text(activity.activityName),
                    showEditIcon: true,
                    onTap: () {
                      editActivityName(
                          activity.activityName,
                          activityIndex,
                          context
                      );
                    }
                )
              ]
          );
        }
    ).toList();

    Future editActivityName(
        String initialText,
        int activityIndex,
        BuildContext context
    ) async {
      final activityName = await showTextDialog(
        context,
        title: 'Nama Aktivitas',
        value: initialText,
      );

      provider.updateActivity(
          dayIndex,
          activityIndex,
          activityName: activityName
      );
    }

    Future editActivityTime(
        String initialText,
        int activityIndex,
        BuildContext context
    ) async {
      final activityTime = await showTextDialog(
        context,
        title: 'Waktu Aktivitas',
        value: initialText,
      );

      provider.updateActivity(
          dayIndex,
          activityIndex,
          activityTime: activityTime
      );
    }
}
