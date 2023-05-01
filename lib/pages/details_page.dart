import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:iterasi1/model/destination.dart';
import 'package:iterasi1/pages/add_days/add_days.dart';
import 'package:uuid/uuid.dart';

import '../model/itinerary.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key, required this.place}) : super(key: key);
  final TourismPlace place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C3131),
      appBar: AppBar(
        title: Text(place.name),
        backgroundColor: Color(0xFF1C3131),
        elevation: 0,
      ),
      body: Stack(children: [
        SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Column(
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
                          color: Colors.white,
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
                            const Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                            ),
                            Text(
                              place.openOn,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            const Icon(
                              Icons.access_time,
                              color: Colors.white,
                            ),
                            Text(
                              place.openAt,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            const Icon(
                              Icons.attach_money,
                              color: Colors.white,
                            ),
                            Text(place.fee,
                                style: const TextStyle(
                                  color: Colors.white,
                                )),
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
                        color: Colors.white,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    //Image Gallery Container
                    height: 150,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
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
                          InkWell(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (context) {
                                          Itinerary(
                                              id : const Uuid().v1() ,
                                              title : "Contoh Title"
                                          );

                                          return AddDays();
                                        }
                                    )
                                );
                              },
                              child: const Text(
                                'Make Itinerary',
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(Color(0xFF39B400)),
                                shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ],
          ),
        ),
        //bottomNavBar
      ]),
    );
  }
}
