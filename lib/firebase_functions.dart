import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/models/task_model.dart';

class FirebaseFunctions {
 static CollectionReference<TaskModel>  getTaskCollection(){
    return FirebaseFirestore.instance.collection('Tasks')
        .withConverter<TaskModel>(
      fromFirestore:(snapshot,_ ) {
        return TaskModel.FromJson(snapshot.data()!);
      },
      toFirestore: (task,_ ) {

        return task.toJson();
      },);
  }
 static Future <void> addTask(TaskModel task){
var collection = getTaskCollection();
var decRef = collection.doc();
task.id =decRef.id;
return decRef.set(task);

  }
  static Future<QuerySnapshot<TaskModel>>  getTasks(){
   var collection = getTaskCollection();
   return collection.get();
  }
}