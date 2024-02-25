import 'package:flutter/material.dart';
import 'package:nexus/Models/Note.dart';
import 'package:nexus/Pages/Apps/NotePage/NoteTodoPage.dart';
import 'package:nexus/Service/NoteService.dart';
import 'package:nexus/Util/Extension/PageNavigator.dart';
import 'package:nexus/Util/Extension/TextUtility.dart';

import '../../../Widget/Components/CustomAppBar.dart';

class ShowNote extends StatelessWidget {
  const ShowNote(
      {super.key,
      required this.title,
      required this.body,
      required this.creationn_date,
      required this.id});

  final int id;
  final String title;
  final String body;
  final String creationn_date;

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
          action: [
            IconButton(
                onPressed: () {
                  NoteDatabaseProvider.db.deleteNote(id);
                  pageNavigator(context, NoteTodoPage());
                },
                icon: Icon(Icons.delete))
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: customGoogleTextStyle(
                  fontWeight: FontWeight.bold, size: 28.0),
            ),
            SizedBox(height: 16.0),
            Text(
              body,
              style: customGoogleTextStyle(size: 18.0),
            )
          ],
        ),
      ),
    );
  }
}
