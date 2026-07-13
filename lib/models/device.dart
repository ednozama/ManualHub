class Device {
  final String manufacturer;
  final String model;
  final String category;
  final String location;
  final String? imagePath;

  const Device({
    required this.manufacturer,
    required this.model,
    required this.category,
    required this.location,
    this.imagePath,
  });
}