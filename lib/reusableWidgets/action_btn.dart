import 'package:flutter/material.dart';

import '../constants/colors.dart';

class ActionBtn extends StatefulWidget {
  final String lable;
  final VoidCallback onPressed;
  final Color? btnColor;
  final double? width;
  final double? height;
  final double? fontSize;

  const ActionBtn({
    super.key,
    required this.lable,
    required this.onPressed,
    this.btnColor,
    this.width,
    this.height,
    this.fontSize,
  });

  @override
  State<ActionBtn> createState() => _ActionBtnState();
}

class _ActionBtnState extends State<ActionBtn> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: kCartColor,
          minimumSize: Size(widget.width ?? double.infinity, widget.height ?? 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Text(
          widget.lable,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: widget.fontSize ?? 15,
            color: kMainColor,
          ),
        ),
      ),
    );
  }
}