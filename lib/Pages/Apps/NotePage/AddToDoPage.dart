import 'package:flutter/material.dart';
import 'package:nexus/Models/Todo.dart';
import 'package:nexus/Util/Colors.dart';
import 'package:nexus/Util/Extension/PageNavigator.dart';
import 'package:nexus/Util/Extension/Size.dart';
import 'package:nexus/Widget/Button/OutlineBorderButton.dart';
import 'package:nexus/Widget/CustomTextField.dart';

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
    pageNavigator(context, NoteTodoPage());
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: AppColor().bgColor,
      child: Scaffold(
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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextField(
              controller: titleController,
              hintText: "Add Task",
            ),
          ),
        ),
      ),
    );
  }
}
