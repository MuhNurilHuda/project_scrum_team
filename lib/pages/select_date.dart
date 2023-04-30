import 'package:flutter/material.dart';
import 'package:iterasi1/model/day.dart';
import 'package:iterasi1/pages/activity/add_activities.dart';
import 'package:iterasi1/pages/pdf/preview_pdf_page.dart';
import 'package:iterasi1/provider/database_provider.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:iterasi1/model/itinerary.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:iterasi1/pages/add_days.dart';
import 'dart:developer' as developer;

import '../model/activity.dart';
import '../provider/itinerary_provider.dart';
import 'package:collection/collection.dart';

import 'activity/activity_form.dart';

class SelectDate extends StatefulWidget {
  SelectDate({Key? key}) : super(key: key);

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  late ItineraryProvider itineraryProvider;

  late DatabaseProvider databaseProvider;

  int selectedDayIndex = 0;

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    itineraryProvider = Provider.of(context, listen: true);
    databaseProvider = Provider.of(context, listen: true);

    return LoaderOverlay(
      child: Scaffold(
        backgroundColor: const Color(0xFF1C3131),
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
          backgroundColor: const Color(0xFF1C3131),
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
                        selectionMode: DateRangePickerSelectionMode.multiRange,
                        showActionButtons: true,
                        onCancel: () {
                          Navigator.of(context).pop();
                        },
                        onSubmit: (Object? selectedValue) {
                          try {
                            final List<PickerDateRange>? choosenRanges =
                                selectedValue as List<PickerDateRange>;

                            developer.log(choosenRanges.toString(),
                                name: "qqqDatePickerData");
                            if (choosenRanges?.isNotEmpty == true) {
                              final ItineraryProvider provider =
                                  Provider.of(context, listen: false);

                              provider.initializeDays(choosenRanges!);

                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return AddDays();
                              }));
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Tanggal yang dipilih tidak boleh kosong!")));
                            developer.log(e.toString(), name: "qqq");
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'From',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'poppins_regular',
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '5 April',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'poppins_bold',
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'To',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'poppins_regular',
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '5 April',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'poppins_bold',
                            color: Colors.black,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                // color: Colors.grey,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ActivityForm(dayIndex: selectedDayIndex);
                        }));
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
