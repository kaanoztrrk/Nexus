import 'package:flutter/material.dart';
import 'package:nexus/Util/Colors.dart';
import 'package:nexus/Util/Extension/PageNavigator.dart';
import 'package:nexus/Util/Extension/Size.dart';
import 'package:nexus/Widget/Button/OutlineBorderButton.dart';
import '../../../Service/NoteService.dart';
import 'AddToDoPage.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  Future<List<Map<String, dynamic>>?> getTodos() async {
    return await TodoDatabaseProvider.db.getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getTodos(),
        builder:
            (context, AsyncSnapshot<List<Map<String, dynamic>>?> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.data == null || snapshot.data!.isEmpty) {
                return Center(
                  child: Text("You don't have any todos yet, create one"),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String title = snapshot.data?[index]['title'] ?? '';
                      String creationDate =
                          snapshot.data?[index]['creation_date'] ?? '';
                      int id = snapshot.data?[index]['id'] ?? 0;

                      return Card(
                        child: ListTile(
                          title: Text(title),
                          trailing: IconButton(
                            onPressed: () {
                              TodoDatabaseProvider.db.deleteTodo(id);
                              setState(() {}); // State'i yenile
                            },
                            icon: Icon(Icons.delete),
                          ),
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
        gradient: LinearGradient(
          colors: <Color>[
            AppColor().pink.withOpacity(0.5),
            AppColor().blue.withOpacity(0.5),
          ],
        ),
        onPressed: () => pageNavigator(context, AddTodoPage()),
        child: Icon(Icons.add),
      ),
    );
  }
}
