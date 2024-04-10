import 'dart:math';

import 'package:flutter/material.dart';
import 'package:task_tracker/models/task.dart';

Random rand = Random();

class TaskCollection{
  TaskCollection({required this.tasks, required this.idColor, required this.title});
  final String title;
  final Color idColor;
  final List<Task> tasks;
  final List<Task> completedTasks = [];
  

  String get abreviatedName{
    return (title.replaceRange(1, null, "")).toUpperCase();
  }
}