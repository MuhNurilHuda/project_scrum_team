import 'package:flutter/material.dart';

class MakeItinerary extends StatefulWidget {
  const MakeItinerary({Key? key}) : super(key: key);

  @override
  State<MakeItinerary> createState() => _MakeItineraryState();
}

class _MakeItineraryState extends State<MakeItinerary> {
  late TextEditingController txtID, txtOnDate, txtActivityName, txtActivityTime;

  _MakeItineraryState() {
    txtID = TextEditingController();
    txtOnDate = TextEditingController();
    txtActivityName = TextEditingController();
    txtActivityTime = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
