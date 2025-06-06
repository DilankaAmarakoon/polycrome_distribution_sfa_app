import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDatePicker extends StatefulWidget {
  const MyDatePicker({super.key});

  @override
  State<MyDatePicker> createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(title: Text('Date Picker Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              selectedDate == null
                  ? 'No date selected.'
                  : 'Selected date: ${selectedDate!.toLocal()}'.split(' ')[0],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Pick a Date'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
