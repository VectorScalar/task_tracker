import 'package:flutter/material.dart';

import 'package:task_tracker/models/task.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({super.key, required this.task, required this.onModifyTask});
  final Task task;
  final Function(Task task) onModifyTask;
  @override
  State<TaskItem> createState() {
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
      title: Stack(
        alignment: Alignment.centerLeft,
        children: [
          const Divider(
            color: Colors.grey,
            thickness: 2,
            endIndent: 5,
          ),
          Text(widget.task.title),
        ],
      ),
      trailing: Checkbox(
              value: true,
              onChanged: (value) {
                widget.task.stepDownState();
                widget.onModifyTask(widget.task);
              }),
    );
  }

  List<Widget> addProgressBar(){
    return [Container(
              padding: const EdgeInsets.all(10),
              //color: Theme.of(context).colorScheme.primary,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  //backgroundBlendMode: BlendMode.color,
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: Text(
                "${widget.task.taskProgress!.currentProgress.toStringAsFixed(0)}/${widget.task.taskProgress!.progressGoal}",
                style: const TextStyle().copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
              )),
          Expanded(
              child: Slider(

                  // TODO: Possibly add a confirmation box to confirm that the task should be marked as complete/wait for check box to fill prior to switching it to completed
                  onChangeEnd: (value) {
                    if (value >= widget.task.taskProgress!.progressGoal) {
                      widget.task.stepUpState();
                      widget.onModifyTask(widget.task);
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      widget.task.taskProgress!.currentProgress = value;
                    });
                  },
                  value: widget.task.taskProgress!.currentProgress,
                  max: widget.task.taskProgress!.progressGoal)),
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
      
      trailing: widget.task.taskProgress == null ?  Checkbox(
            value: false,
            onChanged: (value) {
              value = true;
              widget.task.stepUpState();
              widget.onModifyTask(widget.task);
              }) : null,
      subtitle: widget.task.taskProgress != null ? Row(
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
      TaskState.completed => completedDisplay(),
      // TODO: Handle this case.
      TaskState.scheduled => todoDisplay(),
      TaskState.todo => todoDisplay(),
    });
  }
}
