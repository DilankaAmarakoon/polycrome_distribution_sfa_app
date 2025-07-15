import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class ReusableDropdown extends StatefulWidget {
  final List<Map<String, dynamic>> dataList;
  final ValueChanged<Map<String, dynamic>?> onChange;
  final String hintText;
  final Color? textColor;
  final Color? hintColor;
  final Color? cursorColor;
  final Map<String, dynamic>? selectedItem;
  final bool isEnabled; // <-- NEW

  const ReusableDropdown({
    super.key,
    required this.dataList,
    required this.onChange,
    required this.hintText,
    this.textColor,
    this.hintColor,
    this.cursorColor,
    this.selectedItem,
    this.isEnabled = true, // <-- default to true
  });

  @override
  State<ReusableDropdown> createState() => _ReusableDropdownState();
}

class _ReusableDropdownState extends State<ReusableDropdown> {
  late Map<String, dynamic>? _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField2<Map<String, dynamic>>(
        value: _selectedItem,
        isExpanded: true,
        onChanged: widget.isEnabled
            ? (value) {
          setState(() {
            _selectedItem = value;
          });
          widget.onChange(value);
        }
            : null, // disable interaction
        items: widget.dataList.map((item) {
          return DropdownMenuItem<Map<String, dynamic>>(
            value: item,
            child: Text(
              item['name'].toString(),
              style: TextStyle(
                color: widget.textColor ?? Colors.black,
              ),
            ),
          );
        }).toList(),
        decoration: InputDecoration(
          labelText: widget.hintText,
          labelStyle: TextStyle(
            color: widget.hintColor ?? Colors.grey,
            fontWeight: FontWeight.bold,
          ),
          filled: true,
          fillColor:  Colors.white ,// grayed background
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.hintColor ?? Colors.grey),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey), // disabled border
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.cursorColor ?? Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 450,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}
