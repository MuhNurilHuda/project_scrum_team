import 'package:flutter/material.dart';
import 'package:iterasi1/model/day.dart';
import 'package:iterasi1/pages/itinerary_table.dart';
import 'package:iterasi1/pages/pdf/preview_pdf_page.dart';


class AddItinerary extends StatefulWidget {
  @override
  State<AddItinerary> createState() => _AddItineraryState();
}

class _AddItineraryState extends State<AddItinerary> {
  final List<Day> days = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (builder) => PdfPreviewPage(days : days),
              ),
            );
          },
        ),
        appBar: AppBar(
          title: Text(
            'Make Itinerary',
          ),
          backgroundColor: Colors.lightBlue[900],
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return index == days.length ? addNewDayButton() : listItem(days[index]);
          },
          itemCount: days.length + 1,
        )
      ),
    );
  }

  Widget listItem(Day day){
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(day.date),
          InkWell(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (buider){
                      return ItineraryTable(add_day: day);
                    }
                )
              );
            },
            child : Card(
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children : [
                    Card(
                      child: const Icon(Icons.add),
                    ),
                    Text("Tambah Aktivitas")
                  ]
              ),
            )
          ),

        ],
      )
    );
  }
  
  Widget addNewDayButton() =>
      InkWell(
        onTap: () async {
          final choosenDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2023),
              lastDate: DateTime(2100)
          );

          if (choosenDate != null)
            setState(() {
              days.add(Day(date: formatDate(choosenDate)));
            });

        },
        child: Card(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Card(
                child: Icon(Icons.add),
              ),
              const Text("Tambah Hari")
            ],
          ),
        ),
      );

  String formatDate(DateTime date){
    return "${date.day}/${date.month}/${date.year}";
  }

  String getMonthString(int intMonth){
    switch(intMonth){
      case 1:
        return "Januari";
      default :
        return "Desember";
    }
  }
}
