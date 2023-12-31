import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tp2/models/task.dart';

class FirestoreService {
  final CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');

   Future<void> addTask(Task task) {
    return FirebaseFirestore.instance.collection('tasks').add({
      'taskTitle': task.title.toString(),
      'taskDesc': task.description.toString(),
      'taskCategory': task.category.toString(),
      'taskDate': task.date.toIso8601String(), 
    });
  }
  

  Stream<QuerySnapshot> getTasks() {
    return tasks.snapshots();
  }
}
