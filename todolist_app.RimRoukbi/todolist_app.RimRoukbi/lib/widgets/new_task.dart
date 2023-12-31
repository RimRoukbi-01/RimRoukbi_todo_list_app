import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import 'package:tp2/models/task.dart'; 


class NewTask extends StatefulWidget {
  const NewTask({Key? key, required this.onAddTask}) : super(key: key); 
  final void Function(Task task) onAddTask; 

  @override
  _NewTaskState createState() => _NewTaskState(); 
}

class _NewTaskState extends State<NewTask> {
  Category _selectedCategory = Category.personal; 

  final _titleController = TextEditingController(); 
  final _descriptionController = TextEditingController(); 
  DateTime _selectedDate = DateTime.now(); 

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose(); 
    super.dispose();
  }

  var _enteredTitle = ''; 
  var _enteredDescription = ''; 

  void _saveTitleInput(String inputValue) {
    _enteredTitle = inputValue; 
  }

  void _submitTaskData() {
    if (_titleController.text.trim().isEmpty) { 
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Erreur'), 
          content: const Text(
              'Merci de saisir le titre de la tâche à ajouter dans la liste'), 
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx); 
              },
              child: const Text('Okay'), 
            ),
          ],
        ),
      );
      return;
    }
    widget.onAddTask(Task( 
      title: _titleController.text,
      description: _descriptionController.text,
      date: _selectedDate,
      category: _selectedCategory,
    ));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate, 
      firstDate: DateTime(2023), 
      lastDate: DateTime(2024), 
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _titleController, 
            decoration: const InputDecoration(
              labelText: 'Title', 
            ),
          ),
          TextFormField(
            controller: _descriptionController, 
            decoration: const InputDecoration(
              labelText: 'Description', 
            ),
          ),
          const SizedBox(height: 10), 
          InkWell(
            onTap: () => _selectDate(context), 
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Date', 
                border: OutlineInputBorder(), 
              ),
              child: Text(
                DateFormat.yMMMd().format(_selectedDate), 
              ),
            ),
          ),
          const SizedBox(height: 10), 
          DropdownButton<Category>( 
            value: _selectedCategory, 
            items: Category.values.map((category) {
              return DropdownMenuItem<Category>(
                value: category, 
                child: Text(
                  category.toString().toUpperCase(), 
                ),
              );
            }).toList(),
            onChanged: (Category? newValue) { // Fonction appelée lorsqu'une nouvelle valeur est sélectionnée dans le menu déroulant
              if (newValue != null) {
                setState(() {
                  _selectedCategory = newValue; 
                });
              }
            },
          ),
          const SizedBox(height: 20), 
          ElevatedButton( 
            onPressed: _submitTaskData, 
            child: const Text('Save Task'), 
          ),
        ],
      ),
    );
  }
}
