import 'dart:io';
import 'package:path/path.dart' as path;
import '../utils/logger.dart';

class FileService {
  final logger = getLogger();
  File? selectedFile;

  Future<void> pickFile() async {
    try {
      print('\nEnter the path to your file (Excel, CSV, or JSON):');
      String? filePath = stdin.readLineSync();
      
      if (filePath != null && filePath.isNotEmpty) {
        final file = File(filePath);
        
        if (await file.exists()) {
          final extension = path.extension(filePath).toLowerCase();
          if (['.xlsx', '.csv', '.json'].contains(extension)) {
            selectedFile = file;
            print('Selected file: ${path.basename(selectedFile!.path)}');
          } else {
            print('Error: Unsupported file format. Please use .xlsx, .csv, or .json files.');
          }
        } else {
          print('Error: File does not exist at the specified path.');
        }
      } else {
        print('No file path provided.');
      }
    } catch (e) {
      logger.e('Error picking file: $e');
      print('Error selecting file. Please try again.');
    }
  }
}