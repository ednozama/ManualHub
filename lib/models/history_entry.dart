import 'package:hive/hive.dart';

part 'history_entry.g.dart';

@HiveType(typeId: 1)
class HistoryEntry extends HiveObject {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  double? costs;

  @HiveField(4)
  String? imagePath;

  @HiveField(5)
  String? documentPath;

  HistoryEntry({
    required this.date,
    required this.title,
    required this.description,
    this.costs,
    this.imagePath,
    this.documentPath,
  });
}