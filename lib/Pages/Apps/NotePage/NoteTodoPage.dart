import 'package:flutter/material.dart';
import 'package:nexus/Controller/AppsController.dart';
import 'package:nexus/Pages/Apps.dart';
import 'package:nexus/Util/Colors.dart';
import 'package:nexus/Util/Extension/PageNavigator.dart';
import 'package:nexus/Widget/Components/CustomAppBar.dart';
import '../../../Service/NoteService.dart';
import 'NotePage.dart';
import 'TodoPage.dart';

class NoteTodoPage extends StatefulWidget {
  @override
  _NoteTodoPageState createState() => _NoteTodoPageState();
}

class _NoteTodoPageState extends State<NoteTodoPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomAppbar(
          leading: IconButton(
              onPressed: () => pageNavigator(
                  context,
                  AppsPage(
                    userID: '',
                  )),
              icon: Icon(Icons.arrow_back)),
          title: "My Notes",
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Note'),
            Tab(text: 'Todo'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [NotePage(), TodoPage()],
      ),
    );
  }
}
