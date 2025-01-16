import 'dart:io';
import 'dart:convert';
import 'package:excel/excel.dart';
import 'package:csv/csv.dart';
import 'package:path/path.dart' as path;
import '../models/timetable_entry.dart';
import '../utils/logger.dart';

class ExportService {
  final logger = getLogger();

  Future<void> exportData(List<TimetableEntry> data) async {
    try {
      print('\nSelect export format:');
      print('1. Excel (.xlsx)');
      print('2. CSV (.csv)');
      print('3. JSON (.json)');
      
      stdout.write('Enter your choice (1-3): ');
      String? choice = stdin.readLineSync();

      switch (choice) {
        case '1':
          await _exportExcel(data);
          break;
        case '2':
          await _exportCsv(data);
          break;
        case '3':
          await _exportJson(data);
          break;
        default:
          print('Invalid choice. Export cancelled.');
      }
    } catch (e) {
      logger.e('Error exporting data: $e');
      print('Error exporting data. Please try again.');
    }
  }

  Future<void> _exportExcel(List<TimetableEntry> data) async {
    final excel = Excel.createExcel();
    final sheet = excel['Sheet1'];

    // Add headers
    final headers = TimetableEntry.csvHeaders();
    for (var i = 0; i < headers.length; i++) {
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
        ..value = headers[i];
    }

    // Add data
    for (var i = 0; i < data.length; i++) {
      final row = data[i].toCsvRow();
      for (var j = 0; j < row.length; j++) {
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: j, rowIndex: i + 1))
          ..value = row[j];
      }
    }

    final outputFile = File('timetable_export.xlsx');
    await outputFile.writeAsBytes(excel.encode()!);
    print('Exported to: ${outputFile.path}');
  }

  Future<void> _exportCsv(List<TimetableEntry> data) async {
    final rows = [
      TimetableEntry.csvHeaders(),
      ...data.map((e) => e.toCsvRow()),
    ];

    final csvData = const ListToCsvConverter().convert(rows);
    final outputFile = File('timetable_export.csv');
    await outputFile.writeAsString(csvData);
    print('Exported to: ${outputFile.path}');
  }

  Future<void> _exportJson(List<TimetableEntry> data) async {
    final jsonData = data.map((e) => e.toJson()).toList();
    final outputFile = File('timetable_export.json');
    await outputFile.writeAsString(jsonEncode(jsonData));
    print('Exported to: ${outputFile.path}');
  }
}
