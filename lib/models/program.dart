import 'package:timetable_processor/models/timetable_entry.dart';

class Program {
  final String name;
  final List<TimetableEntry> entries;

  Program({
    required this.name,
    required this.entries,
  });
}