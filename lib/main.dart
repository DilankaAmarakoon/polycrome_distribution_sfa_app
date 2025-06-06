import 'package:flutter/material.dart';
import 'package:polycrome_sales_application/providers/handdle_data_provider.dart';
import 'package:polycrome_sales_application/providers/order_return_provider.dart';
import 'package:polycrome_sales_application/screens/home_screen.dart';
import 'package:polycrome_sales_application/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/colors.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<ItineraryDataHandle>(
          create: (_) => ItineraryDataHandle(),
        ),
        ChangeNotifierProvider<OrderReturnProvider>(   // use ChangeNotifierProvider here if your provider extends ChangeNotifier
          create: (_) => OrderReturnProvider(),
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
      title: 'polycrome sales application',
      theme:  ThemeData(
        scaffoldBackgroundColor: kBgColor, // darker than 0xFF1E1E1E
    colorScheme: ColorScheme.fromSeed(
    seedColor: kMainColor,
    ),
    ),
      home: isLoggedIn ? HomeScreen() : LoginScreen()
    );
  }

  void _checkUserAlreadyLoggedOrNot() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int? id = pref.getInt("user_Id");
    if (id != null && id > 0) {
      setState(() {
        isLoggedIn = true;
      });
    } else {
      setState(() {
        isLoggedIn = false;
      });
    }
  }
}
