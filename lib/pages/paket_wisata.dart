import 'package:flutter/material.dart';
import 'package:iterasi1/model/destination_list.dart';
import 'package:iterasi1/pages/details_page.dart';

// void main() {
//   runApp(const MyApp());
// }

class PaketWisata extends StatelessWidget {
  const PaketWisata({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Daftar Wisata',
          ),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            final TourismPlace place = tourismPlaceList[index];
            return InkWell(
              onTap: () {
                Navigator.push(context , MaterialPageRoute(builder: (context){
                  return DetailsPage(place: place);
                }));
              },
              child: listItem(place),
            );
          },
          itemCount: tourismPlaceList.length,
        )
    );
  }

  Widget listItem(TourismPlace place){
    return Card(
      margin: EdgeInsets.all(15.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Colors.white,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: InkWell(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                place.imageAsset,
                fit: BoxFit.cover,
              ),
              ListTile(
                title: Text(place.name),
                subtitle: Text(place.location),
              )
            ],
          ),
        ),
      ),
    );
  }
}


