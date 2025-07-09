import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SyncDialog extends StatelessWidget {
  final String message;
  final String syncType;

  const SyncDialog({
    super.key,
    required this.message,
    required this.syncType,
  });

  IconData _getIcon() {
    switch (syncType.toLowerCase()) {
      case 'sync':
        return Icons.sync;
      case 'download':
        return Icons.download;
      case 'upload':
        return Icons.cloud_upload;
      case 'load':
        return Icons.hourglass_top;
      default:
        return Icons.sync;
    }
  }

  Color _getIconColor() {
    switch (syncType.toLowerCase()) {
      case 'sync':
        return Colors.blueAccent;
      case 'download':
        return Colors.blueAccent;
      case 'upload':
        return Colors.deepOrange;
      case 'load':
        return Colors.amber;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: LoadingAnimationWidget.inkDrop(color: Theme.of(context).primaryColor, size: 40),
                ),
                Icon(
                  _getIcon(),
                  color: _getIconColor(),
                  size: 22,
                ),
              ],
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
