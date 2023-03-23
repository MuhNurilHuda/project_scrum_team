import 'package:flutter/material.dart';
import 'package:iterasi1/model/destination_list.dart';
import 'package:iterasi1/pages/details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C3131),
      appBar: AppBar(
        title: const Text(
          "TripPlanner",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Haviland',
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF1C3131),
        elevation: 0,
      ),
      // body: ListView.builder(
      //   itemCount: tourismPlaceList.length,
      //   itemBuilder: (BuildContext context, index){
      //     final TourismPlace place = tourismPlaceList[index];
      //     return InkWell(
      //       onTap: () {
      //         Navigator.push(context, MaterialPageRoute(builder: (context) {
      //           return DetailsPage(place: place);
      //         }));
      //       },
      //       child: Column(
      //         children: [
      //           // Vertical List Item
      //           GridView.builder(
      //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //                 crossAxisCount: 2,
      //                 childAspectRatio: 1,
      //               ),
      //               physics: const BouncingScrollPhysics(),
      //               itemCount: tourismPlaceList.length,
      //               scrollDirection: Axis.vertical,
      //               itemBuilder: (context, index) {
      //                 final TourismPlace place = tourismPlaceList[index];
      //                 return InkWell(
      //                   onTap: () {
      //                     Navigator.push(context, MaterialPageRoute(builder: (context){
      //                       return DetailsPage(place: place);
      //                     }));
      //                   },
      //                   // child: listItemVertical(place),
      //                   child: InkWell(
      //                     onTap: () {
      //                       Navigator.push(context, MaterialPageRoute(builder: (context) {
      //                         return DetailsPage(place: place);
      //                       }));
      //                     },
      //                     child: Row(
      //                       children: <Widget>[
      //                         Container(
      //                           width: 200,
      //                           height: 100,
      //                           child: Image.asset(
      //                             place.imageAsset,
      //
      //                           ),
      //                         )
      //                       ],
      //                     ),
      //                   ),
      //                 );
      //               }
      //           ),
      //         ],
      //       ),
      //     );
      //   },
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Recommendation",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            child: SizedBox(
              height: 200.0,
              child: ListView.builder(
                // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //   crossAxisCount: 1,
                //   // mainAxisSpacing: 10.0,
                // ),
                itemExtent: 300,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: tourismPlaceList.length,
                itemBuilder: (context, index) {
                  final TourismPlace place = tourismPlaceList[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DetailsPage(place: place);
                      }));
                    },
                    child: listItemHorizontal(place),
                  );
                },
              ),
            ),
          ),
          const Text(
            "Tempat Wisata",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: SizedBox(
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // mainAxisSpacing: 10.0,
                ),
                itemCount: tourismPlaceList.length,
                itemBuilder: (context, index) {
                  final TourismPlace place = tourismPlaceList[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DetailsPage(place: place);
                      }));
                    },
                    child: listItemVertical(place),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listItemVertical(TourismPlace place) {
    return Card(
      color: Color(0xFFD5A364),
      margin: EdgeInsets.all(12.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: InkWell(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  place.imageAsset,
                  width: 200,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                ListTile(
                  title: Text(
                    place.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(place.location),
                )
              ],
            ),
          )),
    );
  }

  Widget listItemHorizontal(TourismPlace place) {
    return Card(
      color: Color(0xFFD5A364),
      margin: EdgeInsets.all(12.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: InkWell(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  place.imageAsset,
                  width: double.infinity,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                ListTile(
                  title: Text(
                    place.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(place.location),
                )
              ],
            ),
          )),
    );
  }
}
