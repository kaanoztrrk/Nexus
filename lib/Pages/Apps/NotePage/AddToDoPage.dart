import 'package:flutter/material.dart';
import 'package:nexus/Models/Todo.dart';
import 'package:nexus/Util/Colors.dart';
import 'package:nexus/Util/Extension/PageNavigator.dart';
import 'package:nexus/Util/Extension/Size.dart';
import 'package:nexus/Widget/Button/OutlineBorderButton.dart';

import '../../../Service/NoteService.dart';
import 'NoteTodoPage.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  late final TextEditingController titleController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  void addTodo() {
    String title = titleController.text;
    DateTime date = DateTime.now();

    ToDoModel todo = ToDoModel(title: title, creationDate: date.toString());
    TodoDatabaseProvider.db.addNewTodo(todo);
    print("Todo added successfully");
    showSuccessDialog();
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Todo Added"),
          content: Text("Your todo has been added successfully."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Kapatma düğmesi
                pageNavigator(context, NoteTodoPage());
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back),
            ),
            Text("Add Todo"),
          ],
        ),
      ),
      floatingActionButton: OutlineButton(
        size: displayWidth(context) * 0.2,
        strokeWidth: 2.5,
        radius: 100,
        gradient: LinearGradient(
          colors: <Color>[
            AppColor().pink.withOpacity(0.5),
            AppColor().blue.withOpacity(0.5),
          ],
        ),
        onPressed: addTodo,
        child: Icon(Icons.done),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Column(
          children: [
            TextField(
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
                color: AppColor().white.withOpacity(0.7),
              ),
              controller: titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Todo Title",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                  color: AppColor().white.withOpacity(0.7),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
