import 'package:flutter/material.dart';
import 'package:task_tracker/models/task.dart';

class TaskItem extends StatefulWidget {
  const TaskItem(this.task, this.onModifyTask, {super.key});
  final Task task;
  final Function(Task task) onModifyTask;
  @override
  State<TaskItem> createState() {
    // TODO: implement createState
    return _TaskItemState();
  }
}

class _TaskItemState extends State<TaskItem> {
  Widget todoDisplay() {
    return ListTile(
      title: Row(
        textBaseline: TextBaseline.alphabetic,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Text(widget.task.title)),
          Row(
            children: [
              IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.schedule,
                    size: 30,
                  )),
              const SizedBox(
                width: 5,
              ),
              FilledButton(
                  onPressed: () {
                    widget.task.stepUpState();
                    widget.onModifyTask(widget.task);
                  },
                  child: const Text("GO"))
            ],
          )
        ],
      ),
    );
  }

  Widget completedDisplay() {
    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: Stack(alignment: Alignment.centerLeft, children: [
              const Divider(
                color: Colors.grey,
                thickness: 2,
                endIndent: 5,
              ),
              Text(widget.task.title)
            ]),
          ),
          Checkbox(
              value: true,
              onChanged: (value) {
                widget.task.stepDownState();
                widget.onModifyTask(widget.task);
              })
        ],
      ),
    );
  }

  List<Widget> addProgressBar(){

    return [Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: Text(
                "${widget.task.currentProgress!.toStringAsFixed(0)}/${widget.task.progressGoal}",
                style: const TextStyle().copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
              )),
          Expanded(
              child: Slider(
                  // TODO: Possibly add a confirmation box to confirm that the task should be marked as complete/wait for check box to fill prior to switching it to completed
                  onChangeEnd: (value) {
                    if (value >= widget.task.progressGoal!) {
                      widget.task.stepUpState();
                      widget.onModifyTask(widget.task);
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      widget.task.currentProgress = value;
                    });
                  },
                  value: widget.task.currentProgress!,
                  max: widget.task.progressGoal!)),
                  Checkbox(
            value: false,
            onChanged: (value) {
              value = true;
              widget.task.stepUpState();
              widget.onModifyTask(widget.task);
            },
          )];
  }

  Widget inProgressDisplay() {
    return ListTile(
      title: Row(
        textBaseline: TextBaseline.alphabetic,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Text(widget.task.title)),
        ],
      ),
      
      trailing: widget.task.progressGoal == null && widget.task.progressGoal == null ?  Checkbox(
            value: false,
            onChanged: (value) {
              value = true;
              widget.task.stepUpState();
              widget.onModifyTask(widget.task);}) : null,
      subtitle: widget.task.progressGoal != null && widget.task.progressGoal != null ? Row(
        children: [
          // TODO: On Slider End Create a popup to ask if wed like to mark the task as completed
          ...addProgressBar(),
        ],
      ) : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        // Todo Listtile
        child: switch (widget.task.taskState) {
      TaskState.inProgress => inProgressDisplay(),
      // TODO: Handle this case.
      TaskState.completed => completedDisplay(),
      // TODO: Handle this case.
      TaskState.scheduled => todoDisplay(),
      TaskState.todo => todoDisplay(),
      // TODO: Handle this case.
      TaskState.noState => todoDisplay(),
    });
  }
}
