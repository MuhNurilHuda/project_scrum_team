import 'dart:typed_data';

import 'package:iterasi1/model/itinerary.dart';
import 'package:pdf/widgets.dart';

Future<Uint8List> makePdf(Itinerary itinerary) async {
  final pdf = Document();
  pdf.addPage(Page(
    build: (context) => Column(
      children: [
        Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                itinerary.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                )
              )
            ]
        ),
        ...itinerary.days
          .map((day) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(day.date,
              style:
              TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Table.fromTextArray(
            headerAlignment: Alignment.center,
            cellAlignment: Alignment.centerLeft,
            columnWidths: {0: FixedColumnWidth(30)},
            headerStyle: TextStyle(fontWeight: FontWeight.bold),
            cellStyle: TextStyle(height: 1.5),
            data: [
              ['Time', 'Activity'],
              ...day.activities.map((activity) => [
                activity.activityTime,
                activity.activityName,
              ])
            ],
          ),
          SizedBox(height: 20),
        ],
      )).toList()
  ],
    ),
  ));
  return pdf.save();
}
