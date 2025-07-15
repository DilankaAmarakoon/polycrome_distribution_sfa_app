import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class StyledDropdown extends StatefulWidget {
  final List<Map<String, dynamic>> dataList;
  final ValueChanged<Map<String, dynamic>?> onChange;
  final String hintText;
  final String prefixText;
  final IconData icon;
  final Color? textColor;
  final Color? hintColor;
  final Color? cursorColor;
  final String? type;

  const StyledDropdown({
    super.key,
    required this.dataList,
    required this.onChange,
    this.hintText = "Select Category...",
    this.prefixText = "",
    this.icon = Icons.menu,
    this.textColor,
    this.hintColor,
    this.cursorColor,
    this.type,

  });

  @override
  State<StyledDropdown> createState() => _StyledDropdownState();
}

class _StyledDropdownState extends State<StyledDropdown> {
  Map<String, dynamic>? selectedItem;

  @override
  void initState() {
    super.initState();
    if (widget.dataList.isNotEmpty && widget.type == "DefaultSetValue") {
      selectedItem = widget.dataList.first;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onChange(selectedItem);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<Map<String, dynamic>>(
      value: selectedItem,
      isExpanded: true,
      onChanged: (value) {
        setState(() {
          selectedItem = value;
        });
        widget.onChange(value);
      },
      items: widget.dataList
          .map((item) => DropdownMenuItem<Map<String, dynamic>>(
        value: item,
        child: Text(
          item['name'].toString(),
          style: TextStyle(
            color: widget.textColor ?? Colors.black,
          ),
        ),
      ))
          .toList(),
      decoration: InputDecoration(
        prefixText: widget.prefixText,
        prefixIcon: Icon(widget.icon, color: widget.hintColor ?? Colors.grey),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: widget.hintColor ?? Colors.grey,
          fontWeight: FontWeight.bold,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: widget.hintColor ?? Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: widget.cursorColor ?? Theme.of(context).primaryColor,
              width: 2),
        ),
      ),
      dropdownStyleData: DropdownStyleData(

        maxHeight: 450, //
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
