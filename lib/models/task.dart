import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_tracker/models/task_collection.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();
const uUid = Uuid();

enum Priority { 
  lowest(Icon(Icons.keyboard_double_arrow_down_rounded), "Lowest"), 
  low(Icon(Icons.keyboard_arrow_down_rounded), "Low"), 
  normal(Icon(Icons.remove_rounded), "Normal"), 
  high(Icon(Icons.keyboard_arrow_up_rounded), "High"), 
  highest(Icon(Icons.keyboard_double_arrow_up_rounded), "Highest");

  const Priority(this.priorityIcon, this.priorityName);
  final Icon priorityIcon;
  final String priorityName;
  }


enum UnitOption{
  none(label: "none", unit: ""),
  feet(label: "ft", unit: "ft"),
  inches(label: "in", unit: "in");

  const UnitOption({required this.label, required this.unit});

  final String label;
  final String unit;
  
}


enum TaskState { inProgress, completed, scheduled, todo}

class StateInfo {
  const StateInfo({required this.stateName, required this.nextState, required this.prevState, required this.stateIcon});
  final String stateName;
  final TaskState nextState;
  final TaskState prevState;
  final Icon stateIcon;
}

class TaskProgress{
  TaskProgress({this.currentProgress = 0, this.progressGoal = 1, this.progressName = "Untitled", this.unit = UnitOption.none}) : id = uuid.v4();
  double currentProgress;
  double progressGoal;
  String progressName;
  UnitOption unit;
  final String id;
}

var states = {
  TaskState.todo: 
      const StateInfo(stateName:  "Todo", prevState: TaskState.inProgress, nextState: TaskState.inProgress, stateIcon: Icon(Icons.check_box_outline_blank_rounded)),
  // TaskState.scheduled:
  //     const StateInfo(stateName:  "Scheduled", prevState:  TaskState.inProgress, nextState:  TaskState.todo, stateIcon: Icon(Icons.schedule)),
  TaskState.inProgress:
      const StateInfo(stateName:  "Doing", nextState:  TaskState.completed, prevState: TaskState.todo, stateIcon: Icon(Icons.run_circle_outlined,)),
  TaskState.completed:
      const StateInfo(stateName:  "Done", nextState:  TaskState.todo, prevState: TaskState.inProgress, stateIcon: Icon(Icons.check_box_rounded)),
};

class Task {
  final String id;
  String title;
  Priority priority;

  List<TaskProgress> taskProgressables;
  DateTime? scheduledDate;
  TaskState _taskState;
  TaskState get taskState => _taskState;

  Task({this.title = "Untitled Task",this.priority = Priority.normal}) : _taskState = TaskState.todo, id = uUid.v4(), taskProgressables = [];

  void scheduleTask(DateTime date) {
    scheduledDate = date;
    _taskState = TaskState.scheduled;
  }

  void setState(TaskState state){
    _taskState = state;
  }

  void unScheduleTask() {
    scheduledDate = null;
    _taskState = TaskState.todo;
  }

  @override
  bool operator ==(Object other) {
    if (other is Task) {
      return id == other.id;
    }
    return false;
  }

  void stepUpState() {
    if (states[_taskState] != null) {
      _taskState = states[_taskState]!.nextState;
    } else {
      throw Exception("No such state defined");
    }
  }

  void stepDownState() {
    if (states[_taskState] != null) {
      _taskState = states[_taskState]!.prevState;
    } else {
      throw Exception("No such state defined");
    }
  }

  String getFormattedDate(DateTime date) {
    return formatter.format(date);
  }
  
  @override
  int get hashCode => id.hashCode;
  
}
