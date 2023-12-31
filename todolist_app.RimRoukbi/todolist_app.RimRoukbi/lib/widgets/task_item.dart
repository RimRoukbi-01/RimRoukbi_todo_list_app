import 'package:flutter/material.dart';
import 'package:tp2/models/task.dart';

class TaskItem extends StatefulWidget {
  final Task task;

  const TaskItem(this.task, {Key? key}) : super(key: key);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.task.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: _isCompleted ? FontWeight.normal : FontWeight.bold,
                    decoration: _isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                    decorationThickness: 4.5,
                  
                  ),
                ),
                Checkbox(
                  value: _isCompleted,
                  onChanged: (value) {
                    setState(() {
                      _isCompleted = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Description: ${widget.task.description}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Category: ${widget.task.category.toString().split('.').last}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Date: ${widget.task.date.toString()}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
