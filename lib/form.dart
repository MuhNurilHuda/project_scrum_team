import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'model/activity_list.dart';

class ActivityForm extends StatefulWidget {
  final Function(Activity newActivity) setParentState;
  ActivityForm({required this.setParentState});

  @override
  _ActivityFormState createState() => _ActivityFormState(
    setParentState: setParentState
  );
}

class _ActivityFormState extends State<ActivityForm> {
  final Function(Activity newActivity) setParentState;
  _ActivityFormState({required this.setParentState});

  final uuid = Uuid();
  final _formKey = GlobalKey<FormState>();
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
      // setState(() {
      //   activities.add(Activity(
      //       id: uuid.v1(),
      //       activity_name: activity,
      //       activity_time: time.format(context)
      //   ));
      // });
      setParentState(Activity(
          id: uuid.v1(),
          activity_name: activity,
          activity_time: time.format(context)
        )
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Activity'),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}