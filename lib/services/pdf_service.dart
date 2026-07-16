import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class PdfService {
  static Future<String?> pickPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result == null) return null;

    final file = File(result.files.single.path!);

    final directory = await getApplicationDocumentsDirectory();

    final pdfDirectory = Directory(
      "${directory.path}/manuals",
    );

    if (!await pdfDirectory.exists()) {
      await pdfDirectory.create(recursive: true);
    }

    final fileName =
        "${DateTime.now().millisecondsSinceEpoch}_${path.basename(file.path)}";

    final newPath =
        "${pdfDirectory.path}/$fileName";

    final newFile =
        await file.copy(newPath);

    return newFile.path;
  }
}