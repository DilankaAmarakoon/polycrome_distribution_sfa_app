import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../constants/colors.dart';
import '../localDb/app_database.dart';

class CartContainer extends StatefulWidget {
  final String partnerName;
  final String routeName;
  final String date;
  final VoidCallback onTap;

  const CartContainer({
    super.key,
    required this.partnerName,
    required this.routeName,
    required this.date,
    required this.onTap,
  });

  @override
  State<CartContainer> createState() => _CartContainerState();
}

class _CartContainerState extends State<CartContainer> {
  final db = SalesPersonDataOperations();
  Stream<Position>? _positionStream;

  @override
  void dispose() {
    // Cancel any stream or background listeners if needed
    super.dispose();
  }

  Future<void> _onTap() async {
    await _getLiveLocation();
    await _syncPendingOrders();
  }

  Future<void> _getLiveLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        print("Location permission denied");
        return;
      }
    }

    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print("Latitude: ${position.latitude}, Longitude: ${position.longitude}");

    // TODO: Store or send this to backend
  }

  Future<void> _syncPendingOrders() async {
    // Uncomment and implement your syncing logic here
    /*
    final orders = await db.getUnsyncedOrders();
    for (var order in orders) {
      final success = await sendOrderToApi(order);
      if (success) {
        await db.markOrderAsSynced(order.id);
        print("Order ID ${order.id} synced.");
      }
    }
    */
    print("Sync logic executed.");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.06,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.partnerName,
                        style: TextStyle(
                          color: kCartColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.routeName,
                        style: TextStyle(
                          color: kCartColor.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.date,
                      style: TextStyle(
                        color: kCartColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "✅",
                        style: TextStyle(
                          color: kCartColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
