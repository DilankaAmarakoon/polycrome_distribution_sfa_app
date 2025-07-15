import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerFormField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool isEnable;
  final void Function(String)? onChanged;

  const DatePickerFormField({
    Key? key,
    required this.controller,
    required this.isEnable,
    this.label = 'Select Date',
    this.onChanged,
  }) : super(key: key);

  @override
  State<DatePickerFormField> createState() => _DatePickerFormFieldState();
}

class _DatePickerFormFieldState extends State<DatePickerFormField> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(widget.controller.text) ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      widget.controller.text = formattedDate;

      if (widget.onChanged != null) {
        widget.onChanged!(formattedDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: widget.controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: widget.label,
          suffixIcon: IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: widget.isEnable ? () => _selectDate(context) : null,
          ),
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a date';
          }
          return null;
        },
      ),
    );
  }
}
