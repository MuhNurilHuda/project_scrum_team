import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:iterasi1/model/destination_list.dart';
import 'package:full_screen_image/full_screen_image.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key, required this.place}) : super(key: key);
  final TourismPlace place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FullScreenWidget(
                child: InteractiveViewer(child: Image.asset(place.imageAsset, fit: BoxFit.fitWidth))),
            Container(
              //Title Container
              margin: const EdgeInsets.only(top: 16.0),
              child: Text(place.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
                      Icon(Icons.calendar_today),
                      Text(place.openOn),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Icon(Icons.access_time),
                      Text(place.openAt),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Icon(Icons.attach_money),
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
                style: TextStyle(
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
                              child: Image.asset(place.gallery1, width: 300, height: 200, fit: BoxFit.fitWidth),
                            )),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: FullScreenWidget(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: InteractiveViewer(
                              child: Image.asset(place.gallery2, width: 300, height: 200, fit: BoxFit.fitWidth),
                            )),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: FullScreenWidget(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: InteractiveViewer(
                              child: Image.asset(place.gallery3, width: 300, height: 200, fit: BoxFit.fitWidth),
                            )),
                      )),
                  // Padding(
                  //   padding: const EdgeInsets.all(7.0),
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(15.0),
                  //     child: Image.asset('assets/images/surabaya-submarine-monument.jpeg'),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String image;
  const FullScreenImage({required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FullScreenImagePage(
              image: image,
            ),
          ),
        );
      },
      child: Hero(
        tag: image,
        child: Image.network('src'),
      ),
    );
  }
}

class FullScreenImagePage extends StatelessWidget {
  FullScreenImagePage({required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Hero(
          tag: image,
          child: Image.network(
            image,
            fit: BoxFit.contain,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
