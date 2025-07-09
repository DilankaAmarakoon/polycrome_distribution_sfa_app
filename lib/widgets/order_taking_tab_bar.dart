import 'package:flutter/material.dart';
import 'package:polycrome_sales_application/constants/colors.dart';
import 'package:provider/provider.dart';

import '../providers/order_return_payment_provider.dart';
import '../screens/orders_return_tab_bar.dart';
import '../screens/payment_tab_bar.dart';

class OrderTakingTabBar extends StatefulWidget {
  final int liternary_Id;
  final int partner_id;
  const OrderTakingTabBar({super.key,required this.liternary_Id,required this.partner_id});

  @override
  State<OrderTakingTabBar> createState() => _OrderTakingTabBarState();
}

class _OrderTakingTabBarState extends State<OrderTakingTabBar> {
  @override
  Widget build(BuildContext context) {
    final showOrderReturnProductValidData = Provider.of<OrderReturnPaymentProvider>(context);
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.72,
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title:  TabBar(
                dividerColor: Colors.grey,
                indicatorColor: Theme.of(context).primaryColor,
                isScrollable: false,
                labelColor: kMainColor,
                tabs: [
                  Tab(child: Text("Payment")),
                  Tab(child: Text("Return")),
                  Tab(child: Text("Order")),
                ],
              ),
            ),
            body:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<OrderReturnPaymentProvider>(
                builder: (context, provider, _) {
                  return TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      PaymentTabBarDetails(liternary_Id:widget.liternary_Id,partner_id:widget.partner_id),
                      OrdersReturnTabBarDetails(orderOrReturn: "Return",liternary_Id:widget.liternary_Id),
                      provider.outStandingState.isEmpty
                          ? OrdersReturnTabBarDetails(orderOrReturn: "Order", liternary_Id: widget.liternary_Id)
                          : outstandingStateError(provider),
                    ],
                  );
                },
              ),

            ),
          ),
        ),
      ),
    );
  }
  outstandingStateError(OrderReturnPaymentProvider showOrderReturnProductValidData){
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.warning, size: 40, color: Colors.orangeAccent),
            const SizedBox(height: 16),
            Text(
              "Warning",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              showOrderReturnProductValidData.outStandingState,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
