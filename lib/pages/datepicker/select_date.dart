import 'package:flutter/material.dart';
import 'package:iterasi1/provider/database_provider.dart';
import 'package:iterasi1/resource/colors.dart';
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
            'Pilih Tanggal',
            style: const TextStyle(
              fontSize: 30,
              fontFamily: 'poppins_bold'
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
            Padding(
              padding: EdgeInsets.only(top: 24),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SfDateRangePicker(
                          selectionColor: CustomColor.dateBackground,
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
                                fontFamily: 'poppins_bold',
                                color: Colors.black,
                              )),
                        ),
                      ]),
                ),
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
              child: Container(
                width: double.infinity,
                height: 260,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),

              )
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child : Padding(
                padding: const EdgeInsets.all(48),
                child: Container(
                  width: double.infinity,
                  child: FilledButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(CustomColor.buttonColor),
                      padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 20)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))
                      ))
                    ),
                    child: Text('Pilih',
                        style: TextStyle(
                            fontFamily: 'poppins_bold',
                            fontSize: 16,
                            color: Colors.white),
                    ),
                    onPressed: (){
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
                                content: const Text(
                                    "Tanggal yang dipilih tidak boleh kosong!"
                                )
                            )
                        );
                      }
                    },
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
