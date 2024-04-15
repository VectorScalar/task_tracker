
import 'package:flutter/material.dart';
import 'package:task_tracker/models/task.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class TaskCollection{
  TaskCollection({required this.tasks, required this.idColor, required this.title}) : id = uuid.v4();
  final String id;
  String title;
  Color idColor;
  final List<Task> tasks;
  
  String get abreviatedName{
    return (title.replaceRange(1, null, "")).toUpperCase();
  }

  @override
  bool operator ==(Object other) {
    if (other is TaskCollection) {
      return id == other.id;
    }
    return false;
  }
  @override
  int get hashCode => id.hashCode;

  void removeTask(Task task){
    if(tasks.contains(task)){
      tasks.remove(task);
    } else{
      throw Exception("Collection doesnt contain an instance of Task: ${task.title}");
    }
  }

  void addNewTask(Task task){
    if(!tasks.contains(task)){
      tasks.add(task);
    } else{
      throw Exception("Collection already contains an instance of Task: ${task.title}");
    }
  }
}