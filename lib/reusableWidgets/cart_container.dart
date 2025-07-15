import 'package:flutter/material.dart';
import '../constants/colors.dart';

class CartContainer extends StatelessWidget {
  final String partnerName;
  final String routeName;
  final bool isVisited;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const CartContainer({
    super.key,
    required this.partnerName,
    required this.routeName,
    required this.isVisited,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = isVisited ? Colors.green : Colors.grey.shade300;
    Color statusColor = isVisited ? Colors.green.shade100 : Colors.orange.shade100;
    String statusLabel = isVisited ? "Visited" : "Pending";

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        constraints: BoxConstraints(minHeight: 60),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title row with status badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    partnerName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: kCartColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    statusLabel,
                    style: TextStyle(
                      color: borderColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),

            /// Route Row
            Row(
              children: [
                Icon(Icons.route, size: 14, color: Colors.grey),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    routeName,
                    style: TextStyle(color: Colors.black87, fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            /// Tap instruction
            Text(
              "Tap to visit • Long press to mark as visited",
              style: TextStyle(fontSize: 11.5, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
