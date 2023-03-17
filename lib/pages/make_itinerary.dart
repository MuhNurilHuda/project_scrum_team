import 'package:flutter/material.dart';
import 'package:iterasi1/model/day.dart';
import 'package:iterasi1/pages/itinerary_table.dart';
import 'package:iterasi1/pages/pdf/preview_pdf_page.dart';
import 'package:iterasi1/pages/paket_wisata.dart';

class MakeNewItinerary extends StatefulWidget {
  @override
  State<MakeNewItinerary> createState() => _MakeNewItineraryState();
}

class _MakeNewItineraryState extends State<MakeNewItinerary> {
  final List<Day> days = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue[50],
        floatingActionButton: Stack(
          children: <Widget>[
            Positioned(
              right: 16.0,
              bottom: 90.0,
              child: FloatingActionButton(
                child: Icon(Icons.save),
                onPressed: () {},
              ),
            ),
            Positioned(
              right: 16.0,
              bottom: 16.0,
              child: FloatingActionButton(
                child: Icon(Icons.print),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (builder) => PdfPreviewPage(days: days),
                  ));
                },
              ),
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.print),
        //   onPressed: () {
        //     Navigator.of(context).push(
        //       MaterialPageRoute(
        //         builder: (builder) => PdfPreviewPage(days: days),
        //       ),
        //     );
        //   },
        // ),
        appBar: AppBar(
          title: const Text(
            'Make Itinerary',
          ),
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          // ),
          backgroundColor: Colors.lightBlue[900],
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return index == days.length
                ? addNewDayButton()
                : listItem(days[index]);
          },
          itemCount: days.length + 1,
        ),
      ),
    );
  }

  Widget listItem(Day day) {
    return SizedBox(
      height: 80,
      child: Container(
        padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
        child: Card(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(day.date),
                InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (builder) {
                        return ItineraryTable(add_day: day);
                      }));
                    },
                    child: Card(
                      // color: Color(0x1C3131),
                      color: Colors.grey,
                      elevation: 0,
                      child:
                      Row(mainAxisSize: MainAxisSize.min, children: const [
                        Card(
                          child: const Icon(Icons.add),
                        ),
                        Text(
                          "Tambah Aktivitas",
                          style: TextStyle(color: Colors.white),
                        ),
                      ]),
                    )),
              ],
            )),
      ),
    );
  }

  Widget addNewDayButton() => InkWell(
    onTap: () async {
      final choosenDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2023),
          lastDate: DateTime(2100));

      if (choosenDate != null) {
        setState(() {
          days.add(Day(date: formatDate(choosenDate)));
        });
      }
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
                "Tambah Hari",
              ),
            ],
          ),
        ),
      ),
    ),
  );

  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  String getMonthString(int intMonth) {
    switch (intMonth) {
      case 1:
        return "Januari";
      default:
        return "Desember";
    }
  }
}
