import 'package:flutter/material.dart';
import 'package:iterasi1/pages/add_days.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:iterasi1/navigation/side_navbar.dart';
import 'package:flutter/services.dart';

import '../database/database_service.dart';
import '../model/itinerary.dart';
import '../provider/itinerary_provider.dart';
import '../widget/text_dialog.dart';

class ItineraryList extends StatefulWidget {
  const ItineraryList({Key? key}) : super(key: key);

  @override
  _ItineraryListState createState() => _ItineraryListState();
}

class _ItineraryListState extends State<ItineraryList> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dbService = DatabaseService();
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    // String _prefixtext = "Search";

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xFFF1F2F6),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        key: _scaffoldKey,
        floatingActionButton: FloatingActionButton(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            backgroundColor: const Color(0xFFFFB252),
            onPressed: () {
              getItineraryTitle(context);
            },
            child: const Icon(Icons.add)),
        backgroundColor: const Color(0xFFF1F2F6),
        drawer: NavDrawer(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFFF1F2F6),
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.white,
                  child: IconButton(
                    icon: const Image(
                      image: AssetImage('assets/logo/SideNavBar.png'),
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: 50,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.white,
                  child: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Color(0xFF305A5A),
                    ),
                    // icon: const Image(
                    //   image: AssetImage('assets/logo/AppLogo.png'),
                    // ),
                    onPressed: () {
                      showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return Container(
                              color: const Color(0xFFF1F2F6),
                              width: double.infinity,
                              height: 450,
                              child: IntrinsicHeight(
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(7, 10, 7, 10),
                                  child: Column(children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 15, 10, 15),
                                      margin: const EdgeInsets.fromLTRB(
                                          10, 15, 10, 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: Theme(
                                              data: Theme.of(context).copyWith(
                                                  primaryColor: Colors.blue),
                                              child: TextField(
                                                controller: searchController,
                                                onChanged: (value) {
                                                  // setState(() {});
                                                },
                                                decoration: InputDecoration(
                                                    // fillColor: Colors.white38,
                                                    filled: true,
                                                    hintText: "Search",
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20))),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                            width: 10,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              height: 50,
                                              width: 30,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                              ),
                                              child: IconButton(
                                                  onPressed: () {},
                                                  icon: const Image(
                                                    image: AssetImage(
                                                        'assets/logo/SearchButton.png'),
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ]),
                                ),
                              ),
                            );
                          });
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                  ),
                ),
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
                        "TripPlanner",
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
                            return GridView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,                                
                              ),
                              itemCount: itineraries.length,
                              itemBuilder: (context, index) {
                                final item = itineraries[index];

                                return listItem(item);
                              },
                            );
                            // return ListView.builder(
                            //   shrinkWrap: true,
                            //   physics: const BouncingScrollPhysics(),
                            //   itemBuilder: (context, index) {
                            //     final item = itineraries[index];

                            //     return listItem(item);
                            //   },
                            //   itemCount: itineraries.length,
                            // );
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
      ),
    );
  }

  Widget listItem(Itinerary itinerary) {
    return InkWell(
      onTap: () {
        navigateToAddDays(itinerary, context);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          // side: BorderSide(
          //   color: Colors.grey.withOpacity(0.5),
          //   width: 1,
          // )
        ),
        elevation: 4,
        child: Container(   
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),   
          padding: const EdgeInsets.all(7.0),
          // color: Colors.white,
          child: GridTile(        
            child: Align(
              child: Text(
                'Itinerary to ${itinerary.title}',
                style: TextStyle(
                  fontFamily: 'poppins',
                  color: Color(0xFF305A5A),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            footer: Container(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [                  
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     navigateToAddDays(itinerary, context);
                  //   },
                  //   child: Icon(Icons.edit),
                  // ),
                  InkWell(
                    onTap: () {
                      final dbService = DatabaseService();
                      dbService.deleteItinerary(itinerary.id).whenComplete(() {
                        setState(() {});
                      });
                    }, // Buat method Delete
                    child: Icon(
                      Icons.delete,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget listItem(Itinerary itinerary) {
  //   return Card(
  //     color: const Color(0xFFFFB252),
  //     margin: const EdgeInsets.all(15.0),
  //     elevation: 4,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(20.0),
  //     ),
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(20.0),
  //       child: InkWell(
  //         child: SizedBox(
  //           height: 50,
  //           width: double.infinity,
  //           child: Row(
  //             mainAxisSize: MainAxisSize.min,
  //             children: <Widget>[
  //               Flexible(
  //                 flex: 4,
  //                 child: Padding(
  //                   padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: <Widget>[
  //                       Text(
  //                         'Itinerary to ${itinerary.title}',
  //                         // maxLines: 1,
  //                         // overflow: TextOverflow.ellipsis,
  //                         style: const TextStyle(
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 15,
  //                           color: Colors.white,
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               Flexible(
  //                 flex: 1,
  //                 child: Row(
  //                   // mainAxisAlignment: MainAxisAlignment.center,
  //                   children: <Widget>[
  //                     Flexible(
  //                       flex: 1,
  //                       child: Row(
  //                         children: <Widget>[
  //                           Flexible(
  //                             flex: 1,
  //                             child: InkWell(
  //                               onTap: () {
  //                                 navigateToAddDays(itinerary, context);
  //                               }, // Buat method Edit
  //                               child: Icon(
  //                                 Icons.edit,
  //                               ),
  //                             ),
  //                           ),
  //                           Flexible(
  //                               flex: 1,
  //                               child: InkWell(
  //                                 onTap: () {
  //                                   final dbService = DatabaseService();
  //                                   dbService
  //                                       .deleteItinerary(itinerary.id)
  //                                       .whenComplete(() {
  //                                     setState(() {});
  //                                   });
  //                                 }, // Buat method Delete
  //                                 child: Icon(
  //                                   Icons.delete,
  //                                 ),
  //                               )),
  //                         ],
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Future<void> getItineraryTitle(BuildContext context) async {
    final itineraryTitle = await showTextDialog(context,
        title: "Ketik Judul Itinerary", value: "");

    if (itineraryTitle != null)
      navigateToAddDays(
          Itinerary(id: const Uuid().v1(), title: itineraryTitle), context);
  }

  void navigateToAddDays(Itinerary itinerary, BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ChangeNotifierProvider<ItineraryProvider>(
        create: (context) => ItineraryProvider(itinerary: itinerary),
        child: AddItinerary(
          refreshPreviousPage: refreshState,
        ),
      );
    }));
  }

  void refreshState() {
    setState(() {});
  }
}
