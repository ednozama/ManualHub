import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/device.dart';

class StorageService {
  static const String deviceBoxName = "devices";

  static Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(DeviceAdapter());
    }

    await Hive.openBox<Device>(deviceBoxName);
  }

  static Box<Device> get deviceBox =>
      Hive.box<Device>(deviceBoxName);

  static List<Device> getDevices() {
    return deviceBox.values.toList();
  }

  static ValueListenable<Box<Device>> listenToDevices() {
    return deviceBox.listenable();
  }

  static Future<void> addDevice(Device device) async {
    await deviceBox.add(device);
  }

  static Future<void> deleteDevice(int index) async {
    await deviceBox.deleteAt(index);
  }
}