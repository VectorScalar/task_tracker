
import 'package:flutter/material.dart';
import 'package:task_tracker/models/task.dart';

class TaskItem extends StatefulWidget{
  const TaskItem(this.task, {super.key});
 final Task task;
  @override
  State<TaskItem> createState() {
    // TODO: implement createState
    return _TaskItemState();
  }
}

  class _TaskItemState extends State<TaskItem>{
  //In Progress Variables
  double sliderVal = 0;
  double sliderValMax = 12;
  bool usesSlider = false;
  //


  

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
              FilledButton(onPressed: () => {setState(() {
                widget.task.stepUpState();
              })}, child: const Text("GO"))
            ],
          )
        ],
      ),
    );
  }

  Widget completedDisplay(){

    return  ListTile(
      title: Row(
        
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
            const Divider(color: Colors.grey,thickness: 2, endIndent: 5,),
            Text(widget.task.title)
            ]
            ),
          ),
          Checkbox(value: true, onChanged: (value) => setState(() {
            widget.task.stepDownState();
          }))
          
          
        ],
      ),
    );
  }

  Widget inProgressDisplay(){
    bool completed = false;
    return ListTile(
      title: Row(
        textBaseline: TextBaseline.alphabetic,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Text(widget.task.title)),
          
        ],
      ),
      subtitle: Row(
        children: [
          // TODO: On Slider End Create a popup to ask if wed like to mark the task as completed
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: Text("${sliderVal.toStringAsFixed(0)}/$sliderValMax", style: const TextStyle().copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),)),
          Expanded(child: Slider(
            // TODO: Possibly add a confirmation box to confirm that the task should be marked as complete/wait for check box to fill prior to switching it to completed
            onChangeEnd: (value) => {if(value >= sliderValMax){setState(() => widget.task.stepUpState())}},
            onChanged: (value){setState(() {
              sliderVal = value;
            });
            }, 
          value: sliderVal,max: sliderValMax)),

          Checkbox(value: completed, onChanged: (value) => setState(() {
            completed = true;
            widget.task.stepUpState();
          }),)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      // Todo Listtile
      child: 
           switch(widget.task.taskState){
             TaskState.inProgress => inProgressDisplay(),
             // TODO: Handle this case.
             TaskState.completed => completedDisplay(),
             // TODO: Handle this case.
             TaskState.scheduled => todoDisplay(),

             TaskState.todo => todoDisplay(),
             // TODO: Handle this case.
             TaskState.noState => todoDisplay(),
           }
    );
  }
  }