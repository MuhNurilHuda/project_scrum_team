

import 'package:flutter/material.dart';
import 'package:iterasi1/pages/add_days.dart';
import 'package:iterasi1/provider/itinerary_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'dart:developer' as dev;


class DatePickerLayout extends StatelessWidget{
  const DatePickerLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              const Text(
                  "Pilih Rentang Tanggal",
                style: TextStyle(
                  fontSize: 32
                ),
              ),
              SfDateRangePicker(
                selectionMode: DateRangePickerSelectionMode.multiRange,
                showActionButtons: true,
                onCancel : (){
                  Navigator.of(context).pop();
                },
                onSubmit : (Object? selectedValue){
                  try {
                    final List<DateTime>? choosenRanges =
                      selectedValue as List<DateTime>;

                    if (choosenRanges?.isNotEmpty == true) {
                      final ItineraryProvider provider = Provider.of(
                          context ,
                          listen: false
                      );

                      provider.initializeDays(choosenRanges!);

                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) {
                                return AddDays();
                              }
                          )
                      );
                    }
                  }
                  catch(e){
                    ScaffoldMessenger.of(context)
                      .showSnackBar(
                        const SnackBar(
                            content: Text("Tanggal yang dipilih tidak boleh kosong!")
                        )
                    );
                    dev.log(e.toString() , name: "qqq");
                  }
                },
                headerStyle: const DateRangePickerHeaderStyle(
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    )
                ),
              ),
            ]
          ),
        ),
      );
  }
}