import 'package:flutter/material.dart';
import 'package:iterasi1/pages/add_days.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:iterasi1/navigation/side_navbar.dart';

import '../database/database_service.dart';
import '../model/itinerary.dart';
import '../provider/itinerary_provider.dart';
import '../widget/text_dialog.dart';
import 'dart:math';

class ItineraryList extends StatefulWidget {
  const ItineraryList({Key? key}) : super(key: key);

  @override
  _ItineraryListState createState() => _ItineraryListState();
}

class _ItineraryListState extends State<ItineraryList> {
  @override
  Widget build(BuildContext context) {
    final dbService = DatabaseService();                                     
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor: const Color(0xFFFFB252),
          onPressed: () {
            getItineraryTitle(context);
          },
          child: Icon(Icons.add)),  
          backgroundColor: const Color(0xFFF1F2F6),
          drawer: NavDrawer(),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFFF1F2F6),
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Image(
                    image: AssetImage('assets/logo/SideNavBar.png'),
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
                IconButton(
                  icon: const Image(
                    image: AssetImage('assets/logo/AppLogo.png'),
                  ),
                  onPressed: () {},
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                ),
              ],
            ),
          ),
      body: Container(        
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 5,
                      bottom: 10,
                    ),
                    child: const Text(
                      "Trip Planner",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'poppins',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF305A5A)),
                    ),
                  ),
                  FutureBuilder<List<Itinerary>>(
                      future: dbService.fetchItineraries(),
                      builder: (context, snapshot) {
                        final itineraries = snapshot.data;

                        if (itineraries != null) {
                          // developer.log("Itineraries : ${itineraries.length}" , name: "qqq");
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final item = itineraries[index];

                              return listItem(item);
                            },
                            itemCount: itineraries.length,
                          );
                        } else
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listItem(Itinerary itinerary) {
    return Card(
      color: const Color(0xFFFFB252),
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
                                    dbService
                                        .deleteItinerary(itinerary.id)
                                        .whenComplete(() {
                                      setState(() {});
                                    });
                                  }, // Buat method Delete
                                  child: Icon(
                                    Icons.delete,
                                  ),
                                )),
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
  
Future<void> getItineraryTitle(BuildContext context) async {
  final textEditingController = TextEditingController();
  final itineraryTitle = await showModalBottomSheet<String>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    builder: (BuildContext context) {
      return SizedBox(
        height: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Ketik Judul Itinerary',
                      ),
                    ),
                  ),
                  IconButton(
                  onPressed: () {
                    Navigator.pop(context, textEditingController.text);
                  },
                  icon: Transform.rotate(
                    
                    angle: 180 * pi / 90,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // tambhkan ukuran bulat 
                        color: Colors.white,
                        
                      ),
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.send,
                        color: Colors.orange,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                                ],
              ),
            ),
           SizedBox(height: 20),
            Column(
              children: [
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 8),
                        Text(
                          'Gunung Bromo',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 8),
                        Text(
                          'Wisata 2',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon(Icons.local_activity, size: 40, color: Colors.orange),
                        SizedBox(height: 8),
                        Text(
                          'Wisata 3',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 8),
                        Text(
                          'Gunung Bromo',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 8),
                        Text(
                          'Wisata 2',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon(Icons.local_activity, size: 40, color: Colors.orange),
                        SizedBox(height: 8),
                        Text(
                          'Wisata 3',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 8),
                        Text(
                          'Gunung Bromo',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 8),
                        Text(
                          'Wisata 2',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon(Icons.local_activity, size: 40, color: Colors.orange),
                        SizedBox(height: 8),
                        Text(
                          'Wisata 3',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              
            ],
          )
        ],
      ),
    );
  },
);

  if (itineraryTitle != null && itineraryTitle.isNotEmpty) {
    final itinerary = Itinerary(id: const Uuid().v1(), title: itineraryTitle);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ChangeNotifierProvider<ItineraryProvider>(
            create: (context) => ItineraryProvider(itinerary: itinerary),
            child: AddItinerary(refreshPreviousPage: refreshState),
          );
        },
      ),
    );
  }
}

void navigateToAddDays(Itinerary itinerary, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) {
        return ChangeNotifierProvider<ItineraryProvider>(
          create: (context) => ItineraryProvider(itinerary: itinerary),
          child: AddItinerary(
            refreshPreviousPage: refreshState,
          ),
        );
      },
    ),
  );
}

void refreshState() {
  setState(() {});
}
}

//   Future<void> getItineraryTitle(BuildContext context) async {
//     final itineraryTitle = await showTextDialog(context,
//         title: "Ketik Judul Itinerary", value: "");

//     if (itineraryTitle != null)
//       navigateToAddDays(
//           Itinerary(id: const Uuid().v1(), title: itineraryTitle), context);
//   }

//   void navigateToAddDays(Itinerary itinerary, BuildContext context) {
//     Navigator.push(context, MaterialPageRoute(builder: (context) {
//       return ChangeNotifierProvider<ItineraryProvider>(
//         create: (context) => ItineraryProvider(itinerary: itinerary),
//         child: AddItinerary(
//           refreshPreviousPage: refreshState,
//         ),
//       );
//     }));
//   }

//   void refreshState() {
//     setState(() {});
//   }
// }
