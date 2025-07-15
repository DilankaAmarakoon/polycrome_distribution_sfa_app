import 'package:flutter/material.dart';

class SyncDialogButton extends StatelessWidget {
  final double size;
  final IconData icon;
  final String lable;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? backgroundColor;
  final bool isDisabled;

  const SyncDialogButton({
    super.key,
    this.size = 80.0,
    required this.icon,
    required this.lable,
    required this.onTap,
    this.iconColor,
    this.backgroundColor,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: isDisabled ? null : onTap,
          child: Stack(
            children: [
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: backgroundColor ?? Colors.blue[50],
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    size: size * 0.5,
                    color: isDisabled
                        ? Colors.grey
                        : (iconColor ?? Theme.of(context).primaryColor),
                  ),
                ),
              ),
              if (isDisabled)
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(16),
                  ),

                ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          lable,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDisabled ? Colors.grey : Colors.black87,
          ),
        ),
      ],
    );
  }
}
