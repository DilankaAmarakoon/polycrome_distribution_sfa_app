import 'package:flutter/material.dart';
import 'package:polycrome_sales_application/constants/colors.dart';

Widget buildSearchField({
  required BuildContext context,
  required TextEditingController controller,
  required Function(String value) onChanged,
  String hintText = "Search...",
  Color? cursorColor,
  Color? textColor,
  Color? hintColor,
  IconData iconP = Icons.search,
  IconData iconS = Icons.close,
}) {
  return TextFormField(
    controller: controller,
    onChanged: onChanged,
    cursorColor: cursorColor ?? Colors.blue,
    style: TextStyle(color: textColor ?? Colors.black),
    decoration: InputDecoration(
      prefixIcon: Icon(iconP, color: hintColor ?? Colors.grey),
      suffixIcon: IconButton(
        icon: Icon(Icons.close,),
        onPressed: () {
          controller.clear();
        },
      ),
      hintText: hintText,
      hintStyle: TextStyle(color: hintColor ?? Colors.grey,fontWeight: FontWeight.bold),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: hintColor ?? Colors.grey),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: cursorColor ?? Theme.of(context).primaryColor, width: 2),
      ),
    ),
  );
}
