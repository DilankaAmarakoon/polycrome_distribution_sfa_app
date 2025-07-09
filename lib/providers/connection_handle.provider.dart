// class ConnectionHandlle Chan
//
//
//
//
//
//
//
//
// Future<void> checkConnectionAndDoTask() async {
//   final connectivityResult = await Connectivity().checkConnectivity();
//
//   // Step 1: Check if there is any network (WiFi or Mobile)
//   if (connectivityResult != ConnectivityResult.none) {
//     // Step 2: Check if actual internet is available
//     bool isConnected = await InternetConnectionChecker().hasConnection;
//
//     if (isConnected) {
//       // ✅ Internet is available, do your task
//       print('Internet is available');
//       await yourSyncOrNetworkTask();
//     } else {
//       print('Connected to a network, but no internet access.');
//     }
//   } else {
//     print('No network connection.');
//   }
// }