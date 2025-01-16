import 'dart:io';
import 'package:logger/logger.dart';
import 'package:timetable_processor/services/file_service.dart';
import 'package:timetable_processor/services/parser_service.dart';
import 'package:timetable_processor/services/export_service.dart';
import 'package:timetable_processor/utils/logger.dart';

void main(List<String> arguments) async {
  final logger = getLogger();
  final fileService = FileService();
  final parserService = ParserService();
  final exportService = ExportService();

  try {
    print('\n=== Timetable Processor ===');
    while (true) {
      print('\nAvailable options:');
      print('1. Select input file (Excel, CSV, or JSON)');
      print('2. Process and validate timetable data');
      print('3. Export processed data');
      print('4. Exit');

      stdout.write('\nEnter your choice (1-4): ');
      String? choice = stdin.readLineSync();

      switch (choice) {
        case '1':
          await fileService.pickFile();
          break;
        case '2':
          if (fileService.selectedFile != null) {
            await parserService.parseFile(fileService.selectedFile!);
          } else {
            print('Error: No file selected. Please select a file first.');
          }
          break;
        case '3':
          if (parserService.processedData != null) {
            await exportService.exportData(parserService.processedData!);
          } else {
            print('Error: No processed data available. Please process a file first.');
          }
          break;
        case '4':
          print('Goodbye!');
          exit(0);
        default:
          print('Invalid choice. Please try again.');
      }
    }
  } catch (e, stackTrace) {
    logger.e('An error occurred:', error: e, stackTrace: stackTrace);
    print('An unexpected error occurred. Check the logs for details.');
    exit(1);
  }
}