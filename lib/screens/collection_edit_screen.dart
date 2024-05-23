import 'package:flutter/material.dart';
import 'package:task_tracker/models/confirm_input_manager.dart';
import 'package:task_tracker/models/task.dart';
import 'package:task_tracker/models/task_collection.dart';
import 'package:task_tracker/screens/task_edit_screen.dart';
import 'package:task_tracker/widgets/formfield_withconfirm.dart';
import 'package:task_tracker/widgets/task_item.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();




class CollectionEditScreen extends StatefulWidget {
  const CollectionEditScreen(
      {super.key,
      required this.taskCollection,
      required this.onEditCollection});

  final TaskCollection taskCollection;
  final Function(TaskCollection taskCollection) onEditCollection;

  @override
  State<CollectionEditScreen> createState() {
    return _CollectionEditScreen();
  }
}

class _CollectionEditScreen extends State<CollectionEditScreen> {
  final stateTitles = states.values.toList();
  final stateValues = states.keys.toList();

  final ConfirmInputManager inputManager = ConfirmInputManager(scaffoldKey);


  void _modifyTask(Task task) {
    if (widget.taskCollection.tasks.contains(task)) {
      setState(() {
        widget.taskCollection.tasks[widget.taskCollection.tasks.indexOf(task)] =
            task;
        widget.onEditCollection(widget.taskCollection);
      });
    }
  }

  //  Future<void> _openEditTaskScreen(BuildContext context) async{
  //   //Navigator.of(context).push(MaterialPageRoute(builder: ((ctx) => TaskEditModal.newTask()),));
  //   await showDialog<void>(context: context, builder: (BuildContext context) => SimpleDialog(title: Text("Title"),children: [],));
  // }



  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
        itemCount: states.length + 1,
        itemBuilder: (BuildContext context, index) {
          return index == 0
              ? Container(
                  margin: const EdgeInsets.all(10),
                  child: FormFieldWithConfirm(
                    initialValue: widget.taskCollection.desc, 
                    onValueSaved: (newDesc){widget.taskCollection.desc = newDesc;},
                    inputManager: inputManager,
                    maxLines: null,
                    minLines: 3,
                    decoration: const InputDecoration().copyWith(
                      hintText: "....Add Description"
                    )
                  )
                )
              : ExpansionTile(
                  key: PageStorageKey(stateTitles[index - 1].stateName),
                  initiallyExpanded: true,
                  title: Text(stateTitles[index - 1].stateName),
                  children: widget.taskCollection.tasks
                      .map((t) => TaskItem(
                            key: ValueKey(t.id),
                            task: t,
                            onModifyTask: _modifyTask,
                          ))
                      .toList()
                      .where((taskItem) =>
                          taskItem.task.taskState == stateValues[index - 1])
                      .toList());
        });

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title:
            //TODO: Refactor to allow either the passing of a TextFormField or Extend TextFormField to take a confirminputmanager
             FormFieldWithConfirm(
              validator: (p0) {
                if(p0!.length <= 1){
                  return "Minimum of 1 char";
                } else{
                  return null;
                }
              },
              style: Theme.of(context).textTheme.titleLarge,
              decoration: const InputDecoration()
              .copyWith(isDense: true, enabledBorder: InputBorder.none),
              initialValue: widget.taskCollection.title, 
              inputManager: inputManager,
              onValueSaved: (newTitle){
                widget.taskCollection.title = newTitle;
                widget.onEditCollection(widget.taskCollection);
                },),
        actions: [
          IconButton(onPressed: () {
              showDialog<Task>(
                barrierColor: Theme.of(context).dialogBackgroundColor,
                context: context, 
                builder: (BuildContext context) {
                return Dialog.fullscreen(child: TaskEditScreen.newTask(initialCollection: widget.taskCollection,),);
              }).then((value){
                if(value != null){
                setState(() {
                  widget.taskCollection.tasks.add(value);
                });
              }});
              //TaskUtilities.showNewTaskModal(context);
              //_openEditTaskScreen(context);
              //Dialog.fullscreen(child: TaskEditModal(),));
          
          }, icon: const Icon(Icons.add)),
          const SizedBox(
            width: 5,
          )
        ],
      ),
      body: content,
    );
  }
}
