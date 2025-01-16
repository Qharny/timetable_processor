class TimetableEntry {
  final String className;
  final String courseName;
  final String program;
  final String day;
  final String time;
  final String room;

  TimetableEntry({
    required this.className,
    required this.courseName,
    required this.program,
    required this.day,
    required this.time,
    required this.room,
  });

  factory TimetableEntry.fromJson(Map<String, dynamic> json) {
    return TimetableEntry(
      className: json['class_name'] ?? '',
      courseName: json['course_name'] ?? '',
      program: json['program'] ?? '',
      day: json['day'] ?? '',
      time: json['time'] ?? '',
      room: json['room'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'class_name': className,
      'course_name': courseName,
      'program': program,
      'day': day,
      'time': time,
      'room': room,
    };
  }

  List<String> toCsvRow() {
    return [className, courseName, program, day, time, room];
  }

  static List<String> csvHeaders() {
    return ['Class Name', 'Course Name', 'Program', 'Day', 'Time', 'Room'];
  }
}
