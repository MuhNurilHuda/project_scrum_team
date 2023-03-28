import 'dart:typed_data';

import 'package:iterasi1/model/day.dart';
import 'package:pdf/widgets.dart';

Future<Uint8List> makePdf(List<Day> days) async {
  final pdf = Document();
  pdf.addPage(
      Page(
          build : (context) =>
              Column(
                  children: days.map((day) =>
                      Column(
                          children: [
                            Text(day.date),
                            Column(
                                children: day.activities.map((activity) =>
                                    Row(
                                        children: [
                                          Text("\t${activity.activityTime} "),
                                          Text("\t\t\t\t\t\t\t${activity.activityName}"),
                                        ]
                                    )
                                ).toList()
                            )
                          ]
                      )
                  ).toList()
              )
      )
  );

  return pdf.save();
}