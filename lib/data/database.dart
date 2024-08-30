import 'package:hive/hive.dart';

class ToDoDatabase {
  List toDoList = [];
  // reference the hive box
  final myBox = Hive.box('mybox');

  // run this method if this is first time ever opening this app
  void createInitialData() {
    toDoList = [
      ["Welcome to the ToDo app", false],
      ["You can use this app for tracking daily small tasks", false],
      ["Check on the checkBox to mark a task as completed", true],
      ["Slide from the right of the task to delete the task", false],
    ];
  }

  //load data from the database
  void loadData() {
    toDoList = myBox.get("TODOLIST");
  }

  //update the database
  void updateDataBase() {
    myBox.put("TODOLIST", toDoList);
  }
}
