import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

enum Priority {
  lowest,
  low,
  normal,
  high,
  highest
}

class Task{
  final String title;
  final Priority priority; 
  final DateTime scheduledDate;
  final DateTime startDate;

  final bool hasSchedule;

  Task.hasScheduledDate({required this.title, this.priority = Priority.normal, required this.scheduledDate, required this.startDate}) : hasSchedule = true;

  Task.unscheduledDate({required this.title, this.priority = Priority.normal}) : scheduledDate = DateTime.now(), startDate = DateTime.now(), hasSchedule = false;

  String getFormattedDate(DateTime date){
    return formatter.format(date);
  }

}