import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';

final formatter = DateFormat.yMd();
const uUid = Uuid();

enum Priority { lowest, low, normal, high, highest }

enum TaskState { inProgress, completed, scheduled, todo, noState }

class StateInfo {
  StateInfo(this.stateName, this.nextState, this.prevState);
  String stateName;
  TaskState nextState;
  TaskState prevState;
}

var states = {
  TaskState.completed:
      StateInfo("Completed", TaskState.todo, TaskState.inProgress),
  TaskState.inProgress:
      StateInfo("In Progress", TaskState.completed, TaskState.todo),
  TaskState.todo: StateInfo("Todo", TaskState.inProgress, TaskState.noState),
  TaskState.scheduled:
      StateInfo("Scheduled", TaskState.inProgress, TaskState.todo)
};

class Task {
  final String id;
  final String title;
  final Priority priority;
  double? currentProgress, progressGoal;
  DateTime? scheduledDate;
  TaskState _taskState;
  TaskState get taskState => _taskState;

  Task({required this.title,this.priority = Priority.normal, TaskState initialState = TaskState.todo, this.currentProgress, this.progressGoal}) : _taskState = initialState, id = uUid.v4();

  void scheduleTask(DateTime date) {
    scheduledDate = date;
    _taskState = TaskState.scheduled;
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
