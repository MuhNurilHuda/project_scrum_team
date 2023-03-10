import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MakeItinerary extends StatefulWidget {
  const MakeItinerary({Key? key}) : super(key: key);

  @override
  State<MakeItinerary> createState() => _MakeItineraryState();
}

class _MakeItineraryState extends State<MakeItinerary> {
  late TextEditingController txtID, txtActivityName, txtActivityTime, txtIDDay, txtOnDate;

  _MakeItineraryState() {
    txtID = TextEditingController();
    txtActivityName = TextEditingController();
    txtActivityTime = TextEditingController();
    txtIDDay = TextEditingController();
    txtOnDate = TextEditingController();
  }

  Widget txtInputID()=>TextFormField(
    controller: txtID,
    readOnly: true,
    decoration: InputDecoration(labelText: 'No.'),
  );

  Widget txtActivityNameInput()=>TextFormField(
    controller: txtActivityName,
    decoration: InputDecoration(labelText: 'Nama Aktivitas'),
  );

  Widget txtIDDayInput()=>TextFormField(
    controller: txtIDDay,
    readOnly: true,
    decoration: InputDecoration(labelText: 'Day '),
  );
  Widget txtOnDateInput() => TextFormField(
    readOnly: true,
    decoration: InputDecoration(labelText: 'Day $txtIDDay'),
    controller: txtOnDate,
    onTap: () async {
      final date = await showDatePicker(
        context: context,
        initialDate: initOnDate(),
        firstDate: DateTime(1990),
        lastDate: DateTime(2025),
      );

      if(date != null){
        txtOnDate.text = DateFormat('yyyy-mm-dd').format(date);
      }
    },
  );

  DateTime initOnDate() {
    try {
      return DateFormat('yyyy-mm-dd').parse(txtOnDate.value.text);
    } catch(e){}
    return DateTime.now(); //Default Value
  }

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
