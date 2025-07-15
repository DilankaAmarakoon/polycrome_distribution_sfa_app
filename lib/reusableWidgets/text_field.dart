import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NormalTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final bool isNumber;
  final bool isEnabled;
  final int maxLine;
  final void Function(String)? onChanged;

  const NormalTextField({
    Key? key,
    required this.controller,
    this.label = 'Enter text',
    this.validator,
    this.isNumber = false,
    this.isEnabled = true,
    this.maxLine = 1,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        enabled: isEnabled,
         maxLines: maxLine,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        inputFormatters: isNumber
            ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
            : null,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey), // <-- shown when disabled
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
        ),
        validator: validator,
        onChanged: onChanged,
        style: TextStyle(
          color: isEnabled ? Colors.black : Colors.grey,
          fontSize: 15,
      ),
    ),
    );
  }
}
