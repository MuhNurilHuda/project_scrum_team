import 'package:flutter/material.dart';
import 'package:iterasi1/model/day.dart';
import 'package:iterasi1/pages/activity/add_activities.dart';
import 'package:iterasi1/pages/pdf/preview_pdf_page.dart';
import 'package:iterasi1/provider/database_provider.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import '../model/itinerary.dart';
import '../provider/itinerary_provider.dart';

class AddDays extends StatelessWidget{
  AddDays({Key? key}) : super(key: key);

  late ItineraryProvider itineraryProvider;
  late DatabaseProvider databaseProvider;

  @override
  Widget build(BuildContext context) {
    itineraryProvider = Provider.of(context , listen: true);
    databaseProvider = Provider.of(context , listen: true);

    return LoaderOverlay(
        child: Scaffold(
          backgroundColor: const Color(0xFF1C3131),
          floatingActionButton: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  heroTag: "AddDaysSaveItineraryFAB",
                  backgroundColor: const Color(0xFF39B400),
                  onPressed: (){
                    context.loaderOverlay.show();

                    databaseProvider.insertItinerary(
                        itinerary : Itinerary(
                            id: itineraryProvider.itinerary.id,
                            title: itineraryProvider.itinerary.title,
                            days: itineraryProvider.itinerary.days
                        )
                    ).whenComplete(
                            (){
                          context.loaderOverlay.hide();
                          Navigator.pop(context);
                        }
                    );
                  },
                  child: const Icon(Icons.save),
                ),
                const SizedBox(height: 16,),
                FloatingActionButton(
                  heroTag: "AddDaysPrintPDFFAB",
                  backgroundColor: const Color(0xFF39B400),
                  child: const Icon(Icons.print),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (builder) => PdfPreviewPage(
                            itinerary : itineraryProvider.itinerary
                        ),
                      ),
                    );
                  },
                )
              ]
          ),
          appBar: AppBar(
            title: Text(
              itineraryProvider.itinerary.title,
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: const Color(0xFF1C3131),
            elevation: 0,
          ),
          body: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return index == itineraryProvider.itinerary.days.length
                  ? addNewDayButton(context)
                  : listItem(index , context);
            },
            itemCount: itineraryProvider.itinerary.days.length + 1,
          ),
        ),
    );
  }

  Widget listItem(int index , BuildContext context) {
    return SizedBox(
      height: 80,
      child: Container(
        padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
        child: Card(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(itineraryProvider.itinerary.days[index].date),
                InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (builder) {
                        return AddActivities(dayIndex: index);
                      }));
                    },
                    child: Card(
                      // color: Color(0x1C3131),
                      color: Colors.grey,
                      elevation: 0,
                      child: Row(mainAxisSize: MainAxisSize.min, children: const [
                        Card(
                          child: Icon(Icons.add),
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

  Widget addNewDayButton(BuildContext context) => InkWell(
    onTap: () async {
      final choosenDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2023),
          lastDate: DateTime(2100)
      );

      if (choosenDate != null) {
          itineraryProvider.addDay(
              Day(date: formatDate(choosenDate))
          );
      }
    },
    child: SizedBox(
      height: 50,
      child: Container(
        padding: const EdgeInsets.fromLTRB(75, 5, 75, 5),
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
      case 2:
        return "Februari";
      default:
        return "Desember";
    }
  }
}
