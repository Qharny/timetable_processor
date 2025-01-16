import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import '../utils/logger.dart';

class FileService {
  final logger = getLogger();
  File? selectedFile;

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'csv', 'json'],
      );

      if (result != null) {
        selectedFile = File(result.files.single.path!);
        print('Selected file: ${path.basename(selectedFile!.path)}');
      } else {
        print('No file selected.');
      }
    } catch (e) {
      logger.e('Error picking file: $e');
      print('Error selecting file. Please try again.');
    }
  }
}
