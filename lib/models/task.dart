import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

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
  final String title;
  final Priority priority;
  DateTime? scheduledDate;
  TaskState _taskState;
  TaskState get taskState => _taskState;

  //Task.scheduled({required this.title, required this.scheduledDate, this.priority = Priority.normal}) : _taskStateManager = TaskStateManager(scheduledState);
  Task({required this.title,this.priority = Priority.normal, TaskState initialState = TaskState.todo}) : _taskState = initialState;

  // Task.inProgress({required this.title, this.priority = Priority.normal}) : _taskStateManager = TaskStateManager(inProgressState);
  //Potentially add a way to define a custom taskstate

  void scheduleTask(DateTime date) {
    scheduledDate = date;
    _taskState = TaskState.scheduled;
    //_taskStateManager.setState(scheduledState);
  }

  void unScheduleTask() {
    scheduledDate = null;
    _taskState = TaskState.todo;
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
}
