import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iterasi1/pages/add_days/add_days.dart';
import 'package:iterasi1/provider/database_provider.dart';
import 'package:iterasi1/provider/itinerary_provider.dart';
import 'package:iterasi1/pages/datepicker/select_date.dart';
import 'package:provider/provider.dart';
import 'package:iterasi1/navigation/side_navbar.dart';
import 'package:flutter/services.dart';

import '../model/itinerary.dart';
import '../widget/text_dialog.dart';
<<<<<<< HEAD
import 'dart:math';
=======
class ItineraryList extends StatelessWidget {
  static const route = "/ItineraryListRoute";
>>>>>>> 96ba3f47bd485297c7a8efc25265e63ba681868f

  ItineraryList({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();
  var time = DateTime.now();

  late DatabaseProvider dbProvider;

  @override
  Widget build(BuildContext context) {
    dbProvider = Provider.of(context, listen: true);

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    // String _prefixtext = "Search";

<<<<<<< HEAD
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
=======
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
>>>>>>> 96ba3f47bd485297c7a8efc25265e63ba681868f
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
                            return SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Container(
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
                                                data: Theme.of(context)
                                                    .copyWith(
                                                        primaryColor:
                                                            Colors.blue),
                                                child: TextField(
                                                  controller: searchController,
                                                  onChanged: (value) {
                                                    dbProvider.refreshData(
                                                        filterItineraryName:
                                                            searchController
                                                                .text);
                                                  },
                                                  decoration: InputDecoration(
                                                      // fillColor: Colors.white38,
                                                      filled: true,
                                                      hintText: "Search",
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20))),
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
                                                padding: const EdgeInsets.all(5.0),
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                ),
                                                child: IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
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
                            fontFamily: 'poppins_bold',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF305A5A)),
                      ),
                    ),
                    FutureBuilder<List<Itinerary>>(
                        future: dbProvider.itineraryDatas,
                        builder: (context, snapshot) {
                          final itineraries = snapshot.data;
                          if (itineraries != null) {
                            // developer.log("Itineraries : ${itineraries.length}" , name: "qqq");
                            return GridView.builder(
                              scrollDirection: Axis.vertical,
                              physics: const BouncingScrollPhysics(),
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
                                //
                                return listItem(item, dbProvider, context);
                              },
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                            
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listItem(
      Itinerary itinerary, DatabaseProvider dbProvider, BuildContext context) {
    return InkWell(
      onTap: () {
        final itineraryProvider = Provider.of<ItineraryProvider>(context, listen: false);
        itineraryProvider.initItinerary(itinerary);

        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return AddDays();
        }));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 4,
        child: Container(
          margin: const EdgeInsets.only(top: 12.0, left: 8.0, right: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(7.0),
          // color: Colors.white,
          child: GridTile(            
            footer: Container(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${DateFormat('EEEE').format(time)}, ${time.day}-${time.month}-${time.year}',
                    // time.toString(),
                    // DateTime.now().toString(),
                    // 'April, 27 2023',
                    style: const TextStyle(
                      fontFamily: 'poppins_regular',
                      color: Colors.grey,
                      fontSize: 11,
                      // fontWeight: FontWeight.normal,
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  InkWell(
                    onTap: () {
                      dbProvider.deleteItinerary(id: itinerary.id);
                    }, // Buat method Delete
                    child: const Icon(
                      Icons.delete,
                    ),
                  ),
                ],
              ),
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Itinerary to ${itinerary.title}',
                style: const TextStyle(
                  fontFamily: 'poppins_bold',
                  color: Color(0xFF305A5A),
                ),
                textAlign: TextAlign.center,
              ),
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

<<<<<<< HEAD
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
=======
  Future<void> getItineraryTitle(BuildContext context) async {
    final itineraryTitle = await showTextDialog(context,
        title: "Ketik Judul Itinerary", value: "");

    if (itineraryTitle != null && context.mounted) {
      Provider.of<ItineraryProvider>(context, listen: false)
          .initItinerary(Itinerary(title: itineraryTitle));

      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return SelectDate();
      }));
    }
>>>>>>> 96ba3f47bd485297c7a8efc25265e63ba681868f
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
