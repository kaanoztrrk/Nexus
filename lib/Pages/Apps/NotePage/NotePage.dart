import 'package:flutter/material.dart';
import 'package:nexus/Models/Note.dart';
import 'package:nexus/Pages/Apps/NotePage/DisplayNote.dart';
import 'package:nexus/Service/NoteService.dart';
import 'package:nexus/Util/Extension/PageNavigator.dart';

import '../../../Util/Colors.dart';
import '../../../Util/Extension/Size.dart';
import '../../../Widget/Button/OutlineBorderButton.dart';
import 'AddNotePage.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  Future<List<Map<String, dynamic>>?> getNotes() async {
    return await NoteDatabaseProvider.db.getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getNotes(),
        builder:
            (context, AsyncSnapshot<List<Map<String, dynamic>>?> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.data == null || snapshot.data!.isEmpty) {
                return Center(
                  child: Text("You don't have any notes yet, create one"),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String title = snapshot.data?[index]['title'];
                      String body = snapshot.data?[index]['body'];
                      String creationDate =
                          snapshot.data?[index]['creationDate'];
                      int id = snapshot.data?[index]['id'];

                      return Card(
                        child: ListTile(
                          onTap: () {
                            pageNavigator(
                                context,
                                ShowNote(
                                    id: id,
                                    title: title,
                                    body: body,
                                    creationn_date: DateTime.parse(creationDate)
                                        .toString()));
                          },
                          title: Text(title),
                          subtitle: Text(body),
                        ),
                      );
                    },
                  ),
                );
              }
            default:
              return Container(); // Varsayılan olarak boş bir Container döndürün
          }
        },
      ),
      floatingActionButton: OutlineButton(
        size: displayWidth(context) * 0.2,
        strokeWidth: 2.5,
        radius: 100,
        gradient: LinearGradient(colors: <Color>[
          AppColor().pink.withOpacity(0.5),
          AppColor().blue.withOpacity(0.5),
        ]),
        onPressed: () => pageNavigator(context, AddNotePage()),
        child: Icon(Icons.add),
      ),
    );
  }
}
