# University Timetable Processor

A command-line application built with Dart that processes university timetable files in various formats (Excel, CSV, and JSON).

## Features

- **File Input Support**
  - Excel (.xlsx)
  - CSV (.csv)
  - JSON (.json)
  - Validates file formats and content
  - Handles corrupt or improperly formatted files

- **Data Processing**
  - Extracts and validates timetable data
  - Organizes information by class, course, and program
  - Structured data model with error handling

- **Export Capabilities**
  - Export to Excel (.xlsx)
  - Export to CSV (.csv)
  - Export to JSON (.json)
  - Maintains data structure across formats

## Prerequisites

- Dart SDK (version ^3.0.0)
- Compatible operating system (Windows, macOS, or Linux)

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/qharny/timetable_processor.git
   cd timetable_processor
   ```

2. Install dependencies:
   ```bash
   dart pub get
   ```

## Usage

1. Run the application:
   ```bash
   dart run bin/timetable_processor.dart
   ```

2. Follow the interactive menu:
   ```
   === Timetable Processor ===

   Available options:
   1. Select input file (Excel, CSV, or JSON)
   2. Process and validate timetable data
   3. Export processed data
   4. Exit
   ```

3. When selecting a file, provide the full path to your timetable file:
   ```
   Enter the path to your file (Excel, CSV, or JSON):
   /path/to/your/timetable.xlsx
   ```

## File Format Requirements

### Excel (.xlsx)
```
Class Name | Course Name | Program | Day | Time | Room
----------|-------------|---------|-----|------|------
Class A   | Math 101    | BSc     | Mon | 9:00 | R101
```

### CSV (.csv)
```csv
Class Name,Course Name,Program,Day,Time,Room
Class A,Math 101,BSc,Mon,9:00,R101
```

### JSON (.json)
```json
[
  {
    "class_name": "Class A",
    "course_name": "Math 101",
    "program": "BSc",
    "day": "Mon",
    "time": "9:00",
    "room": "R101"
  }
]
```

## Project Structure
```
timetable_processor/
├── bin/
│   └── timetable_processor.dart
├── lib/
│   ├── models/
│   │   ├── timetable_entry.dart
│   │   └── program.dart
│   ├── services/
│   │   ├── file_service.dart
│   │   ├── parser_service.dart
│   │   └── export_service.dart
│   └── utils/
│       ├── logger.dart
│       └── constants.dart
└── test/
    └── timetable_processor_test.dart
```

## Error Handling

The application includes comprehensive error handling for:
- Invalid file formats
- Missing or corrupt data
- File permission issues
- Processing errors

Errors are logged with timestamps and full stack traces for debugging.

## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Commit changes: `git commit -am 'Add feature'`
4. Push to the branch: `git push origin feature-name`
5. Submit a Pull Request

<!-- ## License

This project is licensed under the MIT License - see the LICENSE file for details. -->

## Future Improvements

- Add support for more file formats
- Implement batch processing
- Add data validation rules
- Create a web interface
- Add support for custom timetable templates

## Support

For support, please open an issue in the GitHub repository or contact [kabuteymanasseh5@gmail.com].