import 'package:flutter/material.dart';

Future<bool?> showConfirmationDialog(
    BuildContext context,
    String message, {
      String? actionType = "Confirm",
      String? title,
      IconData? icon,
      Color? color,
      bool? showCancelButton = true,
    }) {
  final theme = Theme.of(context);

  // Default values based on action type
  IconData dialogIcon;
  Color dialogColor;
  String dialogTitle;

  switch (actionType?.toLowerCase()) {
    case 'delete':
      dialogIcon = icon ?? Icons.delete_outline_rounded;
      dialogColor = color ?? const Color(0xFFE57373);
      dialogTitle = title ?? 'Delete Confirmation';
      break;
    case 'logout':
      dialogIcon = icon ?? Icons.logout_rounded;
      dialogColor = color ?? const Color(0xFFFF9800);
      dialogTitle = title ?? 'Logout Confirmation';
      break;
    case 'sync':
      dialogIcon = icon ?? Icons.sync_rounded;
      dialogColor = color ?? theme.colorScheme.primary;
      dialogTitle = title ?? 'Sync Confirmation';
      break;
    case 'ok':
      dialogIcon = icon ?? Icons.info_outline_rounded;
      dialogColor = color ?? theme.colorScheme.primary;
      dialogTitle = title ?? 'Information';
      showCancelButton = false;
      break;
    default:
      dialogIcon = icon ?? Icons.help_outline_rounded;
      dialogColor = color ?? theme.colorScheme.primary;
      dialogTitle = title ?? 'Confirmation';
  }

  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 340),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon Section
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    dialogColor.withOpacity(0.1),
                    dialogColor.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: dialogColor.withOpacity(0.2),
                  width: 1.5,
                ),
              ),
              child: Icon(
                dialogIcon,
                color: dialogColor,
                size: 32,
              ),
            ),

            const SizedBox(height: 20),

            // Title Section
            Text(
              dialogTitle,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
                letterSpacing: 0.2,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // Message Section
            Container(
              constraints: const BoxConstraints(maxHeight: 150),
              child: SingleChildScrollView(
                child: Text(
                  message,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.8),
                    height: 1.5,
                    letterSpacing: 0.1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Action Buttons
            Row(
              children: [
                // Cancel Button (if needed)
                if (showCancelButton!) ...[
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.5,
                        ),
                        foregroundColor: Colors.grey.shade600,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],

                // Action Button
                Expanded(
                  flex: showCancelButton ? 1 : 2,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: dialogColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 2,
                      shadowColor: dialogColor.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: Icon(
                      dialogIcon,
                      size: 18,
                    ),
                    label: Text(
                      actionType ?? "Confirm",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}