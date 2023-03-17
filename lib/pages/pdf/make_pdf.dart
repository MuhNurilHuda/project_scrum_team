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
                                          Text("\t${activity.activity_time} "),
                                          Text(activity.activity_name)
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