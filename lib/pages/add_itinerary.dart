import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iterasi1/model/day.dart';
import 'package:iterasi1/database/dbhelper.dart';

import 'itinerary_table.dart';

class AddItinerary extends StatefulWidget {
  final Map? data;

  AddItinerary({this.data});

  @override
  State<AddItinerary> createState() => _AddItineraryState(this.data);
}

class _AddItineraryState extends State<AddItinerary> {
  final Map? data;
  late TextEditingController txtDay, txtActivities;

  _AddItineraryState(this.data) {
    txtDay = TextEditingController(text: this.data?['day'] ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Make Itinerary',
          ),
          backgroundColor: Colors.lightBlue[900],
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            final Day addDay = dayList[index];
            // return InkWell(
            //   onTap: () {
            //     Navigator.push(context, MaterialPageRoute(builder: (context){
            //       return ItineraryTable(add_day: add_day);
            //     }));
            //   },
            //   child: listItem(add_day),
            // );
            listItem(addDay);
          },
          itemCount: dayList.length,
        )
    );
  }

  DateTime initDay() {
    try {
      return DateFormat("yyyy-mm-dd").parse(txtDay.value.text);
    } catch(e){}
    return DateTime.now();
  }

  Future<int> lastID() async {
    try {
      final _db = await DBHelper.db();
      final query = 'SELECT MAX(id) as id FROM day';
      final ls = (await _db?.rawQuery(query))!;

      if (ls.length > 0) {
        return int.tryParse('${ls[0]['id']}') ?? 0;
      }
    } catch (e) {
      print('error lastid %e');
    }
    return 0;
  }

  Widget listItem(Day addDay){
    return Card(
      margin: EdgeInsets.all(15.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              readOnly: true,
              decoration: const InputDecoration(labelText: "Insert Date"),
              controller: txtDay,
              onTap: () async {
                final dayDate = await showDatePicker(
                  context: context,
                  initialDate: initDay(),
                  firstDate: DateTime(2022),
                  lastDate: DateTime(2030),
                );

                if(dayDate != null){
                  txtDay.text = DateFormat("yyyy-mm-dd").format(dayDate);
                }
              },
            )
          ],
        ),
      ),
    );
    // return Card(
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: <Widget>[
    //       Flexible(
    //         flex: 2,
    //         child: SizedBox(
    //           width: 500,
    //           child: TextFormField(
    //             readOnly: true,
    //             decoration: InputDecoration(labelText: 'Insert Date'),
    //             controller: txtDay,
    //             onTap: () async {
    //               final day_date = await showDatePicker(
    //                 context: context,
    //                 initialDate: initDay(),
    //                 firstDate: DateTime(2022),
    //                 lastDate: DateTime(2030),
    //               );
    //
    //               if(day_date != null) {
    //                 txtDay.text = DateFormat("yyyy-mm-dd").format(day_date);
    //               }
    //             },
    //           ),
    //         )
    //       ),
    //       Flexible(
    //         flex: 1,
    //         child: SizedBox(
    //           width: 200,
    //           child: ClipRRect(
    //             borderRadius: BorderRadius.circular(12.0),
    //             child: Card(
    //               margin: EdgeInsets.all(7.0),
    //               child: InkWell(
    //                 child: Column(
    //                   children: <Widget>[
    //                     Text('Hello')
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //       )
    //     ],
    //   )
    // );
  }
}
