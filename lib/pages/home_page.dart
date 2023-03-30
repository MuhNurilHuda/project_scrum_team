import 'package:flutter/material.dart';
import 'package:iterasi1/model/destination.dart';
import 'package:iterasi1/pages/details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController search = TextEditingController();

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(20.0),
            child: TextField(
              onChanged: (value) {
                setState(() {

                });
              },
              controller: search,
              decoration: InputDecoration(
                prefixText: "Cari",
                prefixStyle: TextStyle(
                  color: Colors.grey,
                ),
                border:OutlineInputBorder(
                  borderRadius:BorderRadius.circular(20.0),
                ),
                fillColor: Colors.white,
                filled: true,
                // prefixIcon: Icon(Icons.)

              ),
            ),
          ),
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
                  width: double.infinity,
                  height: 82,
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
