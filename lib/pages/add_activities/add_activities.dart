import 'package:flutter/material.dart';

import '../../model/activity.dart';

class AddActivities extends StatefulWidget {
  final Activity? initialActivity;
  final Function(Activity) onSubmit;

  AddActivities({
  this.initialActivity,
  required this.onSubmit,
  super.key
});

@override
_AddActivitiesState createState() => _AddActivitiesState();
}

class _AddActivitiesState extends State<AddActivities> {
  TimeOfDay _selectedStartTime = TimeOfDay.now();
  TimeOfDay _selectedEndTime = TimeOfDay.now();

  final TextEditingController titleController = TextEditingController();


  @override
  void initState() {
    super.initState();
    if (widget.initialActivity != null){
      titleController.text = widget.initialActivity!.activityName;
      _selectedStartTime = widget.initialActivity!.getTimeOfDay();
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedStartTime,
    );
    if (picked != null && picked != _selectedStartTime) {
      setState(() {
        _selectedStartTime = picked;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedEndTime,
    );
    if (picked != null && picked != _selectedEndTime) {
      setState(() {
        _selectedEndTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      "Add Itenerary",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Popins',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF305A5A),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Title",
                        style: TextStyle(
                          fontFamily: 'poppins_bold',
                          fontSize: 20,
                          color: Color(0xFF305A5A),
                        ),
                      ),

                      SizedBox(height: 10),
                      // text field
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: titleController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Color(0xFF305A5A),
                                width: 2,
                              ),

                            ),
                          ),
                        ),
                      ),

                    ],
                  ),

                  SizedBox(height: 30),

                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start Time',
                            style: TextStyle(
                              fontFamily: 'poppins_bold',
                              fontSize: 20,
                              color: Color(0xFF305A5A),
                            ),
                          ),

                          SizedBox(height: 10),

                          GestureDetector(
                            onTap: () => _selectStartTime(context),
                            child: Container(
                              width: 145,
                              height: 60,
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
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        "${_selectedStartTime.format(context)}",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 20,
                                          color: Color(0xFF305A5A),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.access_time,
                                    size: 30,
                                    color: Color(0xFF305A5A),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'End Time',
                            style: TextStyle(
                              fontFamily: 'poppins_bold',
                              fontSize: 20,
                              color: Color(0xFF305A5A),
                            ),
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () => _selectEndTime(context),
                            child: Container(
                              width: 145,
                              height: 60,
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
                              child: Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        "${_selectedEndTime.format(context)}",
                                        style: TextStyle(
                                          fontFamily: 'Popins',
                                          fontSize: 20,
                                          color: Color(0xFF305A5A),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.access_time,
                                    size: 30,
                                    color: Color(0xFF305A5A),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Note',
                        style: TextStyle(
                          fontFamily: 'Popins',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF305A5A),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: null,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontFamily: 'Popins',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF305A5A),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Color(0xFF305A5A),
                              width: 2,
                            ),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(10, 15, 15, 100), // Atur padding kiri, atas, kanan, bawah
                        ),
                      ),
                      // TextFormField(
                      //   keyboardType: TextInputType.multiline,
                      //   maxLines: 4,
                      //   minLines: 4,
                      //   decoration: InputDecoration(
                      //     hintStyle: TextStyle(
                      //       fontFamily: 'Popins',
                      //       fontSize: 15,
                      //       fontWeight: FontWeight.bold,
                      //       color: Color(0xFF305A5A),
                      //     ),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(12),
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(12),
                      //       borderSide: BorderSide(
                      //         color: Color(0xFF305A5A),
                      //         width: 2,
                      //       ),
                      //     ),
                      //     isCollapsed: true, //  agar kotak tidak memiliki margin
                      //         contentPadding: EdgeInsets.symmetric(
                      //         vertical: 50, horizontal: 10,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 20),

                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: Size(100, 60),
                    ),
                    onPressed: (){
                      widget.onSubmit(
                          Activity(
                              activityName: titleController.text,
                              activityTime: "${_selectedStartTime.hour}:"
                                  "${_selectedStartTime.minute}"
                          )
                      );
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      child: Text(
                        'Save Activity',
                        style: TextStyle(
                          fontFamily: 'Popins',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
