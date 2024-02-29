import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:nexus/Models/SearchMessage.dart';
import 'package:nexus/Util/Colors.dart';
import 'package:nexus/Util/Extension/Size.dart';
import 'package:nexus/Widget/Button/SearchTextBar.dart';

import '../../../Models/Users.dart';
import '../../../Widget/Components/CustomAppBar.dart';
import '../../../bloc/search_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchBloc searchBloc = SearchBloc();
  TextEditingController controller = TextEditingController();
  UserProfile? userProfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomAppbar(
          title: "Search Page",
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back),
          ),
          action: [
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
          ],
        ),
      ),
      body: BlocConsumer<SearchBloc, SearchState>(
        bloc: searchBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case SearchSuccessState:
              List<SearchMessage> messages =
                  (state as SearchSuccessState).messages;
              return Column(
                children: [
                  Expanded(
                    flex: 9,
                    child: Container(
                      margin: EdgeInsets.all(20),
                      child: ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          final isUserMessage = message.role == "user";
                          return Column(
                            crossAxisAlignment: isUserMessage
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  isUserMessage ? "User" : "Nexus",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isUserMessage
                                        ? AppColor().white
                                        : AppColor().white,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: isUserMessage
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 10,
                                  ),
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: isUserMessage
                                        ? AppColor().crdColor
                                        : AppColor()
                                            .grey
                                            .withOpacity(0.5), // Farklı renkler
                                  ),
                                  child: Text(
                                    message.parts.first.text,
                                    style: TextStyle(
                                      color: isUserMessage
                                          ? AppColor().white
                                          : AppColor().white, // Farklı renkler
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  if (searchBloc.generating)
                    Expanded(child: Lottie.asset("assets/searchLoading.json")),
                  SearchTextBar(
                    controller: controller,
                    sendOnTap: () {
                      String text = controller.text;
                      if (text.isNotEmpty) {
                        searchBloc.add(
                          SearchGenerateNewTextMessageEvent(
                            inputMessage: text,
                          ),
                        );
                        controller.clear();
                      }
                    },
                  ),
                ],
              );

            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
