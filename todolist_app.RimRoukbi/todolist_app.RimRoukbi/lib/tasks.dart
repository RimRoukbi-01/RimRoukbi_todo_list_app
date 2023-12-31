import 'package:flutter/material.dart';
import 'package:tp2/models/task.dart'; 
import 'package:tp2/widgets/new_task.dart'; 
import 'package:tp2/widgets/tasks_list.dart'; 
import 'package:tp2/services/firestore.dart';
import 'package:tp2/widgets/task_item.dart'; 

class Tasks extends StatefulWidget {
  final VoidCallback? onSignOut; 

  const Tasks({Key? key, this.onSignOut}) : super(key: key); 

  @override
  _TasksState createState() => _TasksState(); 
}


class _TasksState extends State<Tasks> {
  final FirestoreService firestoreService = FirestoreService(); 
  final List<Task> _registeredTasks = []; 
  void _openAddTaskOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewTask(onAddTask: _addTask), 
    );
  }

  void _addTask(Task task) {
    setState(() {
      _registeredTasks.add(task); 
      firestoreService.addTask(task); 
      Navigator.pop(context); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ToDoList'), 
        actions: [
          IconButton(
            onPressed: () {
              if (widget.onSignOut != null) {
                widget.onSignOut!(); 
              }
            },
            icon: const Icon(Icons.logout), 
          ),
          IconButton(
            onPressed: _openAddTaskOverlay, 
            icon: const Icon(Icons.add), 
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16), 
        color: Colors.grey[200], 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tasks',
              style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold, 
                color: Colors.black, 
              ),
            ),
            const SizedBox(height: 20), 
            Expanded(
              child: TasksList(
                tasks: _registeredTasks, 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
