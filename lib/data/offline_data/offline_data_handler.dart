import 'package:hive_flutter/hive_flutter.dart';

class OfflineDataHandler {
  static void hiveData() async {
    var box = await Hive.openBox('testBox');

    box.put('name', 'David');

    print('Name: ${box.get('name')}');
  }
}
