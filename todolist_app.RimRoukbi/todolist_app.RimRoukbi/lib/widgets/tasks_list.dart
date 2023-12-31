import 'package:flutter/material.dart';
import 'package:tp2/models/task.dart';
import 'package:tp2/widgets/task_item.dart';
import 'package:tp2/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TasksList extends StatefulWidget {
  final List<Task> tasks;

  const TasksList({
    Key? key,
    required this.tasks,
  }) : super(key: key);

  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestoreService.getTasks(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        final taskLists = snapshot.data!.docs;
        List<Task> taskItems = [];
        for (int index = 0; index < taskLists.length; index++) {
          DocumentSnapshot document = taskLists[index];
          Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
          if (data != null) {
            String title = data['taskTitle'] ?? '';
            String description = data['taskDesc'] ?? '';
            DateTime date = data['taskDate'] != null ? DateTime.parse(data['taskDate']) : DateTime.now();
            String categoryString = data['taskCategory'] ?? '';

            Category category;
            switch (categoryString) {
              case 'personal':
                category = Category.personal;
                break;
              case 'work':
                category = Category.work;
                break;
              case 'shopping':
                category = Category.shopping;
                break;
              default:
                category = Category.others;
            }

            Task task = Task(
              title: title,
              description: description,
              date: date,
              category: category,
            );
            taskItems.add(task);
          }
        }

        return ListView.builder(
          itemCount: taskItems.length,
          itemBuilder: (ctx, index) {
            return TaskItem(taskItems[index]);
          },
        );
      },
    );
  }
}
