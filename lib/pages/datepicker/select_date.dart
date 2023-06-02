import 'package:flutter/material.dart';
import 'package:iterasi1/provider/database_provider.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:iterasi1/pages/add_days/add_days.dart';
import 'dart:developer' as developer;

import '../../provider/itinerary_provider.dart';


class SelectDate extends StatefulWidget {
  List<DateTime> initialDates;
  SelectDate({
    Key? key,
    this.initialDates = const []
  }) : super(key: key);

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  late ItineraryProvider itineraryProvider;

  late DatabaseProvider databaseProvider;

  List<DateTime> selectedDates = [];


  @override
  void initState() {
    selectedDates = widget.initialDates;
  }

  @override
  Widget build(BuildContext context) {
    itineraryProvider = Provider.of(context, listen: true);
    databaseProvider = Provider.of(context, listen: true);

    return LoaderOverlay(
      child: Scaffold(
        backgroundColor: const Color(0xFFE5BA73),
        appBar: AppBar(
          title: Text(
            'Itinerary to ${itineraryProvider.itinerary.title}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            // itineraryProvider.itinerary.title,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: const Color(0xFFE5BA73),
          elevation: 0,
        ),
        body: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Select Date Range",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 27, fontFamily: 'poppins_regular'),
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      SfDateRangePicker(
                        initialSelectedDates: widget.initialDates,
                        selectionMode: DateRangePickerSelectionMode.multiple,
                        onSelectionChanged: (DateRangePickerSelectionChangedArgs? args){
                          if (args?.value is List<DateTime>){
                            final dates = args?.value as List<DateTime>;
                            selectedDates = dates;
                          }
                        },
                        headerStyle: const DateRangePickerHeaderStyle(
                            textAlign: TextAlign.center,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            )),
                      ),
                    ]),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                // padding: EdgeInsets.fromLTRB(7, 15, 7, 30),
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          spreadRadius: 4,
                          blurRadius: 5,
                          offset: const Offset(0, 2))
                    ]),
                height: 200,
                // color: Colors.grey,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 48,
                      right: 48,
                      left: 48,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 185, 33),
                        borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      onTap: () {
                        if (selectedDates.isNotEmpty) {
                          // debugPrint("Jumlah hari baru : ${selectedDates.length}");
                          itineraryProvider.initializeDays(selectedDates);

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return AddDays();
                              }));
                        }
                        else{
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                              const SnackBar(
                                  content: Text("Tanggal yang dipilih tidak boleh kosong!")
                              )
                          );
                        }
                      },
                      child: SizedBox(
                        height: 45,
                        width: 200,
                        child: Card(
                          color: const Color.fromARGB(255, 255, 185, 33),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 0,
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text('Select Date',
                                style: TextStyle(
                                    fontFamily: 'poppins_bold',
                                    fontSize: 16,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
