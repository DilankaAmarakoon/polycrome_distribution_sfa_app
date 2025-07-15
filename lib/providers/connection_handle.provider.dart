import 'package:connectivity_plus/connectivity_plus.dart' show Connectivity, ConnectivityResult;
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectionHandle with ChangeNotifier {
  Future<bool> checkConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      bool isConnected = await InternetConnectionChecker.instance.hasConnection;

      if (isConnected) {
        print('Internet is available');
        return true;
      } else {
        print('No actual internet access.');
        return false;
      }
    } else {
      print('No network at all.');
      return false;
    }
  }
}
