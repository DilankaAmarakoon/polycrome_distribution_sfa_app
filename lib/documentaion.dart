// delete old database
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

//DELETE AND RECREATE DB
Future<void> deleteLocalDatabase() async {
  final dbFolder = await getApplicationDocumentsDirectory();
  final dbPath = p.join(dbFolder.path, 'sales_person.db');
  final dbFile = File(dbPath);

  if (await dbFile.exists()) {
    await dbFile.delete();
    print('Database deleted successfully.');
  } else {
    print('Database file does not exist.');
  }
}
// update localDb
//flutter pub run build_runner build --delete-conflicting-outputs

