import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:iterasi1/model/destination_list.dart';
import 'package:iterasi1/pages/add_itinerary.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key, required this.place}) : super(key: key);
  final TourismPlace place;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text(place.name),
        backgroundColor: Colors.lightBlue[900],
      ),
      body: Stack(children: [
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              FullScreenWidget(
                  child: InteractiveViewer(
                      child: Image.asset(place.imageAsset,
                          width: 400, height: 200, fit: BoxFit.fitWidth))),
              Container(
                //Title Container
                margin: const EdgeInsets.only(top: 16.0),
                child: Text(place.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Orator',
                    )),
              ),
              Container(
                //Icon Container
                margin: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        const Icon(Icons.calendar_today),
                        Text(place.openOn),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        const Icon(Icons.access_time),
                        Text(place.openAt),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        const Icon(Icons.attach_money),
                        Text(place.fee),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                //Description Container
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  place.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15.0,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                //Image Gallery Container
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: FullScreenWidget(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: InteractiveViewer(
                                child: Image.asset(place.gallery[0],
                                    width: 300,
                                    height: 250,
                                    fit: BoxFit.fitWidth),
                              )),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: FullScreenWidget(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: InteractiveViewer(
                                child: Image.asset(place.gallery[1],
                                    width: 300,
                                    height: 250,
                                    fit: BoxFit.fitWidth),
                              )),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: FullScreenWidget(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: InteractiveViewer(
                                child: Image.asset(place.gallery[2],
                                    width: 300,
                                    height: 250,
                                    fit: BoxFit.fitWidth),
                              )),
                        )),
                  ],
                ),
              ),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context){return AddItinerary();}
                          )
                      );
                    },
                    child: const Text(
                      'Make Itinerary',
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.lightBlue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      ),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
        //bottomNavBar
      ]),
    );
  }
}
