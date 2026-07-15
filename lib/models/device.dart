import 'package:hive/hive.dart';

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

  Device({
    required this.manufacturer,
    required this.model,
    required this.category,
    required this.location,
    this.imagePath,
  });
}