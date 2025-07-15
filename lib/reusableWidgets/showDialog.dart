import 'package:flutter/material.dart';

Future<bool?> showConfirmationDialog(
    BuildContext context,
    String message, {
      required String actionType,
      IconData? icon,
      bool isDisableCancel = false,
    }) {
  final String title;
  final Color color;

  switch (actionType.toLowerCase()) {
    case 'delete':
      title = "Delete Confirmation";
      icon ??= Icons.delete_forever;
      color = Colors.redAccent;
      break;
    case 'check in':
      title = "Check In Confirmation";
      icon ??= Icons.login_rounded;
      color = Colors.blue;
      break;
    case 'check out':
      title = "Check Out Confirmation";
      icon ??= Icons.logout_rounded;
      color = Colors.red;
      break;
    case 'log out':
      title = "Log Out Confirmation";
      icon ??= Icons.logout;
      color = Colors.red;
      break;
    default:
      title = "Warning";
      icon ??= Icons.warning;
      color = Colors.orangeAccent;
      break;

  }
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                !isDisableCancel ? TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("Cancel", style: TextStyle(fontSize: 16)),
                ) : SizedBox(),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: Icon(icon),
                  label: Text(actionType, style: const TextStyle(fontSize: 16)),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
