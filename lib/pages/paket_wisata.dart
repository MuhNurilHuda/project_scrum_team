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
      // body: InkWell(
      //   onTap: () {
      //     Navigator.push(context, MaterialPageRoute(builder: (context) {
      //       return DetailScreen();
      //     }));
      //   },
      //   child: listItem(),
      // ),
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
          // onTap: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => )
          //   )
          // },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                place.imageAsset,
                fit: BoxFit.cover,
              ),
              ListTile(
                title: Text(place.name),
                subtitle: Text('Tap for details'),
              )
            ],
          ),
        ),
      ),
    );
    // return Card(
    //   child: Row(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: <Widget>[
    //       Expanded(
    //         flex: 1,
    //         child: Image.asset(place.imageAsset),
    //       ),
    //       Expanded(
    //         flex: 2,
    //         child: Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             mainAxisSize: MainAxisSize.min,
    //             children: <Widget>[
    //               Text(
    //                 place.name,
    //                 style: TextStyle(
    //                     fontSize: 16.0
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 10,
    //               ),
    //               Text(place.location)
    //             ],
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}


