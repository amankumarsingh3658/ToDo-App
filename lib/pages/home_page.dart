import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todoapp/Utilities/dialog_box.dart';
import 'package:todoapp/Utilities/todo_tile.dart';
import 'package:todoapp/data/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Providing the global key to validator
  GlobalKey<FormState> inputKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    //if this is the first time ever opening the app then create default data
    if (myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  //reference the hive box
  final myBox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();

  //Text controller
  final _controller = TextEditingController();

  //Checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    db.toDoList[index][1] = !db.toDoList[index][1];
    setState(() {});
    db.updateDataBase();
  }

  //Save new task
  void saveNewTask() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        db.toDoList.add([_controller.text, false]);
        _controller.clear();
        db.updateDataBase();
      }
    });
    Navigator.pop(context);
  }

  //delete Task
  void deleteTask(int index) {
    setState(() {});
    db.toDoList.removeAt(index);
    db.updateDataBase();
  }

  //Create a New task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            onSave: () {
              saveNewTask();
              db.updateDataBase();
            },
            onCancel: () {
              Navigator.pop(context);
            },
            controller: _controller,
            inputKey: inputKey,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          backgroundColor: Colors.yellow,
          onPressed: () {
            createNewTask();
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
            title: Text('To Do'), elevation: 0, backgroundColor: Colors.yellow),
        backgroundColor: Colors.yellow[200],
        body: ListView.builder(
            itemCount: db.toDoList.length,
            itemBuilder: (context, index) {
              return TodoTile(
                deleteFunction: (context) {
                  deleteTask(index);
                },
                taskName: db.toDoList[index][0],
                taskCompleted: db.toDoList[index][1],
                onChanged: (value) => checkBoxChanged(value, index),
              );
            }));
  }
}
