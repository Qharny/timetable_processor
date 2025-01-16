import 'dart:io';
import 'dart:convert';
import 'package:excel/excel.dart';
import 'package:csv/csv.dart';
import '../models/timetable_entry.dart';
import '../utils/logger.dart';

class ParserService {
  final logger = getLogger();
  List<TimetableEntry>? processedData;

  Future<void> parseFile(File file) async {
    try {
      final extension = file.path.split('.').last.toLowerCase();
      switch (extension) {
        case 'xlsx':
          processedData = await _parseExcel(file);
          break;
        case 'csv':
          processedData = await _parseCsv(file);
          break;
        case 'json':
          processedData = await _parseJson(file);
          break;
        default:
          throw FormatException('Unsupported file format: $extension');
      }
      print('Successfully processed ${processedData?.length ?? 0} entries.');
    } catch (e) {
      logger.e('Error parsing file: $e');
      print('Error processing file. Please check the file format and try again.');
      processedData = null;
    }
  }

  Future<List<TimetableEntry>> _parseExcel(File file) async {
    final bytes = file.readAsBytesSync();
    final excel = Excel.decodeBytes(bytes);
    final sheet = excel.tables[excel.tables.keys.first]!;
    
    List<TimetableEntry> entries = [];
    bool isHeader = true;
    
    for (var row in sheet.rows) {
      if (isHeader) {
        isHeader = false;
        continue;
      }
      
      if (row.length >= 6) {
        entries.add(TimetableEntry(
          className: row[0]?.value.toString() ?? '',
          courseName: row[1]?.value.toString() ?? '',
          program: row[2]?.value.toString() ?? '',
          day: row[3]?.value.toString() ?? '',
          time: row[4]?.value.toString() ?? '',
          room: row[5]?.value.toString() ?? '',
        ));
      }
    }
    return entries;
  }

  Future<List<TimetableEntry>> _parseCsv(File file) async {
    final input = file.readAsStringSync();
    final List<List<dynamic>> rows = const CsvToListConverter().convert(input);
    
    List<TimetableEntry> entries = [];
    for (var i = 1; i < rows.length; i++) {
      final row = rows[i];
      if (row.length >= 6) {
        entries.add(TimetableEntry(
          className: row[0].toString(),
          courseName: row[1].toString(),
          program: row[2].toString(),
          day: row[3].toString(),
          time: row[4].toString(),
          room: row[5].toString(),
        ));
      }
    }
    return entries;
  }

  Future<List<TimetableEntry>> _parseJson(File file) async {
    final input = await file.readAsString();
    final List<dynamic> jsonList = json.decode(input);
    return jsonList.map((json) => TimetableEntry.fromJson(json)).toList();
  }
}