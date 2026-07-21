import 'package:hive/hive.dart';
import 'history_entry.dart';

part 'device.g.dart';

@HiveType(typeId: 0)
class Device extends HiveObject {

  @HiveField(0)
  String manufacturer;

  @HiveField(1)
  String model;

  @HiveField(2)
  String category;

  @HiveField(3)
  String location;

  @HiveField(4)
  String? imagePath;

  @HiveField(5)
  String? manualPath;

  @HiveField(6)
  String? invoicePath;

  @HiveField(7)
  String? warrantyPath;

  @HiveField(8)
List<HistoryEntry> history;

Device({
  required this.manufacturer,
  required this.model,
  required this.category,
  required this.location,
  this.imagePath,
  this.manualPath,
  this.invoicePath,
  this.warrantyPath,
  List<HistoryEntry>? history,
}) : history = history ?? [];
}