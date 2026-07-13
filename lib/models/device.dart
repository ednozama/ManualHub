import 'package:hive/hive.dart';

part 'device.g.dart';

@HiveType(typeId: 0)
class Device {

  @HiveField(0)
  final String manufacturer;

  @HiveField(1)
  final String model;

  @HiveField(2)
  final String category;

  @HiveField(3)
  final String location;

  @HiveField(4)
  final String? imagePath;

  const Device({
    required this.manufacturer,
    required this.model,
    required this.category,
    required this.location,
    this.imagePath,
  });
}