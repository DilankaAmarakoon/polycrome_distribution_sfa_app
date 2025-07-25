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
  final bool isEnabled;

  const ReusableDropdown({
    super.key,
    required this.dataList,
    required this.onChange,
    required this.hintText,
    this.textColor,
    this.hintColor,
    this.cursorColor,
    this.selectedItem,
    this.isEnabled = true,
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
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
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
            : null,
        items: widget.dataList.map((item) {
          return DropdownMenuItem<Map<String, dynamic>>(
            value: item,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                item['name'].toString(),
                style: TextStyle(
                  color: widget.isEnabled
                      ? (widget.textColor ?? theme.colorScheme.onSurface)
                      : Colors.grey.shade400,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.2,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        }).toList(),

        decoration: InputDecoration(
          labelText: widget.hintText,
          labelStyle: TextStyle(
            color: widget.isEnabled
                ? (widget.hintColor ?? theme.colorScheme.onSurface.withOpacity(0.7))
                : Colors.grey.shade400,
            fontWeight: FontWeight.w500,
            fontSize: 14,
            letterSpacing: 0.3,
          ),
          filled: true,
          fillColor: widget.isEnabled
              ? Colors.white
              : Colors.grey.shade50,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: widget.cursorColor ?? theme.colorScheme.primary,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
        ),

        dropdownStyleData: DropdownStyleData(
          maxHeight: 450,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
            thumbColor: MaterialStateProperty.all(theme.colorScheme.primary.withOpacity(0.3)),
          ),
        ),

        menuItemStyleData: MenuItemStyleData(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          overlayColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.hovered)) {
              return theme.colorScheme.primary.withOpacity(0.05);
            }
            return null;
          }),
        ),

        iconStyleData: IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: widget.isEnabled
                ? theme.colorScheme.onSurface.withOpacity(0.6)
                : Colors.grey.shade400,
          ),
          iconSize: 24,
        ),

        buttonStyleData: ButtonStyleData(
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}