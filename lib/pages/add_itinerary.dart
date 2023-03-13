import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iterasi1/model/day.dart';

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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Make Itinerary',
          ),
          backgroundColor: Colors.lightBlue[900],
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            final Day add_day = dayList[index];
            // return InkWell(
            //   onTap: () {
            //     Navigator.push(context, MaterialPageRoute(builder: (context){
            //       return ItineraryTable(add_day: add_day);
            //     }));
            //   },
            //   child: listItem(add_day),
            // );
          },
          itemCount: dayList.length,
        )
      ),
    );
  }

  DateTime initDay() {
    try {
      return DateFormat("yyyy-mm-dd").parse(txtDay.value.text);
    } catch(e){}
    return DateTime.now();
  }

  Widget listItem(Day add_day){
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: TextFormField(
              readOnly: true,
              decoration: InputDecoration(labelText: 'Insert Date'),
              controller: txtDay,
              onTap: () async {
                final day_date = await showDatePicker(
                  context: context,
                  initialDate: initDay(),
                  firstDate: DateTime(2022),
                  lastDate: DateTime(2030),
                );

                if(day_date != null) {
                  txtDay.text = DateFormat("yyyy-mm-dd").format(day_date);
                }
              },
            )
          ),
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Card(
                margin: EdgeInsets.all(7.0),
                child: InkWell(
                  child: Column(

                  ),
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}
