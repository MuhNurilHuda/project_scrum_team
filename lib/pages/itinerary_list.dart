

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iterasi1/pages/add_days.dart';
import 'package:iterasi1/pages/provider/itinerary_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../database/database_service.dart';
import '../model/itinerary.dart';
import '../widget/text_dialog.dart';

class ItineraryList extends StatefulWidget {
  const ItineraryList({Key? key}) : super(key: key);

  @override
  _ItineraryListState createState() => _ItineraryListState();
}

class _ItineraryListState extends State<ItineraryList> {
  @override
  Widget build(BuildContext context) {
    final dbService = DatabaseService();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          getItineraryTitle(context);
        },
        child : Icon(Icons.add)
      ),
      backgroundColor: const Color(0xFF1C3131),
      appBar: AppBar(
        title: const Text("Saved Itinerary"),
        backgroundColor: const Color(0xFF1C3131),
        elevation: 0,
      ),
      body: FutureBuilder<List<Itinerary>>(
        future: dbService.fetchItineraries(),
        builder: (context , snapshot) {
          final itineraries = snapshot.data;

          if (itineraries != null){
            // developer.log("Itineraries : ${itineraries.length}" , name: "qqq");
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final item = itineraries[index];

                return listItem(item);
              },
              itemCount: itineraries.length,
            );
          }
          else return Center(
            child: CircularProgressIndicator(),
          );
        }
      ),
    );
  }

  Widget listItem(Itinerary itinerary) {
    return Card(
      color: Color(0xFFD5A364),
      margin: EdgeInsets.all(15.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: InkWell(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Itinerary to ${itinerary.title}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Flexible(
                      flex: 5,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text('Started on: Monday, 12 June 2023'),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                navigateToAddDays(itinerary, context);
                              }, // Buat method Edit
                              child: Icon(
                                Icons.edit,
                              ),
                            ),
                          ),
                          Flexible(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  final dbService = DatabaseService();
                                  dbService.deleteItinerary(itinerary.id)
                                    .whenComplete((){
                                      setState(() {});
                                    });
                                }, // Buat method Delete
                                child: Icon(
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
    );
  }

  Future<void> getItineraryTitle(BuildContext context) async{
    final itineraryTitle = await showTextDialog(
        context,
        title : "Ketik Judul Itinerary",
        value : ""
    );

    if (itineraryTitle != null)
      navigateToAddDays(
          Itinerary(id: const Uuid().v1(), title: itineraryTitle),
          context
      );
  }

  void navigateToAddDays(Itinerary itinerary , BuildContext context){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context){
          return ChangeNotifierProvider<ItineraryProvider>(
            create: (context) => ItineraryProvider(itinerary: itinerary),
            child: AddItinerary(
              refreshPreviousPage: refreshState,
            ),
          );
        })
    );
  }

  void refreshState(){ setState(() {}); }
}
