import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iterasi1/pages/add_days/add_days.dart';
import 'package:iterasi1/provider/database_provider.dart';
import 'package:iterasi1/provider/itinerary_provider.dart';
import 'package:iterasi1/pages/datepicker/select_date.dart';
import 'package:iterasi1/resource/custom_colors.dart';
import 'package:iterasi1/utilities/date_time_formatter.dart';
import 'package:provider/provider.dart';
import 'package:iterasi1/navigation/side_navbar.dart';
import 'package:flutter/services.dart';
import '../model/itinerary.dart';
import '../widget/text_dialog.dart';
class ItineraryList extends StatefulWidget {
  static const route = "/ItineraryListRoute";

  ItineraryList({Key? key}) : super(key: key);

  @override
  State<ItineraryList> createState() => _ItineraryListState();
}

class _ItineraryListState extends State<ItineraryList> {

  late ScaffoldMessengerState snackbarHandler;

  TextEditingController searchController = TextEditingController();

  final time = DateTime.now();

  late DatabaseProvider dbProvider;

  @override
  Widget build(BuildContext context) {
    snackbarHandler = ScaffoldMessenger.of(context);

    dbProvider = Provider.of(context, listen: true);

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
            backgroundColor: const Color(0xFFC58940),
            onPressed: () {
              getItineraryTitle(context);
            },
            child: const Icon(Icons.add)),
        backgroundColor: const Color(0xFFFAF8F1),
        drawer: NavDrawer(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFFFAF8F1),
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
                      image: AssetImage('assets/logo/AppLogo.png'),
                    ),
                    onPressed: () {
                      // _scaffoldKey.currentState?.openDrawer();
                    },
                    // highlightColor: Colors.transparent,
                    // splashColor: Colors.transparent,
                    // tooltip:
                    //     MaterialLocalizations.of(context).openAppDrawerTooltip,
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
                      color: CustomColor.buttonColor,
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
                                                          'assets/logo/Search_Button.png'),
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
                        "Trip Planner",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'poppins_bold',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFC58940)),
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
                                return KartuItinerary(item, dbProvider, context);
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

  Widget KartuItinerary(
      Itinerary itinerary,
      DatabaseProvider dbProvider,
      BuildContext context
  ) {
    return InkWell(
      onTap: (){
        final itineraryProvider = Provider.of<ItineraryProvider>(context, listen: false);
        itineraryProvider.initItinerary(itinerary);

        snackbarHandler.removeCurrentSnackBar();
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return AddDays();
        }));
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Container(
          padding: EdgeInsets.only(
            bottom: 12
          ),
          height: 180,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(
                    alignment : Alignment.topRight ,
                    child: InkWell(
                      onTap : (){
                        snackbarHandler.removeCurrentSnackBar();

                        final itineraryCopy = itinerary.copy();
                        dbProvider.deleteItinerary(itinerary : itinerary).whenComplete(
                                (){
                              snackbarHandler.showSnackBar(
                                  SnackBar(
                                    content: const Text("Item dihapus!"),
                                    action: SnackBarAction(
                                        label: "Undo",
                                        onPressed: (){
                                          dbProvider.insertItinerary(
                                              itinerary: itineraryCopy
                                          );
                                          snackbarHandler.removeCurrentSnackBar();
                                        }
                                    ),
                                  )
                              );
                            }
                        );
                      },
                      child : Icon(Icons.close , size: 18,)
                    )
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    itinerary.title,
                    style: TextStyle(
                      fontFamily: 'Monsterrat',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: CustomColor.buttonColor
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Mulai : ${itinerary.firstDate}",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getItineraryTitle(BuildContext context) async {
    final itineraryTitle = await showTextDialog(
        context,
        title: "Ketik Judul Itinerary", value: ""
    );

    if (itineraryTitle != null && context.mounted) {
      if (itineraryTitle.isNotEmpty) {
        final today = DateTime.now();

        Provider.of<ItineraryProvider>(context, listen: false)
            .initItinerary(
              Itinerary(
                title: itineraryTitle,
                dateModified: DateTimeFormatter.toDMY(today)
              )
        );

        snackbarHandler.removeCurrentSnackBar();

        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return SelectDate();
        }));
      }
    }
  }
}
