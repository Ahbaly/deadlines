import 'package:intl/intl.dart';

class Deadline {
  final String title;
  final String assignedTo;
  final DateTime date;

  Deadline({required this.title, required this.assignedTo, required this.date});

  static final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

  factory Deadline.fromJson(Map<String, dynamic> json) => Deadline(
    title: json['title'].toString(),
    assignedTo: json['assignedTo'].toString(),
    date: dateFormat.parse(json['date_creation']),
  );
}