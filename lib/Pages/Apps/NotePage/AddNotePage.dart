import 'package:flutter/material.dart';
import 'package:nexus/Models/Note.dart';
import 'package:nexus/Pages/Apps/NotePage/NoteTodoPage.dart';
import 'package:nexus/Service/NoteService.dart';
import 'package:nexus/Util/Colors.dart';
import 'package:nexus/Util/Extension/PageNavigator.dart';
import 'package:nexus/Util/Extension/Size.dart';
import 'package:nexus/Widget/Components/CustomAppBar.dart';

import '../../../Util/Extension/TextUtility.dart';
import '../../../Widget/Button/OutlineBorderButton.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({Key? key}) : super(key: key);

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  late final TextEditingController titleController;
  late final TextEditingController bodyController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    bodyController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  void addNote() {
    String title = titleController.text;
    String body = bodyController.text;
    DateTime date = DateTime.now();

    NoteModel note =
        NoteModel(title: title, body: body, creationDate: date.toString());
    NoteDatabaseProvider.db.addnewNote(note);
    print("Note added successfully");
    pageNavigator(context, NoteTodoPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomAppbar(
          title: "Add Note",
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back),
          ),
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
        onPressed: addNote,
        child: Icon(Icons.done),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Column(
          children: [
            TextField(
              style: customGoogleTextStyle(
                fontWeight: FontWeight.bold,
                size: 28.0,
                color: AppColor().white.withOpacity(0.7),
              ),
              controller: titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Note Title",
                hintStyle: customGoogleTextStyle(
                  fontWeight: FontWeight.bold,
                  size: 28.0,
                  color: AppColor().white.withOpacity(0.7),
                ),
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: TextField(
                controller: bodyController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Your note",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
