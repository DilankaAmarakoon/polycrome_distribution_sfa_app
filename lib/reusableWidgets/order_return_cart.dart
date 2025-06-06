import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../providers/order_return_provider.dart';

class OrderReturnCart extends StatefulWidget {
  final List<dynamic> orderValidData;
  final int  index;
  const OrderReturnCart({
    super.key,
    required this.orderValidData,
    required this.index
  });

  @override
  State<OrderReturnCart> createState() => _OrderReturnCartState();
}

class _OrderReturnCartState extends State<OrderReturnCart> {

  @override
  Widget build(BuildContext context) {
    final orderReturnProviderData = Provider.of<OrderReturnProvider>(context);
    return Padding(
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
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.orderValidData[widget.index]["productName"],
                    style: TextStyle(
                      color: kCartColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "1456555",
                    style: TextStyle(
                      color: kCartColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "QTY :5",
                        style: TextStyle(
                          color: kCartColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "568",
                        style: TextStyle(
                          color: kCartColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(onPressed: (){}, icon:Icon(Icons.delete,size: 18,color: Colors.redAccent,))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



