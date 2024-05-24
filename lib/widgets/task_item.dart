import 'package:flutter/material.dart';

import 'package:task_tracker/models/task.dart';
import 'package:task_tracker/screens/task_edit_screen.dart';
//TODO Modify to allow for on tap do be passed only once and to call opentaskedit
class TaskItem extends StatefulWidget {
  const TaskItem({super.key, required this.task, required this.onModifyTask, required this.openTaskEdit});
  final Task task;
  final Function(Task task) onModifyTask;
  final Function(Task task) openTaskEdit;
  @override
  State<TaskItem> createState() {
    return _TaskItemState();
  }
}

class _TaskItemState extends State<TaskItem> {

  ListTile todoDisplay() {
    return ListTile(
      onTap: () => widget.openTaskEdit(widget.task),
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

  ListTile completedDisplay() {
    return ListTile(
      onTap: () => widget.openTaskEdit(widget.task),
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

  List<Widget> addProgressBar(TaskProgress taskProgress){
    return [Container(
              padding: const EdgeInsets.all(10),
              //color: Theme.of(context).colorScheme.primary,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  //backgroundBlendMode: BlendMode.color,
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: Text(
                "${taskProgress.currentProgress.toStringAsFixed(0)}/${taskProgress.progressGoal}",
                style: const TextStyle().copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
              )),
          Expanded(
              child: Slider(

                  // TODO: Possibly add a confirmation box to confirm that the task should be marked as complete/wait for check box to fill prior to switching it to completed
                  onChangeEnd: (value) {
                    if (value >= taskProgress.progressGoal) {
                      //widget.task.stepUpState();
                      widget.onModifyTask(widget.task);
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      taskProgress.currentProgress = value;
                    });
                  },
                  value: taskProgress.currentProgress,
                  max: taskProgress.progressGoal)),
                  Checkbox(
            value: false,
            onChanged: (value) {
              value = true;
              //widget.task.stepUpState();
              widget.onModifyTask(widget.task);
            },
          )];
  }

  ListTile inProgressDisplay() {
    return ListTile(
      onTap: () => widget.openTaskEdit(widget.task),
      title: Row(
        textBaseline: TextBaseline.alphabetic,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Text(widget.task.title)),
        ],
      ),
      
      trailing: widget.task.taskProgressables.isEmpty ?  Checkbox(
            value: false,
            onChanged: (value) {
              value = true;
              widget.task.stepUpState();
              widget.onModifyTask(widget.task);
              }) : null,
      subtitle: widget.task.taskProgressables.isNotEmpty ? Row(
        children: [
          for(TaskProgress progress in widget.task.taskProgressables)
             ...addProgressBar(progress)
          
         ,
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
