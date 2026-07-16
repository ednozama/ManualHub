import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ImageService {
  static final ImagePicker _picker = ImagePicker();

  static Future<String?> pickImageFromGallery() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image == null) return null;

    return _saveImage(image);
  }

  static Future<String?> pickImageFromCamera() async {
    final image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );

    if (image == null) return null;

    return _saveImage(image);
  }

  static Future<String> _saveImage(XFile image) async {
    final directory = await getApplicationDocumentsDirectory();

    final imageDirectory =
        Directory("${directory.path}/device_images");

    if (!await imageDirectory.exists()) {
      await imageDirectory.create(recursive: true);
    }

    final fileName =
        "${DateTime.now().millisecondsSinceEpoch}${path.extension(image.path)}";

    final newPath =
        "${imageDirectory.path}/$fileName";

    final newImage =
        await File(image.path).copy(newPath);

    return newImage.path;
  }
}