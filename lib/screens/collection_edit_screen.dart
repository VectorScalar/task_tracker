

import 'package:flutter/material.dart';
import 'package:task_tracker/models/task.dart';
import 'package:task_tracker/models/task_collection.dart';
import 'package:task_tracker/widgets/task_item.dart';

class CollectionEditScreen extends StatefulWidget {
  const CollectionEditScreen({super.key, required this.taskCollection, required this.onEditCollection});

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
  final TextEditingController titleEditController = TextEditingController();
  final TextEditingController descEditController = TextEditingController();
  bool showTextFieldConfirm = false;

  @override
  void dispose() {
    titleEditController.dispose();
    descEditController.dispose();
    super.dispose();
  }

  void _modifyTask(Task task){
    if(widget.taskCollection.tasks.contains(task)){
      setState(() {
        widget.taskCollection.tasks[widget.taskCollection.tasks.indexOf(task)] = task;
        widget.onEditCollection(widget.taskCollection);
      });
    }    
  }

  

  @override
  Widget build(BuildContext context) {
    
   descEditController.text = widget.taskCollection.desc;
    titleEditController.text = widget.taskCollection.title;
    
    Widget content = ListView.builder(
            itemCount: states.length + 1,
            itemBuilder: (BuildContext context, index){
            return index == 0 ? 
          Container(
            margin: const EdgeInsets.all(10),
            child: 
          
               TextFormField(
                  controller: descEditController,
                  onSaved: (newValue){if(newValue != null)widget.taskCollection.desc = newValue;},
                  // onFieldSubmitted: (value) => widget.taskCollection.desc = value,
                  maxLines: 3,
                  decoration: const InputDecoration().copyWith(
                        hintText: "...Add Description",
                      ),
                      
                      ),
          ) : 
            ExpansionTile(
              key: PageStorageKey(stateTitles[index - 1].stateName),
              initiallyExpanded: true,
              title: Text(stateTitles[index - 1].stateName), 
              children: widget.taskCollection.tasks.map((t) => TaskItem(
                key: ValueKey(t.id),
                task: t,
                onModifyTask: _modifyTask,)).toList().where((taskItem) => taskItem.task.taskState == stateValues[index - 1]).toList());
          }
          
          );


   
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title:
          TextFormField(
            controller: titleEditController,
            autovalidateMode: AutovalidateMode.disabled,
            validator: (value) => value == null || value.isEmpty ? "Minimum of 1 char required for title" : null,
            onSaved: (newValue){
              if(newValue != null){
                widget.taskCollection.title = newValue;
                widget.onEditCollection(widget.taskCollection);
                }},
            // onFieldSubmitted: (val){
            //   if(titleEditController.text.isNotEmpty){
            //     widget.taskCollection.title = val;
            //     widget.onEditCollection(widget.taskCollection);
            //   }
            // },
            style: Theme.of(context).textTheme.titleLarge,
            decoration: InputDecoration().copyWith(
              
             isDense: true,
             enabledBorder: InputBorder.none             
            ),
          
            
          ),
 
        actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.add)), const SizedBox(width: 5,)],
        ),
      body: content,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: showTextFieldConfirm ? Padding(
        padding: EdgeInsets.only(bottom: getBottomInsets(context)),
        child: Container(
          padding: const EdgeInsets.only(right: 20),
          decoration: const BoxDecoration(color: Colors.red),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: (){}, 
                icon: const Icon(Icons.close)), 
              IconButton(onPressed: (){}, icon: const Icon(Icons.check))],),
        ),
      ) : null,
      
    );
  }
}


double getBottomInsets(BuildContext context) {
   if (MediaQuery.of(context).viewInsets.bottom >
       MediaQuery.of(context).viewPadding.bottom) {
      return MediaQuery.of(context).viewInsets.bottom -
             MediaQuery.of(context).viewPadding.bottom;
   }
   return 0;
}
