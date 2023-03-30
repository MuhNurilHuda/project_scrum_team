import 'package:flutter/material.dart';
import 'package:iterasi1/pages/provider/itinerary_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../model/activity.dart';


class ActivityForm extends StatefulWidget {
  final int dayIndex;
  ActivityForm({required this.dayIndex});

  @override
  _ActivityFormState createState() => _ActivityFormState(
    dayIndex: dayIndex
  );
}

class _ActivityFormState extends State<ActivityForm> {
  late ItineraryProvider provider;

  final int dayIndex;
  _ActivityFormState({required this.dayIndex});

  final _formKey = GlobalKey<FormState>();
  final uuid = Uuid();

  late TextEditingController _activityController;
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _activityController = TextEditingController();
  }

  @override
  void dispose() {
    _activityController.dispose();
    super.dispose();
  }

  void _saveActivity() {
    if (_formKey.currentState!.validate()) {
      // Save the activity
      final String activity = _activityController.text.trim();
      final TimeOfDay time = _selectedTime;

      // Do something with the activity and time
      print('Activity: $activity, Time: ${time.format(context)}');

      // Clear the form
      _activityController.clear();

      provider.addNewActivity(
          Activity(
              activityName: activity,
              activityTime: time.format(context)
          ),
          dayIndex
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context , listen : true);

    return Scaffold(
      appBar: AppBar(
        title: Text('New Activity'),
        backgroundColor: const Color(0xFF1C3131),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _activityController,
                decoration: InputDecoration(
                  labelText: 'Activity',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an activity';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Text('Time'),
              InkWell(
                onTap: () async {
                  final TimeOfDay? newTime = await showTimePicker(
                    context: context,
                    initialTime: _selectedTime,
                  );
                  if (newTime != null) {
                    setState(() {
                      _selectedTime = newTime;
                    });
                  }
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(_selectedTime.format(context)),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: _saveActivity,
                  child: Text('Save'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF39B400)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}