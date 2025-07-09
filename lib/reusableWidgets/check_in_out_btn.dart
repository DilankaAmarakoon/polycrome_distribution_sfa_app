import 'package:flutter/material.dart';

class CheckInOutButton extends StatelessWidget {
  final bool isCheckedIn;
  final VoidCallback onPressed;
  final bool isDisabled;

  const CheckInOutButton({
    super.key,
    required this.isCheckedIn,
    required this.onPressed,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final String label = isCheckedIn ? 'Check Out' : 'Check In';
    final IconData icon = isCheckedIn ? Icons.logout : Icons.login;
    final Color bgColor = isCheckedIn ? Colors.red.shade50 : Colors.green.shade50;
    final Color iconColor = isCheckedIn ? Colors.red : Colors.green;

    return Column(
      children: [
        GestureDetector(
          onTap: isDisabled ? null : onPressed,
          child: Stack(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: bgColor,
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
                    size: 40,
                    color: isDisabled ? Colors.grey : iconColor,
                  ),
                ),
              ),
              if (isDisabled)
                Container(
                  width: 80,
                  height: 80,
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
          label,
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
