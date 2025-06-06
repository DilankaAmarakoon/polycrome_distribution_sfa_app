import 'package:flutter/material.dart';
import 'package:polycrome_sales_application/constants/colors.dart';

import '../screens/orders_tab_bar.dart';

class OrderTakingTabBar extends StatefulWidget {
  final int liternary_Id;
  const OrderTakingTabBar({super.key,required this.liternary_Id});

  @override
  State<OrderTakingTabBar> createState() => _OrderTakingTabBarState();
}

class _OrderTakingTabBarState extends State<OrderTakingTabBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title:  TabBar(
              isScrollable: false,
              labelColor: kMainColor,
              tabs: [
                Tab(child: Text("Order")),
                Tab(child: Text("Return")),
                Tab(child: Text("Payment")),
              ],
            ),
          ),
          body:  TabBarView(
            children: [
              OrdersTabBarDetails(liternary_Id:widget.liternary_Id),
              OrdersTabBarDetails(liternary_Id:widget.liternary_Id),
              Center(child: Text("Payment tab content")),
            ],
          ),
        ),
      ),
    );
  }
}
