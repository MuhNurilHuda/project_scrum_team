

import 'package:flutter/material.dart';
import 'package:iterasi1/pages/add_days.dart';
import 'package:iterasi1/pages/datepicker/date_picker_layout.dart';
import 'package:iterasi1/provider/database_provider.dart';
import 'package:iterasi1/provider/itinerary_provider.dart';
import 'package:provider/provider.dart';

import '../model/itinerary.dart';
import '../widget/text_dialog.dart';

class ItineraryList extends StatelessWidget {
  ItineraryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          heroTag : "ItineraryListFAB",
          backgroundColor: const Color(0xFF39B400),
          onPressed: (){
            getItineraryTitle(context);
          },
          child : const Icon(Icons.add)
      ),
      backgroundColor: const Color(0xFF1C3131),
      appBar: AppBar(
        title: const Text(
          "TripPlanner",
          style: TextStyle(
              fontFamily: 'Haviland',
              fontSize: 30,
              fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: const Color(0xFF1C3131),
        elevation: 0,
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context , provider , child) {
          return FutureBuilder<List<Itinerary>>(
              future: provider.itineraryDatas,
              builder: (context , snapshot) {
                final itineraries = snapshot.data;

                if (itineraries != null){
                  // developer.log("Itineraries : ${itineraries.length}" , name: "qqq");
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = itineraries[index];

                      return listItem(item , provider , context);
                    },
                    itemCount: itineraries.length,
                  );
                }
                else return const Center(
                  child: CircularProgressIndicator(),
                );
              }
          );
        }
      ),
    );
  }

  Widget listItem(
      Itinerary itinerary ,
      DatabaseProvider provider,
      BuildContext context
  ) {
    return Card(
      color: const Color(0xFFD5A364),
      margin: const EdgeInsets.all(15.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: InkWell(
          child: SizedBox(
            height: 50,
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Itinerary to ${itinerary.title}',
                          // maxLines: 1,
                          // overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context){
                                          Provider.of<ItineraryProvider>(context)
                                              .initItinerary(itinerary);

                                          return AddDays();
                                        }
                                    )
                                  );
                                }, // Buat method Edit
                                child: const Icon(
                                  Icons.edit,
                                ),
                              ),
                            ),
                            Flexible(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    provider.deleteItinerary(id: itinerary.id);
                                  }, // Buat method Delete
                                  child: const Icon(
                                    Icons.delete,
                                  ),
                                )
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getItineraryTitle(BuildContext context) async{
    final itineraryTitle = await showTextDialog(
        context,
        title : "Ketik Judul Itinerary",
        value : ""
    );

    if (itineraryTitle != null && context.mounted) {
      Provider.of<ItineraryProvider>(context , listen: false)
          .initItinerary(Itinerary(title: itineraryTitle));

      Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) {
                return const DatePickerLayout();
              }
          )
      );
    }
  }
}
