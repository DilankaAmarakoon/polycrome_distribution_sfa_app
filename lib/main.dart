import 'package:flutter/material.dart';
import 'package:polycrome_sales_application/providers/connection_handle.provider.dart';
import 'package:polycrome_sales_application/providers/handdle_data_provider.dart';
import 'package:polycrome_sales_application/providers/order_return_payment_provider.dart';
import 'package:polycrome_sales_application/providers/product_data.provider.dart';
import 'package:polycrome_sales_application/providers/save_data_provider.dart';
import 'package:polycrome_sales_application/screens/home_screen.dart';
import 'package:polycrome_sales_application/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/colors.dart';
import 'constants/them.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ItineraryDataHandle>(
          create: (_) => ItineraryDataHandle(),
        ),
        ChangeNotifierProvider<OrderReturnPaymentProvider>(
          create: (_) => OrderReturnPaymentProvider(),
        ), ChangeNotifierProvider<ProductDataProvider>(
          create: (_) => ProductDataProvider(),
        ), ChangeNotifierProvider<SaveDataProvider>(
          create: (_) => SaveDataProvider(),
        ),ChangeNotifierProvider<ConnectionHandle>(
          create: (_) => ConnectionHandle(),
        ),
      ],
      child: MyApp(),
    ),
  );
  Provider.debugCheckInvalidValueType = null;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;

  @override
  void initState() {
    _checkUserAlreadyLoggedOrNot();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Polycrome Sales Application',
        theme: AppTheme.lightTheme,
        home: isLoggedIn ? HomeScreen() : LoginScreen()
    );
  }

  Future<void> _checkUserAlreadyLoggedOrNot() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int? id = pref.getInt("user_Id");
    await Future.delayed(Duration(milliseconds: 300));

    if (!mounted) return;
    setState(() {
      isLoggedIn = id != null && id > 0;
    });
  }
}